protocol Mastery {
  var max_energy : Int {get} 
  var energy : Int {get set}
  var ultimate_name : String {get}
  var skill_name : String {get}
  var skill_energy : Int {get}
  func launch_ultimate(rival: inout Figure)
  func launch_skill(player: inout AscendedPlayer)
}