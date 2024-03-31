class FloodBender : Player, Mastery {
  let max_energy : Int 
  var energy : Int
  let ultimate_name : String 
  let skill_energy : Int
  
  init(player: Player) {
    self.max_energy = 120
    self.energy = 0
    self.ultimate_name = "Tsunami"
    self.skill_energy = 72
    super.init(name: player.name,
                 attack: player.attack,
                 max_hp: player.max_hp,
                 health_point: player.health_point,
                 is_alive: player.is_alive,
                 level: player.level,
                 mana_point: player.mana_point,
                 max_mana: player.max_mana,
                 stonecy: player.stonecy,
                 items: player.items)
  }

  override func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
    energy += 18
    if energy > max_energy {
      energy = max_energy
    }
  }
  
  func launch_ultimate(rival: inout Monster) {
    if energy == max_energy {
      rival.health_point -= 50
      if rival.health_point < 0 {
        rival.health_point = 0
      }
      energy -= max_energy
      print("You used your ultimate ability, \(ultimate_name)! You dealt 50 damage to \(rival.name)!")
    }
  }

  func generate_mana(){
    if energy >= skill_energy {
      mana_point += 20
      energy -= skill_energy
      if mana_point > max_mana {
        mana_point = max_mana
      }
      print("You used your skill. You gained 20 mana points.")
    }
  }
}