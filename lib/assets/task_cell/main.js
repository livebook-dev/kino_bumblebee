import * as Vue from "https://cdn.jsdelivr.net/npm/vue@3.2.26/dist/vue.esm-browser.prod.js";

export function init(ctx, payload) {
  ctx.importCSS("main.css");
  ctx.importCSS(
    "https://fonts.googleapis.com/css2?family=Inter:wght@400;500&display=swap"
  );
  ctx.importCSS(
    "https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap"
  );
  ctx.importCSS(
    "https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.min.css"
  );

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
        <div class="info-box" v-if="isBinaryBackend">
          <p>The models require involved computation, please configure an efficient Nx backend. For example, to use EXLA do:</p>
          <pre><code>Nx.global_default_backend(EXLA.Backend)</code></pre>
        </div>
        <form @change="handleFieldChange">
          <div class="container">
            <div class="header">
              <BaseSelect
                name="task_id"
                label="Task"
                :value="fields.task_id"
                selectClass="input input--xs"
                :inline
                :options="taskOptions"
              />
              <BaseSelect
                name="variant_id"
                label="Using"
                :value="fields.variant_id"
                selectClass="input input--xs"
                :inline
                :options="variantOptions"
              />
              <div class="grow"></div>
              <a class="icon-button" :href="selectedVariant.docs_url" target="_blank" rel="noreferrer noopener">
                <i class="ri ri-external-link-line" aria-hidden="true"></i>
              </a>
              <button type="button" @click="toggleHelpBox" class="icon-button">
                <i class="ri ri-questionnaire-line" aria-hidden="true"></i>
              </button>
            </div>
            <div class="help-box" v-if="!showHelpBox">
              <div class="section">
                <p>
                  This smart cell showcases a selection of models, picked with quality and compatibility
                  in mind. If you want to try other checkpoints from HuggingFace Hub, you can convert this
                  to a Code cell and customize however you like.
                </p>
              </div>
              <div class="section">
                <h3>Running on a GPU</h3>
                <p>
                  If you have a GPU available, make sure to configure the backend/compiler of
                  choice to use it. In case of EXLA, you need to set the XLA_TARGET environment
                  variable. One way to do it is updating the Livebook Settings. Note that you
                  need to re-run the Setup cell for EXLA to fetch the matching binary.
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
                  selectClass="input input--xs"
                  :options="compilerOptions"
                />
              </div>
            </div>
          </div>
        </form>
      </div>
    `,

    data() {
      return {
        showHelpBox: true,
        isBinaryBackend: payload.is_binary_backend,
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

  function setValues(fields) {
    for (const field in fields) {
      app.fields[field] = fields[field];
    }
  }
}
