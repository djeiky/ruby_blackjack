class Interface
  def take_name
    print 'Enter your name - '
    name = gets.chomp
    name = name.empty? ? 'Player' : name
  end

  def no_money
    puts 'Not enought money'
  end

  def everything_win
    puts 'You won everything'
  end

  def print_winner(winner)
    puts "Winer - #{winner.name}"
  end

  def print_draw
    puts "Nobody wins"
  end

  def continue_game?
    puts 'Continue - 1'
    puts 'Exit - 2'
    choice = gets.to_i
    choice == 1
  end

  def player_choice
    puts 'check - 1'
    puts 'take card - 2'
    puts 'open - 3'
    gets.to_i
  end

  def game_status(players)
    players.each do |player|
      puts "-"*10
      print_player(player)
    end
  end

  def print_player(player)
    puts "#{player.name} hand - #{player.hand}"
  end

  def balance_status(players)
    puts "-"*10
    players.each do |player|
      puts "#{player.name} money - #{player.money}"
    end
  end

end
