module Freql
  module FPMW
    # fpmw frequency per million words.
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

    class << self
      def fpmw_to_fq fpmw
        fpmw / 1000000.0
      end
      def fpmw_to_fpbw fpmw
        fpmw * 1000
      end
      def fpmw_to_zipf fpmw
        Math.log10(fpmw * 1000)
      end
      def fpmw_to_cb fpmw
        Math.log10(fpmw / 1000000.0) * 100.0
      end

      def calc_fpmw occurances, total
        (occurances / total.to_f) * 1000000
      end
    end
  end

end

