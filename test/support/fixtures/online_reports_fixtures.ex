defmodule LostFound.ONLINE_REPORTSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LostFound.ONLINE_REPORTS` context.
  """

  @doc """
  Generate a online_report.
  """
  def online_report_fixture(attrs \\ %{}) do
    {:ok, online_report} =
      attrs
      |> Enum.into(%{
        description: "some description",
        phone: "some phone"
      })
      |> LostFound.ONLINE_REPORTS.create_online_report()

    online_report
  end
end
