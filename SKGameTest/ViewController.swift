//  ViewController.swift

import UIKit; import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView(frame: view.frame)
//        skView.showsFPS = true
//        skView.showsNodeCount = true
        view = skView

        let size = CGSize(width: view.frame.width, height: view.frame.height)
        let openScene = IntroScene(size: size)
        
        skView.presentScene(openScene)
        
    }

    override var prefersStatusBarHidden: Bool { return true }
}

