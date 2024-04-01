struct Monster : Figure {
  var name : String
  var attack : Int
  var max_hp : Int
  var health_point : Int
  var is_alive : Bool
  var level : Int

  init(name : String){
    self.name = name
    self.attack = Int.random(in: 1...15)
    self.level = Int.random(in: 1...3)
    self.max_hp = 200*self.level
    self.health_point = 200*self.level
    self.is_alive = true
  }

  func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    if rival.health_point < 0 {
      rival.health_point = 0
      rival.is_alive = false
    }
  }
  
  func check_status() {
    print("😈 Monster name: \(self.name)")
    print("😈 HP: \(self.health_point)/\(self.max_hp)")
    print("😈 Attack : \(self.attack)")
  }

  func summon_backup(name : String) -> Monster{
    let backup = Monster(name: "Summoned \(name)")
    return backup
  }
}