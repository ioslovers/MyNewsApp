//
//  Networking.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}

final class Networking: NSObject {
    
    // MARK: - Private variable and functions
    private static let baseUrl = "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full"
    
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public functions
    
    /// fetchNews function will fetch the news stories and returns
    /// Result<NewsData> as completion handler
    public static func fetchNews(completion: @escaping (Result<NewsData>) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        Networking.getData(url: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                let json = try decoder.decode(NewsData.self, from: data)
                completion(.success(json))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    /// downloadImage function will download the thumbnail images
    /// returns Result<Data> as completion handler
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        Networking.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}

