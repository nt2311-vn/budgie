defmodule Budgie.TrackingTest do
  use Budgie.DataCase

  import Budgie.TrackingFixtures

  alias Budgie.Tracking

  describe "budgets" do
    alias Budgie.Tracking.Budget

    test "create_budget/1 with valid data creates budgets" do
      user = Budgie.AccountsFixtures.user_fixture()

      valid_attrs = valid_budget_attributes(%{creator_id: user.id})

      assert({:ok, %Budget{} = budget} = Tracking.create_budget(valid_attrs))
      assert(budget.name == "some name")
      assert(budget.description == "some description")
      assert(budget.start_date == ~D[2025-01-01])
      assert(budget.end_date == ~D[2025-01-31])
      assert(budget.creator_id == user.id)
    end

    test "create_budget/1 requires name" do
      user = Budgie.AccountsFixtures.user_fixture()

      attrs_without_name = %{
        description: "some description",
        start_date: ~D[2025-01-01],
        end_date: ~D[2025-03-31],
        creator_id: user.id
      }

      assert({:error, %Ecto.Changeset{} = changeset} = Tracking.create_budget(attrs_without_name))

      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_budget/1 end before start" do
      user = Budgie.AccountsFixtures.user_fixture()

      attrs_end_before_start = %{
        name: "some name",
        description: "some description",
        start_date: ~D[2025-12-01],
        end_date: ~D[2025-03-31],
        creator_id: user.id
      }

      assert(
        {:error, %Ecto.Changeset{} = changeset} =
          Tracking.create_budget(attrs_end_before_start)
      )

      assert changeset.valid? == false

      assert %{end_date: ["must end after start date"]} = errors_on(changeset)
    end
  end
end
