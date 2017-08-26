defmodule NewSequence.SequenceSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def init(stash_pid) do
    child_process = [ worker(NewSequence.Server, [stash_pid]) ]
    supervise child_process, strategy: :one_for_one

  end
end
