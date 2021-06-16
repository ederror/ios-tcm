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
    /*
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.dataLoad()
        
    }
    
    /*
    //For CoreData View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recycles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = recycles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 */
    
}
