defmodule LostFound.ONLINE_REPORTSTest do
  use LostFound.DataCase

  alias LostFound.ONLINE_REPORTS

  describe "online_reports" do
    alias LostFound.ONLINE_REPORTS.Online_report

    import LostFound.ONLINE_REPORTSFixtures

    @invalid_attrs %{description: nil, phone: nil}

    test "list_online_reports/0 returns all online_reports" do
      online_report = online_report_fixture()
      assert ONLINE_REPORTS.list_online_reports() == [online_report]
    end

    test "get_online_report!/1 returns the online_report with given id" do
      online_report = online_report_fixture()
      assert ONLINE_REPORTS.get_online_report!(online_report.id) == online_report
    end

    test "create_online_report/1 with valid data creates a online_report" do
      valid_attrs = %{description: "some description", phone: "some phone"}

      assert {:ok, %Online_report{} = online_report} = ONLINE_REPORTS.create_online_report(valid_attrs)
      assert online_report.description == "some description"
      assert online_report.phone == "some phone"
    end

    test "create_online_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ONLINE_REPORTS.create_online_report(@invalid_attrs)
    end

    test "update_online_report/2 with valid data updates the online_report" do
      online_report = online_report_fixture()
      update_attrs = %{description: "some updated description", phone: "some updated phone"}

      assert {:ok, %Online_report{} = online_report} = ONLINE_REPORTS.update_online_report(online_report, update_attrs)
      assert online_report.description == "some updated description"
      assert online_report.phone == "some updated phone"
    end

    test "update_online_report/2 with invalid data returns error changeset" do
      online_report = online_report_fixture()
      assert {:error, %Ecto.Changeset{}} = ONLINE_REPORTS.update_online_report(online_report, @invalid_attrs)
      assert online_report == ONLINE_REPORTS.get_online_report!(online_report.id)
    end

    test "delete_online_report/1 deletes the online_report" do
      online_report = online_report_fixture()
      assert {:ok, %Online_report{}} = ONLINE_REPORTS.delete_online_report(online_report)
      assert_raise Ecto.NoResultsError, fn -> ONLINE_REPORTS.get_online_report!(online_report.id) end
    end

    test "change_online_report/1 returns a online_report changeset" do
      online_report = online_report_fixture()
      assert %Ecto.Changeset{} = ONLINE_REPORTS.change_online_report(online_report)
    end
  end
end
