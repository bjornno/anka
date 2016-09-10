defmodule Anka.PageControllerTest do
  use Anka.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Anka"
  end
end
