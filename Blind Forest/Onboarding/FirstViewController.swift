//
//  FirstViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    var bgm : AVAudioPlayer?
    static var soundArray : [AVAudioPlayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let visited = UserDefaults.standard.object(forKey: "visited") {
            bgmAudio()
            let sb = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "main")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }
        else {
            bgmAudio()
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboarding")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }
    }
    func bgmAudio(){

        let path = Bundle.main.path(forResource: "bgm only", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let bgm = try AVAudioPlayer(contentsOf: url)
            bgm.numberOfLoops = -1
            bgm.play()
            FirstViewController.soundArray.append(bgm)

        } catch {
            
        }
    }

}
