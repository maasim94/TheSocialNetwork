//
//  RoundedShadowView.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

import UIKit

class RoundedShadowView: UIView {


    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 10

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4.0
    }
}
