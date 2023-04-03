import UIKit

class ShopCell: UICollectionViewCell, SelfConfiguringCell {
  static var reuseId: String = "ShopCell"
  
  @IBOutlet private weak var image: UIImageView!
  @IBOutlet private weak var money: UILabel!
  
  func configure(with item: Stone.RocketType, isBought: Bool = false) {
    image.image = item.image(false)
    money.text = "\(item.money)"
    image.alpha = isBought == true ? 0.5 : 1
  }
  
}

protocol SelfConfiguringCell {
  static var reuseId: String { get }
  func configure(with item: Stone.RocketType, isBought: Bool)
}


class ShopViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var coinsLabel: UILabel!
  
  var items = Stone.RocketType.allCases
  var coins = UserDefaultsHelper.shared.coins {
    didSet {
      coinsLabel.text = "\(coins)"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    coins = UserDefaultsHelper.shared.coins
  }
  
  private func configure<T: SelfConfiguringCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
      fatalError("Error \(cellType)")
    }
    return cell
  }
  
  @IBAction func back(_ sender: Any) {
    dismiss(animated: true)
  }
  
  func alert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
}

// MARK: - UICollectionViewDelegate
extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.configure(cellType: ShopCell.self, for: indexPath)
    let isBought = items[indexPath.item].isBought
    cell.configure(with: items[indexPath.item], isBought: isBought)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.size.width - 8) / 2
    return CGSize(
      width: width,
      height: width
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = items[indexPath.item]
    if !item.isBought {
      let money = UserDefaultsHelper.shared.coins
      if money >= item.money {
        switch items[indexPath.item] {
          case .one:
            break
          case .two:
            UserDefaultsHelper.shared.second = true
          case .three:
            UserDefaultsHelper.shared.third = true
          case .four:
            UserDefaultsHelper.shared.fourth = true
          case .five:
            UserDefaultsHelper.shared.fifth = true
          case .six:
            UserDefaultsHelper.shared.sixth = true
        }
        UserDefaultsHelper.shared.coins = UserDefaultsHelper.shared.coins - item.money
        UserDefaultsHelper.shared.current = item.rawValue
        coins = UserDefaultsHelper.shared.coins
        collectionView.reloadData()
      } else {
        alert(title: "Sorry", message: "Not enough money to buy")
      }
    } else {
      UserDefaultsHelper.shared.current = item.rawValue
    }
  }
}
