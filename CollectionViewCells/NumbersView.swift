//
//  NumbersView.swift
//  X-Sell Results
//
//  Created by Cantero Francisco on 11/08/2017.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? super.description
        
        return "id: \(id), constant: \(constant)"
    }
}

class NumbersView: UIView {
    
    var numbers: [Int] = [] {
        didSet {
//            collectionView.reloadData()
            addLotteryNumbers()
//            updateHeightConstraint()
            layoutIfNeeded()
        }
    }
    var isCentered: Bool = true {
        didSet {
//            collectionView.collectionViewLayout.invalidateLayout()
//            updateHeightConstraint()
            layoutIfNeeded()
        }
    }
    
    private(set) var lotteryViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLotteryNumbers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLotteryNumbers()
    }
    
    let numberFrame: CGRect = {
        return CGRect(x: 0, y: 0,
                      width: CollectionConstants.cellWidth,
                      height: CollectionConstants.cellWidth)
    }()
    
    func addLotteryNumbers() {
        removeLotteryNumbers()
        translatesAutoresizingMaskIntoConstraints = true
        for number in numbers {
            let numberView = UIView(frame: .zero)
            numberView.backgroundColor = .green
            lotteryViews.append(numberView)
            addSubview(numberView)
        }
    }
    
    func removeLotteryNumbers() {
        for numberView in lotteryViews {
            numberView.removeFromSuperview()
        }
        lotteryViews.removeAll()
    }
    
    func calculateViewsPosition() {
        var lastElementPosition = CGPoint.zero
        
        for view in lotteryViews {
            view.frame = numberFrame
            
            let origin = originX(using: lastElementPosition)
            if(origin + CollectionConstants.cellSpacing
                + CollectionConstants.cellWidth < bounds.width) {
                view.frame.origin.x = origin + CollectionConstants.cellSpacing
                view.frame.origin.y = lastElementPosition.y
            } else {
                view.frame.origin.y = lastElementPosition.y + CollectionConstants.cellWidth
                    + CollectionConstants.lineSpacing
                view.frame.origin.x = CollectionConstants.cellSpacing
            }
            lastElementPosition = view.frame.origin
        }
        
        updateHeightConstraint()
    }
    
    var numbersSize: CGSize {
        let maxY = lotteryViews.map { $0.frame.origin.y }.max()
        return CGSize(width: bounds.width, height: (maxY ?? 0) + 20)
    }
    
    func originX(using lastElementPosition: CGPoint) -> CGFloat {
        return lastElementPosition == .zero
            ? 0
            : lastElementPosition.x + CollectionConstants.cellWidth
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateViewsPosition()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        updateHeightConstraint()
    }
    
    func updateHeightConstraint() {
        removeAutoResizingHeight()
        if let constraint = (constraints.filter { $0.firstAttribute == .height }.last) {
            constraint.constant = numbersSize.height
        }
    }
    
    func removeAutoResizingHeight() {
//        constraints.filter { $0 is NSAutoresizingMaskLayoutConstraint }
//        constraints.filter { $0.firstAttribute == .height }
    }
}
