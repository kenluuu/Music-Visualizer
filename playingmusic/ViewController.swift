//
//  ViewController.swift
//  playingmusic
//
//  Created by Ken Lu on 5/23/18.
//  Copyright © 2018 Ken Lu. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    var playBtn = UIButton()
    var pauseBtn = UIButton()
    var audioPlayer = AVAudioPlayer()
    lazy var visualizer : VisualizerView = {
        return VisualizerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 75))
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addButtons()
        view.addSubview(visualizer)
        
    }
    
    
    
    func addButtons() -> Void {
        playBtn.setTitle("Play", for: UIControlState.normal)
        playBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        playBtn.frame = CGRect(x: view.frame.width/2 - 25, y: view.frame.height - 65, width: 50, height: 50)
        
        playBtn.addTarget(self, action: #selector(playOnTouch), for: UIControlEvents.touchUpInside)
        view.addSubview(playBtn)
        pauseBtn.setTitle("Pause", for: .normal)
        pauseBtn.setTitleColor(UIColor.black, for: .normal)
        pauseBtn.frame = CGRect(x: view.frame.width/2 - 25, y: view.frame.height - 65, width: 50, height: 50)
  
        pauseBtn.addTarget(self, action: #selector(pauseOnTouch), for: .touchUpInside)
    }
    
    
    
    
    @objc func playOnTouch() -> Void {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource: "escape", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            let audioSession = AVAudioSession()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch {
                print(error)
            }
        } catch {
            print("error: \(error)")
        }
        audioPlayer.isMeteringEnabled = true
        visualizer.audioPlayer = audioPlayer
        playBtn.removeFromSuperview()
        view.addSubview(pauseBtn)
        
        audioPlayer.play()
    }
    
    @objc func pauseOnTouch() -> Void {
        pauseBtn.removeFromSuperview()
        view.addSubview(playBtn)
        audioPlayer.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

