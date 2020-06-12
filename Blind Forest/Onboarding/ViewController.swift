//
//  ViewController.swift
//  Blind Forest
//
//  Created by M Habib Ali Akbar on 10/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var forestImageView: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    
    let emitterNode = SKEmitterNode(fileNamed: "Rain.sks")!
    var soundArray : [AVAudioPlayer] = []
    var bgm : AVAudioPlayer?
    var thunder : AVAudioPlayer?
    var tapCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opening()
        addRain()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        thunderEffect()
    }
    
    private func opening() {
        UIView.animate(withDuration: 1, delay: 1, options: [.curveEaseInOut], animations: {
            self.storyLabel.alpha = 1
        }, completion: nil)
    }
    
    private func addRain() {
        let skView = SKView(frame: view.frame)
        skView.backgroundColor = .clear
        
        let scene = SKScene(size: view.frame.size)
        scene.backgroundColor = .clear
        
        skView.presentScene(scene)
        skView.isUserInteractionEnabled = false
        
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(emitterNode)
        
        emitterNode.position.y = scene.frame.maxY
        emitterNode.particlePositionRange.dx = scene.frame.width
        
        view.addSubview(skView)
    }
    
    private func thunderEffect() {
        storyLabel.alpha = 0
        blackView.alpha = 0
        
        tapCounter += 1
        
        
        if tapCounter == 1 {
            thunderAudio()
            storyLabel.text = "The only way to bring back the light is by collect all \"The three stone of light\" from spirit forest"
            forestImageView.image = #imageLiteral(resourceName: "forestBg2")
        } else if tapCounter == 2 {
            thunderAudio()
            storyLabel.text = "You must find these stone but remember, always follow the sound of spirit that guide you."
            forestImageView.image = #imageLiteral(resourceName: "forestBg3")
        }
        else if tapCounter == 3 {
            thunderAudio()
            storyLabel.text = "Use Your Earphone!"
            forestImageView.image = #imageLiteral(resourceName: "forestBg3")
        }
        else if tapCounter == 4 {
            storyLabel.text = ""
        }
        
        UIView.animateKeyframes(
            withDuration: 3,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.01) {
                    self.blackView.alpha = 0.5
                }
                UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.03) {
                    self.blackView.alpha = 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0.02, relativeDuration: 1) {
                    self.blackView.alpha = 1
                    self.storyLabel.alpha = 1
                }
        },
            completion: { (isEnded) in
                if self.tapCounter == 4 {
                    UserDefaults.standard.set(false, forKey: "visited")
                    let sb = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "main")
                    sb.modalPresentationStyle = .fullScreen
                    self.present(sb, animated: false, completion: nil)
                }
            })
    }
    func bgmAudio(){

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
    
    func thunderAudio(){
        let path = Bundle.main.path(forResource: "thunder", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let thunder = try AVAudioPlayer(contentsOf: url)
            thunder.play()
            soundArray.append(thunder)
        } catch {
            
        }
    }
    func stopAllAudio(){
        for audio in soundArray{
            audio.stop()
        }
    }
}

