defmodule Kino.Bumblebee.HighlightedTextTest do
  use ExUnit.Case, async: true

  alias Kino.Bumblebee.HighlightedText

  test "splits text into highlighted chunks" do
    text = "Rachel Green works at Ralph Lauren in New York City in the sitcom Friends."

    highlights = [
      %{label: "PER", phrase: "Rachel Green", start: 0, end: 12},
      %{label: "ORG", phrase: "Ralph Lauren", start: 22, end: 34},
      %{label: "LOC", phrase: "New York City", start: 38, end: 51},
      %{label: "MISC", phrase: "Friends", start: 66, end: 73}
    ]

    kino = HighlightedText.new(text, highlights)

    assert data(kino) == %{
             chunks: [
               %{label: "PER", text: "Rachel Green"},
               %{label: nil, text: " works at "},
               %{label: "ORG", text: "Ralph Lauren"},
               %{label: nil, text: " in "},
               %{label: "LOC", text: "New York City"},
               %{label: nil, text: " in the sitcom "},
               %{label: "MISC", text: "Friends"},
               %{label: nil, text: "."}
             ],
             labels: ["LOC", "MISC", "ORG", "PER"]
           }
  end

  test "interprets offsets as number of utf-8 bytes" do
    text = "Jane é John"

    highlights = [
      %{phrase: "Jane", start: 0, end: 4, label: "PER"},
      %{phrase: "John", start: 8, end: 12, label: "PER"}
    ]

    kino = HighlightedText.new(text, highlights)

    assert data(kino) ==
             %{
               chunks: [
                 %{label: "PER", text: "Jane"},
                 %{label: nil, text: " é "},
                 %{label: "PER", text: "John"}
               ],
               labels: ["PER"]
             }
  end

  defp data(%Kino.JS{ref: ref}) do
    send(Kino.JS.DataStore, {:connect, self(), %{origin: "client:#{inspect(self())}", ref: ref}})
    assert_receive {:connect_reply, data, %{ref: ^ref}}
    data
  end
end
