defmodule JITJerkyWeb.Router do
  use JITJerkyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {JITJerkyWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JITJerkyWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit

    live "/users/:id", UserLive.Show, :show
    live "/users/:id/show/edit", UserLive.Show, :edit

    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit
  end

  scope "/billing", JITJerkyWeb.Billing, as: :billing do
    pipe_through :browser

    live "/addresses", AddressLive.Index, :index
    live "/addresses/new", AddressLive.Index, :new
    live "/addresses/:id/edit", AddressLive.Index, :edit

    live "/addresses/:id", AddressLive.Show, :show
    live "/addresses/:id/show/edit", AddressLive.Show, :edit

    live "/payment_methods", PaymentMethodLive.Index, :index
    live "/payment_methods/new", PaymentMethodLive.Index, :new
    live "/payment_methods/:id/edit", PaymentMethodLive.Index, :edit

    live "/payment_methods/:id", PaymentMethodLive.Show, :show
    live "/payment_methods/:id/show/edit", PaymentMethodLive.Show, :edit
  end

  scope "/shipping", JITJerkyWeb.Shipping, as: :shipping do
    pipe_through :browser

    live "/addresses", AddressLive.Index, :index
    live "/addresses/new", AddressLive.Index, :new
    live "/addresses/:id/edit", AddressLive.Index, :edit

    live "/addresses/:id", AddressLive.Show, :show
    live "/addresses/:id/show/edit", AddressLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", JITJerkyWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: JITJerkyWeb.Telemetry
    end
  end
end
