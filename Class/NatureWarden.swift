class NatureWarden : Player, Mastery {
  let max_energy : Int 
  var energy : Int
  let ultimate_name : String 
  let skill_energy : Int

  init(player: Player) {
    self.max_energy = 80
    self.energy = 0
    self.ultimate_name = "Fertile Ground"
    self.skill_energy = 48
    super.init(name: player.name, attack: player.attack, max_hp: player.max_hp, health_point: player.health_point, is_alive: player.is_alive, level: player.level, mana_point: player.mana_point, max_mana: player.max_mana, stonecy: player.stonecy, defeated_enemy : player.defeated_enemy, items: player.items)
  }

  override func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
    energy += 12
    if energy > max_energy {
      energy = max_energy
    }
  }

  func launch_ultimate(rival: inout Monster) {
    if energy == max_energy {
      rival.health_point -= 30
      if rival.health_point < 0 {
        rival.health_point = 0
        rival.is_alive = false
        self.defeated_enemy += 1
      }
      energy -= max_energy
      print("You used your ultimate ability, \(ultimate_name)! You dealt 30 damage to \(rival.name)!")
    }
  }

  func restoration(){
    if energy >= skill_energy {
      energy -= skill_energy
      self.health_point += 20
      if self.health_point > self.max_hp {
        self.health_point = self.max_hp
      }
      print("You restored yourself by 20 HP.")
    }
  }

  override func level_up(){
    if self.defeated_enemy % 4 == 0 {    
      if self.level == 5 {
        return
      }
      self.level += 1
      self.attack += 2*self.level
      if self.level == 4{
        self.attack += 2
      }
    }
  }
}