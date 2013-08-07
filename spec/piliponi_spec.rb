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
    ["0917-000-0000","+63917-000-0000","917-000-0000"].each do |number|
      context "Given #{number}" do
        it "formats to 09XXXXXXXX" do
          Piliponi.formatted("#{number}","local").should eq("09170000000")
        end
        it "formats to +639XXXXXXX"
        it "formats to 9XXXXXXX"
        it "returns not plausible"
      end
    end
  end

  context "#telco?" do
    it "returns smart for 09XX" do
      Piliponi.telco?("09210000000").should eq("smart")
    end
    it "returns globe for 09XX" do
      Piliponi.telco?("09170000000").should eq("globe")
    end
  end

  context "#prefix" do
    {
      "0917" => "09170000001",
      "0917" => "9170000001",
      "0917" => "+639170000001"
    }.each do |pre,number|
      it "returns #{pre} given #{number}" do
        Piliponi.prefix("#{number}").should eq("#{pre}")
      end
    end
  end

end
