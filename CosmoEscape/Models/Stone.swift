import UIKit
import SpriteKit

class Stone: SKSpriteNode {
  var type: StoneType
  var stoneSize: CGFloat = 50
  var point: CGPoint
  var axis: StoneAxis
  
  enum StoneAxis: Int {
    case horisontal = 0, vertical
  }
  
  enum RocketType: Int, CaseIterable {
    case one = 0, two, three, four, five, six
    
    func image(_ isActive: Bool) -> UIImage {
      return UIImage(named: isActive ? "rocket\(self.rawValue + 1)f" : "rocket\(self.rawValue + 1)") ?? UIImage()
    }
    
    var money: Int {
      switch self {
        case .one:
          return 0
        case .two:
          return 20
        case .three:
          return 40
        case .four:
          return 60
        case .five:
          return 80
        case .six:
          return 100
      }
    }
    
    var isBought: Bool {
      switch self {
        case .one: return true
        case .two:  return UserDefaultsHelper.shared.second
        case .three: return UserDefaultsHelper.shared.third
        case .four: return UserDefaultsHelper.shared.fourth
        case .five: return UserDefaultsHelper.shared.fifth
        case .six: return UserDefaultsHelper.shared.sixth
      }
    }
    
  }
  
  enum StoneType: Int, CaseIterable {
    case one = 0, two, three, four, rocket
    
    var image: UIImage {
      switch self {
        case .one:
          return UIImage(named: "meteorite-0") ?? UIImage()
        case .two:
          return UIImage(named: "meteorite-1") ?? UIImage()
        case .three:
          return UIImage(named: "meteorite-2") ?? UIImage()
        case .four:
          return UIImage(named: "meteorite-3") ?? UIImage()
        case .rocket:
          return RocketType(rawValue: UserDefaultsHelper.shared.current)?.image(true) ?? RocketType.one.image(true)
      }
    }
    
    var color: UIColor {
      return UIColor(named: "color\(self.rawValue + 1)") ?? .clear
    }
  }
  
  init(category: StoneType, width: CGFloat, isBg: Bool = false, point: CGPoint, axis: StoneAxis) {
    self.axis = axis
    self.stoneSize = width
    self.type = category
    self.point = point
    let texture = SKTexture(image: isBg ? UIColor.clear.image(CGSize(width: StoneType.four.image.size.width, height: StoneType.four.image.size.height)) : category.image)
    super.init(texture: texture, color: UIColor.clear, size: texture.size())
    self.setScale(toWidth: stoneSize)
    self.name = UUID().uuidString
  }
  
  func changeSize(width: CGFloat) {
    self.stoneSize = width
    self.setScale(toWidth: stoneSize)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
