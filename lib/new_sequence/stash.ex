defmodule NewSequence.Stash do
  use GenServer

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def set(pid, new_number) do
    GenServer.cast(pid, {:save, new_number})
  end

  def handle_call(:get, _from, current_number) do
    { :reply, current_number, current_number}
  end

  def handle_cast({:save, new_number}, _current_number) do
    { :noreply, new_number}
  end
end
