//
//  PostsTableViewCell.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//
//

import UIKit

final class PostsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var cellTitle: UILabel! {
        didSet{
            self.cellTitle.numberOfLines = 2
        }
    }
    
    // MARK: - life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
    // MARK: - Public
    
    func configure(with title: String) {
        
        self.cellTitle.text = title
    }
    
}
