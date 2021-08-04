defmodule Auction.Item do
  defstruct [:id, :title, :description, :ends_at] # structure of an Item
end

defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [             # @items is a module attribute acting as the Database
    %Item{id: 1, title: "Monopoly", description: "board game",         ends_at: ~N[2021-12-12 00:00:00]},
    %Item{id: 2, title: "PS2",      description: "play station 2",     ends_at: ~N[2021-12-13 00:00:00]},
    %Item{id: 3, title: "Gameboy",  description: "Nintendo hand held", ends_at: ~N[2021-12-14 00:00:00]}
  ]

  def all(Item), do: @items # returns the whole database

  def get!(Item, id) do
    Enum.find(@items, fn(item) -> item.id == id end)
  end

  def get_by(Item, attrs) do
    Enum.find(@items, fn(item) ->
      Enum.all?(Map.keys(attrs), fn(key) ->
        Map.get(item, key) === attrs[key]
      end)
    end)
  end

end

defmodule Auction do                # public interface to access database
  alias Auction.{Item, FakeRepo}    # multiple Alias in one line

  @repo FakeRepo                    # denoting FaekRepo as a Module Attribute

  def list_items do
    @repo.all(Item)                 # call FakeRepo Module Passing Item as first argument
                                    # It lets the database know which table(set of data) you are requesting
                                    # Item is here like telling more of a type
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end
end

# An in memory Database instead of a real one
