defmodule PhoenixResources.DeleteAction do
  use PhoenixResources.Utils

  def call(conn, model, id) do
    case model.find(id) do
      {:ok, note} ->
        case model.delete(note) do
          :ok ->
            head conn, 204

          {:nok, errors} ->
            render_errors conn, errors
        end

      {:nok, errors} ->
        render_errors conn, errors
    end
  end
end
