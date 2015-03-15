defmodule PhoenixResources.UpdateAction do
  use PhoenixResources.Utils

  def call(conn, model, id, attributes) do
    case model.find(id) do
      {:ok, resource} ->
        case model.update(resource, attributes) do
          {:ok, _} ->
            head conn, 204

          {:nok, errors} ->
            render_errors conn, errors
        end

      {:nok, errors} ->
        render_errors conn, errors
    end
  end
end
