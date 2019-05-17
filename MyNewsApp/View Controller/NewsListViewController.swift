//
//  NewsListViewController.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

final class NewsListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    var newsListViewModel: NewsListViewControllerModel?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .gray
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
    
    @objc func refreshNews(_ sender: Any) {
        activityIndicator.startAnimating()
        fetchNews()
    }
    
    private func fetchNews() {
        Networking.fetchNews { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsData):
                self.newsListViewModel = NewsListViewControllerModel(newsData: newsData.assets)
            case .failure(let error):
                let alert = Alert.init(subTitle: error.localizedDescription,
                                       cancelTitle: NSLocalizedString("localiseAlertButtonOk", comment: ""))
                
                alert.presentAlert(from: self)
                
            }
            
            DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  newsListViewModel?.sortedNews()?.count ?? ConstantNumber.noOfRows.rawValue
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

