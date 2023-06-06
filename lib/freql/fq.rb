module Freql
  module FQ
    # fq frequency represented as a proportion between 0 and 1
    # occurances in corpus divided by total words in corpus

    # practicle range 0.053(the) 0.00000001(trella)
    # actual range 0 to 1

    class << self
      def fq_to_fpmw fq
        fq * 1000000
      end
      def fq_to_fpbw fq
        fq * 1000000000
      end
      def fq_to_zipf fq
        Math.log10(fq)+9
      end
      def fq_to_cb fq
        Math.log10(fq) * 100.0
      end

      def calc_fq occurances, total
        occurances / total.to_f
      end
    end

  end
end

