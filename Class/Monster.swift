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
    self.max_hp = 1000
    self.health_point = 1000
    self.is_alive = true
    self.level = 1
  }

  func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
  }
  
  func check_status() {
    print("😈 Monster name: \(self.name)")
    print("😈 HP: \(self.health_point)/\(self.max_hp)")
    print("😈 Attack : \(self.attack)")
  }
}