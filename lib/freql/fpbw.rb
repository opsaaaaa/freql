module Freql
  module FPBW
    # frequency per billion words.
    # the same as fpmw but with a billion instead of million.

    # The advantages over fpbw is that values are far less likely to dip below 1

    class << self
      def to_fq fpbw
        fpbw / 1000000000.0
      end
      def to_fpmw fpbw
        fpbw / 1000
      end
      def to_zipf fpbw
        Math.log10(fpbw)
      end
      def to_cb fpbw
        Math.log10(fpbw / 1000000000.0) * 100.0
      end

      def calc occurances, total
        (occurances / total.to_f) * 1000000000
      end
    end
  end
end

