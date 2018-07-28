//
//  ViewController.swift
//  Party App
//
//  Created by Daniel on 28/7/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var faces = ["jamesface", "yjface"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        cell.faceImageView.image = UIImage(named: "\(faces[indexPath.item])")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let face = faces[indexPath.item]
        var xPos = CGFloat()
        var yPos = CGFloat()
        
        xPos = CGFloat(arc4random_uniform(UInt32((self.mainView?.frame.size.width)!)))
        yPos = CGFloat(arc4random_uniform(UInt32((self.mainView?.frame.size.height)!)))
        
        let image = UIImageView(frame: CGRect(x: xPos, y: yPos, width: 80, height: 80))
        image.image = UIImage(named: "\(face)")
        mainView.addSubview(image)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

