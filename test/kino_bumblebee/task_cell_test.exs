defmodule KinoBumblebee.TaskCellTest do
  use ExUnit.Case, async: true

  import Kino.Test

  alias KinoBumblebee.TaskCell

  setup :configure_livebook_bridge

  describe "initialization" do
    test "with empty attributes" do
      {_kino, source} = start_smart_cell!(TaskCell, %{})

      assert source ==
               """
               {:ok, model_info} =
                 Bumblebee.load_model({:hf, "microsoft/resnet-50"}, log_params_diff: false)

               {:ok, featurizer} = Bumblebee.load_featurizer({:hf, "microsoft/resnet-50"})

               serving =
                 Bumblebee.Vision.image_classification(model_info, featurizer, compile: [batch_size: 1])

               image_input = Kino.Input.image("Image", size: {224, 224})
               form = Kino.Control.form([image: image_input], submit: "Run")
               frame = Kino.Frame.new()

               Kino.listen(form, fn %{data: %{image: image}} ->
                 if image do
                   Kino.Frame.render(frame, Kino.Text.new("Running..."))

                   image =
                     image.data |> Nx.from_binary(:u8) |> Nx.reshape({image.height, image.width, 3})

                   output = Nx.Serving.run(serving, image)

                   output.predictions
                   |> Enum.map(&{&1.label, &1.score})
                   |> Kino.Bumblebee.ScoredList.new()
                   |> then(&Kino.Frame.render(frame, &1))
                 end
               end)

               Kino.Layout.grid([form, frame], boxed: true, gap: 16)\
               """
    end

    test "restores source code from attrs" do
      attrs = %{
        "task_id" => "text_classification",
        "variant_id" => "bert_finbert_sentiment",
        "top_k" => 2,
        "sequence_length" => 50,
        "compiler" => "exla"
      }

      {_kino, source} = start_smart_cell!(TaskCell, attrs)

      assert source ==
               """
               {:ok, model_info} =
                 Bumblebee.load_model({:hf, "ProsusAI/finbert"}, log_params_diff: false)

               {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "bert-base-uncased"})

               serving =
                 Bumblebee.Text.text_classification(model_info, tokenizer,
                   top_k: 2,
                   compile: [batch_size: 1, sequence_length: 50],
                   defn_options: [compiler: EXLA]
                 )

               text_input =
                 Kino.Input.textarea("Text",
                   default:
                     "Our stock predictions indicate that we can expect a rapid growth over the next year."
                 )

               form = Kino.Control.form([text: text_input], submit: "Run")
               frame = Kino.Frame.new()

               Kino.listen(form, fn %{data: %{text: text}} ->
                 Kino.Frame.render(frame, Kino.Text.new("Running..."))
                 output = Nx.Serving.run(serving, text)

                 output.predictions
                 |> Enum.map(&{&1.label, &1.score})
                 |> Kino.Bumblebee.ScoredList.new()
                 |> then(&Kino.Frame.render(frame, &1))
               end)

               Kino.Layout.grid([form, frame], boxed: true, gap: 16)\
               """

      attrs = %{
        "task_id" => "token_classification",
        "variant_id" => "bert_base_cased_ner",
        "aggregation" => "same",
        "sequence_length" => 100,
        "compiler" => "exla"
      }

      {_kino, source} = start_smart_cell!(TaskCell, attrs)

      assert source =~ "aggregation: :same"
    end
  end

  test "keeps track of whether binary backend is used" do
    {kino, _source} = start_smart_cell!(TaskCell, %{})

    data = connect(kino)
    assert data.is_binary_backend

    spawn_link(fn ->
      Nx.default_backend(EXLA.Backend)
      TaskCell.scan_binding(kino.pid, [], Code.env_for_eval([]))
    end)

    assert_broadcast_event(kino, "default_backend_updated", %{
      "is_binary_backend" => false
    })
  end

  test "changing task sets the default variant and options" do
    {kino, _source} = start_smart_cell!(TaskCell, %{})

    push_event(kino, "update_field", %{"field" => "task_id", "value" => "text_classification"})

    assert_broadcast_event(kino, "update", %{
      "fields" => %{
        "task_id" => "text_classification",
        "variant_id" => "roberta_bertweet_emotion",
        "top_k" => nil,
        "sequence_length" => 100,
        "compiler" => nil
      }
    })
  end

  test "updates source on field update" do
    {kino, _source} = start_smart_cell!(TaskCell, %{})

    push_event(kino, "update_field", %{"field" => "top_k", "value" => "2"})

    assert_broadcast_event(kino, "update", %{"fields" => %{"top_k" => 2}})

    assert_smart_cell_update(kino, %{"top_k" => 2}, source)
    assert source =~ "top_k: 2"
  end
end
