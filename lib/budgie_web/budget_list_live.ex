defmodule BudgieWeb.BudgetListLive do
  use BudgieWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    List the budgets here.
    """
  end
end
