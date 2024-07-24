defmodule TaskManagerWeb.Router do
  use TaskManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TaskManagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TaskManagerWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Define a pipeline for authenticated requests
  # pipeline :authenticated do
  #   plug TaskManagerWeb.Auth
  #   plug TaskManagerWeb.Auth, :authenticate_user
  # end

  scope "/", TaskManagerWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    get "/todo/new", TodoController, :new
    get "/todos", TodoController, :index
    post "/todo", TodoController, :create
    put "/todo/:id/update", TodoController, :update
    delete "/todo/:id", TodoController, :delete

  end

  # Authenticated routes
  # scope "/auth", TaskManagerWeb do
  #   pipe_through [:browser, :authenticated]

  #   get "/todo/new", TodoController, :new
  #   get "/todos", TodoController, :index
  #   post "/todo", TodoController, :create
  #   put "/todo/:id/update", TodoController, :update
  #   delete "/todo/:id", TodoController, :delete
  # end


  # end
  # Other scopes may use custom stacks.
  # scope "/api", TaskManagerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:task_manager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TaskManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
