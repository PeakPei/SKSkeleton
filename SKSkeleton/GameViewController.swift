//
//  GameViewController.swift
//  SKSkeleton
//
//  Created by Ryan Knightly on 6/19/17.
//  Copyright © 2017 Ryan Knightly. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Firebase

class GameViewController: UIViewController {

    @IBOutlet var banner: GADBannerView!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GADMobileAds.configure(withApplicationID: kAdAppID)
        
        banner.adUnitID = kBannerID
        banner.rootViewController = self
        banner.load(GADRequest())
        
        //Configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        //Create and configure the scene
        let scene = StartScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        //Present the scene
        skView.presentScene(scene, transition: kScreenTransition)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showInterstitial),
                                               name: NSNotification.Name(rawValue: "showInterstitial"),
                                               object: nil)
    }
    
    func showInterstitial() {
        print("showing interstitial")
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            interstitial = createAd()
        } else {
            print("Not ready yet")
        }
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        //Set up the banner
        print("loading request")
        interstitial = GADInterstitial(adUnitID: kInterstitialID)
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func createAd() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: kInterstitialID)
        interstitial.load(GADRequest())
        return interstitial
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
