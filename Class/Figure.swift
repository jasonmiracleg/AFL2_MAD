protocol Figure{
  var name : String {get}
  var attack : Int {get set}
  var max_hp : Int {get}
  var health_point : Int {get set}
  var is_alive : Bool {get set}
  var level : Int {get set}

  func attack(attacker: Figure, rival: Figure, damage : Int)
  func check_status(current_figure : Figure)
}

extension Figure{
  func attack(attacker: Figure, rival: Figure, damage : Int){
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
  }
}