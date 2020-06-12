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
    @IBOutlet weak var leftStone: UIImageView!
    @IBOutlet weak var rightStone: UIImageView!
    @IBOutlet weak var middleStone: UIImageView!
    @IBOutlet weak var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.coverView.alpha = 0
        }
    }
    
    func setupPage() {
        if let stage = UserDefaults.standard.object(forKey: "stage") {
            if stage as! Int == 2 {
                leftStone.isHidden = false
                middleStone.isHidden = true
                rightStone.isHidden = true
            }
            else if stage as! Int == 3 {
                leftStone.isHidden = false
                middleStone.isHidden = true
                rightStone.isHidden = false
            }
            else if stage as! Int > 3 {
                leftStone.isHidden = false
                middleStone.isHidden = false
                rightStone.isHidden = false
            }
        }
        else {
            leftStone.isHidden = true
            middleStone.isHidden = true
            rightStone.isHidden = true
        }
    }
    
    @IBAction func toGame(_ sender: Any) {
        stopAllAudio()
        if let stage = UserDefaults.standard.object(forKey: "stage") {
            let sb = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "game")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "tutorial")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }
        
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
