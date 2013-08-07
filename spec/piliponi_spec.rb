require 'spec_helper'

describe Piliponi do
  it "should rock" do
    lambda do
      Piliponi.rock()
    end.should_not raise_error
  end

end
