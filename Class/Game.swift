struct Game{
  var shop : Shop 
  
  init(){
    shop = Shop()
  }
  
  mutating func opening_scene(){
    repeat {
      print("Welcome to the world of magic! 🧝‍♂️🧌")
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

  mutating func welcoming_scene(){
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

  mutating func journey_screen(player : inout Player){
    repeat{
      var enemies = Queue<Monster>()
      print("From here, you can...")
      print("\n[C]heck your health and stats")
      print("[H]eal your wounds with potion")
      print("\n...or choose where you want to go")
      print("\n[F]orest of Troll")
      print("[M]ountain of Golem")
      print("[P]et Menu")
      print("[S]hop")
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
          case "P":
            pet_screen(player: &player)
          case "S":
            shop_screen(player: &player)
          print("\n")
          case "Q":
            return
          default:
            print("Input Invalid")
        }
      }
    } while (true)
  }

  func healing_screen(player: inout Player){
    print("\nYour HP is \(player.health_point)")
    if let potionIndex = player.items.firstIndex(where: { $0.item_name == "Potion" }) {
      var potion = player.items[potionIndex]
      if potion.amount <= 0 {
        repeat {
          print("You don't have any potion left. Be careful on your next journey. Press [return] to go back: ", terminator: "")
          if let input = readLine(), input.isEmpty {
            break
          }
        } while true
      } else {
          if player.health_point == player.max_hp {
            print("⛔️ WARNING ⛔️ Using a potion while your HP is maxed out will not affect your HP, yet the potion amount will be deducted")
          }
          repeat {
            print("You have \(potion.amount) Potion(s)")
            print("Are you sure you want to use 1 potion to heal your wounds? [Y/N] ", terminator: "")
            if let input = readLine() {
              if input.uppercased() == "Y" {
                player.use_item(item: &potion)
                print("\nYour HP is now: \(player.health_point)")
                potion.amount-=1
                if potion.amount <= 0 {
                  print("You don't have any potion left. Be careful on your next journey. Press [return] to go back: ", terminator: "")
                  break
                }
              } else if input.uppercased() == "N" {
                break
              }
            }
          } while true
      }
    } else {
      print("You don't have any potions.")
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

  mutating func shop_screen(player: inout Player){
    print("\nCurrent Stonecy : \(player.stonecy)")
    self.shop.final_update(player: player)
    shop_loop : repeat {
      self.shop.show_stocks()
      print("0. Back")
      print("Choose an item to buy: ", terminator: "")
      if let input = readLine(), let choice = Int(input){
        if (choice == 0){
          break shop_loop
        } else if choice < 1 || choice > self.shop.items.count{
          print("The Selected Item isn't available")
        } else {
          if choice - 1 == 2 && shop.items[2].amount > 0 && player.stonecy >= shop.items[2].price {
              if player.pet != nil {
                repeat{
                  print("You already have a pet. Buying a pet means you're gonna release your previous pet. Do you wish to continue? [Y/N] ", terminator: "")
                  if let input = readLine() {
                    if input.uppercased() == "N"{
                      continue shop_loop
                    }
                  }
                } while input.uppercased() == "Y" && input.uppercased() == "N"
              } 
              buying_pet_process(player: &player)
          }
          let result = player.buy_item(at : (choice - 1), shop : &shop)
          if result {
            print("Successfully Purchased an item")
          }
        }
      } else {
        print("Number Input Only")
      }
    } while (true)
  }

  func buying_pet_process(player: inout Player){
    print("Pet Name : ", terminator : "")
    if let name = readLine(){
      repeat {
        print("Pet Role : ")
        print("1. Healer (Heals 10% based on your pet's max HP)")
        print("2. Offender (Attacks enemy with 50% based on pet's attack)")
        print("Select a role : ", terminator: "")
        if let input = readLine(), let role = Int(input){
          if role == 1 {
            let base_healing = Int(50*0.1)
            player.pet = Pet(name, .Healer(healing_point : base_healing))
            break
          } else if role == 2 {
            let bonus_attack = Int(Double(player.attack) * 0.5)
            player.pet = Pet(name, .Offender(bonus_attack : bonus_attack))
            break
          } else {
            print("Invalid role")
          }
        }
      } while true
    }
  }
  
  func pet_screen(player: inout Player){
    repeat {
      print("\n[C]heck Pet Status")
      print("[T]rain Pet")
      print("[B]ack")
      print("Your choice? ", terminator: "")
      if let input = readLine(){
        switch input.uppercased(){
          case "C":
            if player.pet == nil {
              print("You don't have any pet yet")
            } else {
              player.pet!.check_status()
            }
          case "T":
            player.train_pet()
          case "B":
            return
          default:
            print("Input Invalid")
        }
      }
    } while true
  }
  
  func mountain_screen(player: inout Player,_ enemies : inout Queue<Monster>){
    let initial_enemy = Int.random(in: 1...3)
    for _ in 1...initial_enemy {
      enemies.enqueue(Monster(name: "Golem"))
    }
    print("\nAs you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin. Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem(s) emerging from the shadows.")
    battle_template(player : &player, &enemies)
  }
  
  func forest_screen(player : inout Player,_ enemies : inout Queue<Monster>){
    let initial_enemy = Int.random(in: 1...3)
    for _ in 1...initial_enemy {
      enemies.enqueue(Monster(name: "Troll"))
    }
    print("\nAs you enter the forest, you feel a sense of unease wash over you.")
    print("Suddenly, you hear the sound of twigs snapping behind you. you quickly spin around, and find a Troll(s) emerging from the shadows.")
    battle_template(player : &player, &enemies)
  }

  func battle_template(player : inout Player,_ enemies : inout Queue<Monster>){
    var turn = 1
    repeat {
      if let monster = enemies.dequeue() {
        var current_monster = monster as Figure
        repeat {
          if player.pet != nil && turn % 5 == 0 && turn > 4{
            var current_pet = player.pet!
            current_pet.attack(attacker : current_pet, rival : &current_monster, damage : current_monster.attack)
            current_pet.heal(player: &player)
          }
          if player.shield_on {
            print("Shield is off")
            player.shield_on = false
          }
          battle_information(current_monster: current_monster, player: player, enemies : enemies)
          if let input = readLine() {
            switch input.uppercased() {
              case "1":
                player.attack(attacker: player, rival: &current_monster, damage: player.attack)
              case "2":
                if player.mana_point >= 15 {
                  player.attack(attacker: player, rival: &current_monster, damage: 50)
                  player.mana_point -= 15
                } else {
                  print("Enable to cast a meteor because of insufficient mana")
                }
              case "3":
                player.use_shield()
              case "4":
                healing_screen(player: &player)
              case "5":
              if var elixirItem = player.items.first(where: { $0.item_name == "Elixir" }) {
                if elixirItem.amount <= 0 {
                  print("Insufficient Elixir")
                } else {
                  player.use_item(item: &elixirItem)
                }
              } 
              case "6":
                current_monster.check_status()
              case "7":
                flee_screen()
                return
              case "E":
              if var elixirItem = player.items.first(where: { $0.item_name == "Elixir" }) {
                if player.has_mastered{
                  if elixirItem.amount <= 0 {
                    print("Insufficient Elixir")
                  } else {
                    player.use_item(item: &elixirItem)
                  }
                } else {
                  print("Invalid choice")
                  continue
                }
              } 
              case "S":
                if var ascendedPlayer = player as? AscendedPlayer {
                  ascendedPlayer.launch_skill(player: &ascendedPlayer)
                } else {
                  print("Invalid choice")
                  continue
                }
              case "U":
                if let ascendedPlayer = player as? AscendedPlayer {
                  ascendedPlayer.launch_ultimate(rival: &current_monster)
                } else {
                  print("Invalid choice")
                  continue
                }
              default:
                print("Invalid choice")
                continue
            }
          }
          if !player.shield_on {
            var attacked_player = player as Figure
            current_monster.attack(attacker: current_monster, rival: &attacked_player, damage: current_monster.attack)
          } else {
            print("Successfully blocked the attack")
          }
          if turn % 5 == 0 && player.level >= 3 {
            if var monster = current_monster as? Monster {
              if !monster.has_summoned {
                let backup_monster = monster.summon_backup(name: monster.name)
                enemies.enqueue(backup_monster)
                current_monster = monster as Figure
              }
            }
          }
          turn += 1
          player.level_up()
          player = evolve(player: player)
        } while current_monster.is_alive && player.is_alive
        if !player.is_alive {
          print("You have been defeated by the \(current_monster.name)")
          player.health_point = player.max_hp
          print("You've been resurrected")
          player.is_alive = true
          player.stonecy += 15
          print("You've gained 5 stonecy")
          break
        } 
      } else {
        print("You Won!\n")
        player.level_up()
        player = evolve(player: player)
        player.stonecy += 50
        print("You've gained 50 stonecy\n")
        break
      }
    } while true
  }

  func battle_information(current_monster : Figure, player : Player, enemies : Queue<Monster>){
    print("\n😈 Name : \(current_monster.name) Lv. \(current_monster.level)| Remaining \(enemies.count)x")
    print("😈 Health : \(current_monster.health_point)/\(current_monster.max_hp)")
    print("\n🧝‍♂️ Name : \(player.name) Lv. \(player.level)")
    print("🧝‍♂️ Health : \(player.health_point)/\(player.max_hp)")
    print("🧝‍♂️ Mana : \(player.mana_point)/\(player.max_mana)")
    if let ascendedPlayer = player as? AscendedPlayer {
      print("🧝‍♂️ Energy : \(ascendedPlayer.energy)/\(ascendedPlayer.max_energy)")
    }
    print("\nChoose your action: ")
    print("[1] Physical Attack. No mana required. Deal \(player.attack) pt of damage.")
    print("[2] Meteor. Use 15 pt of MP. Deal 50pt of damage.")
    print("[3] Shield. Use 10 pt of MP. Block enemy's attack in 1 turn.")
    if let ascendedPlayer = player as? AscendedPlayer {
      print("[S] Skill \(ascendedPlayer.skill_name). Use \(ascendedPlayer.skill_energy) Energy")
      print("[U] Ultimate \(ascendedPlayer.ultimate_name). Use \(ascendedPlayer.max_energy) Energy")
      print("[E] Energize. Gain 20 Energy")
    }
    print("\n[4] Use Potion to heal wounds.")
    print("[5] Use Elixir to gain mana.")
    print("[6] Scan enemy's vital.")
    print("[7] Flee from battle.")
    print("Your choice? ", terminator: "")
  }

  func flee_screen(){
    print("\nYou feel that if you don't escape soon, you won't be able to continue the fight. You look around frantically, searching for a way out. You sprint towards the exit, your heart pounding in your chest")
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

  func evolve(player : Player) -> Player {
    if player.level >= 3 && !player.has_mastered {
      print("\nYou have reached level 3")
      print("You may select mastery skill")
      print("1. Floody Bender - Mana Generation Skill")
      print("2. Nature Warden - Healing Skill")
      print("Your choice : ")
      if let input = readLine(), let choice = Int(input){
        switch choice{
          case 1:
            return AscendedPlayer(player : player, speciality : .FloodyBender, pet : player.pet)
          case 2:
            return AscendedPlayer(player : player, speciality : .NatureWarden, pet : player.pet)
          default:
            print("Invalid choice")
        }
      }
    }
    return player
  }
}