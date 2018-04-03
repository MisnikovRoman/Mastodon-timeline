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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}// end of ViewController class

//==================================================================
//
//
//
//// MARK: - TableView data source and delegate
//extension TimelineVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return outputArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! Cell
//        cell.nameLbl.text = "Cell \(indexPath.row)"
//        let name = outputArray[indexPath.row].account?.display_name
//        let nikName = outputArray[indexPath.row].account?.username
//        cell.nameLbl.text = name! + " (@" + nikName! + ")"
//        
//        cell.contentLbl.attributedText = outputArray[indexPath.row].content?.convertHtml()
//        if let dateString = outputArray[indexPath.row].created_at {
//            let date = DateFormatter.mastodonFormatter.date(from: dateString)
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_GB")
//            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdHHmm") // // set template after setting locale
//            let newStrindDate = dateFormatter.string(from: date!)
//            cell.dateLbl.text = newStrindDate
//        }
//        
//        if let imageLink = outputArray[indexPath.row].account?.avatar_static {
//            cell.userImage.downloadedFrom(link: imageLink)
//        }
//        
//        return cell
//    }
//    
//    
//}
//
//// MARK: - String from HTML text
//extension String{
//    func convertHtml() -> NSAttributedString{
//        
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do{
//            
//            let text = try NSAttributedString(data: data,
//                                              options: [.documentType: NSAttributedString.DocumentType.html,
//                                                        .characterEncoding: String.Encoding.utf8.rawValue],
//                                              documentAttributes: nil)
//            return text
//        } catch {
//            return NSAttributedString()
//        }
//    }
//}
//
//// MARK: - Change date format
//extension DateFormatter {
//    static let mastodonFormatter: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        
//        return dateFormatter
//    }()
//}
//
//// MARK: - ImageView receive data from URL
//extension UIImageView {
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode)
//    }
//}

