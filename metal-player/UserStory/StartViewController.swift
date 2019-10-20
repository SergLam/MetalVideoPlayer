//
//  ViewController.swift
//  metal-player
//
//  Created by Serg Liamthev on 10/19/19.
//  Copyright © 2019 serglam. All rights reserved.
//

import AVFoundation
import UIKit

class StartViewController: UIViewController {
    
    let player: AVPlayer = AVPlayer()
    
    lazy var playerItemVideoOutput: AVPlayerItemVideoOutput = {
        let attributes = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        return AVPlayerItemVideoOutput(pixelBufferAttributes: attributes)
    }()
    
    lazy var displayLink: CADisplayLink = {
        let dl = CADisplayLink(target: self, selector: #selector(readBuffer(_:)))
        dl.add(to: .current, forMode: RunLoop.Mode.default)
        dl.isPaused = true
        return dl
    }()
    
    private let contentView = StartView()
    private var metalView = MetalView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.addSubview(metalView)
        metalView.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: metalView, attribute: $0, relatedBy: .equal, toItem: contentView, attribute: $0, multiplier: 1, constant: 0)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupPlayer()
        
        // Resume the display link
        displayLink.isPaused = false
        
        // Start to play
        player.play()
    }
    
    private func setupPlayer() {
        
        guard let url = Bundle.main.url(forResource: "video", withExtension: "mp4") else {
            print("Impossible to find the video.")
            return
        }
        
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.add(playerItemVideoOutput)
        player.replaceCurrentItem(with: playerItem)
    }
    
    @objc
    private func readBuffer(_ sender: CADisplayLink) {
        
        var currentTime = CMTime.invalid
        let nextVSync = sender.timestamp + sender.duration
        currentTime = playerItemVideoOutput.itemTime(forHostTime: nextVSync)
        
        if playerItemVideoOutput.hasNewPixelBuffer(forItemTime: currentTime), let pixelBuffer = playerItemVideoOutput.copyPixelBuffer(forItemTime: currentTime, itemTimeForDisplay: nil) {
            self.metalView.pixelBuffer = pixelBuffer
            self.metalView.inputTime = currentTime.seconds
        }
    }
    
}

