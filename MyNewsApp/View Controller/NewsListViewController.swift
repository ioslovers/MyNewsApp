//
//  NewsListViewController.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

final class NewsListViewController: UIViewController {
    
    // MARK: - Private Outlets and Variable
    @IBOutlet private var tableView: UITableView!
    
    private var newsListViewModel: NewsListViewControllerModel?
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .gray
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// UI Setup for news list
        setUpView()
        
        /// Fetching latest news
        fetchNews()
    }
    
    private func setUpView() {
        
        /// Setting up navigation bar
        title = NSLocalizedString("localiseNewsTitle", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        UINavigationBar.appearance().prefersLargeTitles = true
        
        
        /// Setting up Activity Indicator
        let rightBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setLeftBarButton(rightBarButton, animated: true)
        
        //Refresh Button
        let leftBarButton = UIBarButtonItem(title: NSLocalizedString("localiseRefreshButton", comment: ""),
                                            style: .plain,
                                            target: self,
                                            action: #selector(refreshNews))
        navigationItem.setRightBarButton(leftBarButton, animated: true)
        
        /// Setting up table view
        tableView.register(UINib(nibName: String(describing: NewsListCell.self),
                                 bundle: Bundle(for: NewsListCell.self)),
                           forCellReuseIdentifier: NewsListCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.accessibilityIdentifier = ConstantIdentifiers.newsTableViewIdentifier.rawValue
    }
    
    /// Refresh button action
    @objc private func refreshNews(_ sender: Any) {
        fetchNews()
    }
    
    private func fetchNews() {
        activityIndicator.startAnimating()
        Networking.fetchNews { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsData):
                self.newsListViewModel = NewsListViewControllerModel(newsData: newsData.assets)
            case .failure(let error):
                
                /// Showing alert for errors
                DispatchQueue.main.async() {
                    let alert = Alert.init(subTitle: error.localizedDescription,
                                           cancelTitle: NSLocalizedString("localiseAlertButtonOk", comment: ""))
                    alert.presentAlert(from: self)
                }
            }
            
            /// Reload tableView and dismiss activity indicator
            DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sortedNews = self.newsListViewModel?.sortedNews() else { return ConstantNumber.noOfRows.rawValue }
        return  sortedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let sortedNews = self.newsListViewModel?.sortedNews() else { return UITableViewCell() }
        
        let newsListViewModel = NewsListCellDataSource(asset: sortedNews[indexPath.row])
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.cellId) as? NewsListCell {
            cell.show(data: newsListViewModel)
            return cell
        } else {
            let  cell = NewsListCell(style: .default,
                                     reuseIdentifier: NewsListCell.cellId)
            cell.show(data: newsListViewModel)
            return cell
        }
    }
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let sortedNews = self.newsListViewModel?.sortedNews() else { return }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let newsDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
            newsDetailViewController.asset = sortedNews[indexPath.row]
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
    }
}



