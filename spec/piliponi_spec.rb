require 'spec_helper'

class Dummy
  include Piliponi
end

describe Piliponi do

  describe "as Instance Methods" do
    let!(:piliponi) { Dummy.new }

    context "#plausible?" do

      it "works" do
        lambda do
          piliponi.plausible?("whatevs")
        end.should_not raise_error
      end

      it "returns true given 9170000001" do
        piliponi.plausible?("9170000001").should eq(true)
      end

      it "returns true given 639170000001" do
        piliponi.plausible?("639170000001").should eq(true)
      end

      it "returns true given +639170000001" do
        piliponi.plausible?("+639170000001").should eq(true)
      end

      it "returns false given a non-numerical string" do
        piliponi.plausible?("wawa").should eq(false)
      end

    end

    context "#clean" do

      it "removes characters" do
        piliponi.clean("+639170000001").should eq("639170000001")
      end

      it "returns nil if no number is placed" do
        piliponi.clean.should be_nil
      end

    end

    context "#normalize" do
      let(:number) { '(0919) 363-2598' }

      it "formats to 09XXXXXXXX" do
        piliponi.normalize(number, {format: 'local'}).should eq('09193632598')
      end

      it "formats to +639XXXXXXX" do
        piliponi.normalize(number, {format: 'international'}).should eq('+639193632598')
      end

      it "formats to 9XXXXXXX" do
        piliponi.normalize(number, {format: 'pure'}).should eq('9193632598')
      end

      context "when the format passed is not recognized" do

        it "raises FormatNotRecognizedException" do
          expect{
            piliponi.normalize(number, format: :foo)
          }.to raise_error(FormatNotRecognizedException)

          expect{
            piliponi.normalize(number, format: :foo)
          }.to raise_error(FormatNotRecognizedException)
        end

      end

      context "when the number is not valid" do

        it "raises InvalidPhoneNumberException" do
          expect{
            piliponi.normalize("notanumber", format: :local)
          }.to raise_error(InvalidPhoneNumberException)
        end

      end
    end

    context "#telco?" do

      it "returns smart for 09XX" do
        piliponi.telco?('09181234567').should eq('smart')
      end

      it "returns globe for 09XX" do
        piliponi.telco?("09170000000").should eq("globe")
      end

      it "returns sun for 09XX" do
        piliponi.telco?("09220000000").should eq("sun")
      end

      it "returns talk and text/ addict or red" do
        piliponi.telco?("09070000000").should eq("smart_others")
      end

    end

    context '#prefix' do
      describe '09171231234' do

        it 'returns 0917' do
          expect(piliponi.prefix('09171231234')).to eq '0917'
          expect(piliponi.prefix('639171231234')).to eq '0917'
          expect(piliponi.prefix('9171231234')).to eq '0917'
        end

      end
    end

    context '#clean_prefix' do
      describe '0917' do

        it 'retunrs 0917' do
          expect(piliponi.prefix('0917')).to eq '0917'
          expect(piliponi.prefix('63917')).to eq '0917'
          expect(piliponi.prefix('917')).to eq '0917'
        end

      end
    end
  end

  describe "as Singleton Methods" do

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

      it "formats to 09XXXXXXXX" do
        Piliponi.normalize(number, {format: 'local'}).should eq('09193632598')
      end

      it "formats to +639XXXXXXX" do
        Piliponi.normalize(number, {format: 'international'}).should eq('+639193632598')
      end

      it "formats to 9XXXXXXX" do
        Piliponi.normalize(number, {format: 'pure'}).should eq('9193632598')
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

    context "#telco?" do

      it "returns smart for 09XX" do
        Piliponi.telco?('09181234567').should eq('smart')
      end

      it "returns globe for 09XX" do
        Piliponi.telco?("09170000000").should eq("globe")
      end

      it "returns sun for 09XX" do
        Piliponi.telco?("09220000000").should eq("sun")
      end

      it "returns talk and text/ addict or red" do
        Piliponi.telco?("09070000000").should eq("smart_others")
      end

    end

    context '#prefix' do
      describe '09171231234' do

        it 'returns 0917' do
          expect(Piliponi.prefix('09171231234')).to eq '0917'
          expect(Piliponi.prefix('639171231234')).to eq '0917'
          expect(Piliponi.prefix('9171231234')).to eq '0917'
        end

      end
    end

    context '#clean_prefix' do
      describe '0917' do

        it 'retunrs 0917' do
          expect(Piliponi.prefix('0917')).to eq '0917'
          expect(Piliponi.prefix('63917')).to eq '0917'
          expect(Piliponi.prefix('917')).to eq '0917'
        end

      end
    end
  end
end
