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

  @impl true
  def handle_event("validate", %{"budget" => params}, socket) do
    changeset =
      Tracking.change_budget(%Budget{}, params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("save", %{"budget" => params}, socket) do
    creator_id =
      case socket.assigns do
        %{current_user: %{} = user} -> user.id
        %{current_scope: %{user: %{} = user}} -> user.id
        _ -> nil
      end

    params = Map.put(params, "creator_id", creator_id)

    with {:ok, %Budget{} = budget} <- Tracking.create_budget(params) do
      socket =
        socket
        |> put_flash(:info, "Budget created")
        |> assign(form: to_form(Tracking.change_budget(%Budget{})))
        |> push_event("budget-created", %{budget_id: budget.id})

      {:noreply, socket}
    else
      {:error, changeset} -> {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
