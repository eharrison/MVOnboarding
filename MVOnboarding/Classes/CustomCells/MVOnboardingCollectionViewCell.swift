//
//  MVOnboardingCollectionViewCell.swift
//  Micro Learning App
//
//  Created by Evandro Harrison Hoffmann on 14/07/2016.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

@IBDesignable
open class MVOnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak open var backgroundImage: UIImageView!
    @IBOutlet weak open var transparentBackgroundView: UIView!
    @IBOutlet weak open var iconImageView: UIImageView!
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var descriptionTable: UILabel!
    @IBOutlet weak open var actionButton: UIButton!
    
    @IBInspectable var videoName: String?
    @IBInspectable var videoWidthMultiplier: CGFloat = 1
    
    private var player: AVPlayer?
    private var rate: Float = 1
    
    func addsBackgroundVideoIfAny(){
        guard let fileName = videoName?.components(separatedBy: ".").first else {
            return
        }
        
        guard let videoExtension = videoName?.components(separatedBy: ".").last else {
            return
        }
        
        guard let videoURL: URL = Bundle.main.url(forResource: fileName, withExtension: videoExtension) else {
            return
        }
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.frame.size.width*videoWidthMultiplier, height: self.frame.size.height))
        self.layer.addSublayer(playerLayer)
        
//        let moviePlayerController = AVPlayerViewController()
//        moviePlayerController.player = player
//        moviePlayerController.view.frame = self.frame
//        moviePlayerController.videoGravity = AVLayerVideoGravityResizeAspectFill
//        moviePlayerController.view.sizeToFit()
//        moviePlayerController.showsPlaybackControls = false
//        self.addSubview(moviePlayerController.view)
        
        player?.play()
        
        //loop video
        NotificationCenter.default.addObserver(self,
                                               selector: "loopVideo",
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
}
