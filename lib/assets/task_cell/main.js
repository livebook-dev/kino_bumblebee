import * as Vue from "https://cdn.jsdelivr.net/npm/vue@3.2.26/dist/vue.esm-browser.prod.js";

export async function init(ctx, payload) {
  await Promise.all([
    ctx.importCSS("main.css"),
    ctx.importCSS("https://fonts.googleapis.com/css2?family=Inter:wght@400;500&display=swap"),
    ctx.importCSS("https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap"),
    ctx.importCSS("https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.min.css")
  ]);

  const BaseSelect = {
    name: "BaseSelect",

    props: {
      label: {
        type: String,
        default: "",
      },
      selectClass: {
        type: String,
        default: "input",
      },
      modelValue: {
        type: String,
        default: "",
      },
      options: {
        type: Array,
        default: [],
        required: true,
      },
      required: {
        type: Boolean,
        default: false,
      },
      inline: {
        type: Boolean,
        default: false,
      },
      disabled: {
        type: Boolean,
        default: false,
      },
    },

    template: `
    <div v-bind:class="inline ? 'inline-field' : 'field'">
      <label v-bind:class="inline ? 'inline-input-label' : 'input-label'">
        {{ label }}
      </label>
      <select
        :value="modelValue"
        v-bind="$attrs"
        v-bind:disabled="disabled"
        @change="$emit('update:modelValue', $event.target.value)"
        v-bind:class="selectClass"
      >
        <option
          v-for="option in options"
          :value="option.value"
          :key="option"
          :selected="option.value === modelValue"
        >{{ option.label }}</option>
      </select>
    </div>
    `,
  };

  const BaseInput = {
    name: "BaseInput",

    props: {
      label: {
        type: String,
        default: "",
      },
      inputClass: {
        type: String,
        default: "input",
      },
      modelValue: {
        type: [String, Number],
        default: "",
      },
      inline: {
        type: Boolean,
        default: false,
      },
      grow: {
        type: Boolean,
        default: false,
      },
    },

    template: `
    <div v-bind:class="[inline ? 'inline-field' : 'field', grow ? 'grow' : '']">
      <label v-bind:class="inline ? 'inline-input-label' : 'input-label'">
        {{ label }}
      </label>
      <input
        :value="modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        v-bind="$attrs"
        v-bind:class="inputClass"
      >
    </div>
    `,
  };

  const app = Vue.createApp({
    components: { BaseSelect, BaseInput },
    template: `
      <div class="app">
        <div class="box box-warning" v-if="missingDep">
          <p>
            To successfully run, you need to add the following dependency:
          </p>
          <pre><code>{{ missingDep }}</code></pre>
        </div>
        <div class="box box-warning" v-if="isBinaryBackend">
          <p>
            The models require involved computation, please configure an efficient Nx backend. For example, to use EXLA do:
          </p>
          <pre><code>Nx.global_default_backend(EXLA.Backend)</code></pre>
        </div>
        <form @change="handleFieldChange">
          <div class="container">
            <div class="header">
              <BaseSelect
                name="task_id"
                label="Task"
                :value="fields.task_id"
                selectClass="input"
                :inline
                :options="taskOptions"
              />
              <div class="variant-container">
                <BaseSelect
                  name="variant_id"
                  label="Using"
                  :value="fields.variant_id"
                  selectClass="input"
                  :inline
                  :options="variantOptions"
                />
                <a class="icon-button" :href="selectedVariant.docs_url" target="_blank" rel="noreferrer noopener">
                  <img :src="selectedVariant.docs_logo" />
                </a>
              </div>
              <div class="grow"></div>
              <button type="button" @click="toggleHelpBox" class="icon-button">
                <i class="ri ri-questionnaire-line" aria-hidden="true"></i>
              </button>
            </div>
            <div class="help-section" v-if="!showHelpBox">
              <div>
                <p>
                  This smart cell showcases a selection of models, picked with quality and compatibility
                  in mind. If you want to try other checkpoints from HuggingFace Hub, you can convert this
                  to a Code cell and customize however you like.
                </p>
              </div>
              <div>
                <h3>Running on a GPU</h3>
                <p>
                  If you have a GPU available, make sure to configure your backend/compiler
                  of choice to use it. With the EXLA compiler (our default recommendation),
                  you must set the <a href="https://github.com/elixir-nx/xla#usage" target="_blank">
                  <code>XLA_TARGET</code> environment variable</a>. This can be done in
                  <a href="/settings" target="_blank">the Settings page</a>. Note that you need
                  to re-run the Setup cell of your notebook for those changes to take effect.
                </p>
              </div>
            </div>
            <div class="row">
              <div v-for="param in selectedTask.params">
                <BaseInput
                  :name="param.field"
                  :label="param.label"
                  :type="param.type"
                  :value="fields[param.field]"
                  inputClass="input input--xs"
                />
              </div>
              <div>
                <BaseSelect
                  name="compiler"
                  label="Compiler"
                  :value="fields.compiler"
                  selectClass="input"
                  :options="compilerOptions"
                />
              </div>
            </div>
            <div v-if="selectedTask.note" class="note">
              <span class="note-caption">Note:</span>
              {{ selectedTask.note }}
            </div>
          </div>
        </form>
      </div>
    `,

    data() {
      return {
        showHelpBox: true,
        isBinaryBackend: payload.is_binary_backend,
        missingDep: payload.missing_dep,
        fields: payload.fields,
        taskOptions: payload.tasks.map((task) => ({
          value: task.id,
          label: task.label,
        })),
        compilerOptions: [
          { value: "", label: "None" },
          { value: "exla", label: "EXLA" },
        ],
      };
    },

    computed: {
      selectedTask() {
        return payload.tasks.find((task) => task.id === this.fields.task_id);
      },

      selectedVariant() {
        return this.selectedTask.variants.find(
          (variant) => variant.id === this.fields.variant_id
        );
      },

      variantOptions() {
        return this.selectedTask.variants.map((variant) => ({
          value: variant.id,
          label: variant.label,
        }));
      },
    },

    methods: {
      handleFieldChange(event) {
        const { name: field, value } = event.target;

        if (field) {
          ctx.pushEvent("update_field", { field, value });
        }
      },

      toggleHelpBox(_) {
        this.showHelpBox = !this.showHelpBox;
      },
    },
  }).mount(ctx.root);

  ctx.handleEvent("update", ({ fields }) => {
    setValues(fields);
  });

  ctx.handleEvent("default_backend_updated", ({ is_binary_backend }) => {
    app.isBinaryBackend = is_binary_backend;
  });

  ctx.handleEvent("missing_dep", ({ dep }) => {
    app.missingDep = dep;
  });

  function setValues(fields) {
    for (const field in fields) {
      app.fields[field] = fields[field];
    }
  }
}
