//
//  resultsViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class resultsViewController: UIViewController {

    @IBOutlet weak var stonePicture: UIImageView!
    @IBOutlet weak var loseStonePicture: UIImageView!
    
    let emitterNode = SKEmitterNode(fileNamed: "magic.sks")!
    let emitterNode2 = SKEmitterNode(fileNamed: "redSnow.sks")!
    var win : Bool?
    var stage = 0
    var soundArray : [AVAudioPlayer?] = []
    @IBOutlet weak var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(stage)
        if win == true{
            completeAudio()
            addPicture()
            addMagic(particle: emitterNode)
        }
        else if win == false{
            gameoverAudio()
            addPictureLose()
            addMagic(particle: emitterNode2)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 5) {
            self.coverView.alpha = 0
        }
    }
    
    func addPicture() {
        if stage == 1 {
            stonePicture.image = UIImage(named: "kiri")
            emitterNode.particleColor = .blue
        }
        else if stage == 2 {
            stonePicture.image = UIImage(named: "kanan")
            emitterNode.particleColor = .yellow
        }
        else if stage == 3 {
            stonePicture.image = UIImage(named: "tengah")
            emitterNode.particleColor = .red
        }
        loseStonePicture.isHidden = true
    }
    
    func addPictureLose() {
        print(stage)
        if stage == 1 {
            loseStonePicture.image = UIImage(named: "kiriLose")
            emitterNode2.particleColor = .blue
        }
        else if stage == 2 {
            loseStonePicture.image = UIImage(named: "kananLose")
            emitterNode2.particleColor = .yellow
        }
        else if stage == 3 {
            loseStonePicture.image = UIImage(named: "tengahLose")
            emitterNode2.particleColor = .red
        }
        stonePicture.isHidden = true
    }
    
    func addMagic(particle: SKEmitterNode) {
        let skView = SKView(frame: view.frame)
        skView.backgroundColor = .clear
        
        let scene = SKScene(size: view.frame.size)
        scene.backgroundColor = .clear
        
        skView.presentScene(scene)
        skView.isUserInteractionEnabled = false
        
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(particle)
        
        if win! {
            particle.position.y = scene.frame.midY
        }
        else {
            particle.position.y = scene.frame.maxY
        }
        
        particle.particlePositionRange.dx = scene.frame.width
        
        view.addSubview(skView)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let sb = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "main")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false, completion: nil)
    }

    func gameoverAudio(){
        let path = Bundle.main.path(forResource: "game over", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    
    func completeAudio(){
        let path = Bundle.main.path(forResource: "complete 2", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    
}
