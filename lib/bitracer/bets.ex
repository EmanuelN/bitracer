defmodule Bitracer.Bets do
  use GenServer

  # Client API

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end

  def read(pid) do
    GenServer.call(pid, {:read})
  end

  def add(pid, item) do
    GenServer.cast(pid, {:add, item})
  end

  # Server Callbacks

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:read}, from, list) do
    {:reply, list, list}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end

end