//
//  PostsViewModel.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import Foundation

final class PostsViewModel {
    
    struct Dependency {
        let postsService: PostsServiceProtocol
    }
    
    // MARK: - Private Properties

    private let dependency: Dependency
    private var posts: [Post] = []
    private var networkState: NetworkState = .inital
    private var currentPage: Int = 1
    
    // MARK: - Initialization

    required init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    // MARK: - public properties
    
    var refreshUI: CompletionVoid?
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return self.posts.count
    }
    
    
    // MARK: - public func
    
    func postFor(index: Int) -> Post {
        return self.posts[index]
    }
    
    func refreshData() {
        
        self.currentPage = 1
        self.getSocialPosts(refreshData: true)
    }
    
    func askForNextPage() {
        
        guard self.networkState == .finished else { return  }
        self.currentPage += 1
        self.getSocialPosts()
    }
    
}

// MARK: - server call

extension PostsViewModel {
    
    func getSocialPosts(refreshData: Bool = false) {
        
        self.networkState = .progress
        self.dependency.postsService.getPosts(of: self.currentPage) { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            self.networkState = .finished
            
            switch result {
            case .failure(let error):
                Messages.showMessage(message: error.error?.localizedDescription ?? "", theme: .error)
            case .success(let posts):
                if refreshData {
                    self.posts = posts
                } else {
                    self.posts.append(contentsOf: posts)
                }
                
            }
            self.refreshUI?()
            
        }
    }
}
