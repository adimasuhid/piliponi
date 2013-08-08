require 'spec_helper'

describe Piliponi do
  context "#plausible?" do
    it "works" do
      lambda do
        Piliponi.plausible?("whatevs")
      end.should_not raise_error
    end

    it "returns true given 9170000001" do
      Piliponi.plausible?("9170000001").should eq(true)
    end

    it "returns true given 639170000001" do
      Piliponi.plausible?("639170000001").should eq(true)
    end

    it "returns true given +639170000001" do
      Piliponi.plausible?("+639170000001").should eq(true)
    end

    it "returns false given a non-numerical string" do
      Piliponi.plausible?("wawa").should eq(false)
    end

  end

  context "#clean" do
    it "removes characters" do
      Piliponi.clean("+639170000001").should eq("639170000001")
    end

    it "returns nil if no number is placed" do
      Piliponi.clean.should be_nil
    end
  end

  context "#normalize" do
    let(:number) { '(0919) 363-2598' }

    before{ include Piliponi }

    it "formats to 09XXXXXXXX" do
      normalize(number, format: :local).should eq('09193632598')
    end

    it "formats to +639XXXXXXX" do
      normalize(number, format: :international).should eq('+639193632598')
    end

    it "formats to 9XXXXXXX" do
      normalize(number, format: :pure).should eq('9193632598')
    end

    context "when the format passed is not recognized" do
      it "raises FormatNotRecognizedException" do
        normalize(number, format: :foo).
          should raise FormatNotRecognizedException
      end
    end

    context "when the number is not valid" do
      it "raises InvalidPhoneNumberException" do
        normalize("notanumber", format: :local).
          should raise InvalidPhoneNumberException
      end
    end
  end

  context "#telco?" do
    it "returns smart for 09XX"
    it "returns globe for 09XX" do
      Piliponi.telco?("09170000000").should eq("globe")
    end
  end

  context "#prefix" do
    it "returns XXXX"
  end

end
