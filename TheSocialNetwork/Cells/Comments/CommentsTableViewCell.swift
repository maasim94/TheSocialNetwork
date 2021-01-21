//
//  CommentsTableViewCell.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import UIKit

final class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cellTitle: UILabel! {
        didSet{
            self.cellTitle.numberOfLines = 0
            self.cellTitle.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
    
    func configure(with title: String) {
        
        self.cellTitle.text = title
    }
}
