//
//  TimelineVC.swift
//  Mastodon-timeline
//
//  Created by Роман Мисников on 03.04.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class TimelineVC: UIViewController {
    
    // data storage
    var outputArray: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hashtagTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add delegate and ds to self for using tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // for hidding keyboard after 'RETURN' press
        hashtagTextField.delegate = self
        
        // initial request to load
        getMastodonTimeline(hashtag: "test")
    }
    
    @IBAction func searchBtnPress(_ sender: Any) {
        // receive data from textField
        if let hashtag = hashtagTextField.text {
            
            // simple test for input data
            if hashtag == "" || hashtag == " " {
                simpleAlert(title: "Ошибка", message: "Неверно введены данные", buttonText: "Ок")
            } else {
                // hide keyboard
                hashtagTextField.resignFirstResponder()
                // check data
                let noSpacesString = hashtag.replacingOccurrences(of: " ", with: "")
                //erase data
                outputArray = []
                // get data
                getMastodonTimeline(hashtag: noSpacesString)
            }
        }
    }
    

    // MARK: - Receive data from network
    func getMastodonTimeline(hashtag: String) {
        
        // basic URL for request
        let baseUrl = "https://mastodon.social/api/v1/timelines/tag/"
        // build full url for GET request
        let stringUrl = baseUrl + hashtag
        // convert to URL and check
        guard let url = URL(string: stringUrl) else {return}
        // make request
        let request = URLRequest(url: url)
        // create new task with our request
        let _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            // check response code for '200' - received normal data
            guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
                self.simpleAlert(title: "Ошибка", message: "Нет ответа от сервера", buttonText: "ОК")
                return
            }
            
            // call our method for JSON decoding
            let result = self.parseJSON(data: data)
            
            // update labels must be in main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }.resume()
    }
    
    // MARK: - Convert JSON data to Post object
    func parseJSON (data: Data?) -> [Post] {
        
        guard let data = data else { return []}
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] else { return []}
            
            // loop for all objects in data array
            for item in json {
                // convert to dictionary
                let testData = item as? [String: Any]
                // initialize Post object
                let newData = Post(json: testData!)
                // add parsed data
                outputArray.append(newData)
                // debug message
                if let nik = newData.account?.display_name {print("Nik: ", nik)}
                
            }
            
        } catch let jsonError {
            print("JSON error: ", jsonError)
        }
        return outputArray
    }
    
    // MARK: - Alert
    func simpleAlert (title: String, message: String, buttonText: String) {
        // Create controller for alert message
        // preferredStyle: .alert (сообщение по центру) или .actionSheet (сообщение снизу)
        let simpleAlertController = UIAlertController(title: title,
                                                      message: message,
                                                      preferredStyle: .alert)
        // Create button in alert message
        let action = UIAlertAction(title: buttonText, style: .cancel) { (action) in
            // This code will work after button "Согласен" will be pressed
        }
        // Add action to controller
        simpleAlertController.addAction(action)
        // Show alert message after button press
        self.present(simpleAlertController, animated: true, completion: nil)
    }
    
    
}// end of ViewController class

//==================================================================

// MARK: - Text View delegate
extension TimelineVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // for hiding keyboard
        self.view.endEditing(true)
        // get data from text field
        if let hashtag = hashtagTextField.text {
            // simple test
            if hashtag == "" || hashtag == " " {
                simpleAlert(title: "Ошибка", message: "Неверно введены данные", buttonText: "Ок")
            } else {
                // hide keyboard
                hashtagTextField.resignFirstResponder()
                // check data
                let noSpacesString = hashtag.replacingOccurrences(of: " ", with: "")
                //erase data
                outputArray = []
                // get data
                getMastodonTimeline(hashtag: noSpacesString)
            }
        }
        
        return true
    }
}

// MARK: - TableView data source and delegate
extension TimelineVC: UITableViewDelegate, UITableViewDataSource {
    // number of elements in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outputArray.count
    }
    
    // initialize every cell here
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! Cell
        
        // cancel scrolling in textView
        cell.contentTextView.isScrollEnabled = false
        
        // show name
        cell.nameLbl.text = "Cell \(indexPath.row)"
        let name = outputArray[indexPath.row].account?.display_name
        let nikName = outputArray[indexPath.row].account?.username
        cell.nameLbl.text = name!
        cell.nikNameLbl.text = "(@" + nikName! + ")"
        
        // show date
        cell.contentTextView.attributedText = outputArray[indexPath.row].content?.convertHtml()
        if let dateString = outputArray[indexPath.row].created_at {
            
            let date = DateFormatter.mastodonFormatter.date(from: dateString)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_GB")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdHHmm") // // set template after setting locale
            var newStrindDate = dateFormatter.string(from: date!)
            
            let secondsFromPost = Int(Date().timeIntervalSince(date!))
            let timeFromPost = NewTime(seconds: secondsFromPost)
            newStrindDate = timeFromPost.printTime()
            
            cell.dateLbl.text = newStrindDate
        }
        
        // show image
        if let imageLink = outputArray[indexPath.row].account?.avatar_static {
            cell.userImage.downloadedFrom(link: imageLink)
        }
        cell.userImage.layer.cornerRadius = 10.0
        cell.userImage.layer.masksToBounds = true
        
        // change attributed text
        cell.contentTextView.font = UIFont(name: "Helvetica", size: 14.0)
        cell.contentTextView.isUserInteractionEnabled = false
        
        return cell
    }
    
    // segue after item in table view press
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = outputArray[indexPath.row]
        performSegue(withIdentifier: "openDetails", sender: sender)
    }
    
    // MARK: - Send data to the next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsVC {
            detailsVC.mainPost = sender as! Post
        }
    }
}

// MARK: - String from HTML text
extension String{
    func convertHtml() -> NSAttributedString{
        
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            
            let text = try NSAttributedString(data: data,
                                              options: [.documentType: NSAttributedString.DocumentType.html,
                                                        .characterEncoding: String.Encoding.utf8.rawValue],
                                              documentAttributes: nil)
            return text
        } catch {
            return NSAttributedString()
        }
    }
}

// MARK: - Change date format
extension DateFormatter {
    static let mastodonFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter
    }()
}

// MARK: - ImageView receive data from URL
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

