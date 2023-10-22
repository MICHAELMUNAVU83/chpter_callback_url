defmodule ChpterCallbackUrlWeb.TransactionView do
  use ChpterCallbackUrlWeb, :view
  alias ChpterCallbackUrlWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      message: transaction.message,
      success: transaction.success,
      status: transaction.status,
      amount: transaction.amount,
      transaction_code: transaction.transaction_code,
      transaction_reference: transaction.transaction_reference
    }
  end
end
