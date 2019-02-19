class Card
  attr_reader :face, :suit

  def initialize(face, suit)
    @face = face
    @suit = suit
    @face_down = true
  end

  def face_up
    @face_down = false
  end

  def to_s
    @face_down ? "*" : "#{@face}#{@suit}"
  end
end

