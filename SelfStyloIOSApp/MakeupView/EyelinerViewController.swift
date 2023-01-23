//
//  EyelinerViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 23/01/23.
//

import UIKit

class EyelinerViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var eyelinerCollectionView: UICollectionView!
    
    @IBOutlet weak var eyelinerCV: UIView!
    
    
    @IBOutlet weak var eyelinerStyleCV: UIView!
    
    
    var eyeliner_image:[String] = ["color_code_circle", "color_code_circle","color_code_circle", "color_code_circle","color_code_circle","color_code_circle","color_code_circle"]
    var eyeliner_name:[String] =  ["Default","Basic","Feline","Pin-up","Double-take","Triple-take","High-wing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        reloadCollectionViewData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MakeupViewController") as! MakeupViewController
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    func reloadCollectionViewData() {
        self.eyelinerCollectionView.reloadData()
    }

    func setDelegates()
    {
        eyelinerCollectionView.delegate = self
        eyelinerCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eyeliner_image.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eyelinerCollectionView.dequeueReusableCell(withReuseIdentifier: "EyelinerStyleCollectionViewCell", for: indexPath) as! EyelinerStyleCollectionViewCell
        cell.eyelinerImage.image = UIImage(named: eyeliner_image[indexPath.row])
        cell.eyelinerName.text = eyeliner_name[indexPath.row]

        return cell

    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0{
            eyelinerCV.isHidden = false
            eyelinerStyleCV.alpha = 0
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 25.0
    }
    

}
