//
//  ViewController.swift
//  Party App
//
//  Created by Daniel on 28/7/18.
//  Copyright © 2018 Placeholder Interactive. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollisionBehaviorDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var animator: UIDynamicAnimator!
    var collisions: UICollisionBehavior!
    var dynamics: UIDynamicItemBehavior!
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
        
        xPos = CGFloat(arc4random_uniform(UInt32(mainView.frame.width) - 85))
        yPos = CGFloat(arc4random_uniform(UInt32(mainView.frame.height) - 85))
        
        
        let image = UIImageView(frame: CGRect(x: xPos, y: yPos, width: 85, height: 85))
        image.image = UIImage(named: "\(face)")

        mainView.addSubview(image)
        collisions.addItem(image)
        dynamics.addItem(image)
        
        let push = UIPushBehavior(items: [image], mode: .instantaneous)
        push.angle = 2 * CGFloat(drand48() * Double.pi)
        push.magnitude = 1.0 + CGFloat(drand48() * 2)
        animator.addBehavior(push)
        
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            image.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: mainView)
        
        collisions = UICollisionBehavior(items: [])
        collisions.translatesReferenceBoundsIntoBoundary = true
        collisions.collisionDelegate = self
        animator.addBehavior(collisions)
        
        dynamics = UIDynamicItemBehavior(items: [])
        dynamics.elasticity = 1.0
        dynamics.resistance = 0
        
        animator.addBehavior(dynamics)
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("Sir, it appears that you have knocked into my enormous head! I apologise sincerely.")
    }

}

