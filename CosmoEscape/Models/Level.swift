import Foundation
import GameKit

class Level {
  var level: Levels = .one
  var stones: [[Stone]] = [[Stone]]()
  
  init(level: Levels) {
    self.level = level
  }
  
  func setupStones(stoneSize: CGFloat) {
    stones.removeAll()
    for s in 0..<level.places.count {
      stones.append([])
      for p in 0..<level.places[s].count {
        let isFirstRocket = (level.stones[s] == .rocket && p == 0)
        let stone = Stone(category: level.stones[s], width: stoneSize - 8, isBg: isFirstRocket, point: level.places[s][p], axis: level.axis[s])
        stones[s].append(stone)
      }
    }
  }
  
  enum Levels: Int, CaseIterable {
    case one = 0, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty
    
    var stones: [Stone.StoneType] {
      switch self {
        case .one:
          return [.four, .two, .two, .three, .rocket]
        case .two:
          return [.two, .four, .three, .one, .rocket]
        case .three:
          return [.four, .two, .two, .three, .three, .rocket]
        case .four:
          return [.two, .four, .three, .one, .two, .rocket]
        case .five:
          return [.one, .three, .two, .three, .one, .rocket]
        case .six:
          return [.two, .four, .two, .three, .one, .rocket]
        case .seven:
          return [.four, .one, .two, .three, .two, .four, .rocket]
        case .eight:
          return [.one, .three, .four, .three, .one, .rocket]
        case .nine:
          return [.four, .two, .two, .one, .three, .four, .rocket]
        case .ten:
          return [.two, .four, .three, .one, .three, .four, .rocket]
        case .eleven:
          return [.one, .two, .four, .three, .two, .one, .rocket]
        case .twelve:
          return [.four, .one, .two, .three, .two, .four, .rocket]
        case .thirteen:
          return [.two, .four, .three, .two, .three, .two, .rocket]
        case .fourteen:
          return [.one, .four, .one, .two, .three, .four, .rocket]
        case .fifteen:
          return [.two, .four, .two, .four, .one, .two, .rocket]
        case .sixteen:
          return [.one, .three, .two, .three, .one, .four, .rocket]
        case .seventeen:
          return [.three, .two, .four, .three, .two, .one, .rocket]
        case .eighteen:
          return [.one, .two, .four, .one, .two, .four, .rocket]
        case .nineteen:
          return [.two, .four, .three, .two, .three, .two, .rocket]
        case .twenty:
          return [.one, .one, .one, .one, .four, .four, .one, .rocket]
      }
    }
    
    var places: [[CGPoint]] {
      switch self {
        case .one:
          return [[CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3), CGPoint(x: 0, y: 4)],
                  [CGPoint(x: 2, y: 0), CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 4, y: 4)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)]
          ]

