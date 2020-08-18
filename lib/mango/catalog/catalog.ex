defmodule Mango.Catalog do
  alias Mango.Catalog.Product
  alias Mango.Repo

  def list_products do
    Product
    |> Repo.all()
  end

  def list_seasonal_products do
    list_products()
    |> Enum.filter(fn product -> product.is_seasonal end)
  end

  def get_category_products(product_category) do
    list_products()
    |> Enum.filter(fn product -> product.category == product_category end)
  end
end
