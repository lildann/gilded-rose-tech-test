require 'item'

describe Item do
  it "#to_s returns the data of an item" do
    item = Item.new("foo", 1, 0)
    expect(item.to_s).to eq "foo, 1, 0"
  end
end
