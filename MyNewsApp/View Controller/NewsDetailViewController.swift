//
//  NewsDetailViewController.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 12/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    // MARK: - Private Outlets and Variable
    @IBOutlet private var webView: WKWebView!
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = .gray
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Public Outlets
    public var asset: Asset?
    
    // MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Setting view the View
        setUpView()
        
        /// Load webView
        loadWebView()
    }
    
    // MARK: - View Controller life cycle
    private func setUpView() {
        webView.navigationDelegate = self
        webView.accessibilityIdentifier = ConstantIdentifiers.webViewIdentifier.rawValue
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
        title = asset?.headline
    }
    
    // MARK: - load webView
    private func loadWebView() {
        guard let urlString = asset?.url,
            let url = URL(string: urlString)  else { return }
        
        webView.load(URLRequest(url: url))
    }
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
