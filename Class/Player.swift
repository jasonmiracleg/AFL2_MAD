class Player : Figure {
  var name : String
  var attack : Int
  var max_hp : Int
  var health_point : Int
  var is_alive : Bool
  var level : Int
  var mana_point: Int
  let max_mana: Int
  var stonecy : Int // currency
  var items : [Item]
  var pet : Pet? = nil
  var defeated_enemy : Int
  var has_mastered = false
  var shield_on = false

  init(name: String, attack: Int, max_hp: Int, health_point: Int, is_alive: Bool, level: Int, mana_point: Int, max_mana: Int, stonecy: Int, defeated_enemy : Int, items: [Item]){
    self.name = name
    self.mana_point = mana_point
    self.attack = attack
    self.health_point = health_point
    self.max_hp = max_hp
    self.max_mana = max_mana
    self.is_alive = is_alive
    self.level = level
    self.stonecy = stonecy
    self.defeated_enemy = defeated_enemy
    self.items = items
  }
  
  convenience init(name: String){
    self.init(name: name, attack: 10, max_hp: 100, health_point: 100, is_alive: true, level: 2, mana_point: 50, max_mana: 50, stonecy: 50, defeated_enemy : 3, items: [Item(item_name : "Potion", amount : 5, price : 15), Item(item_name : "Elixir", amount : 10, price : 20), Item(item_name : "Energy Botol", amount : 0, price : 35)])
  }
  
  func use_item(item: inout Item){
    if item.item_name == "Potion"{
      self.health_point += 20
      if health_point > max_hp {
        self.health_point = max_hp
      }
      items[0].amount -= 1
    } else if item.item_name == "Elixir"{
      self.mana_point += 10
      if mana_point > max_mana {
        self.mana_point = max_mana
      }
      items[1].amount -= 1
    } 
  }

  func buy_item(at index : Int, shop : inout Shop) -> Bool {
    guard index >= 0 && index < shop.items.count else {
      print("The chosen item is not available")
      return false
    }
    let selected_item = shop.items[index]
    if stonecy < selected_item.price {
      print("Not enough stonecy to buy \(selected_item.item_name)")
      return false
    }
    stonecy -= selected_item.price
    if selected_item.amount == 0 {
      print("\(selected_item.item_name) is out of stock")
      return false
    }
    shop.items[index].amount -= 1
    switch selected_item.item_name {
    case "Potion":
      items[0].amount += 1
    case "Elixir":
      items[1].amount += 1
    case "Energy Botol":
      items[2].amount += 1
    default:
      break
    }
    return true
  }

  func attack(attacker: Figure, rival: inout Figure, damage : Int) {
    print("\(attacker.name) attacks \(rival.name) with \(damage) damage")
    rival.health_point -= damage
    if rival.health_point <= 0 {
      rival.health_point = 0
      rival.is_alive = false
      self.defeated_enemy += 1
    }
  }
  
  func check_status() {
    print("\nPlayer name: \(self.name)")
    print("\nHP: \(self.health_point)/\(self.max_hp)")
    print("MP: \(self.mana_point)/\(self.max_mana)")
    print("\nMagic :")
    print("- Physical Attack. No mana required. Deal \(self.attack) of damage.")
    print("- Meteor. Use 15 pt of MP. Deal 50pt of damage.")
    print("- Shield. Use 10 pt of MP. Block enemy's attack in 1 turn.")
    print("\nItems: ")
    for item in self.items {
      if item.item_name == "Energy Botol" && self.level < 3 {
        return
      } else if item.item_name == "Pet Egg" {
        return
      }
      print("\(item.item_name) x \(item.amount). ", terminator: ""); if item.item_name == "Potion" {
        print("Heal 20pt of your HP")
      } else if item.item_name == "Elixir" {
        print("Add 10pt of your MP")
      } else {
        print("Generate 20pt of your Energy")
      }
    }
  }

  func level_up(){
    if self.defeated_enemy % 4 == 0 && self.defeated_enemy > 3 {    
      if self.level == 3 {
        has_mastered = true
        return
      }
      self.level += 1
      self.max_hp += 10*self.level
      self.health_point = self.max_hp
      self.attack += 2*self.level
      print("\n\u{001B}[33mYou have leveled up\u{001B}[0m\n")
    }
  }

  func use_shield(){
    if self.mana_point >= 10 {
      self.mana_point -= 10
      self.shield_on = true
    } else {
      print("\nEnable to use shield because of insufficient mana")
    }
  }

  func train_pet(){
    if self.pet == nil{
      print("\nYou don't have any pet")
      return
    } else {
      self.pet!.knowledge += 1
      self.pet!.level_up()
      print("\nYou have you trained your pet. \(self.pet!.name) gained 1 knowledge point")
    }
  }
}