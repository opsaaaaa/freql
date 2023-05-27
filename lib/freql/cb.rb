module Freql
  module CB
    # Its a word frequency from of logarithmic centibel scale.

    # practical range -127(the) to -799
    # actuall range is 0 to -900(or less)

    # cb is the word frequency unit used the dataset from the python wordfq program.
    # https://github.com/rspeer/wordfq

    # > 0 cB represents a word that occurs with probability 1, so it is the only
    # > word in the data (this of course doesn't happen). -200 cB represents a
    # > word that occurs once per 100 tokens, -300 cB represents a word that
    # > occurs once per 1000 tokens, and so on.

    # Advantages
    # - Its very similar to zipf, but with a different scale and 0 point.
    # - Its really good for storage sizes.
    # - Its always less than 0, so rare values cant cross 0.
    # - and numbers are larger, so you dont need decimils for reasonable accuracy.
    # - you can easilly save them as positive integers.

    # Disadvantages
    # - its less human readable.

    # In the wordfq program they 'bin' the data to reduce the file size further.
    # array[ bin[ "words", ...], ... ]
    # The index of the bin represents the positive frequency value.
    # you end up with a lot of leading empty bins, but after that it gets really effecient.

    class << self
      def to_fq cb
        raise ArgumentError, "cb fq cannot be positive number" if cb > 0
        10.00 ** (cb / 100.00)
      end
      def to_fpmw cb
        raise ArgumentError, "cb fq cannot be positive number" if cb > 0
        (10.00 ** (-(cb.abs) / 100.00)) * 1000000
      end
      def to_fpbw cb
        raise ArgumentError, "cb fq cannot be positive number" if cb > 0
        (10.00 ** (-(cb.abs) / 100.00)) * 1000000000
      end
      def to_zipf cb
        raise ArgumentError, "cb fq cannot be positive number" if cb > 0
        (cb + 900.00) / 100.00
      end
    end
  end
end

