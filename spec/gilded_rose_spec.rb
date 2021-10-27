require 'gilded_rose'
require 'item'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo" 
    end

    it "reduces quality by 1 each day" do
      items = [Item.new("foo", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end

    it "reduces quality by 2 each day when sell by date has passed" do
      items = [Item.new("foo", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "the quality of an item is never negative" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to eq -1
    end

    it "reduces sellin date by 1 each day" do
      items = [Item.new("foo", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 1
    end

    it "Sulfuras never decreases in quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it "Aged Brie increases in quality as the sellin date decreases" do
      items = [Item.new("Aged Brie", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "The quality of an item can never be more than 50" do
      items = [Item.new("Aged Brie", -50, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    context "Backstage passes" do
      it "an item increases in quality by 2 when the sellin date is between 10 and 6 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 9)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 11
      end

      it "an item increases in quality by 3 when the sellin date is between 5 and 0 days" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 9)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 12
      end

      it "an item's quality drops to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 9)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

  end


end
