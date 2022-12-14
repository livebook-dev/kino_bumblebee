defmodule Kino.Bumblebee.HighlightedText do
  @moduledoc """
  A kino for displaying a text with highlights and labels.

  This kino is primarily used to present the result of token classification.

  ## Examples

      text = "Rachel Green works at Ralph Lauren in New York City in the sitcom Friends."

      highlights = [
        %{label: "PER", phrase: "Rachel Green", start: 0, end: 12},
        %{label: "ORG", phrase: "Ralph Lauren", start: 22, end: 34},
        %{label: "LOC", phrase: "New York City", start: 38, end: 51},
        %{label: "MISC", phrase: "Friends", start: 66, end: 73}
      ]

      Kino.Bumblebee.HighlightedText.new(text, highlights)

  """

  use Kino.JS

  @type t :: Kino.JS.t()

  @doc """
  Creates a new kino displaying the given list of items.

  Expects a list of maps, each element representing a highlight with
  the some label.

  Note that the `:start` and `:end` offsets are interpreted as the
  number of UTF-8 bytes.
  """
  @spec new(
          String.t(),
          list(%{label: String.t(), start: non_neg_integer(), end: non_neg_integer()})
        ) :: t()
  def new(text, highlights) when is_binary(text) and is_list(highlights) do
    chunks = chunks(text, highlights, 0)

    labels =
      for(highlight <- highlights, highlight.label, uniq: true, do: highlight.label)
      |> Enum.sort()

    Kino.JS.new(__MODULE__, %{chunks: chunks, labels: labels})
  end

  defp chunks(text, [%{start: offset} = entity | entities], offset) do
    length = entity.end - entity.start
    chunk = binary_slice(text, offset, length)
    [%{text: chunk, label: entity.label} | chunks(text, entities, offset + length)]
  end

  defp chunks(text, [entity | entities], offset) do
    length = entity.start - offset
    chunk = binary_slice(text, offset, length)
    [%{text: chunk, label: nil} | chunks(text, [entity | entities], offset + length)]
  end

  defp chunks(text, [], offset) do
    case binary_slice(text, offset..-1//1) do
      "" -> []
      chunk -> [%{text: chunk, label: nil}]
    end
  end

  asset "main.js" do
    """
    export function init(ctx, { chunks, labels }) {
      ctx.importCSS("main.css");
      ctx.importCSS("https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap");

      ctx.root.innerHTML = `
        <div class="app">
          <div class="text">
            ${chunks.map((chunk) =>
              chunk.label ? `
                <span class="highlight" style="${styleFor(chunk.label)}">${chunk.text}<span class="label">${chunk.label}</span></span>
              ` : chunk.text
              ).join("")}
          </div>
        </div>
      `;

      function styleFor(label) {
        const idx = labels.indexOf(label) % 8;

        return `
          --highlight-bg: var(--${idx}-bg);
          --highlight-label-bg: var(--${idx}-label-bg);
          --highlight-text: var(--${idx}-text);
        `;
      }
    }
    """
  end

  asset "main.css" do
    """
    .app {
      font-family: "Inter";

      --gray-700: #304254;

      /* blue 100, 500, 800 */
      --0-bg: #dbeafe;
      --0-label-bg: #3b82f6;
      --0-text: #1e40af;

      /* teal 100, 500, 800 */
      --1-bg: #ccfbf1;
      --1-label-bg: #14b8a6;
      --1-text: #115e59;

      /* violet 100, 500, 800 */
      --2-bg: #ede9fe;
      --2-label-bg: #8b5cf6;
      --2-text: #5b21b6;

      /* pink 100, 500, 800 */
      --3-bg: #fce7f3;
      --3-label-bg: #ec4899;
      --3-text: #9d174d;

      /* indigo 100, 500, 800 */
      --4-bg: #e0e7ff;
      --4-label-bg: #6366f1;
      --4-text: #3730a3;

      /* emerald 100, 500, 800 */
      --5-bg: #d1fae5;
      --5-label-bg: #10b981;
      --5-text: #065f46;

      /* purple 100, 500, 800 */
      --6-bg: #f3e8ff;
      --6-label-bg: #d946ef;
      --6-text: #86198f;

      /* rose 100, 500, 800 */
      --7-bg: #ffe4e6;
      --7-label-bg: #f43f5e;
      --7-text: #9f1239;
    }

    .text {
      line-height: 2rem;
      color: var(--gray-700);
    }

    .highlight {
      padding: 2px 4px;
      border-radius: 4px;
      background-color: var(--highlight-bg);
      color: var(--highlight-text);
    }

    .label {
      margin-left: 4px;
      padding: 0 2px;
      border-radius: 4px;
      background-color: var(--highlight-label-bg);
      color: var(--highlight-bg);
      font-size: 0.75rem;
      font-weight: 600;
      user-select: none;
    }
    """
  end
end
