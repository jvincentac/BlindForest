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
    @IBOutlet weak var mainBg: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var bingkai: UIImageView!
    
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
                endBgm()
                leftStone.isHidden = true
                middleStone.isHidden = true
                rightStone.isHidden = true
                mainBg.image = UIImage(named: "colorMainBackground")
                playBtn.setImage(UIImage(named: "replayBtn"), for: .normal)
                bingkai.image = UIImage(named: "bingkaiWarna")
            }
        }
        else {
            leftStone.isHidden = true
            middleStone.isHidden = true
            rightStone.isHidden = true
        }
    }
    
    @IBAction func toGame(_ sender: Any) {
        if let stage = UserDefaults.standard.object(forKey: "stage") {
            if stage as! Int == 4 {
                UserDefaults.standard.set(1, forKey: "stage")
                stopAllAudio()
                backgroundAudio()
            }
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
    
    @IBAction func toTutorial(_ sender: Any) {
        let sb = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "tutorial") as! tutorialViewController
        sb.modalPresentationStyle = .fullScreen
        sb.fromHome = true
        self.present(sb, animated: false, completion: nil)
    }
    
    func backToOnboarding() {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboarding")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false, completion: nil)
    }
    
    func backgroundAudio() {
        let path = Bundle.main.path(forResource: "bgm only", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let bgm = try AVAudioPlayer(contentsOf: url)
            bgm.numberOfLoops = -1
            bgm.play()
            soundArray.append(bgm)
        } catch {
            
        }
    }
    
    func stopAllAudio(){
        soundArray = FirstViewController.soundArray
        for audio in soundArray{
            audio.stop()
        }
    }
    
    func endBgm() {
        soundArray = FirstViewController.soundArray
        for audio in soundArray{
            audio.stop()
        }
        
        let path = Bundle.main.path(forResource: "endBgm", ofType:"mpeg")!
        let url = URL(fileURLWithPath: path)

        do {
            let bgm = try AVAudioPlayer(contentsOf: url)
            bgm.numberOfLoops = -1
            bgm.play()
            soundArray.append(bgm)
        } catch {
            
        }
    }
}
