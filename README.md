# Task Manager

Task Manager is a web application built with the Phoenix framework in Elixir. It allows users to manage tasks, including creating, updating, and deleting them. The application includes features such as user authentication and session management.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Features](#features)
<!-- - [Contributing](#contributing) -->
<!-- - [License](#license) -->

## Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/[yourusername]/task_manager.git
   cd task_manager

2. **Install dependencies:**
   Ensure you have Elixir and Phoenix installed, then run:
   ```sh
   mix deps.get

3. **Set up the database:**
   ```sh
   mix ecto.setup

4. **Start the Phoenix server:**
   ```sh
   mix phx.server
   The server will be available at http://localhost:4000.

## Configuration

- ### Environment Variables

- Ensure you configure your environment variables for database connections and other settings in the `config/` directory.

## Usage

- ### Registration and Login

- Users can register and log in to manage their tasks.

- ### Task Management

- Users can create, update, and delete tasks.

- ### Session Management

- The application includes session management to track user logins.

## Features

- **User authentication and authorization**
- **Task CRUD operations**
- **Responsive design**
- **Session management**

<!-- ## Contributing

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes with clear and descriptive messages.
4. Push your changes to the branch.
5. Submit a pull request. -->