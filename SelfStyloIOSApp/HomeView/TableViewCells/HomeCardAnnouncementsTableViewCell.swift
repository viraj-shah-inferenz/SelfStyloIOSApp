//
//  HomeCardAnnouncementsTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit

class HomeCardAnnouncementsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,GetUsersDelegate {
    func refreshFavouriteProductsList(favouriteproductList: [FavouriteProducts]) {
        
    }
    
    func refreshBannerList(bannerList: [Banner]) {
        self.imgArr = bannerList
        self.sliderCollectionView.reloadData()
    }
    
    
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    
    @IBOutlet weak var pageView: UIPageControl!
    
//    var imgArr = [UIImage(named: "image_1"),UIImage(named: "image_2"),UIImage(named: "image_3")]
    
    var imgArr:[Banner] = []
    
    var apiUtils = ApiUtils()

    var timer = Timer()
    var counter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDelegates()
        self.sliderCollectionView.register(UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
        setCardView(toView: sliderCollectionView)
        pageView.numberOfPages = imgArr.count
        apiUtils.getBanner()
        let db = BannerDao()
        db.getAll()
        apiUtils.getBanner()
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeImage()
    {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as! ImageSliderCollectionViewCell
        let defaultLink = "https://dev.selfstylo.com"
        let completeLink1 = defaultLink + imgArr[indexPath.row].upload_image
        cell.sliderImageView?.DownloadedFrom(link: completeLink1)
       return cell
    }
    
}

extension HomeCardAnnouncementsTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = collectionView.frame.size
            return CGSize(width: size.width, height: size.height)
    }

}
