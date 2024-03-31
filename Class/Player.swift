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
  var pet : Pet?

  init(name: String, attack: Int, max_hp: Int, health_point: Int, is_alive: Bool, level: Int,mana_point: Int, max_mana: Int, stonecy: Int, items: [Item]){
    self.name = name
    self.mana_point = 50
    self.attack = 10
    self.health_point = 100
    self.max_hp = 100
    self.max_mana = 50
    self.is_alive = true
    self.level = 1
    self.stonecy = 10
    self.items = [Item(item_name : "Potion", amount : 5, price : 15), Item(item_name : "Elixir", amount : 10, price : 20), Item(item_name : "Energy Botol", amount : 0, price : 35)]
  }
  
  convenience init(name: String){
    self.init(name: name, attack: 10, max_hp: 100, health_point: 100, is_alive: true, level: 1, mana_point: 50, max_mana: 50, stonecy: 10, items: [Item(item_name : "Potion", amount : 5, price : 15), Item(item_name : "Elixir", amount : 10, price : 20), Item(item_name : "Energy Botol", amount : 0, price : 35)])
  }
  
  func use_item(item: Item){
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

  func buy_item(item: Item, shop : inout Shop) -> Bool {
    if stonecy < item.price {
      return false
    }
    if let index = shop.items.firstIndex(where: { $0.item_name == item.item_name }) {
      stonecy -= item.price
      if shop.items[index].amount == 0{
        return false
      }
      shop.items[index].amount -= 1
      if item.item_name == "Potion" {
          items[0].amount += 1
      } else if item.item_name == "Elixir" {
          items[1].amount += 1
      } else {
          items[2].amount += 1
      }
      return true
    }
    return false
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
      if item.item_name == "Energy Botol" && self.level < 3 {
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

  func acquire_new_pet(_ new_pet : Pet){
    self.pet = new_pet
  }

  func train_pet(){
    if self.pet == nil{
      return
    } else {
      self.pet!.knowledge += 1
    }
  }
}