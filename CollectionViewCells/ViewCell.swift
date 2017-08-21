//
//  ViewCell.swift
//  CollectionViewCells
//
//  Created by Cantero Francisco on 14/08/2017.
//

import UIKit

class ViewCell: UITableViewCell {

    @IBOutlet weak var numbersView: NumbersView!
    
    var numberOfItems: [Int] = [] {
        didSet {
//            collectionView.reloadData()
//            collectionView.collectionViewLayout.invalidateLayout()
//            collectionView.layoutIfNeeded()
            layoutIfNeeded()
            numbersView.numbers = numberOfItems
            numbersView.layoutIfNeeded()
//            updateHeightConstraint()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        numbersView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numbersView.layoutIfNeeded()
        numbersView.updateConstraints()
//        numbersView.frame.size = CGSize(width: bounds.width - 20, height: numbersView.frame.height)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        numbersView.updateConstraints()
    }
}
