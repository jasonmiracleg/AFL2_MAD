struct Monster : Figure {
  var name : String
  var attack : Int
  var max_hp : Int
  var health_point : Int
  var is_alive : Bool
  var level : Int
  var has_summoned = false

  init(name : String){ // Primary Monster
    self.name = name
    self.attack = Int.random(in: 5...15)
    self.level = Int.random(in: 1...3)
    self.max_hp = 200*self.level
    self.health_point = self.max_hp
    self.is_alive = true
  }

  init(name : String, max_hp : Int){ // Summoned Monster
    self.name = name
    self.attack = Int.random(in: 5...10)
    self.level = Int.random(in: 1...2)
    self.max_hp = max_hp*self.level
    self.health_point = self.max_hp
    self.is_alive = true
    self.has_summoned = true
  }

  func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
    if rival.health_point <= 0 {
      rival.health_point = 0
      rival.is_alive = false
    }
  }
  
  func check_status() {
    print("\n😈 Monster name: \(self.name)")
    print("😈 HP: \(self.health_point)/\(self.max_hp)")
    print("😈 Attack : \(self.attack)")
  }

  func summon_backup(name : String) -> Monster{
    return Monster(name: "Summoned \(name)", max_hp : 50)
  }
}