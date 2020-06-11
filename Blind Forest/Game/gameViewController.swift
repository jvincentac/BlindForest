//
//  gameViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {

    //0 tembok
    //1 jalan
    //2 persimpangan
    //3 selesai
    
    let map : [[Int]] = [
           [0,0,0,0,0,0],
           [0,1,1,1,3,0],
           [0,1,0,0,0,0],
           [0,1,1,0,0,0],
           [0,0,1,0,0,0],
           [0,1,2,1,0,0],
           [0,1,0,1,0,0],
           [0,1,0,0,1,0],
           [0,1,2,1,1,0],
           [0,0,1,0,0,0],
           [0,1,1,0,0,0],
           [0,0,0,0,0,0]
       ]
       
       var playerPosition : [Int] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           playerPosition = [1,map.count-2]
           setupSwipeGesture()
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
           if check(x: playerPosition[0], y: playerPosition[1]-1) {
               playerPosition[1] -= 1
           }
           else {
               //play sound tabrak
           }
           print(playerPosition)
       }
       
       func swipeRight() {
           if check(x: playerPosition[0]+1, y: playerPosition[1]) {
               playerPosition[0] += 1
           }
           else {
               //play sound tabrak
           }
           print(playerPosition)
       }
       
       func swipeLeft() {
           if check(x: playerPosition[0]-1, y: playerPosition[1]) {
               playerPosition[0] -= 1
           }
           else {
               //play sound tabrak
           }
           print(playerPosition)
       }
       
       func swipeDown() {
           if check(x: playerPosition[0], y: playerPosition[1]+1) {
               playerPosition[1] += 1
           }
           else {
               //play sound tabrak
           }
           print(playerPosition)
       }
       
       func check(x: Int, y: Int) -> Bool {
           if map[y][x] == 0 {
               return false
           }
           return true
       }

}
