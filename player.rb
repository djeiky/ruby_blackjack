require_relative 'hand.rb'
class Player
  attr_reader :name, :money, :bet, :hand

  START_MONEY = 100

  def initialize(name)
    @name = name
    @hand = Hand.new
    @money = START_MONEY
  end

  def clear_hand
    @hand = Hand.new
  end

  def take_card(card)
    @hand.take_card(card)
  end

  def make_bet(value)
    @bet = value
    @money -= @bet
  end

  def take_bet_back(value)
    @money += value
  end

  def show_hand
    @hand
  end

  alias win_bank take_bet_back
end
