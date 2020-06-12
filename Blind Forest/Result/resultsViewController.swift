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
    
    let emitterNode = SKEmitterNode(fileNamed: "magic.sks")!
    let emitterNode2 = SKEmitterNode(fileNamed: "redSnow.sks")!
    var win = true
    let stage = UserDefaults.standard.object(forKey: "stage")
    var soundArray : [AVAudioPlayer?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if win {
            completeAudio()
            addPicture()
            addMagic(particle: emitterNode)
        }
        else {
            gameoverAudio()
            addMagic(particle: emitterNode2)
            addPictureLose()
        }
    }
    
    func addPicture() {
        if stage as! Int == 2 {
            stonePicture.image = UIImage(named: "kiri")
            emitterNode.particleColor = .blue
        }
        else if stage as! Int == 3 {
            stonePicture.image = UIImage(named: "kanan")
            emitterNode.particleColor = .yellow
        }
        else if stage as! Int == 4 {
            stonePicture.image = UIImage(named: "tengah")
            emitterNode.particleColor = .red
        }
    }
    
    func addPictureLose() {
        //masukin gambar kalah
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
        
        if win {
            emitterNode.position.y = scene.frame.midY
        }
        else {
            emitterNode.position.y = scene.frame.maxY
        }
        
        emitterNode.particlePositionRange.dx = scene.frame.width
        
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
        let path = Bundle.main.path(forResource: "complete", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    
}
