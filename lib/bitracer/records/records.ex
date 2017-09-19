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

  def get_horse_by_name(name), do: Repo.get_by(Horse, name: name)

  def get_horse_by_name!(name), do: Repo.get_by!(Horse, name: name)

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

  alias Bitracer.Records.Bet

  @doc """
  Returns the list of bets.

  ## Examples

      iex> list_bets()
      [%Bet{}, ...]

  """
  def list_bets do
    Repo.all(Bet)
  end

  @doc """
  Gets a single bet.

  Raises `Ecto.NoResultsError` if the Bet does not exist.

  ## Examples

      iex> get_bet!(123)
      %Bet{}

      iex> get_bet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bet!(id), do: Repo.get!(Bet, id)

  @doc """
  Creates a bet.

  ## Examples

      iex> create_bet(%{field: value})
      {:ok, %Bet{}}

      iex> create_bet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bet(user, horse, attrs \\ %{}) do
    %Bet{user: user, horse: horse}
    |> Bet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bet.

  ## Examples

      iex> update_bet(bet, %{field: new_value})
      {:ok, %Bet{}}

      iex> update_bet(bet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bet(%Bet{} = bet, attrs) do
    bet
    |> Bet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bet.

  ## Examples

      iex> delete_bet(bet)
      {:ok, %Bet{}}

      iex> delete_bet(bet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bet(%Bet{} = bet) do
    Repo.delete(bet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bet changes.

  ## Examples

      iex> change_bet(bet)
      %Ecto.Changeset{source: %Bet{}}

  """
  def change_bet(%Bet{} = bet) do
    Bet.changeset(bet, %{})
  end
end
