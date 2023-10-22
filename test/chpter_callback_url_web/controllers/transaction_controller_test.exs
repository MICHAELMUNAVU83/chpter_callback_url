defmodule ChpterCallbackUrlWeb.TransactionControllerTest do
  use ChpterCallbackUrlWeb.ConnCase

  import ChpterCallbackUrl.TransactionsFixtures

  alias ChpterCallbackUrl.Transactions.Transaction

  @create_attrs %{
    message: "some message",
    status: 42,
    success: true,
    amount: "some amount",
    transaction_code: "some transaction_code",
    transaction_reference: "some transaction_reference"
  }
  @update_attrs %{
    message: "some updated message",
    status: 43,
    success: false,
    amount: "some updated amount",
    transaction_code: "some updated transaction_code",
    transaction_reference: "some updated transaction_reference"
  }
  @invalid_attrs %{message: nil, status: nil, success: nil, amount: nil, transaction_code: nil, transaction_reference: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some amount",
               "message" => "some message",
               "status" => 42,
               "success" => true,
               "transaction_code" => "some transaction_code",
               "transaction_reference" => "some transaction_reference"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{conn: conn, transaction: %Transaction{id: id} = transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some updated amount",
               "message" => "some updated message",
               "status" => 43,
               "success" => false,
               "transaction_code" => "some updated transaction_code",
               "transaction_reference" => "some updated transaction_reference"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, Routes.transaction_path(conn, :delete, transaction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.transaction_path(conn, :show, transaction))
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
