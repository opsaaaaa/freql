module Freql
  module FPBW
    # fpbw frequency per billion words.
    # the same as fpmw but with a billion instead of million.

    # The advantages over fpbw is that values are far less likely to dip below 1

    class << self
      def fpbw_to_fq fpbw
        fpbw / 1000000000.0
      end
      def fpbw_to_fpmw fpbw
        fpbw / 1000
      end
      def fpbw_to_zipf fpbw
        Math.log10(fpbw)
      end
      def fpbw_to_cb fpbw
        Math.log10(fpbw / 1000000000.0) * 100.0
      end

      def calc_fpbw occurances, total
        (occurances / total.to_f) * 1000000000
      end
    end
  end
end

