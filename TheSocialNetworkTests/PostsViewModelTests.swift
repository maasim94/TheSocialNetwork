//
//  PostsViewModelTests.swift
//  TheSocialNetworkTests
//
//  Created by Muhammad Arslan Asim on 20.01.21.
//

import XCTest

@testable import TheSocialNetwork

class MockPostsService: PostsServiceProtocol {
    
    func getPosts(of page: Int, handler: @escaping PostsCompletion) {
        let result: Swift.Result<[Post], APIClientError>
        result = .success([Post(userId: 1, id: 10, title: "title", body: "body")])
        handler(result)
    }
}

class PostsViewModelTests: XCTestCase {

    var sut: PostsViewModel!
    override func setUp() {
        continueAfterFailure = false
        
        self.sut = PostsViewModel(dependency: PostsViewModel.Dependency(postsService: MockPostsService()))
        self.sut.getSocialPosts()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(self.sut.numberOfRows , 1)
    }
    
    func testPostId() {
        let post = self.getTestPost()
        XCTAssertEqual(post.id , 10)
    }
    
    func testPostTitle() {
        
        let post = self.getTestPost()
        XCTAssertEqual(post.title , "title")
    }
    
    func testPostBody() {
        let post = self.getTestPost()
        XCTAssertEqual(post.body , "body")
    }
    
    func testPostUserId() {
        let post = self.getTestPost()
        XCTAssertEqual(post.userId , 1)
    }
    
    
    private func getTestPost() -> Post {
        return self.sut.postFor(index: 0)
    }
    
    
}
