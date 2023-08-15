//
//  LikedPeopleTableViewCell.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import UIKit

class LikedPeopleTableViewCell: UITableViewCell {
    
    var data: [Profile] = []

    @IBOutlet weak var vFree: UIView!
    @IBOutlet weak var vPremium: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(data: [Profile]) {
        if data[0].premium {
            vFree.isHidden = true
            vPremium.isHidden = false
        }else {
            vFree.isHidden = false
            vPremium.isHidden = true
        }
        self.data = data
        self.collectionView.reloadData()
    }
}

extension LikedPeopleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 255)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.imgPerson.load(urlString: data[indexPath.row].image[0])
        if data[indexPath.row].premium {
            cell.imgPerson.addBlur(0)
        }else {
            cell.imgPerson.addBlur(1)
        }
        cell.lblName.text = data[indexPath.row].name
        return cell
    }
    
    
    
}
