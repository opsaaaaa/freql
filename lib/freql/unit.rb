
module Freql
  MILLION_F = 1000000.0
  BILLION_F = 1000000000.0
  MILLION = 1000000
  BILLION = 1000000000

  module Freq
    # frequency represented as a proportion between 0 and 1
    # occurances in corpus divided by total words in corpus

    # practicle range 0.053(the) 0.00000001(trella)
    # actual range 0 to 1

    def to_fpmw freq
      freq * 1000000
    end
    def to_fpbw freq
      freq * 1000000000
    end
    def to_zipf freq
      Math.log10(freq)+9
    end
    def to_cb freq
      Math.log10(freq) * 100.0
    end
  end

  module FPMW
    # frequency per million words.
    # or the number of times a word occurs in one million words
    # Practical range 53703(the) to 0.01(trella)
    # actual range is from 1000000 to 0

    # a fpmw of 1 means that word occurs 1 once on average for every million words
    # a fpmw of 1,000,000 would mean every word/token in the corpus was the same.

    # Advantages
    # - Its straight forward to calculated and understand.
    # - corpus size doesn't change the relative value.
    # - Its a old standard.

    # Disadvantages:
    # - the issue with fpmw is that rare words can have a fpmw of less than 1
    # - and its not easy for humans to compare.

    def to_freq fpmw
      fpmw / 1000000.0
    end
    def to_fpbw fpmw
      fpmw * 1000
    end
    def to_zipf fpmw
      Math.log10(fpmw * 1000)
    end
    def to_cb fpmw
      Math.log10(fpmw / 1000000) * 100.0
    end
  end

  module FPBW
    # frequency per billion words.
    # the same as fpmw but with a billion instead of million.

    # The advantages over fpbw is that values are far less likely to dip below 1

    def to_freq fpbw
      fpbw / 1000000000.0
    end
    def to_fpmw fpbw
      fpbw / 1000
    end
    def to_zipf fpbw
      Math.log10(fpbw)
    end
    def to_cb fpbw
      Math.log10(fpbw / 1000000000) * 100.0
    end
  end

  module CB
    # Its a word frequency from of logarithmic centibel scale.

    # practical range -127(the) to -799
    # actuall range is 0 to -900(or less)

    # cb is the word frequency unit used the dataset from the python wordfreq program.
    # https://github.com/rspeer/wordfreq

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

    # In the wordfreq program they 'bin' the data to reduce the file size further.
    # array[ bin[ "words", ...], ... ]
    # The index of the bin represents the positive frequency value.
    # you end up with a lot of leading empty bins, but after that it gets really effecient.

    def to_freq cb    
      raise ArgumentError, "cb freq cannot be positive number" if cb > 0
      10.00 ** (cb / 100.00)
    end
    def to_fpmw cb
      raise ArgumentError, "cb freq cannot be positive number" if cb > 0
      (10.00 ** (-(cb.abs) / 100.00)) * 1000000
    end
    def to_fpbw cb
      raise ArgumentError, "cb freq cannot be positive number" if cb > 0
      (10.00 ** (-(cb.abs) / 100.00)) * 1000000000
    end
    def to_zipf cb
      raise ArgumentError, "cb freq cannot be positive number" if cb > 0
      (cb + 900.00) / 100.00
    end
  end

  module ZipF
    # Its log10 of frequency per billion words
    # Named after the American linguist George Kingsley Zipf

    # Practical Range 1-7ish 1.01(the) to 7.73(trella). *(wait i might have that backwards...)*
    # Actual Range is 9.0 to 0.0(or less technically)

    # Advantages
    # - Its human readable and its a known common standerd.

    # Disavantages
    # - It requires decimials for accuracy.
    # - Technically it can cross 0 with extremely rare items in large datasets.

    def to_freq zipf
      10.00**zipf / 1e9
    end
    def to_fpmw zipf
      10.00 ** zipf / 1000
    end
    def to_fpbw zipf
      10.00 ** zipf
    end
    def to_cb zipf
      (zipf * 100.0) - 900.00
    end
  end

end

