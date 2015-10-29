require "rails_helper"

describe SuperMemo do
  context "correct answer" do
    it "first iteration" do
      supermemo = SuperMemo.new(1, 1, 2.5).call

      expect(supermemo[:e_factor]).to eq 2.6
      expect(supermemo[:interval]).to eq 1
      expect(supermemo[:iteration]).to eq 2
    end

    it "second iteration" do
      supermemo = SuperMemo.new(1, 2, 2.6).call

      expect(supermemo[:e_factor]).to eq 2.7
      expect(supermemo[:interval]).to eq 6
      expect(supermemo[:iteration]).to eq 3
    end

    it "third iteration with long time" do
      supermemo = SuperMemo.new(19, 3, 2.7).call

      expect(supermemo[:e_factor]).to eq 2.4
      expect(supermemo[:interval]).to eq 4.8
      expect(supermemo[:iteration]).to eq 1
    end
  end

  context "incorrect answer" do
    it "first iteration" do
      supermemo = SuperMemo.new(-1, 1, 2.5).call

      expect(supermemo[:e_factor]).to eq 1.7
      expect(supermemo[:interval]).to eq 1
      expect(supermemo[:iteration]).to eq 1
    end

    it "fifth iteration" do
      supermemo = SuperMemo.new(-1, 5, 1.3).call

      expect(supermemo[:e_factor]).to eq 1.3
      expect(supermemo[:interval]).to eq 5.2
      expect(supermemo[:iteration]).to eq 1
    end
  end
end
