//
//  ViewController.swift
//  CollectionViewCells
//
//  Created by Cantero Francisco on 11/08/2017.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var testTableView: UITableView!
    var numberOfItems: [Int] = [20, 5, 6, 8, 7, 7, 5, 15]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testTableView.delegate = self
        testTableView.dataSource = self
//        testTableView.estimatedRowHeight = 131
//        testTableView.rowHeight = UITableViewAutomaticDimension
        testTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! CollectionCell
        var items: [Int] = []
        for i in 0..<numberOfItems[indexPath.row] {
            items.append(i)
        }
        cell.isCentered = false
        cell.numberOfItems = items
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.tableView(tableView, cellForRowAt: indexPath) as! CollectionCell
        var items: [Int] = []
        for i in 0..<numberOfItems[indexPath.row] {
            items.append(i)
        }
        cell.isCentered = false
        cell.numberOfItems = items
        return cell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

