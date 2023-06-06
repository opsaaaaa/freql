module Freql
  module ZipF
    # ZipF is log10 of frequency per billion words
    # Named after the American linguist George Kingsley Zipf

    # Practical Range 1-7ish 1.01(the) to 7.73(trella). *(wait i might have that backwards...)*
    # Actual Range is 9.0 to 0.0(or less technically)

    # Advantages
    # - Its human readable and its a known common standerd.

    # Disavantages
    # - It requires decimials for accuracy.
    # - Technically it can cross 0 with extremely rare items in large datasets.

    class << self
      def zipf_to_fq zipf
        10.00**zipf / 1e9
      end
      def zipf_to_fpmw zipf
        10.00 ** zipf / 1000
      end
      def zipf_to_fpbw zipf
        10.00 ** zipf
      end
      def zipf_to_cb zipf
        (zipf * 100.0) - 900.00
      end

      def calc_zipf occurances, total
        Math.log10(occurances / total.to_f)+9
      end
    end
  end
end

