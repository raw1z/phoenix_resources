defmodule PhoenixResources.IndexAction do
  use PhoenixResources.Utils

  def call(conn, model, params) do
    case model.find(params) do
      {:ok, resources} ->
        conn
        |> json model.serialize(resources)

      {:nok, errors} ->
        render_errors conn, errors
    end
  end
end
