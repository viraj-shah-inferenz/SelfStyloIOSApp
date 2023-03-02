//
//  CombosViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 24/01/23.
//

import UIKit

class CombosViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var combosCollectionView: UICollectionView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    var combos_image:[String] = ["combos", "combos","combos", "combos","combos"]
    var combo_name:[String] =  ["Glow","Pop Of","Psych","Russet","Dull Mate"]
    
    var backToCategory : (()-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        reloadCollectionViewData()
        btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        backToCategory?()
//        let detailViewController:MakeupViewController = self.storyboard!.instantiateViewController(withIdentifier: "MakeupViewController") as! MakeupViewController
//        detailViewController.strOpenView = "second"
//        detailViewController.modalPresentationStyle = .fullScreen
//        self.present(detailViewController, animated: false)
    }
    
    func reloadCollectionViewData() {
        self.combosCollectionView.reloadData()
    }

    func setDelegates()
    {
        combosCollectionView.delegate = self
        combosCollectionView.dataSource = self
    }
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected{
            btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        }else
        {
            btnCheckbox.setImage(UIImage.init(named: "favourite_checked"), for: .normal)
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combos_image.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = combosCollectionView.dequeueReusableCell(withReuseIdentifier: "CombosCollectionViewCell", for: indexPath) as! CombosCollectionViewCell
        cell.comboImage.image = UIImage(named: combos_image[indexPath.row])
        cell.comboName.text = combo_name[indexPath.row]

        return cell
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 25.0
    }
}
