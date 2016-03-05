//
//  CardsViewController.swift
//  tinder
//
//  Created by Mudit Mittal on 3/2/16.
//  Copyright © 2016 Mudit Mittal. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardIntialCenter: CGPoint!
    var heroImageHeight: CGFloat!
    var beginPanLocation: CGFloat!
    
    var fadeTransition: FadeTransition!
    
    
    @IBOutlet weak var heroImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func didPanImage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let location = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            cardIntialCenter = heroImageView.center
            heroImageHeight = heroImageView.frame.size.height
            beginPanLocation = location.y
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            //Move image in direction of pan
            heroImageView.center = CGPoint (x: cardIntialCenter.x + translation.x, y: cardIntialCenter.y)
            
            //Pan image based on location of touch
            if beginPanLocation < cardIntialCenter.y {
                heroImageView.transform = CGAffineTransformMakeRotation(CGFloat(Double(translation.x / 10) * M_PI / 180))
            } else {
                heroImageView.transform = CGAffineTransformMakeRotation(CGFloat(-Double(translation.x / 10) * M_PI / 180))
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translation.x > 70 {
                //Move image to extreme right
                UIView.animateWithDuration(0.3
                    , animations: { () -> Void in
                        self.heroImageView.center = CGPoint (x: self.cardIntialCenter.x + self.view.frame.height, y: self.cardIntialCenter.y)
                        
                        self.heroImageView.transform = CGAffineTransformMakeRotation(CGFloat(Double(self.heroImageView.center.x / 10) * M_PI / 180))

                })

                //Reset and bring image back
                UIView.animateWithDuration(0.3, delay: 1, options: [], animations: {
                    () -> Void in
                    self.heroImageView.center = CGPoint (x: self.cardIntialCenter.x, y: self.cardIntialCenter.y)
                    
                    self.heroImageView.transform = CGAffineTransformIdentity
                    }, completion: nil)

                
            } else if translation.x < -70 {
                //Move image to extreme left
                UIView.animateWithDuration(0.3
                    , animations: { () -> Void in
                        self.heroImageView.center = CGPoint (x: self.cardIntialCenter.x - self.view.frame.height, y: self.cardIntialCenter.y)
                        
                        self.heroImageView.transform = CGAffineTransformMakeRotation(CGFloat(Double(self.heroImageView.center.x / 10) * M_PI / 180))
                })
                
                //Reset and bring image back
                UIView.animateWithDuration(0.3, delay: 1, options: [], animations: {
                    () -> Void in
                    self.heroImageView.center = CGPoint (x: self.cardIntialCenter.x, y: self.cardIntialCenter.y)
                    
                    self.heroImageView.transform = CGAffineTransformIdentity
                    }, completion: nil)
                
                
            } else {
                //Bring image back to center
                UIView.animateWithDuration(0.3
                    , animations: { () -> Void in
                        self.heroImageView.center = CGPoint (x: self.cardIntialCenter.x, y: self.cardIntialCenter.y)
                        
                        self.heroImageView.transform = CGAffineTransformIdentity
                })
            }

        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController as! ProfileViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        destinationViewController.view.layoutIfNeeded()
        destinationViewController.imageView.image = heroImageView.image

        fadeTransition = FadeTransition()
        
        destinationViewController.transitioningDelegate = fadeTransition
        fadeTransition.duration = 0.4
        
        

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
