require "piliponi/version"
require "piliponi/piliponi_api"

module Piliponi
  def self.plausible? number
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

  def self.formatted number=nil, type="local"
    if plausible? number
      clean_num = clean(number)

      if type == "local"
        if clean_num[0] == "9"
          "0#{clean_num[0..9]}"
        elsif clean_num[0..1] == "63"
          "0#{clean_num[2..11]}"
        elsif clean_num[0..1] == "09"
          clean_num[0..11]
        else
          nil
        end
      end

    else
      "not plausible"
    end
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
end
