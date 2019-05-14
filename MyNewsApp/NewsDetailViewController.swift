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
    @IBOutlet private var webView: WKWebView!
    public var asset: Asset?
    let activityIndicator = UIActivityIndicatorView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        activityIndicator.color = UIColor.darkGray
        activityIndicator.startAnimating()
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        title = asset?.headline
        
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
