//
//  TableViewController.swift
//  MemeMe
//
//  Created by Hiren Samtani on 14/05/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {
    
    
    var memes: [Meme]{
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        
        
        
        cell.imageView?.image=meme.imageMemed
        cell.textLabel?.text=meme.textTop
        cell.detailTextLabel?.text=meme.textBottom
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        
        controller.meme = memes[indexPath.row]
        
        navigationController!.pushViewController(controller, animated: true)
    }
    
    
    
    
}
