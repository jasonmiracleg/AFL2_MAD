enum Role {
  case Healer(healing_point : Int)
  case Offender(bonus_attack : Int)
}

struct Pet : Figure {
  var name : String
  var attack : Int
  var max_hp : Int
  var health_point : Int
  var is_alive : Bool
  var level : Int
  var role : Role
  var knowledge : Int

  init(name: String, role : Role){
    self.name = name
    self.max_hp = 50
    self.health_point = 50
    self.is_alive = true
    self.level = 1
    self.role = role
    self.knowledge = 0
    self.attack = 5
  }
  
  func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    if case let .Offender(bonus_attack) = self.role {
      print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
      rival.health_point -= damage + bonus_attack
      if (rival.health_point < 0){
        rival.health_point = 0
      }
    }
  }

  mutating func heal(player: inout Figure){
    if case let .Healer(healing_point) = self.role{
      player.health_point += healing_point
      if player.health_point > player.max_hp{
        player.health_point = player.max_hp
      }
    }
  }

  mutating func level_up(){
    if self.level == 3 {
      return
    }
    if self.knowledge % 3 == 0 && knowledge > 2{
      self.level += 1
      switch self.role {
      case .Healer(var healing_point):
          healing_point *= self.level
          self.role = .Healer(healing_point: healing_point)
      case .Offender(let bonus_attack):
          attack += self.level*bonus_attack
      }
    }
  }
  
  func check_status() {
    print("🙉 Pet name: \(self.name)")
    print("🙉 HP: \(self.health_point)/\(self.max_hp)")
    switch self.role {
      case .Healer(let healing_point):
        print("Can help restoring your health by \(healing_point) point")
      case .Offender(let bonus_attack):
        print("Can help attacking enemy by \(bonus_attack) damage")
    }
  }
}