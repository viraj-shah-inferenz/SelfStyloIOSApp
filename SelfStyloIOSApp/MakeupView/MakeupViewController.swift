//
//  MakeupViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 19/01/23.
//

import UIKit
import WebKit
import JavaScriptCore

class MakeupViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var eyelinerCV:UIView!
    @IBOutlet weak var lipstickCV: UIView!
    @IBOutlet weak var blushCV: UIView!
    
    @IBOutlet weak var eyeshadowCV: UIView!
    
    @IBOutlet weak var foundationCV: UIView!
    
    @IBOutlet weak var comboCV: UIView!
    
    @IBOutlet weak var comboView: CardView!
    
    @IBOutlet weak var makeupView: UIView!
    
    var category_image = [UIImage(named: "eyeliner"),UIImage(named: "lipstick"),UIImage(named: "blush"),UIImage(named: "eyeshadow"),UIImage(named: "foundation")]
    var category_name:[String] = ["Eyeliner","Lipstick","Blush","Eyeshadow","Foundation"]
    
    var lipstickView: LipstickView!
    
    var strOpenView:String!
    
    var makeup = MakeDetails()
    
    var eyeshadowVC = EyeshadowViewController()
    
    var makeupData: Dictionary = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
        loadHtmlFile()
        
        setDelegates()
        setObserverforMakeup()
        
        print(makeup.data?.makeup)
        eyeshadowVC.makeup = makeup
        
        // Do any additional setup after loading the view.
        self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        comboView.target(forAction: #selector(combo), withSender: nil)
        comboView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(combo)))
        
        makeupData.removeAll()
        
    }
    
    fileprivate func setObserverforMakeup() {
        
        //lipstick observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyMakeup(notification:)), name: Notification.Name("applyLipstick"), object: nil)
        
        //eyeshadow observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyEyeshadow(notification:)), name: Notification.Name("applyEyeshadow"), object: nil)
        
//       blush observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.applyBlush(notification:)), name: Notification.Name("applyBlush"), object: nil)
    }
    
    @objc func combo() {
        comboCV.isHidden = false
        makeupView.alpha = 0
    }
    
    
    func setDelegates() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    func setupWebview() {
        webView.sizeToFit()
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        webView.configuration.preferences.javaScriptEnabled = true
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.allowsAirPlayForMediaPlayback = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    /// Call JavaScript Function for apply make - up
    /// Lipsticks:-
    ///  0:Mat
    ///  1:Glossy
    ///  2:Metallic
    ///  3:Glitter
    @objc func applyMakeup(notification: Notification) {
        if let product = notification.object as? Product {
            print(product.colorCode!)
            guard let color = product.colorCode?.rgbToColor() else { return }
            let colorComponents = color.rgbComponents
            let red = colorComponents.red
            let green = colorComponents.green
            let blue = colorComponents.blue
            let alpha = colorComponents.alpha
            
            if product.productTypeCode == nil || product.productTypeCode == 0 {
                makeupData.updateValue(["color":[Int(red * 255), Int(green * 255), Int(blue * 255)], "product_type": 0], forKey: "Lipstick")
            } else {
                guard let productTypeCode = product.productTypeCode else { return }
                makeupData.updateValue(["color":[Int(red * 255), Int(green * 255), Int(blue * 255)], "product_type": productTypeCode], forKey: "Lipstick")
            }
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: makeupData, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString)
        if let json = jsonString {
            updateEffectList(json: json)
        }
    }
    
    /// Eyeshadow:-
    ///  0: Base
    ///  1: Metallic
    ///  2: Micro
    ///  3: Nano
    @objc func applyEyeshadow(notification: Notification) {
        if let product = notification.object as? Product {
            print(product.colorCode!)
            guard let color = product.colorCode?.rgbToColor() else { return }
            let colorComponents = color.rgbComponents
            let red = colorComponents.red
            let green = colorComponents.green
            let blue = colorComponents.blue
            let alpha = colorComponents.alpha
            
            if product.productTypeCode == nil || product.productTypeCode == 0 {
                makeupData.updateValue(["color":[Int(red * 255), Int(green * 255), Int(blue * 255)], "product_type": 0], forKey: "Eyeshadow")
                
            } else {
                guard let productTypeCode = product.productTypeCode else { return }
                makeupData.updateValue(["color":[Int(red * 255), Int(green * 255), Int(blue * 255)], "product_type": productTypeCode], forKey: "Eyeshadow")
            }
            let jsonData = try? JSONSerialization.data(withJSONObject: makeupData, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)
            print(jsonString)
            if let json = jsonString {
                updateEffectList(json: json)
            }
        }
    }
    
    @objc func applyBlush(notification: Notification) {
        if let product = notification.object as? Product {
            print(product.colorCode!)
            guard let color = product.colorCode?.rgbToColor() else { return }
            let colorComponents = color.rgbComponents
            let red = colorComponents.red
            let green = colorComponents.green
            let blue = colorComponents.blue
            let alpha = colorComponents.alpha
            
            if product.productTypeCode == nil || product.productTypeCode == 0 {
                makeupData.updateValue(["color":[Int(red * 255), Int(green * 255), Int(blue * 255)], "product_type": 4], forKey: "Blush")
            } else {
                guard let productTypeCode = product.productTypeCode else { return }
                makeupData.updateValue(["color":[Int(red * 255), Int(green * 255), Int(blue * 255)], "product_type": productTypeCode], forKey: "Blush")
            }
            let jsonData = try? JSONSerialization.data(withJSONObject: makeupData, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)
            print(jsonString)
            if let json = jsonString {
                updateEffectList(json: json)
            }
        }
    }
    
    fileprivate func loadHtmlFile() {
        
        // Adding webView content
        do {
            guard let fileUrl = Bundle.main.url(forResource: "indexMain", withExtension: "html") else {
                print("File reading error")
                return
            }
            webView.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
        }
        catch {
            print ("File HTML error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lipstickView" {
            if let lipsticVC = segue.destination as? LipstickViewController {
                lipsticVC.backToCategory = {
                    self.lipstickCV.isHidden = true
                    self.makeupView.alpha = 1
                }
            }
        }
        if segue.identifier == "eyeshadowView" {
            if let eyeshadowVC = segue.destination as? EyeshadowViewController {
                eyeshadowVC.backToCategory = {
                    self.eyeshadowCV.isHidden = true
                    self.makeupView.alpha = 1
                }
            }
        }
        
        if segue.identifier == "blushView" {
            if let blushVC = segue.destination as? BlushViewController {
                blushVC.backToCategory = {
                    self.blushCV.isHidden = true
                    self.makeupView.alpha = 1
                }
            }
        }
        
        if segue.identifier == "eyelinerView" {
            if let eyelinerVC = segue.destination as? EyelinerViewController {
                eyelinerVC.backToCategory = {
                    self.eyelinerCV.isHidden = true
                    self.makeupView.alpha = 1
                }
            }
        }
        if segue.identifier == "comboView" {
            if let comboVC = segue.destination as? CombosViewController {
                comboVC.backToCategory = {
                    self.comboCV.isHidden = true
                    self.makeupView.alpha = 1
                }
            }
        }
        
        if segue.identifier == "foundationView" {
            if let foundationVC = segue.destination as? FoundationViewController {
                foundationVC.backToCategory = {
                    self.foundationCV.isHidden = true
                    self.makeupView.alpha = 1
                }
            }
        }
    }
    
    @IBAction func backHome(_ sender: UIButton) {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
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
    
    
    var ProductListViewController: LipstickViewController {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "ProductListViewController") as! LipstickViewController
        return vc
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/3 - 25, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
}

extension MakeupViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? [AnyObject] else {
            print("could not convert message body to array: \(message.body)")
            return
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("HTML Script loaded")
        
//        setCanvasAttributes()
        guard let img1 = UIImage(named: "lipstickGloss") else { return }
        guard let gloss_lip_base64 = img1.base64(format: .png) else { return }
        let _glossBase = "\"\(gloss_lip_base64)\""
        
        guard let img2 = UIImage(named: "lipstickMetallic") else { return }
        guard let metallic_lip_base64 = img2.base64(format: .png) else { return }
        let _metallicBase = "\"\(metallic_lip_base64)\""
        
        guard let img3 = UIImage(named: "lipstickGlitter") else { return }
        guard let glitter_lip_base64 = img3.base64(format: .png) else { return }
        let _glitterBase = "\"\(glitter_lip_base64)\""
//
        guard let imgEyeshadow1 = UIImage(named: "eyeshadowNormal") else { return }
        guard let normal_eyeshadow_base64 = imgEyeshadow1.base64(format: .png) else { return }
        let _eyeshadowBase = "\"\(normal_eyeshadow_base64)\""
        
        guard let imgEyeshadow2 = UIImage(named: "Metallic_eyeshadow") else { return }
        guard let metallic_eyeshadow_base64 = imgEyeshadow2.base64(format: .png) else { return }
        let _eyeshadowMetallic = "\"\(metallic_eyeshadow_base64)\""
        
        guard let imgEyeshadow3 = UIImage(named: "Micro_eyeshadow") else { return }
        guard let micro_eyeshadow_base64 = imgEyeshadow3.base64(format: .png) else { return }
        let _eyeshadowMirco = "\"\(micro_eyeshadow_base64)\""
        
        guard let imgEyeshadow4 = UIImage(named: "Nano_eyeshadow") else { return }
        guard let nano_eyeshadow_base64 = imgEyeshadow4.base64(format: .png) else { return }
        let _eyeshadowNano = "\"\(nano_eyeshadow_base64)\""
        
        guard let imgBlush = UIImage(named: "squareFace") else { return }
        guard let blush_base64 = imgBlush.base64(format: .png) else { return }
        let _blushBase = "\"\(blush_base64)\""
        
        loadImages(_glossBase: _glossBase, _glitterBase: _glitterBase, _metallicBase: _metallicBase, _eyeshadowBase: _eyeshadowBase, _eyeshadowMetallic: _eyeshadowMetallic, _eyeshadowMirco: _eyeshadowMirco, _eyeshadowNano: _eyeshadowNano, _blushBase: _blushBase)
    }
    
    func webView(_ webView: WKWebView,
                 requestMediaCapturePermissionFor
                 origin: WKSecurityOrigin,initiatedByFrame
                 frame: WKFrameInfo,type: WKMediaCaptureType,
                 decisionHandler: @escaping (WKPermissionDecision) -> Void){
        decisionHandler(.grant)
    }
    
    func setCanvasAttributes() {
        let width = webView.bounds.width  //- 5.0
        let height = webView.frame.height + 5.0 //- 50.0
        
        let f = "setCanvasAttributes(\(width), \(height));"
        self.webView.evaluateJavaScript(f) { (response, error) in
            if error == nil {
                print("-- setCanvasAttributes -- return value : \(response)")
            } else {
                print("error: " + error.debugDescription)
            }
            //            RunLoop.current.run(mode: .default, before: Date.distantFuture)
        }
    }
    
    func loadImages(_glossBase: String, _glitterBase: String, _metallicBase: String, _eyeshadowBase: String, _eyeshadowMetallic: String, _eyeshadowMirco: String, _eyeshadowNano: String, _blushBase: String) {
        
        let f = "loadImages(\(_glossBase), \(_glitterBase), \(_metallicBase), \(_eyeshadowBase), \(_eyeshadowMetallic), \(_eyeshadowMirco), \(_eyeshadowNano), \(_blushBase));"
        self.webView.evaluateJavaScript(f) { (response, error) in
            if error == nil {
                print("----return value : \(response)")
            } else {
                print("error: " + error.debugDescription)
            }
            RunLoop.current.run(mode: .default, before: Date.distantFuture)
        }
    }
    
    func updateEffectList(json: String) {
        let f = "updateEffectList(`\(json)`);"
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
    
    func applyEyeshadowJs(ra:Int, ga: Int, ba:Int, type: Int) {
        let f = "applyEyeshadow(" + String(ra) + "," + String(ga) + "," + String(ba) + "," + String(type) + ");"
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

extension MakeupViewController: WKUIDelegate {
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
