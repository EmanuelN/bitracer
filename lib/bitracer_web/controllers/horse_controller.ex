defmodule BitracerWeb.HorseController do
  use BitracerWeb, :controller

  alias Bitracer.Records
  alias Bitracer.Records.Horse

  def index(conn, _params) do
    horses = Records.list_horses()
    render(conn, "index.html", horses: horses)
  end

  def new(conn, _params) do
    changeset = Records.change_horse(%Horse{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"horse" => horse_params}) do
    case Records.create_horse(horse_params) do
      {:ok, horse} ->
        conn
        |> put_flash(:info, "Horse created successfully.")
        |> redirect(to: horse_path(conn, :show, horse))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    horse = Records.get_horse!(id)
    render(conn, "show.html", horse: horse)
  end

  def edit(conn, %{"id" => id}) do
    horse = Records.get_horse!(id)
    changeset = Records.change_horse(horse)
    render(conn, "edit.html", horse: horse, changeset: changeset)
  end

  def update(conn, %{"id" => id, "horse" => horse_params}) do
    horse = Records.get_horse!(id)

    case Records.update_horse(horse, horse_params) do
      {:ok, horse} ->
        conn
        |> put_flash(:info, "Horse updated successfully.")
        |> redirect(to: horse_path(conn, :show, horse))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", horse: horse, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    horse = Records.get_horse!(id)
    {:ok, _horse} = Records.delete_horse(horse)

    conn
    |> put_flash(:info, "Horse deleted successfully.")
    |> redirect(to: horse_path(conn, :index))
  end
end
