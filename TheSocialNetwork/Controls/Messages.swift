//
//  Messages.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 20.01.21.
//

import Foundation

import SwiftMessages

class Messages: SwiftMessages {
    
    /// show top message to user about results of their actions
    ///
    /// - Parameters:
    ///   - message: message to show
    ///   - theme: theme of pop up
    ///   - duration: optional duration in seconds, if not given it will hide automatic
    static func showMessage(message: String, theme: Theme, duration: Duration = .automatic) {
        
        var config: SwiftMessages.Config = SwiftMessages.defaultConfig
        config.duration = duration
        SwiftMessages.show(config: config) { () -> UIView in
            
            let view = MessageView.viewFromNib(layout: .cardView)
            view.button?.isHidden = true
            view.configureTheme(theme)
            view.configureDropShadow()
            var title = "Error"
            switch theme {
            case .success:
                title  = NSLocalizedString("Success", comment: "success message")
            case .info:
                title  = NSLocalizedString("Info", comment: "info message")
            case .warning:
                title  = NSLocalizedString("Warning", comment: "warning message")
            default:
                break
            }
            view.configureContent(title: title, body: message)
            
            return view
            
        }
    }
    
}
