struct Monster : Figure {
  let name : String
  var attack = Int.random(in: 1...15)
  var max_hp : Int = 1000
  var health_point : Int = 1000
  var is_alive : Bool = true
  
  func show_status(enemy current_Figure : Figure){
    print("😈Monster name: \(enemy.name)")
    print("😈 HP: \(enemy.health_point)/\(enemy.max_hp)"
    print("😈 Attack : \(enemy.attack)")
  }
}