        case .two:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3), CGPoint(x: 1, y: 4)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 5, y: 1), CGPoint(x: 5, y: 2)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .three:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 0, y: 5), CGPoint(x: 1, y: 5), CGPoint(x: 2, y: 5)],
                  [CGPoint(x: 5, y: 3), CGPoint(x: 5, y: 4)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .four:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 1, y: 5), CGPoint(x: 2, y: 5), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 4, y: 0)],
                  [CGPoint(x: 5, y: 3), CGPoint(x: 5, y: 4), CGPoint(x: 5, y: 5)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .five:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2)],
                  [CGPoint(x: 0, y: 4), CGPoint(x: 1, y: 4), CGPoint(x: 2, y: 4)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
                  
          ]
        case .six:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1)],
                  [CGPoint(x: 0, y: 4), CGPoint(x: 1, y: 4), CGPoint(x: 2, y: 4)],
                  [CGPoint(x: 3, y: 4), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .seven:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2)],
                  [CGPoint(x: 1, y: 3), CGPoint(x: 1, y: 4)],
                  [CGPoint(x: 2, y: 0), CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 4, y: 4)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .eight:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .nine:
          return [[CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2), CGPoint(x: 3, y: 3)],
                  [CGPoint(x: 3, y: 5), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 5, y: 4), CGPoint(x: 5, y: 5)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .ten:
          return [[CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 2, y: 5), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2), CGPoint(x: 3, y: 3)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .eleven:
          return [[CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 1, y: 5), CGPoint(x: 2, y: 5), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .twelve:
          return [[CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3), CGPoint(x: 0, y: 4)],
                  [CGPoint(x: 0, y: 5), CGPoint(x: 1, y: 5), CGPoint(x: 2, y: 5)],
                  [CGPoint(x: 1, y: 4), CGPoint(x: 2, y: 4)],
                  [CGPoint(x: 2, y: 0), CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2)],
                  [CGPoint(x: 3, y: 4), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .thirteen:
          return [[CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 2, y: 5), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .fourteen:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 0, y: 4), CGPoint(x: 1, y: 4)],
                  [CGPoint(x: 2, y: 3), CGPoint(x: 2, y: 4)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2)],
                  [CGPoint(x: 3, y: 3), CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 5, y: 1), CGPoint(x: 5, y: 2)],
                  [CGPoint(x: 1, y: 2), CGPoint(x: 2, y: 2)],
          ]
        case .fifteen:
          return [[CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2), CGPoint(x: 3, y: 3)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 5, y: 4), CGPoint(x: 5, y: 5)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .sixteen:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 2, y: 5), CGPoint(x: 3, y: 5)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .seventeen:
          return [[CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 0, y: 5), CGPoint(x: 1, y: 5)],
                  [CGPoint(x: 2, y: 3), CGPoint(x: 2, y: 4), CGPoint(x: 2, y: 5)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2)],
                  [CGPoint(x: 3, y: 3), CGPoint(x: 4, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 1, y: 2), CGPoint(x: 2, y: 2)],
          ]
        case .eighteen:
          return [[CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0)],
                  [CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)],
                  [CGPoint(x: 2, y: 3), CGPoint(x: 3, y: 3), CGPoint(x: 4, y: 3)],
                  [CGPoint(x: 2, y: 4), CGPoint(x: 2, y: 5)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 3, y: 1), CGPoint(x: 3, y: 2)],
                  [CGPoint(x: 3, y: 4), CGPoint(x: 4, y: 4), CGPoint(x: 5, y: 4)],
                  [CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 2)],
          ]
        case .nineteen:
          return [[CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 1, y: 3)],
                  [CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3)],
                  [CGPoint(x: 1, y: 4), CGPoint(x: 2, y: 4)],
                  [CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 4)],
                  [CGPoint(x: 4, y: 3), CGPoint(x: 5, y: 3)],
                  [CGPoint(x: 4, y: 4), CGPoint(x: 4, y: 5)],
                  [CGPoint(x: 3, y: 2), CGPoint(x: 4, y: 2)],
          ]
        case .twenty:
          return [[CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0)],
                  [CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)],
                  [CGPoint(x: 1, y: 3), CGPoint(x: 1, y: 4)],
                  [CGPoint(x: 3, y: 0), CGPoint(x: 3, y: 1)],
                  [CGPoint(x: 3, y: 4), CGPoint(x: 4, y: 4), CGPoint(x: 5, y: 4)],
                  [CGPoint(x: 4, y: 1), CGPoint(x: 4, y: 2)],
                  [CGPoint(x: 4, y: 5), CGPoint(x: 5, y: 5)],
                  [CGPoint(x: 2, y: 2), CGPoint(x: 3, y: 2)],
          ]
      }
    }
    
    var axis: [Stone.StoneAxis] {
      switch self {
        case .one:
          return [.horisontal, .horisontal, .horisontal, .horisontal, .vertical]
        case .two:
          return [.horisontal, .horisontal, .horisontal, .horisontal, .vertical,]
        case .three:
          return [.horisontal, .horisontal, .horisontal, .vertical, .horisontal, .vertical,]
        case .four:
          return [.horisontal, .vertical, .horisontal, .vertical, .horisontal, .vertical,]
        case .five:
          return [.horisontal, .horisontal, .horisontal, .vertical, .horisontal, .vertical]
        case .six:
          return [.horisontal, .horisontal, .vertical, .horisontal, .horisontal, .vertical]
        case .seven:
          return [.horisontal, .horisontal, .horisontal, .horisontal, .vertical, .horisontal, .vertical]
        case .eight:
          return [.horisontal, .horisontal, .horisontal, .vertical, .horisontal, .vertical]
        case .nine:
          return [.horisontal, .horisontal, .horisontal, .vertical, .vertical, .horisontal, .vertical]
        case .ten:
          return [.horisontal, .vertical, .vertical, .horisontal, .vertical, .horisontal, .vertical]
        case .eleven:
          return [.horisontal, .horisontal, .horisontal, .vertical, .vertical, .horisontal, .vertical]
        case .twelve:
          return [.horisontal, .vertical, .vertical, .horisontal, .horisontal, .horisontal, .vertical]
        case .thirteen:
          return [.horisontal, .horisontal, .vertical, .vertical, .vertical, .horisontal, .vertical]
        case .fourteen:
          return [.horisontal, .vertical, .horisontal, .horisontal, .vertical, .horisontal, .vertical]
        case .fifteen:
          return [.horisontal, .vertical, .horisontal, .vertical, .horisontal, .horisontal, .vertical]
        case .sixteen:
          return [.horisontal, .horisontal, .vertical, .vertical, .vertical, .horisontal, .vertical]
        case .seventeen:
          return [.horisontal, .vertical, .horisontal, .horisontal, .vertical, .horisontal, .vertical]
        case .eighteen:
          return [.vertical, .horisontal, .vertical, .horisontal, .horisontal, .vertical, .vertical]
        case .nineteen:
          return [.horisontal, .horisontal, .vertical, .horisontal, .vertical, .horisontal, .vertical]
        case .twenty:
          return [.vertical, .horisontal, .horisontal, .horisontal, .vertical, .horisontal, .vertical, .vertical]
      }
    }
    
    var record: Int {
      switch self {
        case .one:
          return 4
        case .two:
          return 4
        case .three:
          return 5
        case .four:
          return 5
        case .five:
          return 5
        case .six:
          return 5
        case .seven:
          return 6
        case .eight:
          return 11
        case .nine:
          return 15
        case .ten:
          return 16
        case .eleven:
          return 16
        case .twelve:
          return 15
        case .thirteen:
          return 16
        case .fourteen:
          return 17
        case .fifteen:
          return 15
        case .sixteen:
          return 16
        case .seventeen:
          return 20
        case .eighteen:
          return 15
        case .nineteen:
          return 16
        case .twenty:
          return 18
      }
    }
  }
}
