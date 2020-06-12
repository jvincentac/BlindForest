//
//  gameViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class gameViewController: UIViewController {
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var forestImageView: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var gif: UIImageView!
    var soundArray : [AVAudioPlayer] = []
    var step = 0
    
    //0 tembok
    //1 jalan
    //2 persimpangan kiri, 3 persimpangan kanan, 4 persimpangan atas
    //5 selesai
    
    let map : [[Int]] = [
        [0,0,0,0,0,0],
        [0,1,1,1,5,0],
        [0,1,0,0,0,0],
        [0,1,1,0,0,0],
        [0,0,1,0,0,0],
        [0,1,4,1,0,0],
        [0,1,0,1,0,0],
        [0,1,0,0,1,0],
        [0,1,2,1,1,0],
        [0,0,1,0,0,0],
        [0,1,3,0,0,0],
        [0,0,0,0,0,0]
    ]
    var detik = Timer()
    var countdown = Timer()
    var playerPosition : [Int] = []
    var time = 60
    let emitterNode = SKEmitterNode(fileNamed: "Rain.sks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bgmAudio()
        playerPosition = [1,map.count-2]
        setupSwipeGesture()
        addRain()
        timer.text = String(time)
        
        detik = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 8...10)), repeats: true) { timer in
            self.setupPageAnimation()
            
        }
        
        countdown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.time == 0 {
                timer.invalidate()
                //logic kalah
                self.detik.invalidate()
                self.countdown.invalidate()
                self.stopAllAudio()
                let sb = UIStoryboard(name: "Results", bundle: nil).instantiateViewController(withIdentifier: "lose")
                sb.modalPresentationStyle = .fullScreen
                self.present(sb
                    , animated: false, completion: nil)
            }else if self.time == 30{
                self.wolfAudio()
                self.time -= 1
                self.timer.text = String(self.time)
            }
            else {
                self.time -= 1
                self.timer.text = String(self.time)
            }
        }
        
    }
    
    func setupPageAnimation() {
        self.thunderAudio()
        blackView.alpha = 0
        UIView.animateKeyframes(
            withDuration: 3,
            delay: 0,
            options: [.calculationModeLinear,.allowUserInteraction],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.01) {
                    
                    self.blackView.alpha = 0.5
                }
                UIView.addKeyframe(withRelativeStartTime: 0.01, relativeDuration: 0.03) {
                    self.blackView.alpha = 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0.02, relativeDuration: 1) {
                    self.blackView.alpha = 1
                }
        },
            completion: nil)
    }
    
    func setupSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeUp.direction = .up
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if sender.direction == .right {
                swipeRight()
            }
            else if sender.direction == .left {
                swipeLeft()
            }
            else if sender.direction == .up {
                swipeUp()
            }
            else if sender.direction == .down {
                swipeDown()
            }
        }
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
    
    func swipeUp() {
        if check(x: playerPosition[0], y: playerPosition[1]-1) {
            playerPosition[1] -= 1
        }
    }
    
    func swipeRight() {
        if check(x: playerPosition[0]+1, y: playerPosition[1]) {
            playerPosition[0] += 1
        }
    }
    
    func swipeLeft() {
        if check(x: playerPosition[0]-1, y: playerPosition[1]) {
            playerPosition[0] -= 1
        }
        
    }
    
    func swipeDown() {
        if check(x: playerPosition[0], y: playerPosition[1]+1) {
            playerPosition[1] += 1
        }
    }
    
    func check(x: Int, y: Int) -> Bool {
        if map[y][x] == 0 {
            blockAudio()
            return false
        }
        else if map[y][x] == 1 {
            stepAudio()
        }
        else if map[y][x] == 2 {
            clueAudio(pan: -0.8)
            stepAudio()
        }
        else if map[y][x] == 3 {
            clueAudio(pan: 0.8)
            stepAudio()
        }
        else if map[y][x] == 4 {
            clueAudio(pan: 0)
            stepAudio()
        }
        else if map[y][x] == 5 {
            //pindah ke page menang
            detik.invalidate()
            countdown.invalidate()
            stepAudio()
            stopAllAudio()
            let sb = UIStoryboard(name: "Results", bundle: nil).instantiateViewController(withIdentifier: "win")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb
                , animated: false, completion: nil)
        }
        return true
    }
    func bgmAudio(){

        let path = Bundle.main.path(forResource: "bgm only", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let bgm = try AVAudioPlayer(contentsOf: url)
            bgm.play()
            soundArray.append(bgm)
        } catch {
            
        }
    }
    func blockAudio(){
        let path = Bundle.main.path(forResource: "block", ofType:"mp3")!
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
    
    func wolfAudio()
    {
        let path = Bundle.main.path(forResource: "wolf", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    func grassAudio(){
        let path = Bundle.main.path(forResource: "grass", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    func stepAudio(){
        step += 1
        if step % 2 != 0{
            let path = Bundle.main.path(forResource: "step_1", ofType:"mp3")!
            let url = URL(fileURLWithPath: path)

            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                sound.play()
                soundArray.append(sound)
            } catch {
                
            }
        }else{
            let path = Bundle.main.path(forResource: "step_2", ofType:"mp3")!
            let url = URL(fileURLWithPath: path)

            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                sound.play()
                soundArray.append(sound)
            } catch {
                
            }
        }
        if step % 5 == 0{
            let path = Bundle.main.path(forResource: "grass", ofType:"mp3")!
            let url = URL(fileURLWithPath: path)

            do {
                let sound = try AVAudioPlayer(contentsOf: url)
                sound.play()
                soundArray.append(sound)
            } catch {
                
            }
        }
        
    }
    func thunderAudio(){
        let path = Bundle.main.path(forResource: "thunder", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    func clueAudio(pan : Float){
        let clue = ["help Kenji","over here Kenji","this way Kenji","come here Kenji"]
        let index = Int.random(in: 0...clue.count-1)
        let path = Bundle.main.path(forResource: clue[index], ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.pan = pan
            sound.play()
            soundArray.append(sound)
        } catch {
            
        }
    }
    func stopAllAudio(){
        for audio in soundArray{
            audio.stop()
        }
    }
    
}
