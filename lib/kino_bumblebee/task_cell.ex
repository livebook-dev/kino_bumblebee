defmodule KinoBumblebee.TaskCell do
  @moduledoc false

  use Kino.JS, assets_path: "lib/assets/task_cell"
  use Kino.JS.Live
  use Kino.SmartCell, name: "Neural Network task"

  @tasks [
    %{
      id: "image_classification",
      label: "Image classification",
      variants: [
        %{
          id: "resnet",
          label: "ResNet",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/microsoft/resnet-50",
          generation: %{
            model_repo_id: "microsoft/resnet-50",
            featurizer_repo_id: "microsoft/resnet-50"
          }
        },
        %{
          id: "convnext",
          label: "ConvNeXT",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/facebook/convnext-tiny-224",
          generation: %{
            model_repo_id: "facebook/convnext-tiny-224",
            featurizer_repo_id: "facebook/convnext-tiny-224"
          }
        },
        %{
          id: "vit",
          label: "ViT",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/google/vit-base-patch16-224",
          generation: %{
            model_repo_id: "google/vit-base-patch16-224",
            featurizer_repo_id: "google/vit-base-patch16-224"
          }
        },
        %{
          id: "deit",
          label: "DeiT",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/facebook/deit-base-distilled-patch16-224",
          generation: %{
            model_repo_id: "facebook/deit-base-distilled-patch16-224",
            featurizer_repo_id: "facebook/deit-base-distilled-patch16-224"
          }
        }
      ],
      params: [
        %{field: "top_k", label: "Top-k", type: :number, default: nil}
      ]
    },
    %{
      id: "text_classification",
      label: "Text classification",
      variants: [
        %{
          id: "roberta_bertweet_emotion",
          label: "RoBERTa (BERTweet) - emotion",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/finiteautomata/bertweet-base-emotion-analysis",
          generation: %{
            model_repo_id: "finiteautomata/bertweet-base-emotion-analysis",
            tokenizer_repo_id: "vinai/bertweet-base",
            default_text: "Oh wow, I didn't know that!"
          }
        },
        %{
          id: "roberta_bertweet_sentiment",
          label: "RoBERTa (BERTweet) - sentiment",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/finiteautomata/bertweet-base-sentiment-analysis",
          generation: %{
            model_repo_id: "finiteautomata/bertweet-base-sentiment-analysis",
            tokenizer_repo_id: "vinai/bertweet-base",
            default_text: "Cats are so cute"
          }
        },
        %{
          id: "roberta_tweets_topic_single",
          label: "RoBERTa (tweets) - topic",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/cardiffnlp/tweet-topic-latest-single",
          generation: %{
            model_repo_id: "cardiffnlp/tweet-topic-latest-single",
            tokenizer_repo_id: "cardiffnlp/tweet-topic-latest-single",
            default_text: "We've just started a company, it's happening!"
          }
        },
        %{
          id: "roberta_tweets_emoji",
          label: "RoBERTa (tweets) - emoji",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/cardiffnlp/twitter-roberta-base-emoji",
          generation: %{
            model_repo_id: "cardiffnlp/twitter-roberta-base-emoji",
            tokenizer_repo_id: "roberta-base",
            default_text: "Machine Learning is on fire this year"
          }
        },
        %{
          id: "roberta_tweets_offensive",
          label: "RoBERTa (tweets) - offensive",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/cardiffnlp/twitter-roberta-base-offensive",
          generation: %{
            model_repo_id: "cardiffnlp/twitter-roberta-base-offensive",
            tokenizer_repo_id: "roberta-base",
            default_text: "I'm not sure what to think about this."
          }
        },
        %{
          id: "distilroberta_emotion",
          label: "DistilRoBERTa - emotion",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/j-hartmann/emotion-english-distilroberta-base",
          generation: %{
            model_repo_id: "j-hartmann/emotion-english-distilroberta-base",
            tokenizer_repo_id: "j-hartmann/emotion-english-distilroberta-base",
            default_text: "Oh wow, I didn't know that!"
          }
        },
        %{
          id: "bert_finbert_sentiment",
          label: "BERT (FinBERT) - finance sentiment",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/ProsusAI/finbert",
          generation: %{
            model_repo_id: "ProsusAI/finbert",
            tokenizer_repo_id: "bert-base-uncased",
            default_text:
              "Our stock predictions indicate that we can expect a rapid growth over the next year."
          }
        }
      ],
      params: [
        %{field: "top_k", label: "Top-k", type: :number, default: nil},
        %{field: "sequence_length", label: "Max input tokens", type: :number, default: 100}
      ]
    },
    %{
      id: "text_generation",
      label: "Text generation",
      variants: [
        %{
          id: "gpt2",
          label: "GPT2 (base)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/gpt2",
          generation: %{
            model_repo_id: "gpt2",
            tokenizer_repo_id: "gpt2",
            default_text: "Yesterday, I was reading a book and"
          }
        },
        %{
          id: "gpt2_medium",
          label: "GPT2 (medium)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/gpt2-medium",
          generation: %{
            model_repo_id: "gpt2-medium",
            tokenizer_repo_id: "gpt2-medium",
            default_text: "Yesterday, I was reading a book and"
          }
        },
        %{
          id: "gpt2_large",
          label: "GPT2 (large)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/gpt2-large",
          generation: %{
            model_repo_id: "gpt2-large",
            tokenizer_repo_id: "gpt2-large",
            default_text: "Yesterday, I was reading a book and"
          }
        },
        %{
          id: "gpt2_xl",
          label: "GPT2 (xl)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/gpt2-xl",
          generation: %{
            model_repo_id: "gpt2-xl",
            tokenizer_repo_id: "gpt2-xl",
            default_text: "Yesterday, I was reading a book and"
          }
        },
        %{
          id: "distilgpt2",
          label: "DistilGPT2 (base)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/distilgpt2",
          generation: %{
            model_repo_id: "distilgpt2",
            tokenizer_repo_id: "distilgpt2",
            default_text: "Yesterday, I was reading a book and"
          }
        },
        %{
          id: "bart_xsum_summarization",
          label: "BART (XSum) - summarization",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/sshleifer/distilbart-xsum-12-3",
          generation: %{
            model_repo_id: "sshleifer/distilbart-xsum-12-3",
            tokenizer_repo_id: "facebook/bart-large-xsum",
            default_text:
              "The tower is 324 metres (1,063 ft) tall, about the same height as an 81-storey building, and the tallest structure in Paris. Its base is square, measuring 125 metres (410 ft) on each side. During its construction, the Eiffel Tower surpassed the Washington Monument to become the tallest man-made structure in the world, a title it held for 41 years until the Chrysler Building in New York City was finished in 1930. It was the first structure to reach a height of 300 metres. Due to the addition of a broadcasting aerial at the top of the tower in 1957, it is now taller than the Chrysler Building by 5.2 metres (17 ft). Excluding transmitters, the Eiffel Tower is the second tallest free-standing structure in France after the Millau Viaduct."
          }
        },
        %{
          id: "bart_cnn_summarization",
          label: "BART (CNN) - summarization",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/sshleifer/distilbart-cnn-12-6",
          generation: %{
            model_repo_id: "sshleifer/distilbart-cnn-12-6",
            tokenizer_repo_id: "facebook/bart-large-cnn",
            default_text:
              "The tower is 324 metres (1,063 ft) tall, about the same height as an 81-storey building, and the tallest structure in Paris. Its base is square, measuring 125 metres (410 ft) on each side. During its construction, the Eiffel Tower surpassed the Washington Monument to become the tallest man-made structure in the world, a title it held for 41 years until the Chrysler Building in New York City was finished in 1930. It was the first structure to reach a height of 300 metres. Due to the addition of a broadcasting aerial at the top of the tower in 1957, it is now taller than the Chrysler Building by 5.2 metres (17 ft). Excluding transmitters, the Eiffel Tower is the second tallest free-standing structure in France after the Millau Viaduct."
          }
        }
      ],
      params: [
        %{field: "sequence_length", label: "Max input tokens", type: :number, default: 100},
        %{field: "min_new_tokens", label: "Min new tokens", type: :number, default: nil},
        %{field: "max_new_tokens", label: "Max new tokens", type: :number, default: 10}
      ]
    },
    %{
      id: "text_to_image",
      label: "Text-to-image",
      variants: [
        %{
          id: "stable_diffusion_v1_4",
          label: "Stable Diffusion (v1.4)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/CompVis/stable-diffusion-v1-4",
          generation: %{
            repo_id: "CompVis/stable-diffusion-v1-4",
            default_text: "numbat, forest, high quality, detailed, digital art"
          }
        },
        %{
          id: "stable_diffusion_anime",
          label: "Stable Diffusion (anime)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/Linaqruf/anything-v3.0",
          generation: %{
            repo_id: "Linaqruf/anything-v3.0",
            default_text:
              "scenery, shibuya tokyo, post-apocalypse, ruins, rust, sky, skyscraper, abandoned, blue sky, broken window, building, cloud, crane machine, outdoors, overgrown, pillar, sunset"
          }
        },
        %{
          id: "stable_diffusion_ghibli",
          label: "Stable Diffusion (Ghibli style)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/nitrosocke/Ghibli-Diffusion",
          generation: %{
            repo_id: "nitrosocke/Ghibli-Diffusion",
            default_text: "ghibli style numbat in forest"
          }
        },
        %{
          id: "stable_diffusion_modern_disney",
          label: "Stable Diffusion (modern Disney style)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/nitrosocke/mo-di-diffusion",
          generation: %{
            repo_id: "nitrosocke/mo-di-diffusion",
            default_text: "modern disney style grumpy cat"
          }
        },
        %{
          id: "stable_diffusion_classic_disney",
          label: "Stable Diffusion (classic Disney style)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/nitrosocke/classic-anim-diffusion",
          generation: %{
            repo_id: "nitrosocke/classic-anim-diffusion",
            default_text: "classic disney style albert einstein"
          }
        },
        %{
          id: "stable_diffusion_classic_redshift",
          label: "Stable Diffusion (redshift style)",
          docs_logo: "huggingface_logo.svg",
          docs_url: "https://huggingface.co/nitrosocke/redshift-diffusion",
          generation: %{
            repo_id: "nitrosocke/redshift-diffusion",
            default_text: "redshift style batman"
          }
        }
      ],
      params: [
        %{field: "sequence_length", label: "Max input tokens", type: :number, default: 50},
        %{field: "num_steps", label: "Number of steps", type: :number, default: 20},
        %{field: "num_images_per_prompt", label: "Number of images", type: :number, default: 2},
        %{field: "seed", label: "Seed", type: :number, default: nil}
      ],
      note:
        "this is a very involved task, the generation can take a long time if you run it on a CPU. To achieve a better quality increase the number of steps, 40 is usually a better default."
    }
  ]

  @default_task_id get_in(@tasks, [Access.at!(0), :id])
  @default_variant_id get_in(@tasks, [Access.at!(0), :variants, Access.at!(0), :id])

  @impl true
  def init(attrs, ctx) do
    task_id = attrs["task_id"] || @default_task_id

    {default_backend, default_compiler} = default_backend_and_compiler()

    fields = %{
      "task_id" => task_id,
      "variant_id" => attrs["variant_id"] || @default_variant_id,
      "compiler" =>
        Map.get(attrs, "compiler", default_compiler_field(default_backend, default_compiler))
    }

    fields =
      for {field, default} <- field_defaults_for(task_id),
          into: fields,
          do: {field, attrs[field] || default}

    {:ok,
     assign(ctx,
       fields: fields,
       missing_dep: missing_dep(fields),
       default_backend: default_backend,
       default_compiler: default_compiler
     )}
  end

  defp field_defaults_for(task_id) do
    task = task_by_id(task_id)

    for param <- task.params, into: %{} do
      {param.field, param.default}
    end
  end

  defp default_backend_and_compiler() do
    {backend, _opts} = Nx.default_backend()
    compiler = Nx.Defn.default_options()[:compiler]
    {backend, compiler}
  end

  defp default_compiler_field(EXLA.Backend, nil), do: "exla"
  defp default_compiler_field(_default_backend, _default_compiler), do: nil

  @impl true
  def handle_connect(ctx) do
    {:ok,
     %{
       fields: ctx.assigns.fields,
       tasks: tasks(),
       missing_dep: ctx.assigns.missing_dep,
       is_binary_backend: ctx.assigns.default_backend == Nx.BinaryBackend
     }, ctx}
  end

  @impl true
  def handle_event("update_field", %{"field" => "task_id", "value" => task_id}, ctx) do
    task = task_by_id(task_id)
    variant_id = hd(task.variants).id
    param_fields = field_defaults_for(task_id)

    fields =
      Map.merge(
        %{
          "task_id" => task_id,
          "variant_id" => variant_id,
          "compiler" =>
            default_compiler_field(ctx.assigns.default_backend, ctx.assigns.default_compiler)
        },
        param_fields
      )

    ctx = assign(ctx, fields: fields)

    broadcast_event(ctx, "update", %{"fields" => fields})

    {:noreply, ctx}
  end

  def handle_event("update_field", %{"field" => field, "value" => value}, ctx) do
    current_task_id = ctx.assigns.fields["task_id"]

    type =
      Enum.find_value(tasks(), fn task ->
        task.id == current_task_id &&
          Enum.find_value(task.params, fn param ->
            param.field == field && param.type
          end)
      end)

    updated_fields = to_updates(field, value, type)
    ctx = update(ctx, :fields, &Map.merge(&1, updated_fields))

    broadcast_event(ctx, "update", %{"fields" => updated_fields})

    missing_dep = missing_dep(ctx.assigns.fields)

    ctx =
      if missing_dep == ctx.assigns.missing_dep do
        ctx
      else
        broadcast_event(ctx, "missing_dep", %{"dep" => missing_dep})
        assign(ctx, missing_dep: missing_dep)
      end

    {:noreply, ctx}
  end

  defp to_updates(field, value, type), do: %{field => parse_value(value, type)}

  defp parse_value("", _type), do: nil
  defp parse_value(value, :number), do: String.to_integer(value)
  defp parse_value(value, _type), do: value

  @impl true
  def scan_binding(pid, _binding, _env) do
    {default_backend, default_compiler} = default_backend_and_compiler()
    send(pid, {:default_backend_and_compiler, default_backend, default_compiler})
  end

  @impl true
  def handle_info({:default_backend_and_compiler, default_backend, default_compiler}, ctx) do
    if default_backend != ctx.assigns.default_backend do
      broadcast_event(ctx, "default_backend_updated", %{
        "is_binary_backend" => default_backend == Nx.BinaryBackend
      })
    end

    {:noreply, assign(ctx, default_backend: default_backend, default_compiler: default_compiler)}
  end

  @impl true
  def to_attrs(ctx) do
    ctx.assigns.fields
  end

  @impl true
  def to_source(attrs) do
    for quoted <- to_quoted(attrs), do: Kino.SmartCell.quoted_to_string(quoted)
  end

  defp to_quoted(%{"task_id" => "image_classification"} = attrs) do
    opts =
      if(top_k = attrs["top_k"],
        do: [top_k: top_k],
        else: []
      ) ++
        [compile: [batch_size: 1]] ++ maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} =
          Bumblebee.load_model({:hf, unquote(generation.model_repo_id)}, log_params_diff: false)

        {:ok, featurizer} =
          Bumblebee.load_featurizer({:hf, unquote(generation.featurizer_repo_id)})

        serving = Bumblebee.Vision.image_classification(model_info, featurizer, unquote(opts))
      end,
      quote do
        image_input = Kino.Input.image("Image", size: {224, 224})
        form = Kino.Control.form([image: image_input], submit: "Run")

        frame = Kino.Frame.new()

        form
        |> Kino.Control.stream()
        |> Stream.filter(& &1.data.image)
        |> Kino.listen(fn %{data: %{image: image}} ->
          Kino.Frame.render(frame, Kino.Markdown.new("Running..."))

          image = image.data |> Nx.from_binary(:u8) |> Nx.reshape({image.height, image.width, 3})
          output = Nx.Serving.run(serving, image)

          output.predictions
          |> Enum.map(&{&1.label, &1.score})
          |> Kino.Bumblebee.ScoredList.new()
          |> then(&Kino.Frame.render(frame, &1))
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "text_classification"} = attrs) do
    opts =
      if(top_k = attrs["top_k"],
        do: [top_k: top_k],
        else: []
      ) ++
        [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]]] ++
        maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} =
          Bumblebee.load_model({:hf, unquote(generation.model_repo_id)}, log_params_diff: false)

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        serving = Bumblebee.Text.text_classification(model_info, tokenizer, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
        form = Kino.Control.form([text: text_input], submit: "Run")

        frame = Kino.Frame.new()

        form
        |> Kino.Control.stream()
        |> Kino.listen(fn %{data: %{text: text}} ->
          Kino.Frame.render(frame, Kino.Markdown.new("Running..."))

          output = Nx.Serving.run(serving, text)

          output.predictions
          |> Enum.map(&{&1.label, &1.score})
          |> Kino.Bumblebee.ScoredList.new()
          |> then(&Kino.Frame.render(frame, &1))
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "text_generation"} = attrs) do
    opts =
      drop_nil_options(
        min_new_tokens: attrs["min_new_tokens"],
        max_new_tokens: attrs["max_new_tokens"]
      ) ++
        [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]]] ++
        maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} =
          Bumblebee.load_model({:hf, unquote(generation.model_repo_id)}, log_params_diff: false)

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        serving = Bumblebee.Text.generation(model_info, tokenizer, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
        form = Kino.Control.form([text: text_input], submit: "Run")

        frame = Kino.Frame.new()

        form
        |> Kino.Control.stream()
        |> Kino.listen(fn %{data: %{text: text}} ->
          Kino.Frame.render(frame, Kino.Markdown.new("Running..."))
          %{results: [%{text: generated_text}]} = Nx.Serving.run(serving, text)
          Kino.Frame.render(frame, Kino.Markdown.new(generated_text))
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(
         %{"task_id" => "text_to_image", "variant_id" => "stable_diffusion_" <> _} = attrs
       ) do
    opts =
      drop_nil_options(
        num_steps: attrs["num_steps"],
        num_images_per_prompt: attrs["num_images_per_prompt"],
        safety_checker: quote(do: safety_checker),
        safety_checker_featurizer: quote(do: featurizer)
      ) ++
        [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]]] ++
        maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        repository_id = unquote(generation.repo_id)

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "openai/clip-vit-large-patch14"})

        {:ok, clip} =
          Bumblebee.load_model({:hf, repository_id, subdir: "text_encoder"},
            log_params_diff: false
          )

        {:ok, unet} =
          Bumblebee.load_model({:hf, repository_id, subdir: "unet"},
            params_filename: "diffusion_pytorch_model.bin",
            log_params_diff: false
          )

        {:ok, vae} =
          Bumblebee.load_model({:hf, repository_id, subdir: "vae"},
            architecture: :decoder,
            params_filename: "diffusion_pytorch_model.bin",
            log_params_diff: false
          )

        {:ok, scheduler} = Bumblebee.load_scheduler({:hf, repository_id, subdir: "scheduler"})

        {:ok, featurizer} =
          Bumblebee.load_featurizer({:hf, repository_id, subdir: "feature_extractor"})

        {:ok, safety_checker} =
          Bumblebee.load_model({:hf, repository_id, subdir: "safety_checker"},
            log_params_diff: false
          )

        serving =
          Bumblebee.Diffusion.StableDiffusion.text_to_image(
            clip,
            unet,
            vae,
            tokenizer,
            scheduler,
            unquote(opts)
          )
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
        form = Kino.Control.form([text: text_input], submit: "Run")
        frame = Kino.Frame.new()

        form
        |> Kino.Control.stream()
        |> Kino.listen(fn %{data: %{text: text}} ->
          Kino.Frame.render(frame, Kino.Markdown.new("Running..."))

          output = Nx.Serving.run(serving, text)

          for result <- output.results do
            Kino.Image.new(result.image)
          end
          |> Kino.Layout.grid(columns: 2)
          |> then(&Kino.Frame.render(frame, &1))
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(_) do
    []
  end

  defp drop_nil_options(opts) do
    Enum.reject(opts, &match?({_key, nil}, &1))
  end

  defp maybe_defn_options(attrs) do
    if compiler = attrs["compiler"] do
      [defn_options: [compiler: to_compiler(compiler)]]
    else
      []
    end
  end

  defp to_compiler("exla"), do: EXLA

  defp tasks(), do: @tasks

  defp task_by_id(task_id) do
    Enum.find(tasks(), &(&1.id == task_id))
  end

  defp variant_by_id(task_id, variant_id) do
    task = task_by_id(task_id)
    Enum.find(task.variants, &(&1.id == variant_id))
  end

  defp variant_from_attrs(attrs) do
    variant_by_id(attrs["task_id"], attrs["variant_id"])
  end

  defp missing_dep(%{"compiler" => "exla"}) do
    unless Code.ensure_loaded?(EXLA) do
      ~s/{:exla, "~> 0.4.0"}/
    end
  end

  defp missing_dep(_fields), do: nil
end
