defmodule LostFound.ONLINE_REPORTS do
  @moduledoc """
  The ONLINE_REPORTS context.
  """

  import Ecto.Query, warn: false
  alias LostFound.Repo

  alias LostFound.ONLINE_REPORTS.Online_report

  @doc """
  Returns the list of online_reports.

  ## Examples

      iex> list_online_reports()
      [%Online_report{}, ...]

  """
  def list_online_reports do
    Repo.all(Online_report)
  end

  @doc """
  Gets a single online_report.

  Raises `Ecto.NoResultsError` if the Online report does not exist.

  ## Examples

      iex> get_online_report!(123)
      %Online_report{}

      iex> get_online_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_online_report!(id), do: Repo.get!(Online_report, id)

  @doc """
  Creates a online_report.

  ## Examples

      iex> create_online_report(%{field: value})
      {:ok, %Online_report{}}

      iex> create_online_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_online_report(attrs \\ %{}) do
    %Online_report{}
    |> Online_report.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a online_report.

  ## Examples

      iex> update_online_report(online_report, %{field: new_value})
      {:ok, %Online_report{}}

      iex> update_online_report(online_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_online_report(%Online_report{} = online_report, attrs) do
    online_report
    |> Online_report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a online_report.

  ## Examples

      iex> delete_online_report(online_report)
      {:ok, %Online_report{}}

      iex> delete_online_report(online_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_online_report(%Online_report{} = online_report) do
    Repo.delete(online_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking online_report changes.

  ## Examples

      iex> change_online_report(online_report)
      %Ecto.Changeset{data: %Online_report{}}

  """
  def change_online_report(%Online_report{} = online_report, attrs \\ %{}) do
    Online_report.changeset(online_report, attrs)
  end
end
