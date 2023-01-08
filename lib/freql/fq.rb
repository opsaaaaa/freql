module Freql
  module FQ
    # frequency represented as a proportion between 0 and 1
    # occurances in corpus divided by total words in corpus

    # practicle range 0.053(the) 0.00000001(trella)
    # actual range 0 to 1
    class << self
      def to_fpmw fq
        fq * 1000000
      end
      def to_fpbw fq
        fq * 1000000000
      end
      def to_zipf fq
        Math.log10(fq)+9
      end
      def to_cb fq
        Math.log10(fq) * 100.0
      end
    end
  end
end

