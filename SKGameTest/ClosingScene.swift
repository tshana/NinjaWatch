//  ClosingScene.swift

import UIKit
import SpriteKit

class ClosingScene: SKScene{

    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1.0)
        getScore()
        closureText()

    }
    // Get Current Score
    func getScore(){
        let stand = UserDefaults.standard
        let prevScore = stand.value(forKey: "currentScore") as? Int
        
        let pointsNode = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        pointsNode.text = "\(prevScore!)"
        pointsNode.fontSize = 36
        if prevScore! > 0{ pointsNode.fontColor = UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0) }
        else{ pointsNode.fontColor = UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0) }
        
        pointsNode.position = CGPoint(x: size.width/2.0 + 80, y: size.height - 150)
        addChild(pointsNode)
    }
    func closureText(){
        let txtNode = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        txtNode.text = "Game Over!"
        txtNode.fontSize = 48
        txtNode.position = CGPoint(x: size.width/2.0, y: size.height - 50)
        addChild(txtNode)
        
        let labelNode = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        labelNode.text = "Score:"
        labelNode.fontSize = 34
        labelNode.position = CGPoint(x: size.width/2.0 - 100, y: size.height - 150)
        addChild(labelNode)
        
        let label2 = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        label2.text = "High Score:"
        label2.fontSize = 34
        label2.position = CGPoint(x: size.width/2.0 - 100, y: size.height - 200)
        addChild(label2)
        
        let highScoreNode = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        highScoreNode.text = "100"
        highScoreNode.fontSize = 36
        highScoreNode.position = CGPoint(x: size.width/2.0 + 80, y: size.height - 200)
        addChild(highScoreNode)
        
        let backTxt = SKLabelNode(fontNamed: "Futura")
        backTxt.text = "Tap Here to Return to the Menu"
        backTxt.fontSize = 36
        backTxt.fontColor = UIColor(red:1.00, green:0.92, blue:0.65, alpha:1.0)
        backTxt.position = CGPoint(x: size.width/2.0, y: size.height - 300)
        backTxt.name = "goBack"
        addChild(backTxt)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)

        for node in nodes(at: location!){
            if node.name == "goBack"{
                if let view = view { 
                    let game = IntroScene(size: size)
                    
                    let transition = SKTransition.crossFade(withDuration: 1.0)
                    view.presentScene(game, transition: transition)
                }
            }
        }
    }
    
    
}
