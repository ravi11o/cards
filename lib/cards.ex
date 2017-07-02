defmodule Cards do

  @moduledoc """
    Provides method for creating and handling a deck of cards
  """
  @doc """
    Creates a list of cards with suits and values
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Diamonds", "Clubs", "Hearts"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(card) do
    Enum.shuffle(card)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

    iex> card = Cards.create_deck
    iex> Cards.contains?(card, "Five of Diamonds")
    true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(card, hand_size) do
    {cards, _remaining} = Enum.split(card, hand_size)
    cards
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> 
        :erlang.binary_to_term(binary)
      {:error, _reason} -> 
        "file does not exist"
    end
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle
    |> deal(hand_size)
  end

end
