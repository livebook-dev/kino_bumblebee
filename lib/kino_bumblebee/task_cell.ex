defmodule KinoBumblebee.TaskCell do
  @moduledoc false

  use Kino.JS, assets_path: "lib/assets/task_cell", entrypoint: "build/main.js"
  use Kino.JS.Live
  use Kino.SmartCell, name: "Neural Network task"

  @task_groups [
    %{
      label: "Vision",
      tasks: [
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
          id: "image_to_text",
          label: "Image-to-text",
          variants: [
            %{
              id: "blip_captioning_base",
              label: "BLIP (base) - image captioning",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/Salesforce/blip-image-captioning-base",
              generation: %{
                model_repo_id: "Salesforce/blip-image-captioning-base",
                featurizer_repo_id: "Salesforce/blip-image-captioning-base",
                tokenizer_repo_id: "Salesforce/blip-image-captioning-base"
              }
            },
            %{
              id: "blip_captioning_large",
              label: "BLIP (large) - image captioning",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/Salesforce/blip-image-captioning-large",
              generation: %{
                model_repo_id: "Salesforce/blip-image-captioning-large",
                featurizer_repo_id: "Salesforce/blip-image-captioning-large",
                tokenizer_repo_id: "Salesforce/blip-image-captioning-large"
              }
            }
          ],
          params: [
            %{field: "min_new_tokens", label: "Min new tokens", type: :number, default: nil},
            %{field: "max_new_tokens", label: "Max new tokens", type: :number, default: 100}
          ]
        }
      ]
    },
    %{
      label: "Text",
      tasks: [
        %{
          id: "fill_mask",
          label: "Fill-mask",
          variants: [
            %{
              id: "bert_base_uncased",
              label: "BERT (base uncased)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/google-bert/bert-base-uncased",
              generation: %{
                model_repo_id: "google-bert/bert-base-uncased",
                tokenizer_repo_id: "google-bert/bert-base-uncased",
                default_text: "Paris is the [MASK] of France."
              }
            },
            %{
              id: "bert_base_cased",
              label: "BERT (base cased)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/google-bert/bert-base-cased",
              generation: %{
                model_repo_id: "google-bert/bert-base-cased",
                tokenizer_repo_id: "google-bert/bert-base-cased",
                default_text: "Paris is the [MASK] of France."
              }
            },
            %{
              id: "bert_base_multilingual_uncased",
              label: "BERT (base multilingual uncased)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/google-bert/bert-base-multilingual-uncased",
              generation: %{
                model_repo_id: "google-bert/bert-base-multilingual-uncased",
                tokenizer_repo_id: "google-bert/bert-base-multilingual-uncased",
                default_text: "Paris est la [MASK] de la France."
              }
            },
            %{
              id: "bert_base_multilingual_cased",
              label: "BERT (base multilingual cased)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/google-bert/bert-base-multilingual-cased",
              generation: %{
                model_repo_id: "google-bert/bert-base-multilingual-cased",
                tokenizer_repo_id: "google-bert/bert-base-multilingual-cased",
                default_text: "Paris est la [MASK] de la France."
              }
            },
            %{
              id: "roberta_base",
              label: "RoBERTa (base)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/FacebookAI/roberta-base",
              generation: %{
                model_repo_id: "FacebookAI/roberta-base",
                tokenizer_repo_id: "FacebookAI/roberta-base",
                default_text: "Elixir is a [MASK] programming language."
              }
            },
            %{
              id: "distilroberta_base",
              label: "DistilRoBERTa (base)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/distilbert/distilroberta-base",
              generation: %{
                model_repo_id: "distilbert/distilroberta-base",
                tokenizer_repo_id: "distilbert/distilroberta-base",
                default_text: "Elixir is a [MASK] programming language."
              }
            },
            %{
              id: "xlm_roberta_base",
              label: "XLM-RoBERTa (base)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/FacebookAI/xlm-roberta-base",
              generation: %{
                model_repo_id: "FacebookAI/xlm-roberta-base",
                tokenizer_repo_id: "FacebookAI/xlm-roberta-base",
                default_text: "Elixir is a [MASK] programming language."
              }
            },
            %{
              id: "albert_base_v2",
              label: "ALBERT (base v2)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/albert/albert-base-v2",
              generation: %{
                model_repo_id: "albert/albert-base-v2",
                tokenizer_repo_id: "albert/albert-base-v2",
                default_text: "Paris is the [MASK] of France."
              }
            }
          ],
          params: [
            %{field: "top_k", label: "Top-k", type: :number, default: nil},
            %{field: "sequence_length", label: "Max input tokens", type: :number, default: 100}
          ]
        },
        %{
          id: "question_answering",
          label: "Question answering",
          variants: [
            %{
              id: "distilbert_base_cased",
              label: "DistilBERT (base cased)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/distilbert/distilbert-base-cased-distilled-squad",
              generation: %{
                model_repo_id: "distilbert/distilbert-base-cased-distilled-squad",
                tokenizer_repo_id: "distilbert/distilbert-base-cased-distilled-squad",
                default_question: "Where do I live?",
                default_context: "My name is Sarah and I live in London."
              }
            },
            %{
              id: "bert_large_uncased",
              label: "BERT (large uncased)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "google-bert/bert-large-uncased-whole-word-masking-finetuned-squad",
              generation: %{
                model_repo_id:
                  "google-bert/bert-large-uncased-whole-word-masking-finetuned-squad",
                tokenizer_repo_id:
                  "google-bert/bert-large-uncased-whole-word-masking-finetuned-squad",
                default_question: "What's my name?",
                default_context: "My name is Clara and I live in Berkeley."
              }
            },
            %{
              id: "roberta_base",
              label: "RoBERTa (base)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/deepset/roberta-base-squad2",
              generation: %{
                model_repo_id: "deepset/roberta-base-squad2",
                tokenizer_repo_id: "FacebookAI/roberta-base",
                default_question: "Where do I live?",
                default_context: "My name is Wolfgang and I live in Berlin"
              }
            }
          ],
          params: [
            %{field: "sequence_length", label: "Max input tokens", type: :number, default: 500}
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
                tokenizer_repo_id: "FacebookAI/roberta-base",
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
                tokenizer_repo_id: "FacebookAI/roberta-base",
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
              id: "xlm_roberta_language_detection",
              label: "XLM-RoBERTa - language detection",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/papluca/xlm-roberta-base-language-detection",
              generation: %{
                model_repo_id: "papluca/xlm-roberta-base-language-detection",
                tokenizer_repo_id: "papluca/xlm-roberta-base-language-detection",
                default_text: "La casa de papel"
              }
            },
            %{
              id: "bert_finbert_sentiment",
              label: "BERT (FinBERT) - finance sentiment",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/ProsusAI/finbert",
              generation: %{
                model_repo_id: "ProsusAI/finbert",
                tokenizer_repo_id: "google-bert/bert-base-uncased",
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
          id: "token_classification",
          label: "Token classification",
          variants: [
            %{
              id: "bert_base_cased_ner",
              label: "BERT (base cased) - named-entity recognition",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/dslim/bert-base-NER",
              generation: %{
                model_repo_id: "dslim/bert-base-NER",
                tokenizer_repo_id: "google-bert/bert-base-cased",
                default_text:
                  "Rachel Green works at Ralph Lauren in New York City in the sitcom Friends."
              }
            },
            %{
              id: "bert_base_uncased_pos",
              label: "BERT (base uncased) - part of speech",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/vblagoje/bert-english-uncased-finetuned-pos",
              generation: %{
                model_repo_id: "vblagoje/bert-english-uncased-finetuned-pos",
                tokenizer_repo_id: "google-bert/bert-base-uncased",
                default_text:
                  "Elixir is a dynamic, functional language for building scalable and maintainable applications."
              }
            },
            %{
              id: "roberta_base_upos",
              label: "RobBERTa (base) - universal part of speech",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/KoichiYasuoka/roberta-base-english-upos",
              generation: %{
                model_repo_id: "KoichiYasuoka/roberta-base-english-upos",
                tokenizer_repo_id: "FacebookAI/roberta-base",
                default_text:
                  "Elixir is a dynamic, functional language for building scalable and maintainable applications."
              }
            },
            %{
              id: "xlm_roberta_base_punctuation",
              label: "RobBERTa (base) - punctuation",
              docs_logo: "huggingface_logo.svg",
              docs_url:
                "https://huggingface.co/oliverguhr/fullstop-punctuation-multilingual-sonar-base",
              generation: %{
                model_repo_id: "oliverguhr/fullstop-punctuation-multilingual-sonar-base",
                tokenizer_repo_id: "oliverguhr/fullstop-punctuation-multilingual-sonar-base",
                default_text:
                  "Elixir is a functional concurrent general-purpose programming language that runs on the BEAM virtual machine which is also used to implement the Erlang programming language"
              }
            }
          ],
          params: [
            %{
              field: "aggregation",
              label: "Aggregation",
              type: :select,
              options: [%{value: nil, label: "None"}, %{value: "same", label: "Same"}],
              default: "same"
            },
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
              docs_url: "https://huggingface.co/openai-community/gpt2",
              generation: %{
                model_repo_id: "openai-community/gpt2",
                tokenizer_repo_id: "openai-community/gpt2",
                default_text: "Yesterday, I was reading a book and"
              }
            },
            %{
              id: "gpt2_medium",
              label: "GPT2 (medium)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai-community/gpt2-medium",
              generation: %{
                model_repo_id: "openai-community/gpt2-medium",
                tokenizer_repo_id: "openai-community/gpt2-medium",
                default_text: "Yesterday, I was reading a book and"
              }
            },
            %{
              id: "gpt2_large",
              label: "GPT2 (large)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai-community/gpt2-large",
              generation: %{
                model_repo_id: "openai-community/gpt2-large",
                tokenizer_repo_id: "openai-community/gpt2-large",
                default_text: "Yesterday, I was reading a book and"
              }
            },
            %{
              id: "gpt2_xl",
              label: "GPT2 (xl)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai-community/gpt2-xl",
              generation: %{
                model_repo_id: "openai-community/gpt2-xl",
                tokenizer_repo_id: "openai-community/gpt2-xl",
                default_text: "Yesterday, I was reading a book and"
              }
            },
            %{
              id: "distilgpt2",
              label: "DistilGPT2 (base)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/distilbert/distilgpt2",
              generation: %{
                model_repo_id: "distilbert/distilgpt2",
                tokenizer_repo_id: "distilbert/distilgpt2",
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
            %{field: "max_new_tokens", label: "Max new tokens", type: :number, default: 20}
          ]
        },
        %{
          id: "zero_shot_text_classification",
          label: "Zero-shot text classification",
          variants: [
            %{
              id: "bart_large_mnli",
              label: "BART (large MNLI)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/facebook/bart-large-mnli",
              generation: %{
                model_repo_id: "facebook/bart-large-mnli",
                tokenizer_repo_id: "facebook/bart-large-mnli",
                default_text: "One day I will see the world."
              }
            },
            %{
              id: "xlm_roberta_large_xnli",
              label: "XLM-RoBERTa (large XNLI) - multilingual",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/joeddav/xlm-roberta-large-xnli",
              generation: %{
                model_repo_id: "joeddav/xlm-roberta-large-xnli",
                tokenizer_repo_id: "FacebookAI/xlm-roberta-large",
                default_text: "Un jour je verrai le monde."
              }
            }
          ],
          params: [
            %{
              field: "labels",
              label: "Labels (comma-separated)",
              type: :text,
              default: "cooking, traveling, dancing"
            },
            %{field: "top_k", label: "Top-k", type: :number, default: nil},
            %{field: "sequence_length", label: "Max input tokens", type: :number, default: 100}
          ]
        }
      ]
    },
    %{
      label: "Audio",
      tasks: [
        %{
          id: "speech_to_text",
          label: "Speech-to-text",
          variants: [
            %{
              id: "whisper_tiny",
              label: "Whisper (tiny multilingual)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai/whisper-tiny",
              generation: %{
                model_repo_id: "openai/whisper-tiny",
                featurizer_repo_id: "openai/whisper-tiny",
                tokenizer_repo_id: "openai/whisper-tiny"
              }
            },
            %{
              id: "whisper_base",
              label: "Whisper (base multilingual)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai/whisper-base",
              generation: %{
                model_repo_id: "openai/whisper-base",
                featurizer_repo_id: "openai/whisper-base",
                tokenizer_repo_id: "openai/whisper-base"
              }
            },
            %{
              id: "whisper_small",
              label: "Whisper (small multilingual)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai/whisper-small",
              generation: %{
                model_repo_id: "openai/whisper-small",
                featurizer_repo_id: "openai/whisper-small",
                tokenizer_repo_id: "openai/whisper-small"
              }
            },
            %{
              id: "whisper_medium",
              label: "Whisper (medium multilingual)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai/whisper-medium",
              generation: %{
                model_repo_id: "openai/whisper-medium",
                featurizer_repo_id: "openai/whisper-medium",
                tokenizer_repo_id: "openai/whisper-medium"
              }
            },
            %{
              id: "whisper_large_v3",
              label: "Whisper (large v3 multilingual)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/openai/whisper-large-v3",
              generation: %{
                model_repo_id: "openai/whisper-large-v3",
                featurizer_repo_id: "openai/whisper-large-v3",
                tokenizer_repo_id: "openai/whisper-large-v3"
              }
            },
            %{
              id: "distil_whisper_large_v2",
              label: "Distil Whisper (large v2 multilingual)",
              docs_logo: "huggingface_logo.svg",
              docs_url: "https://huggingface.co/distil-whisper/distil-large-v2",
              generation: %{
                model_repo_id: "distil-whisper/distil-large-v2",
                featurizer_repo_id: "distil-whisper/distil-large-v2",
                tokenizer_repo_id: "distil-whisper/distil-large-v2"
              }
            }
          ],
          params: [
            %{field: "max_new_tokens", label: "Max new tokens", type: :number, default: 100}
          ]
        }
      ]
    },
    %{
      label: "Multimodal",
      tasks: [
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
              docs_url: "https://huggingface.co/AdamOswald1/Anything-Preservation",
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
            %{
              field: "num_images_per_prompt",
              label: "Number of images",
              type: :number,
              default: 1
            }
          ],
          note:
            "this is a very involved task, the generation can take a long time if you run it on a CPU. To achieve a better quality increase the number of steps, 40 is usually a better default."
        }
      ]
    }
  ]

  default_task = get_in(@task_groups, [Access.at!(0), :tasks, Access.at!(0)])

  @default_task_id default_task.id
  @default_variant_id get_in(default_task, [:variants, Access.at!(0), :id])

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
          do: {field, Map.get(attrs, field, default)}

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
       task_groups: task_groups(),
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

    param =
      Enum.find_value(tasks(), fn task ->
        task.id == current_task_id && Enum.find(task.params, &(&1.field == field))
      end)

    updated_fields = to_updates(field, value, param)
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

  defp to_updates(field, value, param), do: %{field => parse_value(value, param)}

  defp parse_value(text, %{type: :text}), do: text
  defp parse_value("", _param), do: nil
  defp parse_value(value, %{type: :number}) when is_binary(value), do: String.to_integer(value)

  defp parse_value(value, %{type: :select, options: options}) do
    Enum.find_value(options, fn option ->
      to_string(option.value) == value && option.value
    end)
  end

  defp parse_value(value, _param), do: value

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
      ) ++ [compile: [batch_size: 1]] ++ maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, featurizer} =
          Bumblebee.load_featurizer({:hf, unquote(generation.featurizer_repo_id)})

        serving = Bumblebee.Vision.image_classification(model_info, featurizer, unquote(opts))
      end,
      quote do
        image_input = Kino.Input.image("Image", size: {224, 224})
        form = Kino.Control.form([image: image_input], submit: "Run")

        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{image: image}} ->
          if image do
            Kino.Frame.render(frame, Kino.Text.new("Running..."))

            image =
              image.file_ref
              |> Kino.Input.file_path()
              |> File.read!()
              |> Nx.from_binary(:u8)
              |> Nx.reshape({image.height, image.width, 3})

            output = Nx.Serving.run(serving, image)

            output.predictions
            |> Enum.map(&{&1.label, &1.score})
            |> Kino.Bumblebee.ScoredList.new()
            |> then(&Kino.Frame.render(frame, &1))
          end
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "image_to_text"} = attrs) do
    opts = [compile: [batch_size: 1]] ++ maybe_defn_options(attrs)

    generation_otps =
      drop_nil_options(
        min_new_tokens: attrs["min_new_tokens"],
        max_new_tokens: attrs["max_new_tokens"]
      )

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, featurizer} =
          Bumblebee.load_featurizer({:hf, unquote(generation.featurizer_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        {:ok, generation_config} =
          Bumblebee.load_generation_config({:hf, unquote(generation.model_repo_id)})

        unquote_splicing(maybe_configure_generation(generation_otps))

        serving =
          Bumblebee.Vision.image_to_text(
            model_info,
            featurizer,
            tokenizer,
            generation_config,
            unquote(opts)
          )
      end,
      quote do
        image_input = Kino.Input.image("Image", size: {384, 384})
        form = Kino.Control.form([image: image_input], submit: "Run")

        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{image: image}} ->
          if image do
            Kino.Frame.render(frame, Kino.Text.new("Running..."))

            image =
              image.file_ref
              |> Kino.Input.file_path()
              |> File.read!()
              |> Nx.from_binary(:u8)
              |> Nx.reshape({image.height, image.width, 3})

            %{results: [%{text: text}]} = Nx.Serving.run(serving, image)

            Kino.Frame.render(frame, Kino.Text.new(text))
          end
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
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        serving = Bumblebee.Text.text_classification(model_info, tokenizer, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
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

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "token_classification"} = attrs) do
    opts =
      if(aggregation = attrs["aggregation"],
        do: [aggregation: String.to_atom(aggregation)],
        else: []
      ) ++
        [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]]] ++
        maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        serving = Bumblebee.Text.token_classification(model_info, tokenizer, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
        form = Kino.Control.form([text: text_input], submit: "Run")

        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{text: text}} ->
          Kino.Frame.render(frame, Kino.Text.new("Running..."))
          output = Nx.Serving.run(serving, text)
          Kino.Frame.render(frame, Kino.Bumblebee.HighlightedText.new(text, output.entities))
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "zero_shot_text_classification"} = attrs) do
    opts =
      if(top_k = attrs["top_k"],
        do: [top_k: top_k],
        else: []
      ) ++
        [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]]] ++
        maybe_defn_options(attrs)

    labels =
      for label <- String.split(attrs["labels"], ","),
          label = String.trim(label),
          label != "",
          do: label

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        labels = unquote(labels)

        serving =
          Bumblebee.Text.zero_shot_classification(model_info, tokenizer, labels, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
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

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "fill_mask"} = attrs) do
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
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        serving = Bumblebee.Text.fill_mask(model_info, tokenizer, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
        form = Kino.Control.form([text: text_input], submit: "Run")
        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{text: text}} ->
          one_mask? = match?([_, _], String.split(text, "[MASK]"))

          if one_mask? do
            Kino.Frame.render(frame, Kino.Text.new("Running..."))
            output = Nx.Serving.run(serving, text)

            output.predictions
            |> Enum.map(&{&1.token, &1.score})
            |> Kino.Bumblebee.ScoredList.new()
            |> then(&Kino.Frame.render(frame, &1))
          else
            Kino.Frame.render(frame, Kino.Text.new("The text must include exactly one [MASK]."))
          end
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "question_answering"} = attrs) do
    opts =
      [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]]] ++
        maybe_defn_options(attrs)

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        serving = Bumblebee.Text.question_answering(model_info, tokenizer, unquote(opts))
      end,
      quote do
        inputs = [
          question: Kino.Input.text("Question", default: unquote(generation.default_question)),
          context: Kino.Input.textarea("Context", default: unquote(generation.default_context))
        ]

        form = Kino.Control.form(inputs, submit: "Run")

        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{question: question, context: context}} ->
          output = Nx.Serving.run(serving, %{question: question, context: context})

          output.results
          |> Enum.map(&{&1.text, &1.score})
          |> Kino.Bumblebee.ScoredList.new()
          |> then(&Kino.Frame.render(frame, &1))
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "text_generation"} = attrs) do
    opts =
      [compile: [batch_size: 1, sequence_length: attrs["sequence_length"]], stream: true] ++
        maybe_defn_options(attrs)

    generation_otps =
      drop_nil_options(
        min_new_tokens: attrs["min_new_tokens"],
        max_new_tokens: attrs["max_new_tokens"]
      )

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        {:ok, generation_config} =
          Bumblebee.load_generation_config({:hf, unquote(generation.model_repo_id)})

        unquote_splicing(maybe_configure_generation(generation_otps))

        serving =
          Bumblebee.Text.generation(model_info, tokenizer, generation_config, unquote(opts))
      end,
      quote do
        text_input = Kino.Input.textarea("Text", default: unquote(generation.default_text))
        form = Kino.Control.form([text: text_input], submit: "Run")

        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{text: text}} ->
          Kino.Frame.clear(frame)

          for chunk <- Nx.Serving.run(serving, text) do
            Kino.Frame.append(frame, Kino.Text.new(chunk, chunk: true))
          end
        end)

        Kino.Layout.grid([form, frame], boxed: true, gap: 16)
      end
    ]
  end

  defp to_quoted(%{"task_id" => "speech_to_text"} = attrs) do
    opts =
      [compile: [batch_size: 4], chunk_num_seconds: 30, timestamps: :segments, stream: true] ++
        maybe_defn_options(attrs)

    generation_otps = drop_nil_options(max_new_tokens: attrs["max_new_tokens"])

    %{generation: generation} = variant_from_attrs(attrs)

    [
      quote do
        {:ok, model_info} = Bumblebee.load_model({:hf, unquote(generation.model_repo_id)})

        {:ok, featurizer} =
          Bumblebee.load_featurizer({:hf, unquote(generation.featurizer_repo_id)})

        {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, unquote(generation.tokenizer_repo_id)})

        {:ok, generation_config} =
          Bumblebee.load_generation_config({:hf, unquote(generation.model_repo_id)})

        unquote_splicing(maybe_configure_generation(generation_otps))

        serving =
          Bumblebee.Audio.speech_to_text_whisper(
            model_info,
            featurizer,
            tokenizer,
            generation_config,
            unquote(opts)
          )
      end,
      quote do
        audio_input = Kino.Input.audio("Audio", sampling_rate: featurizer.sampling_rate)
        form = Kino.Control.form([audio: audio_input], submit: "Run")

        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{audio: audio}} ->
          if audio do
            audio =
              audio.file_ref
              |> Kino.Input.file_path()
              |> File.read!()
              |> Nx.from_binary(:f32)
              |> Nx.reshape({:auto, audio.num_channels})
              |> Nx.mean(axes: [1])

            Kino.Frame.render(frame, Kino.Text.new("(Start of transcription)", chunk: true))

            for chunk <- Nx.Serving.run(serving, audio) do
              [start_mark, end_mark] =
                for seconds <- [chunk.start_timestamp_seconds, chunk.end_timestamp_seconds] do
                  seconds
                  |> round()
                  |> Time.from_seconds_after_midnight()
                  |> Time.to_string()
                end

              text = "\n#{start_mark}-#{end_mark}: #{chunk.text}"
              Kino.Frame.append(frame, Kino.Text.new(text, chunk: true))
            end

            Kino.Frame.append(frame, Kino.Text.new("\n(End of transcription)", chunk: true))
          end
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
        seed: attrs["seed"],
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

        {:ok, clip} = Bumblebee.load_model({:hf, repository_id, subdir: "text_encoder"})

        {:ok, unet} = Bumblebee.load_model({:hf, repository_id, subdir: "unet"})

        {:ok, vae} =
          Bumblebee.load_model({:hf, repository_id, subdir: "vae"}, architecture: :decoder)

        {:ok, scheduler} = Bumblebee.load_scheduler({:hf, repository_id, subdir: "scheduler"})

        {:ok, featurizer} =
          Bumblebee.load_featurizer({:hf, repository_id, subdir: "feature_extractor"})

        {:ok, safety_checker} =
          Bumblebee.load_model({:hf, repository_id, subdir: "safety_checker"})

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
        seed_input = Kino.Input.number("Seed")
        form = Kino.Control.form([text: text_input, seed: seed_input], submit: "Run")
        frame = Kino.Frame.new()

        Kino.listen(form, fn %{data: %{text: text, seed: seed}} ->
          Kino.Frame.render(frame, Kino.Text.new("Running..."))

          output = Nx.Serving.run(serving, %{prompt: text, seed: seed})

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

  defp maybe_configure_generation([]), do: []

  defp maybe_configure_generation(opts) do
    [
      quote do
        generation_config = Bumblebee.configure(generation_config, unquote(opts))
      end
    ]
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

  defp task_groups(), do: @task_groups

  defp tasks(), do: Enum.flat_map(task_groups(), & &1.tasks)

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
      ~s/{:exla, "~> 0.4.1"}/
    end
  end

  defp missing_dep(_fields), do: nil
end
