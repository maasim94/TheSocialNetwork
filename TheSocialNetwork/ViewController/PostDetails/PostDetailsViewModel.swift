//
//  PostDetailsViewModel.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

final class PostDetailsViewModel {
    
    struct Dependency {
        let commentsService: CommentsServiceProtocol
        let userService: UserServiceProtocol
        let post: Post
    }
    
    // MARK: - private properties
    
    private let dependency: Dependency
    private var comments: [Comment] = []
    private var user: User?
    
    // MARK: - init
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.getPostDetails()
    }
    
    // MARK: - public properties
    
    var refreshUI: CompletionVoid?
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfComments: Int {
        return self.comments.count
    }
    
    var autherName: String {
        return self.user?.name ?? ""
    }
    
    var postDetails: String {
        return self.dependency.post.body
    }
    
    var postTitle: String {
        return self.dependency.post.title
    }
    
    // MARK: - public func
    
    func commentsFor(index: Int) -> String {
        return self.comments[index].body
    }
}

// MARK: - server call

extension PostDetailsViewModel {
    
    func getPostDetails() {
        
        let fetchGroup = DispatchGroup()
        
        fetchGroup.enter()
        self.getCommentsOfPost {
            fetchGroup.leave()
        }
        
        fetchGroup.enter()
        self.getUserDetails {
            fetchGroup.leave()
        }
        
        fetchGroup.notify(queue: .main) { [weak self] in
            self?.refreshUI?()
        }
        
    }
    
    private func getCommentsOfPost(_ completion: @escaping CompletionVoid) {
        
        self.dependency.commentsService.getComments(for: self.dependency.post.id) { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            
            switch result {
            case .failure(let error):
                Messages.showMessage(message: error.error?.localizedDescription ?? "", theme: .error)
            case .success(let comments):
                self.comments = comments
            }
            completion()
        }
    }
    
    private func getUserDetails(_ completion: @escaping CompletionVoid) {
        self.dependency.userService.getUser(of: self.dependency.post.userId) { [weak self] (result) in
            
            guard let `self` = self else {
                return
            }
            
            switch result {
            case .failure(let error):
                Messages.showMessage(message: error.error?.localizedDescription ?? "", theme: .error)
            case .success(let user):
                self.user = user
            }
            completion()
        }
    }
}
