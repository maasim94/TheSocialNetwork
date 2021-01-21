//
//  ViewController.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import UIKit

final class PostsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.backgroundColor = UIColor.clear
            
            self.tableView.estimatedRowHeight = 44
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.register(cellType: PostsTableViewCell.self)
            
            self.tableView.tableFooterView = UIView()
            self.tableView.separatorStyle = .none
        }
    }
    
    // MARK: - properties
    
    private lazy var refreshControl = UIRefreshControl()
    private let viewModel = PostsViewModel(dependency: PostsViewModel.Dependency(postsService: PostsService()))
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Posts", comment: "")
        self.view.backgroundColor = UIColor.systemGray6
        self.addActivityIndicator()
        self.addPullToRefresh()
        
        self.viewModel.getSocialPosts()
        self.viewModel.refreshUI = { [weak self] in
            
            guard let `self` = self else {
                return
            }
            
            self.spinner.stopAnimating()
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()

        }
        
    }
    
    // MARK: - Helping
    
    private func addActivityIndicator() {
        
        self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.spinner.startAnimating()
    }
    
    private func addPullToRefresh() {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Pull to Refresh", comment: ""))
        self.refreshControl.addTarget(self, action: #selector(self.pullToRefreshAction), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc private func pullToRefreshAction() {
        self.viewModel.refreshData()
    }
    
    private func showDetails(post: Post) {
        
        let controller = PostDetailsViewController.makeInstantiate(with: post)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let post = self.viewModel.postFor(index: indexPath.row)
        cell.configure(with: post.title)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = self.viewModel.postFor(index: indexPath.row)
        self.showDetails(post: post)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y + scrollView.bounds.height + 100 >= scrollView.contentSize.height {
            self.spinner.startAnimating()
            self.viewModel.askForNextPage()
        }
    }
}
