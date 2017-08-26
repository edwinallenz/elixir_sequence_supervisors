defmodule NewSequence do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    {:ok, _pid} = NewSequence.Supervisor.start_link(321)
  end
end
