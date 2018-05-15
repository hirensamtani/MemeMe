//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Hiren Samtani on 14/05/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes:[Meme]{
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    func setupFlowLayout() {
        let items: CGFloat = view.frame.size.width > view.frame.size.height ? 5.0 : 3.0
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - ((items + 1) * space)) / items
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 8.0 - items
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFlowLayout()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData()
        
        
        setupFlowLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        
        
        cell.image?.image = meme.imageMemed
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        
        controller.meme = memes[indexPath.row]
        
        navigationController!.pushViewController(controller, animated: true)
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        setupFlowLayout()
    }
    
    
    
}
