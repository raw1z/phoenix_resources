defmodule PhoenixResources.CreateAction do
  use PhoenixResources.Utils

  def call(conn, model, attributes) do
    case model.create(attributes) do
      {:ok, resource} ->
        conn
        |> put_status(201)
        |> json model.serialize(resource)

      {:nok, errors} ->
        render_errors conn, errors
    end
  end
end
