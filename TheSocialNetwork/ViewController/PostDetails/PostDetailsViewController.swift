//
//  PostDetailsViewController.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import UIKit

final class PostDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var autherName: UILabel! {
        didSet {
            self.autherName.textColor = UIColor.systemTeal
            self.autherName.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
    @IBOutlet private weak var postDetails: UILabel! {
        didSet {
            self.postDetails.font = UIFont.systemFont(ofSize: 12)
            self.postDetails.numberOfLines = 0
        }
    }
    @IBOutlet private weak var numberOfComments: UILabel! {
        didSet {
            self.numberOfComments.textColor = UIColor.systemGray
            self.numberOfComments.font = UIFont.systemFont(ofSize: 10)
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            
            self.tableView.dataSource = self

            self.tableView.backgroundColor = UIColor.clear
            
            self.tableView.estimatedRowHeight = 44
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.register(cellType: CommentsTableViewCell.self)
            
            self.tableView.tableFooterView = UIView()
            self.tableView.separatorStyle = .none
        }
    }
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    // MARK: - properties
    
    private var viewModel: PostDetailsViewModel!
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addRefreshButton()
        self.spinner.startAnimating()
        
        self.viewModel.refreshUI = { [weak self] in
            
            guard let `self` = self else {
                return
            }
            
            self.autherName.text = self.viewModel.autherName
            self.postDetails.text = self.viewModel.postDetails
            self.numberOfComments.text = "\(self.viewModel.numberOfComments) comments"
            self.title = NSLocalizedString("Details", comment: "")
                
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - helping
    
    private func addRefreshButton() {
        let rightBarButtton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        self.navigationItem.rightBarButtonItem = rightBarButtton
    }
    
    @objc private func refreshData() {
        
        self.spinner.startAnimating()
        self.viewModel.getPostDetails()
    }
}

// MARK: - UITableViewDataSource

extension PostDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfComments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: self.viewModel.commentsFor(index: indexPath.row))
        return cell
    }
    
}

// MARK: - init

extension PostDetailsViewController {
    
    static func makeInstantiate (with post: Post) -> PostDetailsViewController {
        let viewController = StoryboardScene.Main.postDetailsViewController.instantiate()
        let viewModel = PostDetailsViewModel(dependency: PostDetailsViewModel.Dependency(commentsService: CommentsService(), userService: UserService(), post: post))
        viewController.viewModel = viewModel
        return viewController
    }
}

