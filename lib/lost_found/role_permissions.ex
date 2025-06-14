defmodule LostFound.ROLE_PERMISSIONS do
  @moduledoc """
  The ROLE_PERMISSIONS context.
  """

  import Ecto.Query, warn: false
  alias LostFound.Repo

  alias LostFound.ROLE_PERMISSIONS.Role_permission

  @doc """
    USER DEFINED FUNCTIONS
  """
  def get_by_role_id(role_id) do
    query = from r in Role_permission, where: r.role_id == ^role_id
    Repo.one(query)
  end

  @doc """
  Returns the list of role_permissions.

  ## Examples

      iex> list_role_permissions()
      [%Role_permission{}, ...]

  """
  def list_role_permissions do
    Repo.all(Role_permission)
  end

  @doc """
  Gets a single role_permission.

  Raises `Ecto.NoResultsError` if the Role permission does not exist.

  ## Examples

      iex> get_role_permission!(123)
      %Role_permission{}

      iex> get_role_permission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role_permission!(id), do: Repo.get!(Role_permission, id)

  @doc """
  Creates a role_permission.

  ## Examples

      iex> create_role_permission(%{field: value})
      {:ok, %Role_permission{}}

      iex> create_role_permission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role_permission(attrs \\ %{}) do
    %Role_permission{}
    |> Role_permission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role_permission.

  ## Examples

      iex> update_role_permission(role_permission, %{field: new_value})
      {:ok, %Role_permission{}}

      iex> update_role_permission(role_permission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role_permission(%Role_permission{} = role_permission, attrs) do
    role_permission
    |> Role_permission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role_permission.

  ## Examples

      iex> delete_role_permission(role_permission)
      {:ok, %Role_permission{}}

      iex> delete_role_permission(role_permission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role_permission(%Role_permission{} = role_permission) do
    Repo.delete(role_permission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role_permission changes.

  ## Examples

      iex> change_role_permission(role_permission)
      %Ecto.Changeset{data: %Role_permission{}}

  """
  def change_role_permission(%Role_permission{} = role_permission, attrs \\ %{}) do
    Role_permission.changeset(role_permission, attrs)
  end
end
