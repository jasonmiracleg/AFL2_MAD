protocol Figure{
  var name : String {get}
  var attack : Int {get set}
  var max_hp : Int {get set}
  var health_point : Int {get set}
  var is_alive : Bool {get set}
  var level : Int {get set}

  func attack(attacker: Figure, rival: inout Figure, damage : Int)
  func check_status()
}