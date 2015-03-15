defmodule PhoenixResources.ShowAction do
  use PhoenixResources.Utils

  def call(conn, model, id) do
    case model.find(id) do
      {:ok, resource} ->
        conn
        |> json model.serialize(resource)

      {:nok, errors} ->
        render_errors conn, errors
    end
  end
end
