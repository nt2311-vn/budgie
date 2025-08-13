defmodule BudgieWeb.CreateBudgetDialog do
  use BudgieWeb, :live_component

  alias Budgie.Tracking
  alias Budgie.Tracking.Budget

  @impl true
  def update(assigns, socket) do
    changeset = Tracking.change_budget(%Budget{})

    socket =
      socket
      |> assign(assigns)
      |> assign(form: to_form(changeset))

    {:ok, socket}
  end
end
