enum specialities {
  case FloodyBender
  case NatureWarden
}

class AscendedPlayer : Player {
  let max_energy : Int 
  var energy : Int
  let ultimate_name : String 
  let skill_name : String
  let skill_energy : Int
  let speciality : specialities
  let speciality_title : String
  
  init(player: Player, speciality : specialities, pet : Pet?) {
    self.energy = 0
    if speciality == .FloodyBender {
      self.max_energy = 120
      self.ultimate_name = "Tsunami"
      self.skill_energy = 72
      self.speciality_title = "Floody Bender"
      self.skill_name = "Hydrogen Geneator"
    } else {
      self.max_energy = 80
      self.ultimate_name = "Fertile Ground"
      self.skill_energy = 48
      self.speciality_title = "Nature Warden"
      self.skill_name = "Sprouts"
    }
    self.speciality = speciality
    super.init(name: player.name, attack: player.attack, max_hp: player.max_hp, health_point: player.health_point, is_alive: player.is_alive, level: player.level, mana_point: player.mana_point, max_mana: player.max_mana, stonecy: player.stonecy, defeated_enemy : player.defeated_enemy, items: player.items)
    super.has_mastered = true
    super.pet = pet
  }

  override func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
    if rival.health_point <= 0 {
      rival.health_point = 0
      rival.is_alive = false
      super.defeated_enemy += 1
    }
    if let ascendedAttacker = attacker as? AscendedPlayer {
        if ascendedAttacker.speciality == .FloodyBender {
            ascendedAttacker.energy += 18
        } else {
            ascendedAttacker.energy += 12
        }
        if ascendedAttacker.energy > ascendedAttacker.max_energy {
            ascendedAttacker.energy = ascendedAttacker.max_energy
        }
    }
  }

  override func check_status(){
    super.check_status()
    print("\nSpeciality: \u{001B}[35m\(self.speciality_title)\u{001B}[35m")
    print("Skill : \(self.skill_name) (Generate Mana) | Energy cost : \(self.skill_energy) ")
    print("Ultimate : \(self.ultimate_name) (Restore HP) | Energy cost : \(self.max_energy)")
  }
  
  func launch_ultimate(rival: inout Figure) {
    if energy == max_energy {
      rival.health_point -= 50
      if rival.health_point <= 0 {
        rival.health_point = 0
        rival.is_alive = false
        super.defeated_enemy += 1
      }
      energy -= max_energy
      print("\nYou used your ultimate ability, \(ultimate_name)! You dealt 50 damage to \(rival.name)!")
    } else {
      print("\nYou don't have enough energy to use your ultimate ability!")
    }
  }

  func launch_skill(player : inout AscendedPlayer){
    if player.energy >= player.skill_energy {
      if player.speciality == .FloodyBender {
        player.mana_point += 15
        if player.health_point >= player.max_hp{
          player.mana_point = player.max_mana
          print("\nYou generate 15 MP")
        } 
      } else {
        player.health_point += 20
        if player.health_point >= player.max_hp{
          player.health_point = player.max_hp
          print("\nYou restore 20 HP")
        }
      }
      player.energy -= player.skill_energy
    } else {
     print("Insufficient energy to launch a skill") 
    }
  }

  override func use_item(item: inout Item){
    super.use_item(item: &item)
    if item.item_name == "Energy Botol"{
      energy += 20
      if energy > max_energy {
        energy = max_energy
      }
      self.items[2].amount -= 1
    }
  }
  
  override func level_up(){
    if self.defeated_enemy % 4 == 0 && self.defeated_enemy > 15 {    
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