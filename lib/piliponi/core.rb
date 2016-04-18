module Core
  class ::FormatNotRecognizedException < Exception; end;
  class ::InvalidPhoneNumberException < Exception; end;

  #checks the number's validity
  #return false if number is null
  def plausible? number
    return false if number.nil?

    clean_num = clean(number)
    size = clean_num.size

    ((clean_num[0] == "9" && size == 10) ||
    (clean_num[0..1] == "63" && size == 12) ||
    (clean_num[0..1] == "09" && size == 11)) &&
    telco?(clean_num) != "unknown"
  end

  #normalize number
  #three formats: pure, local and international
  def normalize(number, options={})
    formats = [:pure, :local, :international]
    format = options[:format].intern

    raise FormatNotRecognizedException unless formats.include?(format)

    return send "_nf_#{format}", clean(number) if plausible?(number)
    raise InvalidPhoneNumberException
  end

  #cleans the number
  def clean(number=nil)
    number.tr('^0-9','') if number
  end
  
  def telco? number=nil
    PiliponiApi.new.lookup prefix(clean number)
  end

  def prefix number=nil
    hash = { '0' => [0,3], '6' => [2,4], '9' => [0,2] }
    start, finish = hash[number[0]].first, hash[number[0]].last
    clean_prefix(number[start..finish])
  end

  def clean_prefix(number)
    number = "0#{number}" if number[0] != '0'; number
  end

  private

    def _nf_pure(number)
      number[-10..-1]
    end

    def _nf_local(number)
      '0' << _nf_pure(number)
    end

    def _nf_international(number)
      '+63' << _nf_pure(number)
    end

end
