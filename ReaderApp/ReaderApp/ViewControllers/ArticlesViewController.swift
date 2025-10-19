//
//  ArticlesViewController.swift
//  ReaderApp
//
//  Created by Prraneth on 19/10/25.
//


import UIKit

class ArticlesViewController: UIViewController {
    
    let tableView = UITableView()
    let viewModel = ArticleViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    private var searchWorkItem: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        setupTableView()
        setupSearch()
        setupBindings()
        
        viewModel.fetchArticles()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: ArticleCell.identifier, bundle: nil), forCellReuseIdentifier: ArticleCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Articles"
        navigationItem.searchController = searchController
    }
    
    func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refresh() {
        viewModel.refreshArticles()
    }
}
extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        let article = viewModel.articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        let detailVC = ArticleDetailViewController(article: article, viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ArticlesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchData = searchController.searchBar.text?.lowercased() ?? ""
        
        // Cancel previous pending work item
        searchWorkItem?.cancel()
                
        // Create a new work item
        let workItem = DispatchWorkItem { [weak self] in
            self?.viewModel.fetchArticles(for: searchData)
        }
        
        // Save reference to cancel if user types again
        searchWorkItem = workItem
        
        // Execute after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
    }

}
