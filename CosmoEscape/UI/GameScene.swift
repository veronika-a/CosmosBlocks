
import SpriteKit

protocol GameProtocol: AnyObject {
  func gameOver()
}

class GameScene: SKScene {
  
  var vc: GameViewController?
  private var item: Stone?
  private var spikes: SKSpriteNode?
  var isGameOver: Bool = false
  private var stoneSize: CGFloat = 0
  private var smalStoneSize: CGFloat = 0
  weak var gameProtocol: GameProtocol?
  private var background = SKSpriteNode(imageNamed: "bgGame")
  
  private var matrix: [[Stone?]] = []
  private var matrixPosition: [[CGPoint]] = []
  var level: Level = Level(level: .one)
  var isUpdateMatrix = false
  var galaxyPosition: CGPoint = .zero
  private var moves: Int = 0 {
    didSet {
      vc?.move = moves
    }
  }
  
  func setUpScene() {
    stoneSize = ((self.frame.size.width - 80) / 6)
    level.setupStones(stoneSize: stoneSize)
    createMatrix()
  }

  private func createMatrix() {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    let topPadding = (window?.safeAreaInsets.top ?? 0) + (view?.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    
    let minX = stoneSize / 2 + 40
    let minY: CGFloat = self.frame.height - topPadding - 180 - stoneSize / 2
    
    var x = minX
    var y = minY
    matrix = Array(repeating: Array(repeating: nil, count: 6), count: 6)
    matrixPosition = Array(repeating: Array(repeating: .zero, count: 6), count: 6)
    
    for i in 0..<matrix.count {
      for j in 0..<matrix[i].count {
        let position = CGPoint(x: x, y: y)
        matrixPosition[i][j] = position
        x = x + stoneSize
      }
      
      y = y - stoneSize
      x = minX
    }
    
    let galaxy = SKSpriteNode(imageNamed: "galaxy")
    galaxy.setScale(toWidth: stoneSize * 2)
    galaxy.size = CGSize(width: galaxy.size.width, height: galaxy.size.height)
    galaxy.position = CGPoint(x: frame.size.width / 2, y: minY + stoneSize + galaxy.size.height / 2 )
    self.addChild(galaxy)
    galaxyPosition = galaxy.position
    
    let background = SKSpriteNode(imageNamed: "frame")
    background.setScale(toWidth: frame.size.width - 80)
    background.size = CGSize(width: background.size.width, height: stoneSize * 6.5 )
    background.position = CGPoint(x: frame.size.width / 2, y: minY + stoneSize - background.size.height / 2)
    self.addChild(background)
    
    
    for i in 0..<matrix.count {
      for j in 0..<matrix[i].count {
        let stoneBg = Stone(category: .one, width: stoneSize - CGFloat(6 * 6), isBg: true, point: .zero, axis: .horisontal)
        stoneBg.position = matrixPosition[i][j]
        self.addChild(stoneBg)
      }
    }
    
    for s in 0..<level.stones.count {
      for p in 0..<level.stones[s].count {
        let i = Int(level.level.places[s][p].x)
        let j = Int(level.level.places[s][p].y)
        level.stones[s][p].position = matrixPosition[i][j]
        self.addChild(level.stones[s][p])
        matrix[i][j] = level.stones[s][p]
      }
    }
    // print(matrixPosition)
    print(matrix)
  }
  
  private func updateMatrix(at pos: CGPoint? = nil, node: Stone) {
    guard let position = pos != nil ? pos : node.position else { return }
    var i: Int? = nil
    var j: Int? = nil
    for mi in 0..<matrix.count {
      for mj in 0..<matrix[mi].count {
        if self.item == matrix[mi][mj] {
          i = mi
          j = mj
        }
      }
    }
    guard let i = i, let j = j else { return }
    let maxY = (matrixPosition.first?.first?.y ?? 0) + stoneSize / 2
    let minY = (matrixPosition.last?.last?.y ?? 0) - stoneSize / 2
    
    guard position.y > minY, position.y < maxY else {
      return
    }
    var foundY: Int? = nil
    for i in 0..<matrixPosition.count {
      if (matrixPosition[i].first?.y ?? 0) + stoneSize / 2 > position.y, (matrixPosition[i].first?.y ?? 0) - stoneSize / 2 < position.y {
        foundY = i
        break
      }
    }
    guard let foundY = foundY else { return }
    let minX = (matrixPosition[foundY].first?.x ?? 0) - stoneSize / 2
    let maxX = (matrixPosition[foundY].last?.x ?? 0) + stoneSize / 2
    guard position.x > minX, position.x < maxX else {
      return
    }
    
    var foundX: Int? = nil
    for i in 0..<matrixPosition[foundY].count {
      if matrixPosition[foundY][i].x + stoneSize / 2 > position.x, matrixPosition[foundY][i].x - stoneSize / 2 < position.x {
        foundX = i
        break
      }
    }
    guard let foundX = foundX else { return }
    guard node.axis == .horisontal ? i == foundY : j == foundX else { return }
    let deltaI = foundY - i
    let deltaJ = foundX - j
    var newMass = [[Int]]()
    for foundGroup in 0..<level.stones.count {
      if level.stones[foundGroup].contains(where: { $0.name == node.name }){
        var flag = true
        for f in 0..<level.stones[foundGroup].count {
          for x in 0..<matrix.count {
            for y in 0..<matrix[x].count {
              if matrix[x][y] != nil, matrix[x][y] == level.stones[foundGroup][f] {
                let newX = x + deltaI
                let newY = y + deltaJ
                newMass.append([newX, newY, x, y])
                if
                  newX >= 0, newX < matrix.count,
                  newY >= 0, newY < matrix[x].count {
                  if let n = matrix[newX][newY], !level.stones[foundGroup].contains(n) {
                    flag = false
                  }
                } else {
                  flag = false
                }
              }
            }
          }
        }
        if flag {
          let oldMatrix = matrix
          for n in newMass {
            let newX = n[0]
            let newY = n[1]
            let x = n[2]
            let y = n[3]
            matrix[newX][newY] = oldMatrix[x][y]
            if !newMass.contains(where: {$0[0] == x && $0[1] == y}) {
              matrix[x][y] = nil
            }
            let move = SKAction.move(to: matrixPosition[newX][newY], duration: 0.1)
            matrix[newX][newY]?.run(move)
          }
        }
      }
      
    }
    
  }
  
  private func inspect() {
    for mi in 0..<matrix.count {
      for mj in 0..<matrix[mi].count {
        if matrix[mi][mj]?.type == .rocket, mi == 0 {
          let move = SKAction.move(to: CGPoint(x: matrix[1][mj]?.position.x ?? .zero, y: galaxyPosition.y), duration: 0.1)
          matrix[1][mj]?.run(move) { [weak self] in
            self?.gameOver()
          }
        }}
    }
  }
  
  override func didMove(to view: SKView) {
    background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    background.size = CGSize(width: self.size.width, height: self.size.height)
    self.addChild(background)
    self.setUpScene()
  }
  
  private func gameOver() {
    guard !isGameOver else { return }
    isGameOver = true
    self.removeAllActions()
    self.removeAllChildren()
    self.vc?.gameOver()
  }
  
}

extension GameScene {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      let location = t.location(in: self)
      for i in matrix {
        for j in i {
          if j != nil, j?.contains(location) ?? false {
            self.item = j
          }
        }
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      let location = t.location(in: self)
      guard item != nil else { return }
      updateMatrix(at: location, node: item!)
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
    item = nil
    moves = moves + 1
    inspect()
  }
}
