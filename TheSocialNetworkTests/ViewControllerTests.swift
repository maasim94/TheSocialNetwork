//
//  ViewControllerTests.swift
//  TheSocialNetworkTests
//
//  Created by Muhammad Arslan Asim on 20.01.21.
//

import XCTest
@testable import TheSocialNetwork

class ViewControllerTests: XCTestCase {

    var viewControllerUnderTest : PostsViewController!
    
    override func setUp() {
        self.viewControllerUnderTest = StoryboardScene.Main.postsViewController.instantiate()
        //load view hierarchy
        if(self.viewControllerUnderTest != nil) {
            self.viewControllerUnderTest.loadView()
            self.viewControllerUnderTest.viewDidLoad()
        }
    }

    override func tearDown() {
        self.viewControllerUnderTest = nil
    }
    
    func testViewControllerIsComposeOfTableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView,"ViewController under test is not composed of a UITableView")
    }
    func testControllerConformsToTableViewDelegate() {
        XCTAssert(viewControllerUnderTest.conforms(to: UITableViewDelegate.self), "ViewController under test  does not conform to UITableViewDelegate protocol")
    }
    func testControllerConformsToTableViewDataSource() {
        XCTAssert(viewControllerUnderTest.conforms(to: UITableViewDataSource.self),"ViewController under test  does not conform to UITableViewDataSource protocol")
    }
    func testTableViewDelegateIsSet() {
        XCTAssertNotNil(self.viewControllerUnderTest.tableView.delegate)
    }
    func testTableViewDataSourceIsSet() {
        XCTAssertNotNil(self.viewControllerUnderTest.tableView.dataSource)
    }
}
