//
//  ViewController.swift
//  ShowImage
//
//  Created by Ty Walker on 8/9/16.
//  Copyright © 2016 Ty Walker. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var swiftimage: UIImageView!
    @IBOutlet weak var displaybutton: UIButton!
    
    @IBAction func actiondisplayimage(_ sender: AnyObject) {
        swiftimage.isHidden = false;
    }
    override func viewDidLoad() {
               super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem!)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton.addTarget(self, action: #selector(ViewController.playButtonTapped(_:)), for: .touchUpInside)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playButtonTapped(_ sender: AnyObject) {
        if player?.rate == 0
        {
            player!.play()
            playButton.setImage(UIImage(named: "1472177045_PauseDisabled copy.png"), for: UIControlState())
        } else {
            player!.pause()
            playButton.setImage(UIImage(named: "1472177058_Play1Disabled copy.png"), for: UIControlState())
        }
    
    }
    
    func finishedPlaying(_ myNotification:Notification) {
        playButton.setImage(UIImage(named: "1472177058_Play1Disabled copy.png"), for: UIControlState())
        
        let stopedPlayerItem: AVPlayerItem = myNotification.object as! AVPlayerItem
        stopedPlayerItem.seek(to: kCMTimeZero)
    }
 
}
