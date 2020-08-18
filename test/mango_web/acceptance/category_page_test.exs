defmodule MangoWeb.Acceptance.CategoryPageTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    alias Mango.Repo
    alias Mango.Catalog.Product

    Repo.insert(%Product{
      name: "Tomato",
      price: 55,
      sku: "A123",
      is_seasonal: false,
      category: "vegetables"
    })

    Repo.insert(%Product{
      name: "Apple",
      price: 75,
      sku: "B232",
      is_seasonal: true,
      category: "fruits"
    })

    :ok
  end

  test "show fruits" do
    navigate_to("/categories/fruits")
    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Fruits"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()

    assert product_name == "Apple"
    assert product_price == "75"

    refute page_source() =~ "Tomato"
  end

  test "show vegetables" do
    navigate_to("/categories/vegetables")
    page_title = find_element(:css, ".page-title") |> visible_text()
    assert page_title == "Vegetables"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text()
    product_price = find_within_element(product, :css, ".product-price") |> visible_text()
    assert product_name == "Tomato"
    assert product_price == "55"

    refute page_source =~ "Apple"
  end
end
