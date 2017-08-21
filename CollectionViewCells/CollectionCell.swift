//
//  CollectionCell.swift
//  CollectionViewCells
//
//  Created by Cantero Francisco on 11/08/2017.
//

import UIKit

struct CollectionConstants {
    static let cellWidth: CGFloat = 35
    static let cellSpacing: CGFloat = 10
    static let lineSpacing: CGFloat = 5
}

class CollectionCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpFlowLayout()
    }
    
    fileprivate let collectionViewCellName = "CollectionViewCell"
    var numberOfItems: [Int] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.layoutIfNeeded()
            updateHeightConstraint()
        }
    }
    
    var isCentered: Bool = true {
        didSet {
            collectionView.collectionViewLayout.invalidateLayout()
            updateHeightConstraint()
        }
    }
    
    private func setUpFlowLayout() {
        collectionView.collectionViewLayout = CollectionFlow()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        updateHeightConstraint()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
        contentView.layoutIfNeeded()
        updateHeightConstraint()
    }
    
    func updateHeightConstraint() {
        if let constraint = (collectionView.constraints.filter { $0.firstAttribute == .height }.last) {
            let height = collectionView.collectionViewLayout.collectionViewContentSize.height
            if height > 0 {
                constraint.constant = height
            }
        }
    }
    
    var cellHeight: CGFloat {
        return (collectionView.constraints.filter { $0.firstAttribute == .height }.last)!.constant + 20
    }
}

extension CollectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 35, height: 35)
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellName,
                                                      for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionConstants.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let collectionViewWidth = collectionView.bounds.width
        
        var insets: UIEdgeInsets = .zero
        let rightInset = (collectionViewWidth - totalContentWidth) / 2
        if shouldCenterContents {
            let leftInset = rightInset
            insets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        } else if contentIsLessThanWidth {
            insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -rightInset * 2)
        }
        
        return insets
    }
    
    var shouldCenterContents: Bool {
        return contentIsLessThanWidth && isCentered
    }
    
    var contentIsLessThanWidth: Bool {
        return collectionView.bounds.width > totalContentWidth
    }
    
    var totalContentWidth: CGFloat {
        let width: CGFloat = CGFloat(totalCellWidth + totalSpacingWidth)
        return width
    }
    
    var totalCellWidth: CGFloat {
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CollectionConstants.cellWidth * cellCount
    }
    
    var totalSpacingWidth: CGFloat {
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CollectionConstants.cellSpacing * (cellCount - 1)
    }
}
