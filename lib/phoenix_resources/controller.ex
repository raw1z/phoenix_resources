defmodule PhoenixResources.Controller do
  use PhoenixResources.Utils

  defmacro __using__(opts) do
    {model, model_name} = get_model(opts)

    quote do
      def index(conn, params) do
        PhoenixResources.IndexAction.call(conn, unquote(model), format_params(params))
      end

      def show(conn, %{"id" => id}) do
        PhoenixResources.ShowAction.call(conn, unquote(model), id)
      end

      def create(conn, %{unquote(model_name) => note_attributes}) do
        PhoenixResources.CreateAction.call(conn, unquote(model), format_params(note_attributes))
      end

      def update(conn, %{"id" => id, unquote(model_name) => note_attributes}) do
        PhoenixResources.UpdateAction.call(conn, unquote(model), id, format_params(note_attributes))
      end

      def delete(conn, %{"id" => id}) do
        PhoenixResources.DeleteAction.call(conn, unquote(model), id)
      end
    end
  end
end
