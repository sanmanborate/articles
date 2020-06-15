//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(vm viewModel: ArticleCellViewModel) {
        
        lblUsername.text = viewModel.userName
        lblUserDesignation.text = viewModel.userDesignation
        lblContent.text = viewModel.articleContent
        if viewModel.articleUrl != nil {
            lblUrl.text = viewModel.articleUrl.absoluteString
        }
        lblLikes.text = viewModel.likes
        lblComments.text = viewModel.comments
        lblTitle.text = viewModel.articleTitle
        
        if let userAvatar = viewModel.userAvatar {
            imgUserAvatar.kf.setImage(with: userAvatar)
        }
        
        if let mediaImage = viewModel.articleImage {
            imgArticle.kf.setImage(with: mediaImage)
        }
    }
    
}
