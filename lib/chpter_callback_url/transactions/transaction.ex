defmodule ChpterCallbackUrl.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :message, :string
    field :status, :integer
    field :success, :boolean, default: false
    field :amount, :string
    field :transaction_code, :string
    field :transaction_reference, :string

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [
      :message,
      :success,
      :status,
      :amount,
      :transaction_code,
      :transaction_reference
    ])
    |> validate_required([:success, :status, :transaction_reference])
  end
end
