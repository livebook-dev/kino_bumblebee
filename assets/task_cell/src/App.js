import React, { useEffect, useRef, useState } from "react";
import { RiQuestionnaireLine, RiArrowDownSLine } from "@remixicon/react";
import classNames from "classnames";

export default function App({ ctx, payload }) {
  const [missingDep, setMissingDep] = useState(payload.missing_dep);
  const [isBinaryBackend, setIsBinaryBackend] = useState(
    payload.is_binary_backend,
  );
  const [fields, setFields] = useState(payload.fields);
  const [showHelpBox, setShowHelpBox] = useState(false);

  const tasks = payload.task_groups.flatMap((taskGroup) => taskGroup.tasks);

  const taskOptionGroups = payload.task_groups.map(({ label, tasks }) => ({
    label,
    options: tasks.map((task) => ({
      value: task.id,
      label: task.label,
    })),
  }));

  const selectedTask = tasks.find((task) => task.id === fields.task_id);

  const selectedVariant =
    selectedTask.variants.find((variant) => variant.id === fields.variant_id) ||
    selectedTask.variants[0];

  const variantOptions = selectedTask.variants.map((variant) => ({
    value: variant.id,
    label: variant.label,
  }));

  useEffect(() => {
    ctx.handleEvent("update", ({ fields }) => {
      setFields((currentFields) => ({ ...currentFields, ...fields }));
    });

    ctx.handleEvent("default_backend_updated", ({ is_binary_backend }) => {
      setIsBinaryBackend(is_binary_backend);
    });

    ctx.handleEvent("missing_dep", ({ dep }) => {
      setMissingDep(dep);
    });
  }, []);

  function pushUpdate(field, value) {
    ctx.pushEvent("update_field", { field, value });
  }

  function handleChange(event, push = true) {
    const field = event.target.name;

    const value =
      event.target.type === "checkbox"
        ? event.target.checked
        : event.target.value;

    setFields({ ...fields, [field]: value });

    if (push) {
      pushUpdate(field, value);
    }
  }

  function handleBlur(event) {
    const field = event.target.name;

    pushUpdate(field, fields[field]);
  }

  return (
    <div className="flex flex-col gap-4 font-sans">
      {missingDep && (
        <MessageBox variant="warning">
          To successfully run, you need to add the following dependency:
          <pre className="font-xs mt-4 font-mono text-gray-900">
            <code>{missingDep}</code>
          </pre>
        </MessageBox>
      )}
      {isBinaryBackend && (
        <MessageBox variant="warning">
          The models require involved computation, please configure an efficient
          Nx backend. For example, to use EXLA do:
          <pre className="font-xs mt-4 font-mono text-gray-900">
            <code>Nx.global_default_backend(EXLA.Backend)</code>
          </pre>
        </MessageBox>
      )}
      <div className="rounded-lg border border-gray-300 bg-[#fefefe]">
        <Header>
          <FieldWrapper>
            <InlineLabel label="Task" />
            <SelectField
              name="task_id"
              value={fields.task_id}
              onChange={handleChange}
              optionGroups={taskOptionGroups}
            />
          </FieldWrapper>
          <div className="flex items-center gap-3">
            <FieldWrapper>
              <InlineLabel label="Using" />
              <SelectField
                name="variant_id"
                value={fields.variant_id}
                onChange={handleChange}
                options={variantOptions}
              />
            </FieldWrapper>
            <a
              href={selectedVariant.docs_url}
              target="_blank"
              rel="noreferrer noopener"
            >
              <img className="h-6" src={selectedVariant.docs_logo} />
            </a>
          </div>
          <div className="grow"></div>
          <div class="flex items-center">
            <IconButton onClick={(_event) => setShowHelpBox(!showHelpBox)}>
              <RiQuestionnaireLine size={20} />
            </IconButton>
          </div>
        </Header>
        {showHelpBox && <HelpBox />}
        <div className="flex flex-wrap gap-2 p-4">
          {selectedTask.params.map((param) => (
            <React.Fragment key={param.field}>
              {param.type === "number" && (
                <div class="w-36">
                  <TextField
                    key={param.field}
                    type="number"
                    name={param.field}
                    label={param.label}
                    value={fields[param.field] || ""}
                    onChange={(event) => handleChange(event, false)}
                    onBlur={handleBlur}
                  />
                </div>
              )}
              {param.type === "text" && (
                <div class="grow">
                  <TextField
                    key={param.field}
                    type="text"
                    name={param.field}
                    label={param.label}
                    value={fields[param.field] || ""}
                    onChange={(event) => handleChange(event, false)}
                    onBlur={handleBlur}
                    fullWidth
                  />
                </div>
              )}
              {param.type === "select" && (
                <SelectField
                  key={param.field}
                  name={param.field}
                  label={param.label}
                  value={fields[param.field]}
                  onChange={handleChange}
                  options={param.options}
                />
              )}
            </React.Fragment>
          ))}
          <SelectField
            name="compiler"
            label="Compiler"
            value={fields.compiler}
            onChange={handleChange}
            options={[
              { value: "", label: "None" },
              { value: "exla", label: "EXLA" },
            ]}
          />
        </div>
        {selectedTask.note && (
          <div className="p-4 pt-2 text-sm text-gray-700">
            <span className="font-medium text-gray-800">Note:</span>{" "}
            {selectedTask.note}
          </div>
        )}
      </div>
    </div>
  );
}

