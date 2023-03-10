//
//  HomeCardAnnouncementsTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit
import SDWebImage

class HomeCardAnnouncementsTableViewCell: UITableViewCell{
   

    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    
    @IBOutlet weak var pageView: UIPageControl!
    
//    var imgArr = [UIImage(named: "image_1"),UIImage(named: "image_2"),UIImage(named: "image_3")]
    
    var imgArr:[Banner] = []
    var timer = Timer()
    var counter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sliderCollectionView.register(UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
        setCardView(toView: sliderCollectionView)
        setDelegates()
        setpageView()
        setBannerData()
        

    }
    
    func setBannerData() {
        let db = BannerDao()
        for banner in db.getAll()
        {
            imgArr.append(banner)
        }
        
    }
    
    
    
    func setpageView(){
        pageView.currentPage = 0
        pageView.numberOfPages = imgArr.count
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage()
    {
        if !imgArr.isEmpty && sliderCollectionView.numberOfItems(inSection: 0) == imgArr.count{
            if counter < imgArr.count{
                let index = IndexPath.init(item: counter, section: 0)
                self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                pageView.currentPage = counter
                counter += 1
                
            }else{
                counter = 0
                let index = IndexPath.init(item: counter, section: 0)
                self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                pageView.currentPage = counter
                counter = 1
            }
        }
    }
    
    
    func setCardView(toView: UIView)
    {
        toView.layer.shadowColor = UIColor.black.cgColor
        toView.layer.shadowRadius = 42
        toView.layer.shadowOffset = CGSize(width: 0, height: 0)
        toView.layer.cornerRadius = 15
        toView.layer.borderColor = UIColor.white.cgColor
        toView.layer.borderWidth = 7
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        func setDelegates() {
            self.sliderCollectionView.delegate = self
            self.sliderCollectionView.dataSource = self
            
        }
    

    
    
  
    
}

extension HomeCardAnnouncementsTableViewCell:GetUsersDelegate{
    func refreshBannerList(bannerList: [Banner]) {
        self.imgArr = bannerList
        self.sliderCollectionView.reloadData()
    }
}

extension HomeCardAnnouncementsTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as! ImageSliderCollectionViewCell
        let defaultLink = "https://dev.selfstylo.com"
        let completeLink1 = defaultLink + imgArr[indexPath.row].uploadImage
        
        cell.sliderImageView.sd_setImage(with: URL(string: completeLink1))
//        cell.sliderImageView?.DownloadedFrom(link: completeLink1)
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }

}
