defmodule Budgie.TrackingTest do
  use Budgie.DataCase

  alias Budgie.Tracking

  describe "budgets" do
    alias Budgie.Tracking.Budget

    test "create_budget/1 with valid data creates budgets" do
      user = Budgie.AccountsFixtures.user_fixture()

      valid_attrs = %{
        name: "some name",
        description: "some description",
        start_date: ~D[2025-01-01],
        end_date: ~D[2025-03-31],
        creator_id: user.id
      }

      assert({:ok, %Budget{} = budget} = Tracking.create_budget(valid_attrs))
      assert(budget.name == "some name")
      assert(budget.description == "some description")
      assert(budget.start_date == ~D[2025-01-01])
      assert(budget.end_date == ~D[2025-03-31])
      assert(budget.creator_id == user.id)
    end
  end
end
