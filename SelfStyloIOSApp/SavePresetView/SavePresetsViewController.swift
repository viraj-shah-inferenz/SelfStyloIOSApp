//
//  SavePresetsViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit

class SavePresetsViewController: UIViewController {

    
    @IBOutlet weak var btnBackHome: UIButton!
    @IBOutlet weak var savePresetsCollectionView: UICollectionView!
    var save_image = [UIImage(named: "pexels_photo_1"),UIImage(named: "pexels_photo_2"),UIImage(named: "pexels_photo_3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegates()
        btnBackHome.addTarget(self, action: #selector(BackHome(sender: )), for: .touchUpInside)
    }
    
    @objc func BackHome(sender: UIButton){
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    func setDelegates() {
        self.savePresetsCollectionView.delegate = self
        self.savePresetsCollectionView.dataSource = self
    }

}

extension SavePresetsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return save_image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavePresetsCollectionViewCell", for: indexPath)
        if let vc = cell.viewWithTag(1) as? UIImageView{
            vc.image = save_image[indexPath.row]
        }
        cell.contentView.layer.cornerRadius = 24
        
        return cell
    }


}


extension SavePresetsViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = savePresetsCollectionView.bounds
        return CGSize(width: bounds.width/2 - 50, height: bounds.height/5)
    }

}
