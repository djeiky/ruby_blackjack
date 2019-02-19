require_relative 'card.rb'

class Deck

  SUITS = ['♠', '♦', '♥', '♣']
  FACES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  attr_accessor :cards

  def initialize
    @cards = create_deck
  end

  def deal_card
    @cards.shift
  end

private
  def create_deck
    @cards = SUITS.map {|suit| FACES.map {|face| Card.new face, suit}}.flatten
    @cards.shuffle
  end
end
