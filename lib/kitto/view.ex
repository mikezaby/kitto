defmodule Kitto.View do
  @moduledoc """
  HTML rendering facility.

  This module defines functions to deal with EEx templates used to provide markup
  for the dashboards.

  ## Configuration Options
  * `templates_dir` - Where to look for templates, defaults to "dashboards".
  * `default_layout` - The layout in which to wrap dashboards, defaults to
  "layout" found in the `templates_dir`.
  """

  @templates_dir Application.get_env :kitto, :templates_dir, "dashboards"
  @default_layout Application.get_env :kitto, :default_layout, "layout"

  @doc """
  Returns the EEx compiled output of the layout with template specified
  """
  def render(template, bindings \\ []) do
    @default_layout
    |> path
    |> EEx.eval_file([template: render_template(template, bindings), assigns: bindings])
  end

  @doc """
  Returns the EEx compiled output of the template specified
  """
  def render_template(template, bindings \\ []) do
    template |> path |> EEx.eval_file(assigns: bindings)
  end

  @doc """
  Returns true if the given template exists in the templates directory
  """
  def exists?(template), do: template |> path |> File.exists?

  defp path(template), do: Path.join templates_path, "#{template}.html.eex"
  defp templates_path, do: Path.join Kitto.root, @templates_dir
end
