//
//  tutorialViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 12/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class tutorialViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!

    var step = 0
    var soundArray : [AVAudioPlayer?] = []
    
    let map : [[Int]] = [
        [0,0,0,0,0,0,0],
        [0,0,5,1,2,1,0],
        [0,0,0,0,1,0,0],
        [0,1,3,1,4,0,0],
        [0,0,1,0,1,0,0],
        [0,1,1,0,0,0,0],
        [0,0,0,0,0,0,0]
    ]
    
    var playerPosition : [Int] = [1,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeGesture()
    }
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    func swipeUp() {
        if check(x: playerPosition[0], y: playerPosition[1]-1, map: map) {
            playerPosition[1] -= 1
        }
    }
    
    func swipeRight() {
        if check(x: playerPosition[0]+1, y: playerPosition[1], map: map) {
            playerPosition[0] += 1
        }
    }
    
    func swipeLeft() {
        if check(x: playerPosition[0]-1, y: playerPosition[1], map: map) {
            playerPosition[0] -= 1
        }
        
    }
    
    func swipeDown() {
        if check(x: playerPosition[0], y: playerPosition[1]+1, map: map) {
            playerPosition[1] += 1
        }
    }
    
    func check(x: Int, y: Int, map: [[Int]]) -> Bool {
        if map[y][x] == 0 {
            blockAudio()
            tutorialLabel.text = "You Can't Go This Way"
            return false
        }
        else if map[y][x] == 1 {
            stepAudio()
            tutorialLabel.text = "Keep Going"
        }
        else if map[y][x] == 2 {
            clueAudio(pan: -0.8)
            stepAudio()
            tutorialLabel.text = "Follow The Sound, Go West"
        }
        else if map[y][x] == 3 {
            clueAudio(pan: 0.8)
            stepAudio()
            tutorialLabel.text = "Follow The Sound, Go East"
        }
        else if map[y][x] == 4 {
            clueAudio(pan: 0)
            stepAudio()
            tutorialLabel.text = "Follow The Sound, Go North"
        }
        else if map[y][x] == 5 {
            //pindah ke page menang
            stepAudio()
            tutorialLabel.text = "Congratulations, You've Completed The Tutorial. Now The Text Will Disappear"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                let sb = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "game")
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: false, completion: nil)
            }
        }
        return true
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
}
