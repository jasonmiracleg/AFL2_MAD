struct Player{
  let name: String
  var health_point: Int = 100
  var mana_point: Int = 50
  var attack: Int = 0
  let max_hp: Int = 100
  let max_mana: Int = 50
  var is_alive: Bool = true
  var items = [Item(item_name : "Potion", amount : 0), Item(item_name : "Elixir", amount : 20)]
  
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

  func check_status(player current_Figure : Figure){
    print("Player name: \(player.name)")
    print("\nHP: \(player.health_point)/\(player.max_hp)")
    print("MP: \(player.mana_point)/\(player.max_mana)")
    print("\nMagic :")
    print("- Physical Attack. No mana required. Deal 5pt of damage.")
    print("- Meteor. Use 15 pt of MP. Deal 50pt of damage.")
    print("- Shield. Use 10 pt of MP. Block enemy's attack in 1 turn.")
    print("\nItems: ")
    for item in items {
      print("\(item.item_name) x \(item.amount). ", terminator: ""); if item.item_name == "Potion" {
        print("Heal 20pt of your HP")
      } else {
        print("Add 10pt of your MP")
      }
    }
  }
}