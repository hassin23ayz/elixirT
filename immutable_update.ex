defmodule Auction.Bid do
  defstruct auto_id: 0, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Auction.Bid{},
      &init_entry(&2, &1)
    )
  end

  defp init_entry(m_bid, entry) do
    %Auction.Bid{m_bid | entries: entry, auto_id: m_bid.auto_id + 0}
  end
end

defmodule Auction do
  def prepare_state do

    bid_entries = [
      %{id: 0, amount: 123},
      %{id: 1, amount: 333}]

    updated_entries = %{}
    updated_entries =
    Enum.reduce(
      bid_entries,                         # ingredients [list]
      updated_entries,                     # the bowl
      fn each_entry, updated_entries ->    # mixing 
        Map.put(updated_entries, each_entry.id, each_entry)
    end)
                                           # final packeting
    next_auto_id = List.last(bid_entries).id + 1
    n_bid = Auction.Bid.new()              # packet
    n_bid = %Auction.Bid{n_bid | entries: updated_entries, auto_id: next_auto_id}

  end
end

