import UIKit
import GameKit

class InitViewController: UIViewController {
    
  @IBOutlet weak var musicButton: UIButton!
  private lazy var scene = MenuScene()

  private var isMuted = UserDefaultsHelper.shared.isMuted {
    didSet {
      DispatchQueue.main.async { [self] in
        if isMuted {
          musicButton.setBackgroundImage(UIImage(named: "SoundOff"), for: .normal)
          SoundManager.shared.stopMusic()
        } else {
          musicButton.setBackgroundImage(UIImage(named: "SoundOn"), for: .normal)
          SoundManager.shared.playBackgroundMusic()
        }
        UserDefaultsHelper.shared.isMuted = isMuted
      }
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    isMuted = UserDefaultsHelper.shared.isMuted
    
    let skView = SKView(frame: view.bounds)
    skView.backgroundColor = .clear
    skView.isUserInteractionEnabled = false
    
    view.addSubview(skView)
    
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    scene.scaleMode = .resizeFill
    
    skView.presentScene(scene)
  }
  
  @IBAction func levelsTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "level") as? LevelViewController else { return }
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func soundTap(_ sender: Any) {
    isMuted = !isMuted
  }
  
  @IBAction func infoTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "info") as? InfoViewController else { return }
    self.present(vc, animated: true)
  }
  
  @IBAction func shopTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "shop") as? ShopViewController else { return }
    self.present(vc, animated: true)
  }
  
  @IBAction func startTap (_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController else { return }
    vc.level = Level(level: Level.Levels.init(rawValue: UserDefaultsHelper.shared.level) ?? .one)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension InitViewController: GKGameCenterControllerDelegate {
  
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
}
