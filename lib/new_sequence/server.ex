defmodule NewSequence.Server do
  use GenServer

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def init(stash_pid) do
    current_number = NewSequence.Stash.get stash_pid
    {:ok, {current_number, stash_pid}}
  end
  def next_number() do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  def handle_call(:next_number, _from, { current_number, stash_pid} ) do
    { :reply, current_number, { current_number + 1, stash_pid} }
  end

  def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
    { :noreply, {current_number + delta, stash_pid}}
  end

  def terminate(_reason, {current_number, stash_pid}) do
    NewSequence.Stash.set stash_pid, current_number
  end
end
