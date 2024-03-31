struct Player : Figure {
  var name : String
  var attack : Int
  var max_hp : Int
  var health_point : Int
  var is_alive : Bool
  var level : Int
  var mana_point: Int
  let max_mana: Int
  var items : [Item]

  init(name : String){
    self.name = name
    self.mana_point = 50
    self.attack = 10
    self.health_point = 100
    self.max_hp = 100
    self.max_mana = 50
    self.is_alive = true
    self.level = 1
    self.items = [Item(item_name : "Potion", amount : 0), Item(item_name : "Elixir", amount : 20)]
  }
  
  mutating func use_item(item: Item){
    if item.item_name == "Potion"{
      self.health_point += 20
      if health_point > max_hp {
        self.health_point = max_hp
      }
    } else if item.item_name == "Elixir"{
      self.mana_point += 10
      if mana_point > max_mana {
        self.mana_point = max_mana
      }
    }
    for index in items.indices {
        if items[index].item_name == item.item_name {
            items[index].amount -= 1
            break
        }
    }
  }

  func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
  }
  
  func check_status() {
    print("Player name: \(self.name)")
    print("\nHP: \(self.health_point)/\(self.max_hp)")
    print("MP: \(self.mana_point)/\(self.max_mana)")
    print("\nMagic :")
    print("- Physical Attack. No mana required. Deal 5pt of damage.")
    print("- Meteor. Use 15 pt of MP. Deal 50pt of damage.")
    print("- Shield. Use 10 pt of MP. Block enemy's attack in 1 turn.")
    print("\nItems: ")
    for item in self.items {
      print("\(item.item_name) x \(item.amount). ", terminator: ""); if item.item_name == "Potion" {
        print("Heal 20pt of your HP")
      } else {
        print("Add 10pt of your MP")
      }
    }
  }
}