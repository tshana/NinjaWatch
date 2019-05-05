//  GameScene.swift

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let soundBit = SKAction.playSoundFileNamed("swipe.mp3", waitForCompletion: true)

    
    let img = SKTexture(imageNamed: "blade.png")
    var points = 0;
    var timeLimit = 15
    var timer:Timer?
    
    override func didMove(to view: SKView) {
        setTime()
        backgroundColor = UIColor.black
        txtHeader()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTimer), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1.6, target: self, selector: #selector(GameScene.tossTiming), userInfo: nil, repeats: true)
        
    }
//  Logic for Custom Timer
    func setTime(){
        let stand = UserDefaults.standard
        let prevScore = stand.value(forKey: "customTime") as? String
        let convertString = Int(prevScore!)
        if convertString != nil {
            if convertString! <= 0{ timeLimit = 15 }
            else{ timeLimit = convertString! }
        }
    }
// Top Header Texts
    func txtHeader(){
        let headerY = size.height - 50
        
        let textNode = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        textNode.text = "Score: "
        textNode.fontSize = 48
        textNode.position = CGPoint(x: size.width/2.0, y: headerY)
        
        addChild(textNode)
        
        let score = SKLabelNode(fontNamed: "Futura")
        score.text = "\(points)"
        score.fontSize = 40
        score.fontColor = UIColor(red:0.95, green:0.77, blue:0.06, alpha:1.0)
        score.position = CGPoint(x: size.width/2.0 + 120, y: headerY)
        score.name = "scoreText"
        addChild(score)
        
        
        let timerTxt = SKLabelNode(fontNamed: "Futura")
        timerTxt.text = "\(timeLimit)"
        timerTxt.fontSize = 40
        timerTxt.fontColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0)
        timerTxt.position = CGPoint(x: size.width - 50, y: headerY)
        timerTxt.name = "timerText"
        addChild(timerTxt)
    }

// Handles Touches
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: self)
            let previous = t.previousLocation(in: self)
          
            // Detects Swipe Collision
            for node in nodes(at: location){
                if node.name == "Hero"      { points += 1; node.removeFromParent() }
                else if node.name == "Hanz" { points += 4; node.removeFromParent() }
                else if node.name == "Enemy"{ points -= 3; node.removeFromParent() }
                updatePoints()
            }

// Creates/Removes Swipe Effect
            // Adds the touch locations from begin to end of the swipe motion.
            let linePath = CGMutablePath()
            linePath.move(to: location)
            linePath.addLine(to: previous)
            
            let lines = SKShapeNode(path: linePath)
            lines.strokeColor = UIColor(red: 0.56, green: 0.93, blue: 0.56, alpha: 1.0)
            lines.lineWidth = 5
            
            let genji = SKSpriteNode(texture: img)
            genji.position = location; genji.size = CGSize(width: 70, height: 70)
            
            genji.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 0.5), SKAction.removeFromParent()]))
            lines.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 0.6), SKAction.removeFromParent()]))
            
            addChild(genji); addChild(lines)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(soundBit) }

//  Updates Text with points
    func updatePoints(){
        if let txtNode = childNode(withName: "scoreText") as? SKLabelNode{ txtNode.text = "\(points)"}
    }

//  Throws Objects onto Screen that Give Points to the Player
    func tossObjects(){
        let tHanzo = SKTexture(imageNamed: "hanzo.png")
        let tAna   = SKTexture(imageNamed: "ana.png")
        let tMercy = SKTexture(imageNamed: "mercy.png")
        
        let spriteObj: SKSpriteNode
        let body = SKPhysicsBody()
       
        let randomizePick = Int.random(in: 0...7)
        switch randomizePick {
        case 0...1: spriteObj = SKSpriteNode(texture: tHanzo);spriteObj.name = "Hanz"
        case 2...4: spriteObj = SKSpriteNode(texture: tAna);  spriteObj.name = "Hero"
        case 5...7: spriteObj = SKSpriteNode(texture: tMercy);spriteObj.name = "Hero"
        default: spriteObj = SKSpriteNode(texture: tHanzo)
        }
        
        
        spriteObj.size = CGSize(width: 60, height: 60)
        spriteObj.position = CGPoint(x: CGFloat.random(in: 0...frame.width), y: -50)
        
        if spriteObj.position.x > frame.size.width/2{ body.velocity.dx = CGFloat.random(in:-200...10) }
        else if spriteObj.position.x < frame.size.width/2{ body.velocity.dy = CGFloat.random(in:10...200) }
        
        body.velocity.dy = CGFloat.random(in:800...1200)
        body.angularVelocity = CGFloat.random(in: -3...3)
        body.isDynamic = true
        
        spriteObj.physicsBody = body
        
        addChild(spriteObj)
    }
    
//  Throws Objects onto Screen that Take Points Away from the Player. (Different Movements from points)
    func tossEnemies(){
        let tBrig  = SKTexture(imageNamed: "brig.png")
        let tWinst = SKTexture(imageNamed: "winston.png")
        
        let spriteObj: SKSpriteNode; let body = SKPhysicsBody()
        
        let randomizePick = Int.random(in: 0...5)
        switch randomizePick {
        case 0...3: spriteObj = SKSpriteNode(texture: tBrig)
        case 4...5: spriteObj = SKSpriteNode(texture: tWinst)
        default:    spriteObj = SKSpriteNode(texture: tBrig)
        }
        
        spriteObj.name = "Enemy"
        spriteObj.size = CGSize(width: 60, height: 60)
        spriteObj.position = CGPoint(x: CGFloat.random(in: 0...frame.width), y: -50)
        
        if spriteObj.position.x > frame.size.width/2{ body.velocity.dx = CGFloat.random(in:-200...10) }
        else if spriteObj.position.x < frame.size.width/2{ body.velocity.dy = CGFloat.random(in:10...200) }
        
        body.velocity.dy = CGFloat.random(in:1000...1200)
        body.angularVelocity = CGFloat.random(in: -2...2)
        body.isDynamic = true
        
        spriteObj.physicsBody = body
        addChild(spriteObj)
    
    }
    
    @objc func updateTimer(){
        timeLimit -= 1
        if let txtNode = childNode(withName: "timerText") as? SKLabelNode{
            if timeLimit >= 0 { txtNode.text = "\(timeLimit)" }
            else{
                timer?.invalidate()
                if let view = view {
                    let game = ClosingScene(size: size)
                    
                    let storePoints = UserDefaults.standard
                    storePoints.set(points, forKey: "currentScore")

                    let transition = SKTransition.crossFade(withDuration: 1.0)
                    view.presentScene(game, transition: transition)
                }
            }
        }
    }
    @objc func tossTiming(){
        //TO DO: Either set a timer for how often the enemie/object is called. Or try a randomizer loop within the toss Functions.
        tossObjects()
        tossEnemies()
        tossObjects()
        catchOuterNodes()
        // TODO: FIX   -->  CatchOuterNodes is only removing one node per second.
    }
    
//  Catches nodes that have fell out of the screen's view and need to be deleted.
    func catchOuterNodes(){
        if let node = childNode(withName: "Enemy") ??  childNode(withName: "Hero"){
            if node.position.y < -100{ node.removeFromParent() }
        }
            
    }
    
}
