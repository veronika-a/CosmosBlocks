import Foundation

public enum UserDefaultsKeys: String, CaseIterable {
  case isMuted
  case isMutedSound
  case level
  case second
  case third
  case fourth
  case fifth
  case sixth
  case coins
  case current

}

class UserDefaultsHelper {
  static let shared = UserDefaultsHelper()
  var level: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.level.rawValue)
    }
    set {
      guard newValue >= 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.level.rawValue)
    }
  }
  
  var coins: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.coins.rawValue)
    }
    set {
      guard newValue >= 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.coins.rawValue)
    }
  }
  
  var current: Int {
    get {
      return UserDefaults.standard.integer(forKey: UserDefaultsKeys.current.rawValue)
    }
    set {
      guard newValue >= 0 else { return }
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.current.rawValue)
    }
  }
  
  var isMuted: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isMuted.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isMuted.rawValue)
    }
  }
  
  var isMutedSound: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isMutedSound.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isMutedSound.rawValue)
    }
  }
  
  var second: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.second.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.second.rawValue)
    }
  }
  
  var third: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.third.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.third.rawValue)
    }
  }
  
  var fourth: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.fourth.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.fourth.rawValue)
    }
  }
  
  var fifth: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.fifth.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.fifth.rawValue)
    }
  }
  
  var sixth: Bool {
    get {
      return UserDefaults.standard.bool(forKey: UserDefaultsKeys.sixth.rawValue)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.sixth.rawValue)
    }
  }
  
  init() {
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.isMuted.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.isMutedSound.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.level.rawValue : 0])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.coins.rawValue : 0])

    UserDefaults.standard.register(defaults: [UserDefaultsKeys.second.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.third.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.fourth.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.fifth.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.sixth.rawValue : false])
    UserDefaults.standard.register(defaults: [UserDefaultsKeys.current.rawValue : 0])

  }
}
