require 'spec_helper'

class Dummy
  include Piliponi
end

describe Piliponi do
  let!(:dummy) { Dummy.new }

  context "#plausible?" do
    it "works" do
      lambda do
        dummy.plausible?("whatevs")
      end.should_not raise_error
    end

    it "returns true given 9170000001" do
      dummy.plausible?("9170000001").should eq(true)
    end

    it "returns true given 639170000001" do
      dummy.plausible?("639170000001").should eq(true)
    end

    it "returns true given +639170000001" do
      dummy.plausible?("+639170000001").should eq(true)
    end

    it "returns false given a non-numerical string" do
      dummy.plausible?("wawa").should eq(false)
    end

  end

  context "#clean" do
    it "removes characters" do
      dummy.clean("+639170000001").should eq("639170000001")
    end

    it "returns nil if no number is placed" do
      dummy.clean.should be_nil
    end
  end

  context "#normalize" do
    let(:number) { '(0919) 363-2598' }

    it "formats to 09XXXXXXXX" do
      dummy.normalize(number, {format: 'local'}).should eq('09193632598')
    end

    it "formats to +639XXXXXXX" do
      dummy.normalize(number, {format: 'international'}).should eq('+639193632598')
    end

    it "formats to 9XXXXXXX" do
      dummy.normalize(number, {format: 'pure'}).should eq('9193632598')
    end

    context "when the format passed is not recognized" do
      it "raises FormatNotRecognizedException" do
        expect{
          dummy.normalize(number, format: :foo)
        }.to raise_error(FormatNotRecognizedException)
      end
    end

    context "when the number is not valid" do
      it "raises InvalidPhoneNumberException" do
        expect{
          dummy.normalize("notanumber", format: :local)
        }.to raise_error(InvalidPhoneNumberException)
      end
    end
  end

  context "#telco?" do
    it "returns smart for 09XX" do
      dummy.telco?('09181234567').should eq('smart')
    end

    it "returns globe for 09XX" do
      dummy.telco?("09170000000").should eq("globe")
    end

    it "returns sun for 09XX" do
      dummy.telco?("09220000000").should eq("sun")
    end

    it "returns talk and text/ addict or red" do
      dummy.telco?("09070000000").should eq("talk and text/ addict or red")
    end
  end

  context '#prefix' do
    describe '09171231234' do
      it 'returns 0917' do
        expect(dummy.prefix('09171231234')).to eq '0917'
        expect(dummy.prefix('639171231234')).to eq '0917'
        expect(dummy.prefix('9171231234')).to eq '0917'
      end
    end
  end

  context '#clean_prefix' do
    describe '0917' do
      it 'retunrs 0917' do
        expect(dummy.prefix('0917')).to eq '0917'
        expect(dummy.prefix('63917')).to eq '0917'
        expect(dummy.prefix('917')).to eq '0917'
      end
    end
  end

end
