//
//  ReadTableViewController.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftSpinner

class ReadTableViewController: UITableViewController {
    
    var readPresenter = ReadPresenter()
    
    var articles = [Article]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load data when view appear
        readPresenter.loadArticles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readPresenter.readTableViewControllerProtocol = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadCell", for: indexPath) as! ReadTableViewCell
        
        let art = articles[indexPath.row]
        
        cell.readTitle.text = art.title
        cell.readDes.text = art.description
        
        if let imgUrl = art.image, let url = URL(string: imgUrl){
            cell.readImg.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "unnamed"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            SwiftSpinner.show("Deleting...")
            // Get article to delete
            let delId = articles[indexPath.row].id
            // Tell presenter to delete
            readPresenter.deleteArticle(id: delId!)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row] // row or cell of article in screen display
        self.performSegue(withIdentifier: "UpdateSegue", sender: selectedArticle) // then sent the data of that row or cell by seque
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateSegue"{
            let art = sender as! Article // because when send by seque the data is any so we need to cast it to Article
            let vc = segue.destination as! UpdateTableViewController
            vc.artID = art.id // send data from Article that we just cast to property that we create in class UpdateTableViewController
            vc.artTitle = art.title
            vc.artDes = art.description
            vc.imgUrl = art.image
        }
    }
}
                        

extension ReadTableViewController : ReadTableViewControllerProtocol{
    func responseData(data: [Article]) {
        articles = data
        tableView.reloadData()
    }
    
    func deleteSuccess(message: String) {
        SwiftSpinner.hide()
        print(message)
        // Reload Data
        readPresenter.loadArticles()
    }
}
