struct Shop {
  var items : [Item]
  var updated = false
  
  init(){
    self.items = [Item(item_name : "Potion", amount : 20, price : 15), 
                  Item(item_name : "Elixir", amount : 20, price : 20),
                  Item(item_name : "Pet Egg", amount : 10, price : 35)]
  }
  
  func show_stocks(){
    print("\nWelcome to the Magical Tavern")
    for (index, item) in self.items.enumerated() {
      print("\(index + 1). \(item.item_name): \(item.amount)x, price: \(item.price)")
    }
  }

  mutating func final_update(player : Player){
    if player.level >= 3  && !self.updated{
      items.append(Item(item_name : "Energy Botol", amount : 15, price : 35))
      self.updated = true
    }
  }
}