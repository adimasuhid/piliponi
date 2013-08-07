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

  context "#format" do
    it "formats to 09XXXXXXXX"
    it "formats to +639XXXXXXX"
    it "formats to 9XXXXXXX"
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
