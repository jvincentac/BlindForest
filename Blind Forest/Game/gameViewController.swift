//
//  gameViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit
import SpriteKit

class gameViewController: UIViewController {
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var forestImageView: UIImageView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var gif: UIImageView!
    
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
        [0,1,1,0,0,0],
        [0,0,0,0,0,0]
    ]
    
    var playerPosition : [Int] = []
    var time = 10
    let emitterNode = SKEmitterNode(fileNamed: "Rain.sks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerPosition = [1,map.count-2]
        setupSwipeGesture()
        addRain()
        timer.text = String(time)
        Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 8...10)), repeats: true) { timer in
            self.setupPageAnimation()
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.time == 0 {
                timer.invalidate()
                //logic kalah
                let sb = UIStoryboard(name: "Results", bundle: nil).instantiateViewController(withIdentifier: "lose")
                sb.modalPresentationStyle = .fullScreen
                self.present(sb
                    , animated: false, completion: nil)
            }
            else {
                self.time -= 1
                self.timer.text = String(self.time)
            }
        }
        
    }
    
    func setupPageAnimation() {
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
            //play sound tabrak
            return false
        }
        else if map[y][x] == 1 {
            
        }
        else if map[y][x] == 2 {
            
        }
        else if map[y][x] == 3 {
            
        }
        else if map[y][x] == 4 {
            
        }
        else if map[y][x] == 5 {
            //pindah ke page menang
            let sb = UIStoryboard(name: "Results", bundle: nil).instantiateViewController(withIdentifier: "win")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb
                , animated: false, completion: nil)
        }
        return true
    }
    
}
