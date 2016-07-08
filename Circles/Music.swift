//
//  Music.swift
//  Circles
//
//  Created by Apple on 16/7/7.
//  Copyright © 2016年 Apple. All rights reserved.
//
import SpriteKit
import AVFoundation

// it doesn't work, maybe i should put the mp3 file to default bundle  !!!!!
//but i fixed later, the .mp3 file should add to project manually, or it cannot be found 

class SoundManager : SKNode {
    var bgmusicPlayer = try!AVAudioPlayer(contentsOfURL: NSBundle.mainBundle().URLForResource("bg", withExtension: "wav")!) //declare a player
    let hitAct = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false) //boom
    let clickAct = SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false)
    let scoreAct = SKAction.playSoundFileNamed("score.wav", waitForCompletion: false) // bingo
    
    func playBackGround() {
        bgmusicPlayer.numberOfLoops = -1 // play will never stop
        bgmusicPlayer.prepareToPlay()
        bgmusicPlayer.play()
    }
    func stopBackGround() {
        bgmusicPlayer.stop()
    }
    
    func playHit() {
        self.runAction(hitAct)
    }
    
    func playClick() {
        self.runAction(clickAct)
    }
    
    func playScore() {
        self.runAction(scoreAct)
    }
}
