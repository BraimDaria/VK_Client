//
//  VKLoginViewController.swift
//  VK_Client
//
//  Created by  Daria on 30.11.2022.
//

import UIKit
import WebKit

final class VKLoginViewController: UIViewController {
    
    var session = Session.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadAuthVK()
    }
    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }

    func loadAuthVK() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
                 URLQueryItem(name: "client_id", value: "51490005"),
                 URLQueryItem(name: "display", value: "mobile"),
                 URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                 URLQueryItem(name: "scope", value: "friends,photos,groups"),
                 URLQueryItem(name: "response_type", value: "token"),
                 URLQueryItem(name: "revoke", value: "1"),
                 URLQueryItem(name: "v", value: "5.131")
             ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
}

extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
        let fragment = url.fragment else {
        decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        if let token = params["access_token"], let id = params["user_id"] {
        Session.shared.userId = Int(id)!
        Session.shared.token = token
        decisionHandler(.cancel)
        performSegue(withIdentifier: "login", sender: nil)

        }
    }
}

