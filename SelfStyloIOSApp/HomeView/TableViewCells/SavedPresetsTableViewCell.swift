//
//  SavedPresetsTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit

class SavedPresetsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var savePresetsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    var save_image = [UIImage(named: "pexels_photo_1"),UIImage(named: "pexels_photo_2"),UIImage(named: "pexels_photo_3")]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDelegates()
        self.savePresetsCollectionView.register(UINib(nibName: "SavePresetsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SavePresetsCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDelegates() {
        self.savePresetsCollectionView.delegate = self
        self.savePresetsCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let savecell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavePresetsCollectionViewCell", for: indexPath) as! SavePresetsCollectionViewCell
                    savecell.contentView.layer.cornerRadius = 30
                    savecell.save_image.image = self.save_image[indexPath.row]
                        return savecell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.frame
        return CGSize(width: bounds.width/2.5, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
