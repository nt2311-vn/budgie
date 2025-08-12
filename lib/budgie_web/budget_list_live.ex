defmodule BudgieWeb.BudgetListLive do
  use BudgieWeb, :live_view

  alias Budgie.Tracking

  def mount(_params, _session, socket) do
    budgets = Tracking.list_budgets()
    socket = assign(socket, budgets: budgets)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <ul>
      <li :for={budget <- @budgets}>
        {budget.name}
      </li>
    </ul>
    """
  end
end
