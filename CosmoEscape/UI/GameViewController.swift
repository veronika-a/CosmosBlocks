//
//  GameViewController.swift
//  MagicGems iOS
//
//  Created by Veronika Andrianova on 14.09.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  @IBOutlet private weak var skView: SKView?
  @IBOutlet private weak var levelLabel: UILabel?
  @IBOutlet private weak var movesLabel: UILabel?
  @IBOutlet private weak var recordLabel: UILabel?

  var move: Int = 0 {
    didSet {
      movesLabel?.text = "MOVES: \(move)"
    }
  }
  
  private lazy var bgScene = MenuScene()
  var level = Level.init(level: .one)
  var scene: GameScene?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let skView = SKView(frame: view.bounds)
    skView.backgroundColor = .clear
    skView.isUserInteractionEnabled = false
    
    view.addSubview(skView)
    
    bgScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    bgScene.scaleMode = .resizeFill
    
    skView.presentScene(bgScene)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    newGame()
  }
  
  func newGame() {
    recordLabel?.text = "BEST: \(level.level.record)"
    levelLabel?.text = "Level: \(level.level.rawValue + 1)"
    move = 0
    self.scene = nil
    if let skView = self.view as! SKView? {
      skView.showsPhysics = true
      let scene = GameScene()
      scene.vc = self
      scene.level = level
      scene.backgroundColor = .clear
      scene.isGameOver = false
      scene.gameProtocol = self
      scene.scaleMode = .resizeFill
      skView.allowsTransparency = true
      skView.presentScene(scene)
      self.scene = scene
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  @IBAction func backButtonTap(_ sender: UIButton) {
    scene = nil
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func replayTap(_ sender: UIButton) {
    newGame()
  }
  
}

extension GameViewController: GameProtocol {
  func gameOver() {
    let win = move == level.level.record
    var money = 0
    if level.level.rawValue == UserDefaultsHelper.shared.level, win {
      UserDefaultsHelper.shared.level = UserDefaultsHelper.shared.level + 1
      money = 10
      UserDefaultsHelper.shared.coins = UserDefaultsHelper.shared.coins + money
    }
    SoundManager.shared.playSound(name: win ? "win.mp3" : "falling.wav")
    let vc = storyboard?.instantiateViewController(withIdentifier: "finish") as! FinishViewController
    vc.isWinning = win
    vc.coins = money
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}
