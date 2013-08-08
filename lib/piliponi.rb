require "piliponi/version"
require "piliponi/piliponi_api"

module Piliponi
  class ::FormatNotRecognizedException < Exception; end;
  class ::InvalidPhoneNumberException < Exception; end;

  def plausible? number
    clean_num = clean(number)
    size = clean_num.size

    if clean_num[0] == "9" && size == 10
      true
    elsif clean_num[0..1] == "63" && size == 12
      true
    elsif clean_num[0..1] == "09" && size == 11
      true
    else
      false
    end
  end

  def normalize(number, options={})
    formats = [:pure, :local, :international]
    format = options[:format].intern

    raise FormatNotRecognizedException unless formats.include?(format)

    return send "_nf_#{format}", clean(number) if plausible?(number)
    raise InvalidPhoneNumberException
  end

  def self.clean(number=nil)
    number.gsub(/\D/,'') if number
  end

  def self.telco? number=nil
    PiliponiApi.new.lookup prefix(number)
  end

  def self.prefix number=nil
    clean_num = clean(number)

    if clean_num[0] == "9"
      "0#{clean_num[0..2]}"
    elsif clean_num[0..1] == "63"
      "0#{clean_num[2..4]}"
    elsif clean_num[0..1] == "09"
      clean_num[0..3]
    else
      nil
    end
  end

  private

    def self._nf_pure(number)
      number[-10..-1]
    end

    def self._nf_local(number)
      '0' << _nf_pure(number)
    end

    def self._nf_international(number)
      '+63' << _nf_pure(number)
    end
end
