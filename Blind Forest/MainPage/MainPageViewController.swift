//
//  MainPageViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import AVFoundation

class MainPageViewController: UIViewController {

    var soundArray : [AVAudioPlayer] = []
    var bgm : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bgmAudio()
    }

    @IBAction func toGame(_ sender: Any) {
        stopAllAudio()
        let sb = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "game")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false, completion: nil)
        
    }
    
    @IBAction func toOnboarding(_ sender: Any) {
        stopAllAudio()
        backToOnboarding()
        
    }
    
    func backToOnboarding() {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboarding")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false, completion: nil)
    }
    func bgmAudio(){

        let path = Bundle.main.path(forResource: "bgm only", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let bgm = try AVAudioPlayer(contentsOf: url)
            bgm.numberOfLoops = 3
            bgm.play()
            soundArray.append(bgm)
        } catch {
            
        }
    }
    func stopAllAudio(){
        for audio in soundArray{
            audio.stop()
        }
    }
}
