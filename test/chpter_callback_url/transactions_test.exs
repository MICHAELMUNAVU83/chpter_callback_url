defmodule ChpterCallbackUrl.TransactionsTest do
  use ChpterCallbackUrl.DataCase

  alias ChpterCallbackUrl.Transactions

  describe "transactions" do
    alias ChpterCallbackUrl.Transactions.Transaction

    import ChpterCallbackUrl.TransactionsFixtures

    @invalid_attrs %{message: nil, status: nil, success: nil, amount: nil, transaction_code: nil, transaction_reference: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{message: "some message", status: 42, success: true, amount: "some amount", transaction_code: "some transaction_code", transaction_reference: "some transaction_reference"}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.message == "some message"
      assert transaction.status == 42
      assert transaction.success == true
      assert transaction.amount == "some amount"
      assert transaction.transaction_code == "some transaction_code"
      assert transaction.transaction_reference == "some transaction_reference"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{message: "some updated message", status: 43, success: false, amount: "some updated amount", transaction_code: "some updated transaction_code", transaction_reference: "some updated transaction_reference"}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.message == "some updated message"
      assert transaction.status == 43
      assert transaction.success == false
      assert transaction.amount == "some updated amount"
      assert transaction.transaction_code == "some updated transaction_code"
      assert transaction.transaction_reference == "some updated transaction_reference"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
