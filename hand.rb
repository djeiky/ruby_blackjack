require_relative 'card.rb'

class Hand

  attr_reader :cards

  MAX_POINTS = 21
  MAX_CARDS = 3

  def initialize
    @cards = []
  end

  def take_card(card)
    @cards << card
  end

  def full?
    @cards >= MAX_CARDS
  end

  def show
    @cards.join ', '
  end

  def value
    val = @cards.map(&:value).sum
    ace = @cards.find(&:ace?)
    if ace && (val <= (MAX_POINTS - 10))
      val += 10
    end
    val
  end
end
