defmodule JITJerkyWeb.Shipping.AddressLive.FormComponent do
  use JITJerkyWeb, :live_component

  alias JITJerky.Shipping

  @impl true
  def update(%{address: address} = assigns, socket) do
    changeset = Shipping.change_address(address)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"address" => address_params}, socket) do
    changeset =
      socket.assigns.address
      |> Shipping.change_address(address_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"address" => address_params}, socket) do
    save_address(socket, socket.assigns.action, address_params)
  end

  defp save_address(socket, :edit, address_params) do
    case Shipping.update_address(socket.assigns.address, address_params) do
      {:ok, _address} ->
        {:noreply,
         socket
         |> put_flash(:info, "Address updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_address(socket, :new, address_params) do
    case Shipping.create_address(address_params) do
      {:ok, _address} ->
        {:noreply,
         socket
         |> put_flash(:info, "Address created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
