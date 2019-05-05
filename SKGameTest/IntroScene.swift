//  IntroScene.swift

import UIKit
import SpriteKit
import AVFoundation

class IntroScene: SKScene{
    var textField: UITextField?
    let menuMusic = SKAction.playSoundFileNamed("menu.mp3", waitForCompletion: false)
    var endAudioPlayer: AVAudioPlayer? = nil

    func loadAudio(){
        let path = Bundle.main.path(forResource: "menu", ofType: "mp3")
        let audioURL = URL(fileURLWithPath: path!)
        do{ endAudioPlayer = try AVAudioPlayer(contentsOf: audioURL)}
        catch{ print("unable to load audio file")}
    }
    
    override func didMove(to view: SKView) {
        txtFieldInit()
        backgroundColor = UIColor(red:0.61, green:0.35, blue:0.71, alpha:1.0)
        txtHeader()
        charMenu()
        loadAudio()
        endAudioPlayer?.play()
    }
    
    func txtFieldInit(){
        textField = UITextField(frame: CGRect(x: size.width/2.0, y: size.height - 75, width: 45, height: 30))
        textField!.placeholder = "15"
        textField!.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:0.8)
        textField!.textAlignment = .center
        self.view!.addSubview(textField!)
        
    }
    
    func txtHeader(){
        let txtNode = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        txtNode.text = "NinjaWatch"
        txtNode.fontSize = 48
        txtNode.position = CGPoint(x: size.width/2.0, y: size.height - 50)
        addChild(txtNode)
        
//        let subtxt2Node = SKLabelNode(fontNamed: "Futura")
//        subtxt2Node.text = "(WARNING!?) Your First Swipe Might be Laggy..."
//        subtxt2Node.fontSize = 22
//        subtxt2Node.position = CGPoint(x: size.width/2.0, y: size.height - 90)
//        addChild(subtxt2Node)
        
        let subtxtNode = SKLabelNode(fontNamed: "Futura")
        subtxtNode.text = "To play, swipe your fingers across the screen to collect points."
        subtxtNode.fontSize = 22
        subtxtNode.position = CGPoint(x: size.width/2.0, y: size.height - 100)
        addChild(subtxtNode)

        let pointText = SKLabelNode(fontNamed: "Menlo-Bold")
        pointText.text = "Points:"
        pointText.fontSize = 28
        pointText.position = CGPoint(x: 200, y: size.height - 170)
        addChild(pointText)
        
        let avoidText = SKLabelNode(fontNamed: "Menlo-Bold")
        avoidText.text = "Avoid:"
        avoidText.fontSize = 28
        avoidText.position = CGPoint(x: 200, y: size.height - 270)
        addChild(avoidText)
        
        let musicText = SKLabelNode(fontNamed: "Menlo-Bold")
        musicText.text = "Menu Music: No Mercy - The Living Tombstone - grande1899 Cover"
        musicText.fontSize = 12
        musicText.position = CGPoint(x: size.width/2.0, y: 10)
        addChild(musicText)
        
        let optionalTime = SKLabelNode(fontNamed: "Futura-MediumItalic")
        optionalTime.text = "*Optional - Custom Time Limit"
        optionalTime.position = CGPoint(x: 180, y: 50)
        optionalTime.fontSize = 20
        optionalTime.fontColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        addChild(optionalTime)
        
        let footer = SKLabelNode(fontNamed: "Futura-MediumItalic")
        footer.text = "(15 seconds is the default time.)"
        footer.position = CGPoint(x: size.width/2.0 + 145, y: 50)
        footer.fontSize = 12
        footer.fontColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0)
        addChild(footer)

        
        
    }
    func charMenu(){
        
        let tHanzo = SKTexture(imageNamed: "hanzo.png")
        let tAna   = SKTexture(imageNamed: "ana.png")
        let tMercy = SKTexture(imageNamed: "mercy.png")
        let tBrig  = SKTexture(imageNamed: "brig.png")
        let tWinst = SKTexture(imageNamed: "winston.png")
        
        let sHanzo = SKSpriteNode(texture: tHanzo)
        let sAna   = SKSpriteNode(texture: tAna)
        let sMercy = SKSpriteNode(texture: tMercy)
        let sBrig  = SKSpriteNode(texture: tBrig)
        let sWinst = SKSpriteNode(texture: tWinst)
        
        let objSize = CGSize(width: 80, height: 80)
        let ySubtract = CGFloat(150.0)
        let yAvoid = CGFloat(250.0)
        sHanzo.size = objSize
        sHanzo.position = CGPoint(x: size.width/2.0 + 80, y: size.height - ySubtract)
        addChild(sHanzo)
        
        sAna.size = objSize
        sAna.position = CGPoint(x: size.width/2.0 , y: size.height - ySubtract)
        addChild(sAna)
        
        sMercy.size = objSize
        sMercy.position = CGPoint(x: size.width/2.0 + 160 , y: size.height - ySubtract)
        addChild(sMercy)
        
        sBrig.size = objSize
        sBrig.position = CGPoint(x: size.width/2.0 , y: size.height - yAvoid)
        addChild(sBrig)
        
        sWinst.size = objSize
        sWinst.position = CGPoint(x: size.width/2.0 + 80 , y: size.height - yAvoid)
        addChild(sWinst)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = view {
            textField?.removeFromSuperview()
            let storeTime = UserDefaults.standard
            storeTime.set(textField?.text, forKey: "customTime")

            let game = GameScene(size: size)
            let transition = SKTransition.reveal(with: SKTransitionDirection.up , duration: 0.75)
            view.presentScene(game, transition: transition)
        }
    }
}
