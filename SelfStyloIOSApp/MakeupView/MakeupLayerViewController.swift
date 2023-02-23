//
//  MakeupLayerViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 17/02/23.
//

import UIKit
protocol MakeupDelegate {
    func removeMakeup(data: [String: Any])
}
class MakeupLayerViewController: UIViewController {

    @IBOutlet weak var layerTableView: UITableView!
    @IBOutlet weak var tableViewHight: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    
    var makeupLayerData: Dictionary = [String:Any]()
    
    var keys = [String]()
    var vals: [String:[String:Any]] = [:]
    
    var delegate: MakeupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        btnBack.addTarget(self,
                          action: #selector(closeView),
                          for: .touchUpInside
        )
        setupView()
    }
    
    fileprivate func setupView() {
        convertDictionarytoJson()
        
        layerTableView.register(UINib(nibName: "MakeupLayerTableViewCell", bundle: nil), forCellReuseIdentifier: "MakeupLayerTableViewCell")
        
        layerTableView.backgroundColor = .clear
        layerTableView.delegate = self
        layerTableView.dataSource = self
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func convertDictionarytoJson() {
        
        let numberOfCell = CGFloat(makeupLayerData.count)
        let maxHeight = self.view.bounds.maxY
        if numberOfCell > maxHeight {
            tableViewHight.constant = maxHeight
        } else {
            tableViewHight.constant = numberOfCell * 98.0
        }
        
        
        self.keys.removeAll()
        self.vals.removeAll()
        
        for (key, value) in makeupLayerData {
            self.keys.append(key)
            guard let data = value as? [String: Any] else { return }
            self.vals.updateValue(data, forKey: key)
        }
        print(vals)
        layerTableView.reloadData()
        
    }
    
    @objc
    func removeItem(_ sender: UIButton) {
        print(sender.tag)
        let strMakeup = keys[sender.tag]
        print(strMakeup)
        makeupLayerData.removeValue(forKey: strMakeup)
        if makeupLayerData.keys.count == 0 {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.removeMakeup(data: makeupLayerData)
        convertDictionarytoJson()
    }
}


extension MakeupLayerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vals.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MakeupLayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MakeupLayerTableViewCell") as! MakeupLayerTableViewCell
        cell.backView.layer.borderColor = UIColor.gray.cgColor
        cell.imgColorCode.layer.cornerRadius = cell.imgColorCode.frame.height / 2
        cell.imgColorCode.clipsToBounds = false
        
        let str = keys[indexPath.row]
        
        if let data: [String: Any] = vals[str] {
            
            cell.categoryName.text = str
            let colorArray = data["color"] as? [Int]
            let red = CGFloat(Double(colorArray![0]) / 255.0)
            let green = CGFloat(Double(colorArray![1]) / 255.0)
            let blue = CGFloat(Double(colorArray![2]) / 255.0)
            
            cell.imgColorCode.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            cell.makeupName.text = data["category_name"] as? String
            cell.productName.text = data["colorName"] as? String
            
            cell.removeItemButton.tag = indexPath.row
            
            cell.removeItemButton.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
            
            switch(str) {
            case "Lipstick":
                cell.imgMakeupImage.image = UIImage(named: "lipstick_icon")
                break
            case "Eyeshadow":
                cell.imgMakeupImage.image = UIImage(named: "eyeshadow")
                break
            case "Eyeliner":
                cell.imgMakeupImage.image = UIImage(named: "eyeliner")
                break
            case "Blush":
                cell.imgMakeupImage.image = UIImage(named: "blush")
                break
            case "Foundation":
                cell.imgMakeupImage.image = UIImage(named: "foundation")
                break
            default:
                break
            }
        }
        
            
        
        cell.backView.layer.borderWidth = 1.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98.0
    }
}

extension Dictionary {
    func containsKey(_ key: Key) -> Bool {
        index(forKey: key) != nil
    }
}
