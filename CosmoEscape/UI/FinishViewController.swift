import UIKit
import GameKit

class FinishViewController: UIViewController {
  
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var exitButton: UIButton!
  @IBOutlet weak var statusImg: UIImageView!
  @IBOutlet weak var musicButton: UIButton!
  
  @IBOutlet weak var money: UILabel!
  @IBOutlet weak var moneyStack: UIStackView!
  var isWinning: Bool = false
  var coins: Int = 0

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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populate()
    isMuted = UserDefaultsHelper.shared.isMuted
  }
  
  private func populate() {
    switch isWinning {
      case true:
        if coins > 0 {
          money.text = "\(coins)"
          moneyStack.isHidden = false
        }
        bgImage.image = UIImage(named: "bgWin")
        statusImg.image = UIImage(named: "youWin")
        exitButton.setBackgroundImage(UIImage(named: "next"), for: .normal)
      case false:
        bgImage.image = UIImage(named: "bgLose")
        statusImg.image = UIImage(named: "youLose")
        exitButton.setBackgroundImage(UIImage(named: "back"), for: .normal)
    }
  }
  
  @IBAction func tryAgain(_ sender: Any) {
    if let vc = navigationController?.viewControllers.filter({$0.isKind(of: LevelViewController.self)}).first {
      navigationController?.popToViewController(vc, animated: true)
    } else {
      guard let vc = storyboard?.instantiateViewController(withIdentifier: "level") as? LevelViewController else { return }
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  @IBAction func home(_ sender: Any) {
    if let vc = navigationController?.viewControllers.filter({$0.isKind(of: InitViewController.self)}).first {
      navigationController?.popToViewController(vc, animated: true)
    }
  }
  
  @IBAction func back(_ sender: Any) {
    if let vc = navigationController?.viewControllers.filter({$0.isKind(of: GameViewController.self)}).first {
      navigationController?.popToViewController(vc, animated: true)
    }
  }
}

