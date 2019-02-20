require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'

class Game
  BET = 10

  def initialize
    @player = new_player
    @dealer = Dealer.new
  end

  def new_player
    print 'Enter your name - '
    name = gets.chomp
    name = name.empty? ? 'Player' : name
    Player.new(name)
  end

  def start_game
    loop do
      start_round
      make_moves
      end_round

      if @player.money < BET
        puts 'Not enought money'
        break
      end

      puts 'You won everything' if @dealer.money < BET

      return unless continue_game?
    end
  end

  def game_status
    puts "Dealer hand - #{@dealer.hand} Money - #{@dealer.money}"
    puts "Player #{@player.name} hand - #{@player.hand} Money - #{@player.money}"
  end

  def start_round
    make_bets
    @deck = Deck.new
    @player.clear_hand
    @dealer.clear_hand
    2.times do
      @player.take_card @deck.deal_card.face_up
      @dealer.take_card @deck.deal_card
    end
  end

  def make_moves
    loop do
      game_status
      case player_choice
      when 2 then @player.take_card(@deck.deal_card.face_up)
      when 3 then
        @dealer.take_card(@deck.deal_card)
        break
      end

      @dealer.take_card(@deck.deal_card)

      break if @player.hand.full? && @dealer.hand.full?
    end
  end

  def player_choice
    puts 'check - 1'
    puts 'take card - 2'
    puts 'open - 3'
    gets.to_i
  end

  def continue_game?
    puts 'Continue - 1'
    puts 'Exit - 2'
    choice = gets.to_i
    choice == 1
  end

  def end_round
    @dealer.show_hand
    game_status
    winner = get_winner
    if winner
      puts "Winer - #{winner.name}"
      winner.win_bank(@player.bet + @dealer.bet)
    else
      puts 'Nobody win'
      @player.take_bet_back(@player.bet)
      @dealer.take_bet_back(@player.bet)
    end
    game_status
  end

  def get_winner
    return if @player.hand.busted? && @dealer.hand.busted?
    return if @player.hand.value == @dealer.hand.value
    return @player if !@player.hand.busted? && @dealer.hand.busted?
    return @dealer if @player.hand.value < @dealer.hand.value || @player.hand.busted?
    return @player if @player.hand.value > @dealer.hand.value || @dealer.hand.busted?
  end

  def make_bets
    @player.make_bet(BET)
    @dealer.make_bet(BET)
  end

  def deal_cards; end
end

Game.new.start_game
