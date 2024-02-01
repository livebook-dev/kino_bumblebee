import "./main.css";

import * as Vue from "vue/dist/vue.esm-browser.prod.js";

export async function init(ctx, payload) {
  await Promise.all([
    ctx.importCSS("main.css"),
    ctx.importCSS(
      "https://fonts.googleapis.com/css2?family=Inter:wght@400;500&display=swap"
    ),
    ctx.importCSS(
      "https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap"
    ),
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
        required: false,
      },
      optionGroups: {
        type: Array,
        default: [],
        required: false,
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
          :value="option.value || ''"
          :key="option"
          :selected="option.value === modelValue"
        >{{ option.label }}</option>
        <optgroup v-for="optionGroup in optionGroups" :label="optionGroup.label">
          <option
            v-for="option in optionGroup.options"
            :value="option.value || ''"
            :key="option"
            :selected="option.value === modelValue"
          >{{ option.label }}</option>
        </optgroup>
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

  const BaseSwitch = {
    name: "BaseSwitch",

    props: {
      label: {
        type: String,
        default: "",
      },
      modelValue: {
        type: Boolean,
        default: true,
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
      <div class="input-container">
        <label class="switch-button">
          <input
            :checked="modelValue"
            type="checkbox"
            @input="$emit('update:modelValue', $event.target.checked)"
            v-bind="$attrs"
            class="switch-button-checkbox"
            v-bind:class="[inputClass, number ? 'input-number' : '']"
          >
          <div class="switch-button-bg" />
        </label>
      </div>
    </div>
    `,
  };

  const app = Vue.createApp({
    components: { BaseSelect, BaseInput, BaseSwitch },
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
                v-model="fields.task_id"
                selectClass="input"
                inline
                :optionGroups="taskOptionGroups"
              />
              <div class="variant-container">
                <BaseSelect
                  name="variant_id"
                  label="Using"
                  v-model="fields.variant_id"
                  selectClass="input"
                  inline
                  :options="variantOptions"
                />
                <a class="icon-button" :href="selectedVariant.docs_url" target="_blank" rel="noreferrer noopener">
                  <img :src="'files/' + selectedVariant.docs_logo" />
                </a>
              </div>
              <div class="grow"></div>
              <button type="button" @click="toggleHelpBox" class="icon-button">
                <svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M5.76282 17H20V5H4V18.3851L5.76282 17ZM6.45455 19L2 22.5V4C2 3.44772 2.44772 3 3 3H21C21.5523 3 22 3.44772 22 4V18C22 18.5523 21.5523 19 21 19H6.45455ZM11 14H13V16H11V14ZM8.56731 8.81346C8.88637 7.20919 10.302 6 12 6C13.933 6 15.5 7.567 15.5 9.5C15.5 11.433 13.933 13 12 13H11V11H12C12.8284 11 13.5 10.3284 13.5 9.5C13.5 8.67157 12.8284 8 12 8C11.2723 8 10.6656 8.51823 10.5288 9.20577L8.56731 8.81346Z"></path></svg>
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
              <template v-for="param in selectedTask.params">
                <BaseInput
                  v-if="param.type === 'number'"
                  type="number"
                  :name="param.field"
                  :label="param.label"
                  v-model="fields[param.field]"
                  inputClass="input input--xs"
                />
                <BaseInput
                  v-if="param.type === 'text'"
                  type="text"
                  :name="param.field"
                  :label="param.label"
                  v-model="fields[param.field]"
                  inputClass="input"
                  :grow
                />
                <BaseSelect
                  v-if="param.type === 'select'"
                  :name="param.field"
                  :label="param.label"
                  v-model="fields[param.field]"
                  inputClass="input"
                  :options="param.options"
                />
                <BaseSwitch
                  v-if="param.type === 'boolean'"
                  :name="param.field"
                  :label="param.label"
                  v-model="fields[param.field]"
                />
              </template>
              <BaseSelect
                name="compiler"
                label="Compiler"
                v-model="fields.compiler"
                selectClass="input"
                :options="compilerOptions"
              />
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
        tasks: payload.task_groups.flatMap((taskGroup) => taskGroup.tasks),
        taskOptionGroups: payload.task_groups.map(({ label, tasks }) => ({
          label,
          options: tasks.map((task) => ({
            value: task.id,
            label: task.label,
          })),
        })),
        compilerOptions: [
          { value: "", label: "None" },
          { value: "exla", label: "EXLA" },
        ],
      };
    },

    computed: {
      selectedTask() {
        return this.tasks.find((task) => task.id === this.fields.task_id);
      },

      selectedVariant() {
        return (
          this.selectedTask.variants.find(
            (variant) => variant.id === this.fields.variant_id
          ) || this.selectedTask.variants[0]
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
        const field = event.target.name;

        if (field) {
          const value = this.fields[field];
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
