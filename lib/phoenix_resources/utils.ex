defmodule PhoenixResources.Utils do
  import Phoenix.Controller
  import Plug.Conn

  defmacro __using__(_opts) do
    quote do
      import PhoenixResources.Utils
      import Phoenix.Controller
      import Plug.Conn
    end
  end

  def format_params(params) do
    ignored_params = ["createdAt", "updatedAt", "format"]

    params
    |> Enum.filter(fn {k,_} -> Enum.find(ignored_params, &(&1 == k)) == nil end)
    |> format_map
  end

  defp format_map(map) do
    map
    |> Enum.map(fn {k,v} -> { Inflex.underscore(k) |> String.to_atom, v } end)
    |> Enum.map(fn {k,v} ->
      if is_map(v) do
        {k, format_map(v)}
      else
        {k,v}
      end
    end)
    |> Enum.into(%{})
  end

  def get_model(opts) do
    {module, _} = opts
    |> Keyword.get(:model)
    |> Code.eval_quoted

    model_name = "#{module}"
    |> String.split(".")
    |> List.last
    |> Inflex.parameterize("_")

    {module, model_name}
  end

  def head(conn, status) do
    conn
    |> put_status(status)
    |> put_resp_header("cache-control", "no-cache")
    |> put_resp_header("content-length", "0")
    |> json ""
  end

  def render_errors(conn, errors) do
    conn
    |> put_status(422)
    |> json %{errors: errors}
  end
end
