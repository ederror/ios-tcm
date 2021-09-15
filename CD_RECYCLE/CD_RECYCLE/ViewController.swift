//
//  ViewController.swift
//  CD_RECYCLE
//
//  Created by 백인찬 on 2021/05/06.
//

import UIKit
import CoreData
import SwiftCSV


class ViewController: UIViewController{//}, UITableViewDelegate, UITableViewDataSource {
    var container: NSPersistentContainer!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.dataLoad()
        
    }
}
