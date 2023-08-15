//
//  InterestedTableViewCell.swift
//  Project
//
//  Created by Kiran Nayak on 15/08/23.
//

import UIKit

class InterestedTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var vHeader: UIView!
    var images: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.register(UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        
    }
    
    func setupCell(row: Int, note: CustomNoteModel) {
        if row == 0 {
            vHeader.isHidden = false
        }else {
            vHeader.isHidden = true
        }
        images = note.profile[0].image.compactMap({
            return $0
        })
        lblName.text = note.profile[0].name
        collectionView.reloadData()
    }
    
}


extension InterestedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 334)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.imgPerson.load(urlString: images[indexPath.row])
        cell.lblName.text = ""
        return cell
    }
    
    
    
}
