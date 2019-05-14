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
    var newsData: [Asset]?
    let activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetchNews()
    }
    
    private func setUpView() {
        title = "News"
        tableView.accessibilityIdentifier = "newsTableViewIdentifier"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        UINavigationBar.appearance().prefersLargeTitles = true
        activityIndicator.color = UIColor.darkGray
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
        tableView.register(UINib(nibName: String(describing: NewsListCell.self),
                                 bundle: Bundle(for: NewsListCell.self)),
                           forCellReuseIdentifier: NewsListCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func refresh(_ sender: Any) {
        activityIndicator.startAnimating()
        fetchNews()
    }
    
    private func fetchNews() {
        Networking.fetchNews { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let newsData):
                self.newsData = newsData.assets
                self.newsData?.sort(by: { $0.timeStamp > $1.timeStamp})
            case .failure(let error):
                let alert = Alert.init(title: nil,
                                       subTitle: error.localizedDescription,
                                       buttonTitles: [],
                                       cancelTitle: "Ok")
                alert.presentAlert(from: self, actionHandler: { (_, _) in }, cancelHandler: nil)
                
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
        return  self.newsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let asset = self.newsData?[indexPath.row] else { return UITableViewCell() }
        
        let newsListViewModel = NewsListCellDataSource(asset: asset)
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.cellId) as? NewsListCell {
            cell.show(data: newsListViewModel)
            cell.accessibilityIdentifier = ("newsCell_\(indexPath.row)")
            return cell
        } else {
            let  cell = NewsListCell(style: .default,
                                     reuseIdentifier: NewsListCell.cellId)
            cell.show(data: newsListViewModel)
            cell.accessibilityIdentifier = ("newsCell_\(indexPath.row)")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let asset = self.newsData?[indexPath.row] else { return }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let newsDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
            newsDetailViewController.asset = asset
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
    }
}

