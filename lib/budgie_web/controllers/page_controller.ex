defmodule BudgieWeb.PageController do
  use BudgieWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
