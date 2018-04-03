//
//  DetailsVC.swift
//  Mastodon-timeline
//
//  Created by Роман Мисников on 03.04.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var mainPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let post = mainPost else { return }
        nameLbl.text = post.account?.display_name
        contentTextView.attributedText = post.content?.convertHtml()
//        contentTextView.attributedText = post.account?.note?.convertHtml()
        contentTextView.font = UIFont(name: "Helvetica", size: 14.0)
        if let imageLink = post.account?.avatar_static {
            avatarImageView.downloadedFrom(link: imageLink)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
