//
//  NewMakeupViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 24/01/23.
//

import UIKit
import WebKit


class NewMakeupViewController: UIViewController {

    @IBOutlet weak var btnBackButton: UIButton!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var makeupView: UIView!
    
    @IBOutlet weak var btnCapture: UIButton!
    
    @IBOutlet weak var comboView: CardView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var category_image = [UIImage(named: "eyeliner"),UIImage(named: "lipstick"),UIImage(named: "blush"),UIImage(named: "eyeshadow"),UIImage(named: "foundation")]
    var category_name:[String] = ["Eyeliner","Lipstick","Blush","Eyeshadow","Foundation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
        loadHtmlFile()
        setDelegates()
        
        self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
        
    }
    func setDelegates() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    func setupWebview() {
        webView.sizeToFit()
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.configuration.preferences.javaScriptEnabled = true
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.allowsAirPlayForMediaPlayback = false
        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.customUserAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    }
    
    fileprivate func loadHtmlFile() {
        
        // Adding webView content
        do {
            guard let fileUrl = Bundle.main.url(forResource: "index", withExtension: "html") else {
                print("File reading error")
                return
            }
            webView.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
        }
        catch {
            print ("File HTML error")
        }
    }

}

extension NewMakeupViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category_name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categorycell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell

           categorycell.categoryName.text = category_name[indexPath.row]
           categorycell.categoryImage.image = category_image[indexPath.row]
           categorycell.contentView.layer.cornerRadius = 10
           return categorycell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 {
            let view = UINib(nibName: "LipstickView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! LipstickView
            
            view.frame = self.makeupView.bounds
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideLipstickView))
            view.backView.addGestureRecognizer(tapGesture)
            view.setupData()
            self.makeupView.addSubview(view)
        }
    }
    
    @objc func hideLipstickView(sender: UITapGestureRecognizer) {
        let view = makeupView.subviews.last as! LipstickView
        view.removeFromSuperview()
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0{
            eyelinerCV.isHidden = false
            makeupView.alpha = 0
        }
        else if indexPath.item == 1{
            lipstickCV.isHidden = false
            makeupView.alpha = 0
        }
        else if indexPath.item == 2{
            blushCV.isHidden = false
            makeupView.alpha = 0
        }else if indexPath.item == 3{
            eyeshadowCV.isHidden = false
            makeupView.alpha = 0
        }else if indexPath.item == 4{
            foundationCV.isHidden = false
            makeupView.alpha = 0
        }
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/3 - 25, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
}

extension NewMakeupViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? [AnyObject] else {
            print("could not convert message body to array: \(message.body)")
            return
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("HTML Script loaded")
//        setCanvasAttributes()
        guard let img1 = UIImage(named: "gloss-lip") else { return }
        guard let gloss_lip_base64 = img1.base64(format: .png) else { return }
        let _glossBase = "\"\(gloss_lip_base64)\""

        guard let img2 = UIImage(named: "metallic_lips") else { return }
        guard let metallic_lip_base64 = img2.base64(format: .png) else { return }
        let _metallicBase = "\"\(metallic_lip_base64)\""

        guard let img3 = UIImage(named: "glitter_lip") else { return }
        guard let glitter_lip_base64 = img3.base64(format: .png) else { return }
        let _glitterBase = "\"\(glitter_lip_base64)\""
        loadImages(_glossBase: _glossBase, _glitterBase: _glitterBase, _metallicBase: _metallicBase)
        
    }
    
    /*func setCanvasAttributes() {
        let width = webView.bounds.width //- 5.0
        let height = webView.frame.height //- 50.0
        
                let f = "setCanvasAttributes(\(width), \(height));"
//        let f = "setCanvasAttributes(\(height));"
                self.webView.evaluateJavaScript(f) { (response, error) in
                    if error == nil {
                        print("----return value : \(response)")
                    } else {
                        print("error: " + error.debugDescription)
                    }
        //            RunLoop.current.run(mode: .default, before: Date.distantFuture)
                }
    }*/
    
    func loadImages(_glossBase: String, _glitterBase: String, _metallicBase: String) {
        
        let f = "loadImages(\(_glossBase), \(_glitterBase), \(_metallicBase));"
        self.webView.evaluateJavaScript(f) { (response, error) in
            if error == nil {
                print("----return value : \(response)")
            } else {
                print("error: " + error.debugDescription)
            }
            RunLoop.current.run(mode: .default, before: Date.distantFuture)
        }
    }
    
    func applyLipstick(ra:Int, ga: Int, ba:Int, type: Int) {
        let f = "applyMakeup(" + String(ra) + "," + String(ga) + "," + String(ba) + "," + String(type) + ");"
        print(f)
        self.webView.evaluateJavaScript(f) { (response, error) in
            if error == nil {
                print("----return value : \(response)")
            } else {
                print("error: " + error.debugDescription)
            }
            RunLoop.current.run(mode: .default, before: Date.distantFuture)
        }
    }
}

extension NewMakeupViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(btnOk)
        
        if (self.isViewLoaded) {
            present(alert, animated: true, completion: nil)
            completionHandler()
        } else {
            completionHandler()
        }
    }
}
