defmodule LostFound.SUB_CATEGORIES do
  @moduledoc """
  The SUB_CATEGORIES context.
  """

  import Ecto.Query, warn: false
  alias LostFound.Repo

  alias LostFound.SUB_CATEGORIES.Sub_category

  @doc """
  Returns the list of sub_categories.

  ## Examples

      iex> list_sub_categories()
      [%Sub_category{}, ...]

  """
  def list_sub_categories do
    Repo.all(Sub_category)
  end

  @doc """
  Gets a single sub_category.

  Raises `Ecto.NoResultsError` if the Sub category does not exist.

  ## Examples

      iex> get_sub_category!(123)
      %Sub_category{}

      iex> get_sub_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sub_category!(id), do: Repo.get!(Sub_category, id)

  @doc """
  Creates a sub_category.

  ## Examples

      iex> create_sub_category(%{field: value})
      {:ok, %Sub_category{}}

      iex> create_sub_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_category(attrs \\ %{}) do
    %Sub_category{}
    |> Sub_category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sub_category.

  ## Examples

      iex> update_sub_category(sub_category, %{field: new_value})
      {:ok, %Sub_category{}}

      iex> update_sub_category(sub_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sub_category(%Sub_category{} = sub_category, attrs) do
    sub_category
    |> Sub_category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sub_category.

  ## Examples

      iex> delete_sub_category(sub_category)
      {:ok, %Sub_category{}}

      iex> delete_sub_category(sub_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sub_category(%Sub_category{} = sub_category) do
    Repo.delete(sub_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sub_category changes.

  ## Examples

      iex> change_sub_category(sub_category)
      %Ecto.Changeset{data: %Sub_category{}}

  """
  def change_sub_category(%Sub_category{} = sub_category, attrs \\ %{}) do
    Sub_category.changeset(sub_category, attrs)
  end
end
