struct Game{
  
  func gameplay(){
    opening_scene()
  }
  
  func opening_scene(){
    repeat {
      print("Welcome to the world of magic! 🧙‍♂️🧌")
      print("You have been chosen to embark on an epic journey as a young wizard on the path to becoming a master of the arcane arts. Your adventures will take you through forest 🌳, mountains 🏔️, and dungeons 🏰, where you will face challenges, make allies, and fight enemies.")
      print("Press [return] to continue...", terminator: "")
      if let input = readLine(){
        if input.isEmpty {
          break
        }
      }
      print("\n")
    } while (true)
    print("\n")
    welcoming_scene()
  }

  func welcoming_scene(){
    var player: Player?
    repeat{
      print("May I know your name, a young wizard? ", terminator: "")
      if let name = readLine(){
        if check_alphabet(input: name){
          player = Player(name: name)
          if let player = player{
            print("Nice to meet you \(player.name)")
            break
          }
        }
      }
    } while(true)
    if var player = player {
        print("\n")
        journey_screen(player: &player)
    }
  }

  func journey_screen(player : inout Player){
    repeat{
      print("From here, you can...")
      print("\n[C]heck your health and stats")
      print("[H]eal your wounds with potion")
      print("\n...or choose where you want to go")
      print("\n[F]orest of Troll")
      print("[M]ountain of Golem")
      print("[Q]uit Game")
      print("\nYour choice? ", terminator: "")
      if let input = readLine(){
        switch input.uppercased(){
          case "C":
            repeat{
              player.check_status()
              print("\nPlease [return] to go back : ", terminator: "")
              if let input = readLine(){
                if input.isEmpty {
                  break
                }
              }
            } while true
          case "H":
            healing_screen(player: &player)
          case "F":
            print("")
          case "M":
            print("")
          case "Q":
            print("")
          default:
            print("Input Invalid")
        }
      }
    } while (true)
  }

  func healing_screen(player: inout Player){
    print("Your HP is \(player.health_point)")
    if let potion = player.items.first(where: { $0.item_name == "Potion" }) {
      if potion.amount <= 0 {
        print("You don't have any potion left. be careful of your next journey. Press [return] to go back: ", terminator: "")
      } else {
        if player.health_point == 100 {
          print("⛔️ WARNING ⛔️ Using potion while your HP is 100 will not affect your HP, yet the potion amount will be deducted")
        }
        repeat {
          print("You have \(potion.amount) Potions")
          print("Are you sure want to use 1 potion to heal wound? [Y/N] ", terminator: "")
          if let input = readLine(){
            if input.uppercased() == "Y"{
              player.use_item(item: potion)
              print("\nYour HP is now : \(player.health_point)")
              print("\nYou have \(potion.amount - 1) Potion(s) left")
              print("\n")
            } else if input.uppercased() == "N" {
              break
            }
          }    
        } while true
      }
    }
    print("\n")
  }
  
  func check_alphabet(input: String) -> Bool{
    if input.isEmpty{
      return false
    }
    for char in input {
      if !("a"..."z" ~= char || "A"..."Z" ~= char){
        return false
      }
    }
    return true
  }
}