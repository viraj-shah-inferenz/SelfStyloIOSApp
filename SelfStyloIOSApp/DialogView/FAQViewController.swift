//
//  FAQViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 14/02/23.
//

import UIKit
import WebKit

class FAQViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .gray.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupWebView()
        // Do any additional setup after loading the view.
    }
    
    private func loadURL(targetURL: String){
        DispatchQueue.global(qos: .background).async{
            if let url = NSURL(string: targetURL) {
                let request = NSURLRequest(url: url as URL)
                DispatchQueue.main.async {
                    self.webView.load(request as URLRequest)
                }
                
            }
        }
    }
    
    func setupWebView(){
        DispatchQueue.main.async {
            self.webView.sizeToFit()
            self.webView.scrollView.bounces = false
            self.webView.navigationDelegate = self
            self.loadURL(targetURL: "https://selfstylo.com/faqs/")
        }
       
    }
    
    @IBAction func btn_dismiss(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
        
    }
    
    func setupView() {
        // 6. add blur view and send it to back
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.getElementById(\"header\").style.display='none';document.getElementById(\"footer\").style.display='none';", completionHandler: { (res, error) -> Void in
            //Here you can check for results if needed (res) or whether the execution was successful (error)
        })
        
        insertCSSString(into: webView)
    }
    
    func insertCSSString(into webView: WKWebView) {
        let cssString = "body { font-size: 15px; }"
        let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        webView.evaluateJavaScript(jsString, completionHandler: nil)
    }
    


}