function HelpBox(_props) {
  return (
    <div className="flex flex-col gap-5 border-b border-gray-200 p-4 text-sm text-gray-700">
      <div>
        <p>
          This smart cell showcases a selection of models, picked with quality
          and compatibility in mind. If you want to try other checkpoints from
          HuggingFace Hub, you can convert this to a Code cell and customize
          however you like.
        </p>
      </div>
      <div>
        <h3 className="mb-2 text-base font-medium text-gray-800">
          Running on a GPU
        </h3>
        <p>
          If you have a GPU available, make sure to configure your
          backend/compiler of choice to use it. With the EXLA compiler (our
          default recommendation), you must set the{" "}
          <a
            href="https://github.com/elixir-nx/xla#usage"
            target="_blank"
            className="border-b border-gray-900 font-medium text-gray-900 no-underline hover:border-none"
          >
            <code>XLA_TARGET</code> environment variable
          </a>
          . This can be done in{" "}
          <a
            href="/settings"
            target="_blank"
            className="border-b border-gray-900 font-medium text-gray-900 no-underline hover:border-none"
          >
            the Settings page
          </a>
          . Note that you need to re-run the Setup cell of your notebook for
          those changes to take effect.
        </p>
      </div>
    </div>
  );
}

function MessageBox({ variant = "neutral", children }) {
  return (
    <div
      className={classNames([
        "rounded-lg border p-4 text-sm",
        {
          neutral: "border-gray-300 text-gray-700",
          warning: "color-gray-900 border-yellow-600 bg-yellow-100",
        }[variant],
      ])}
    >
      {children}
    </div>
  );
}

function Header({ children }) {
  return (
    <div className="align-stretch flex flex-wrap justify-start gap-4 rounded-t-lg border-b border-b-gray-200 bg-blue-100 px-4 py-2">
      {children}
    </div>
  );
}

function IconButton({ children, ...props }) {
  return (
    <button
      {...props}
      className="align-center flex cursor-pointer items-center rounded-full p-1 leading-none text-gray-500 hover:text-gray-900 focus:bg-gray-300/25 focus:outline-none disabled:cursor-default disabled:text-gray-300"
    >
      {children}
    </button>
  );
}

function SelectField({
  label = null,
  value,
  className,
  options = [],
  optionGroups = [],
  ...props
}) {
  function renderOptions(options) {
    return options.map((option) => (
      <option key={option.value || ""} value={option.value || ""}>
        {option.label}
      </option>
    ));
  }

  return (
    <div className="flex flex-col">
      {label && (
        <label className="color-gray-800 mb-0.5 block text-sm font-medium">
          {label}
        </label>
      )}
      <div className="relative block">
        <select
          {...props}
          value={value}
          className={classNames([
            "w-full appearance-none rounded-lg border border-gray-200 bg-gray-50 px-3 py-2 pr-7 text-sm text-gray-600 placeholder-gray-400 focus:outline-none",
            className,
          ])}
        >
          {renderOptions(options)}
          {optionGroups.map(({ label, options }) => (
            <optgroup key={label} label={label}>
              {renderOptions(options)}
            </optgroup>
          ))}
        </select>
        <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-500">
          <RiArrowDownSLine size={16} />
        </div>
      </div>
    </div>
  );
}

function FieldWrapper({ children }) {
  return <div className="flex items-center gap-1.5">{children}</div>;
}

function InlineLabel({ label }) {
  return (
    <label className="block text-sm font-medium uppercase text-gray-600">
      {label}
    </label>
  );
}

function TextField({
  label = null,
  value,
  type = "text",
  className,
  required = false,
  fullWidth = false,
  inputRef,
  startAdornment,
  ...props
}) {
  return (
    <div
      className={classNames([
        "flex max-w-full flex-col",
        fullWidth ? "w-full" : "w-[20ch]",
      ])}
    >
      {label && (
        <label className="color-gray-800 mb-0.5 block text-sm font-medium">
          {label}
        </label>
      )}
      <div
        className={classNames([
          "flex items-stretch overflow-hidden rounded-lg border bg-gray-50",
          required && !value ? "border-red-300" : "border-gray-200",
        ])}
      >
        {startAdornment}
        <input
          {...props}
          ref={inputRef}
          type={type}
          value={value}
          className={classNames([
            "w-full bg-transparent px-3 py-2 text-sm text-gray-600 placeholder-gray-400 focus:outline-none",
            className,
          ])}
        />
      </div>
    </div>
  );
}
