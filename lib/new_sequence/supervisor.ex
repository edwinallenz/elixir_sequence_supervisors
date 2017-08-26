defmodule NewSequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_number], name: __MODULE__)
    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    {:ok, stash} = Supervisor.start_child(sup, worker(NewSequence.Stash, [initial_number]))
    Supervisor.start_child(sup, supervisor(NewSequence.SequenceSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
