defmodule Bitracer.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false
  alias Bitracer.Repo

  alias Bitracer.Records.Horse

  @doc """
  Returns the list of horses.

  ## Examples

      iex> list_horses()
      [%Horse{}, ...]

  """
  def list_horses do
    Repo.all(Horse)
  end

  @doc """
  Gets a single horse.

  Raises `Ecto.NoResultsError` if the Horse does not exist.

  ## Examples

      iex> get_horse!(123)
      %Horse{}

      iex> get_horse!(456)
      ** (Ecto.NoResultsError)

  """
  def get_horse!(id), do: Repo.get!(Horse, id)

  @doc """
  Creates a horse.

  ## Examples

      iex> create_horse(%{field: value})
      {:ok, %Horse{}}

      iex> create_horse(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_horse(attrs \\ %{}) do
    %Horse{}
    |> Horse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a horse.

  ## Examples

      iex> update_horse(horse, %{field: new_value})
      {:ok, %Horse{}}

      iex> update_horse(horse, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_horse(%Horse{} = horse, attrs) do
    horse
    |> Horse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Horse.

  ## Examples

      iex> delete_horse(horse)
      {:ok, %Horse{}}

      iex> delete_horse(horse)
      {:error, %Ecto.Changeset{}}

  """
  def delete_horse(%Horse{} = horse) do
    Repo.delete(horse)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking horse changes.

  ## Examples

      iex> change_horse(horse)
      %Ecto.Changeset{source: %Horse{}}

  """
  def change_horse(%Horse{} = horse) do
    Horse.changeset(horse, %{})
  end
end
