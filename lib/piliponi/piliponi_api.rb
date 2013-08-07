module Piliponi
  class PiliponiApi
    def lookup(prefix)
      smart = %w{0813 0918 0947 0998 0999 0907 0908 0909 0910 0912 0919 0921
      0928 0929 0949 0989 0920 0930 0938 0939 0946}
      globe = %w{0817 0917 0994 0905 0915 0916 0926 0927 0935 0936 0937 0996 0997}
      sun = %w{0922 0923 0925 0932 0933 0934 0942 0943}

      if smart.include? prefix
        "smart"
      elsif globe.include? prefix
        "globe"
      elsif sun.include? prefix
        "sun"
      else
        "unknown"
      end
    end

  end
end
