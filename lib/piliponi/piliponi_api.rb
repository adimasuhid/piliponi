module Piliponi
  class PiliponiApi
    def lookup(prefix)
      smart = %w{0813 0918 0947 0998 0999}
      globe = %w{0817 0905 0906 0915 0916 0917 0925 0926 0927 0935 0936 0937 0945 0994 0995 0996 0997}
      sun = %w{0922 0923 0932 0933 0934 0942 0943}
      talk_and_text_addict_or_red = %w{0907 0908 0909 0910 0912 0919 0920 0921 0928 0929 0930 0938 0939 0946 0948 0949 0989}


      if smart.include? prefix
        "smart"
      elsif globe.include? prefix
        "globe"
      elsif sun.include? prefix
        "sun"
      elsif talk_and_text_addict_or_red.include? prefix
        "talk and text/ addict or red"
      else
        "unknown"
      end
    end

  end
end
