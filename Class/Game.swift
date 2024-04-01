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
    var enemies = Queue<Monster>()
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
            forest_screen(player: &player, &enemies)
          case "M":
            mountain_screen(player: &player, &enemies)
          case "Q":
            break
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
        repeat {
          print("You don't have any potion left. be careful of your next journey. Press [return] to go back: ", terminator: "")
          if let input = readLine(){
            if input.isEmpty {
              break
            }
          }
        } while true
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

  func mountain_screen(player: inout Player,_ enemies : inout Queue<Monster>){
    let initial_enemy = Int.random(in: 1...3)
    for _ in 1...initial_enemy {
      enemies.enqueue(Monster(name: "Golem"))
    }
    print("As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin. Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it -  a massive, snarling Golem(s) emerging from the shadows.")
    battle_template(player : &player, &enemies)
  }
  
  func forest_screen(player : inout Player,_ enemies : inout Queue<Monster>){
    let initial_enemy = Int.random(in: 1...3)
    for _ in 1...initial_enemy {
      enemies.enqueue(Monster(name: "Troll"))
    }
    print("As you enter the forest, you feel a sense of unease wash over you.")
    print("Suddenly, you hear the sound of twigs snapping behind you. you quickly spin around, and find a Troll(s) emerging from the shadows.")
    battle_template(player : &player, &enemies)
  }

  func battle_template(player : inout Player,_ enemies : inout Queue<Monster>){
    var turn = 1
    repeat {
      if let monster = enemies.dequeue() {
        var current_monster = monster as Figure
        print("😈 Name : \(current_monster.name) \(enemies.count)")
        print("😈 Health : \(current_monster.health_point)/\(current_monster.max_hp)")
        print("Choose your action: ")
        print("[1] Physical Attack. No mana required. Deal \(player.attack) pt of damage.")
        print("[2] Meteor. Use 15 pt of MP. Deal 50pt of damage.")
        print("[3] Shield. Use 10 pt of MP. Block enemy's attack in 1 turn.")
        print("\n[4] Use Potion to heal wounds.")
        print("[5] Scan enemy's vital.")
        print("[6] Flee from battlle.")
        print("Your choice? ", terminator: "")
        if let input = readLine() {
          switch input{
            case "1":
              player.attack(attacker: player, rival: &current_monster, damage: player.attack)
            case "2":
              if player.mana_point >= 15 {
                player.attack(attacker: player, rival: &current_monster, damage: 50)
              } else {
                print("Enable to cast a meteor because of insufficient mana")
              }
            case "3":
              player.use_shield()
            case "4":
              healing_screen(player: &player)
            case "5":
              current_monster.check_status()
            case "6":
              flee_screen()
              return
            default:
              print("Invalid choice")
          }
        }
      } else {
        print("You Won!")
        player.level_up()
        break
      }
      turn += 1
    } while true
  }

  func flee_screen(){
    print("You feel that if you don't escape soon, you won't be able to continue the fight. You look around frantically, searching for a way out. You sprint towards the exit, your heart pounding in your chest")
    print("You're safe, for now.")
    print("Press [return] to continue:")
    repeat {
      if let input = readLine(){
        if input.isEmpty {
          break
        }
      }
      print("\n")
    } while true
  }
}