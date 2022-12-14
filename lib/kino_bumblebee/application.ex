defmodule KinoBumblebee.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Kino.SmartCell.register(KinoBumblebee.TaskCell)

    children = []
    opts = [strategy: :one_for_one, name: KinoBumblebee.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
