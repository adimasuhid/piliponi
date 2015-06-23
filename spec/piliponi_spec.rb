require 'spec_helper'

describe Piliponi do

  describe ".plausible?" do

    it "returns true given 9170000001" do
      expect(Piliponi.plausible? "9170000001").to eq(true)
    end

    it "returns true given 639170000001" do
      expect(Piliponi.plausible? "639170000001").to eq(true)
    end

    it "returns true given +639170000001" do
      expect(Piliponi.plausible? "+639170000001").to eq(true)
    end

    it "returns false given a non-numerical string" do
      expect(Piliponi.plausible? "wawa").to eq(false)
    end

  end

  describe ".clean" do

    it "removes characters" do
      expect(Piliponi.clean "+639170000001").to eq("639170000001")
    end

    it "returns nil if no number is placed" do
      expect(Piliponi.clean).to be_nil
    end

  end

  describe ".normalize" do
    let(:number) { '(0919) 363-2598' }

    it "formats to 09XXXXXXXX" do
      expect(Piliponi.normalize number, {format: 'local'}).to eq('09193632598')
    end

    it "formats to +639XXXXXXX" do
      expect(Piliponi.normalize number, {format: 'international'}).to eq('+639193632598')
    end

    it "formats to 9XXXXXXX" do
      expect(Piliponi.normalize number, {format: 'pure'}).to eq('9193632598')
    end

    context "when the format passed is not recognized" do

      it "raises FormatNotRecognizedException" do
        expect{
          Piliponi.normalize(number, format: :foo)
        }.to raise_error(FormatNotRecognizedException)

        expect{
          Piliponi.normalize(number, format: :foo)
        }.to raise_error(FormatNotRecognizedException)
      end

    end

    context "when the number is not valid" do

      it "raises InvalidPhoneNumberException" do
        expect{
          Piliponi.normalize("notanumber", format: :local)
        }.to raise_error(InvalidPhoneNumberException)
      end

    end
  end

  describe ".telco?" do

    it "returns smart for 09XX" do
      expect(Piliponi.telco? '09181234567').to eq('smart')
    end

    it "returns globe for 09XX" do
      expect(Piliponi.telco? "09170000000").to eq("globe")
    end

    it "returns sun for 09XX" do
      expect(Piliponi.telco? "09220000000").to eq("sun")
    end

    it "returns talk and text/ addict or red" do
      expect(Piliponi.telco? "09070000000").to eq("smart_others")
    end

  end

  describe '.prefix' do
    context '09171231234' do

      it 'returns 0917' do
        expect(Piliponi.prefix('09171231234')).to eq '0917'
        expect(Piliponi.prefix('639171231234')).to eq '0917'
        expect(Piliponi.prefix('9171231234')).to eq '0917'
      end

    end
  end

  describe '.clean_prefix' do
    context '0917' do

      it 'returns 0917' do
        expect(Piliponi.prefix('0917')).to eq '0917'
        expect(Piliponi.prefix('63917')).to eq '0917'
        expect(Piliponi.prefix('917')).to eq '0917'
      end

    end
  end
end
