defmodule Kino.Bumblebee.ScoredList do
  @moduledoc """
  A kino for displaying a list of labels with scores.

  This kino is primarily used to present top classification predictions.

  ## Examples

      predictions = [
        {"france", 0.9279842972755432},
        {"brittany", 0.008412551134824753},
        {"algeria", 0.007433671969920397},
        {"department", 0.004957548808306456},
        {"reunion", 0.004369721747934818}
      ]

      KinoBumblebee.ScoredList.new(predictions)

  """

  use Kino.JS

  @type t :: Kino.JS.t()

  @doc """
  Creates a new kino displaying the given list of items.

  Expects a list of tuples, each element being the label and its score.
  """
  @spec new(list({String.t(), number()})) :: t()
  def new(items) when is_list(items) do
    items =
      for {label, score} <- items do
        %{label: label, score: score}
      end

    Kino.JS.new(__MODULE__, items)
  end

  asset "main.js" do
    """
    export function init(ctx, items) {
      ctx.importCSS("main.css");
      ctx.importCSS(
        "https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600&display=swap"
      );

      ctx.root.innerHTML = `
        <div class="app">
          <ul class="list">
            ${items.map((item) => (`
              <li class="item">
                <div class="label">
                  <div class="score-bar" style="width: ${Math.ceil(item.score * 100)}%;"></div>
                  <div>${item.label}</div>
                </div>
                <div class="score">
                  ${item.score.toFixed(3)}
                </div>
              </li>
            `)).join("")}
          </ul>
        </div>
      `;
    }
    """
  end

  asset "main.css" do
    """
    .app {
      font-family: "JetBrains Mono", monospace;
      font-size: 14px;

      --blue-400: #8BA2FF;
    }

    .list {
      padding: 0;
      margin: 0;
      list-style: none;
    }

    .item {
      display: flex;
      justify-content: space-between;
    }

    .item:not(:first-child) {
      margin-top: 16px;
    }

    .label {
      flex-grow: 1;
      margin-right: 8px;
    }

    .score-bar {
      height: 4px;
      border-radius: 4px;
      margin-bottom: 4px;
      background-color: var(--blue-400);
    }

    .score {
      line-height: 1;
    }
    """
  end
end
