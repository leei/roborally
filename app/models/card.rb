# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

class Card
  private

  #
  # A description of all the cards in the deck. The keys are the card name,
  # followed by a description of the range in priorities in the form
  # [min, max, step_size].
  #
  ALL_DESCRS = {
    :uturn => [10, 60, 10],
    :rotate_l => [70, 410, 20],
    :rotate_r => [80, 420, 20],
    :backup => [430, 480, 10],
    :move_1 => [490, 660, 10],
    :move_2 => [670, 780, 10],
    :move_3 => [790, 840, 10]
  }

  @@all_cards = nil

  class << self
    #
    # An array of all cards in the deck.  Generated from ALL_DESCRS.
    #
    private
    def all_cards
      return @@all_cards if @@all_cards
      cards = []
      ALL_DESCRS.each do |name, seq|
        args = name.to_s.split(/_/)
        klass = self.const_get(args.shift.to_s.camelize)
        (first, last, by) = seq
        pri = first
        while pri <= last
          cards << klass.new(pri, *args) if klass
          pri += by
        end
      end
      @@all_cards = cards
    end

    #
    # A shuffled deck of cards.
    #
    public
    def shuffle
      deck = all_cards.dup
      size = deck.length
      for i in 0..(size-1)
        j = rand(size)
        deck[i], deck[j] = deck[j], deck[i]
      end
      deck
    end
  end

  class Deck
    attr_reader :cards
    def initialize
      @cards = Card.shuffle
    end

    def deal
      @cards.shift
    end

    def size
      @cards.size
    end
  end
end
