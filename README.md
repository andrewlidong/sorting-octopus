# Sorting Octopus for Recurse Center

A fun, interactive chatbot that sorts Recurse Center students into Hogwarts houses based on their programming interests and personality traits.

**Live Demo:** [https://sorting-octopus.fly.dev](https://sorting-octopus.fly.dev)

![Sorting Octopus](https://github.com/andrewlidong/sorting-octopus/raw/main/priv/static/images/sorting-octopus-screenshot.png)

## About

The Sorting Octopus is a modern take on the Hogwarts Sorting Hat, designed specifically for programmers at the Recurse Center. During a 60-second conversation, the Octopus analyzes your responses to determine which programming house best matches your style and approach:

- **Gryffindor**: For the brave who tackle challenging problems and new technologies
- **Ravenclaw**: For the intellectually curious who value learning and knowledge
- **Hufflepuff**: For the team players who value collaboration and community
- **Slytherin**: For the ambitious who strive for excellence and achievement

## Features

- Interactive chat interface with a 60-second timer
- Dynamic conversation with the Sorting Octopus
- Keyword analysis to determine your dominant traits
- Custom house descriptions tailored to the Recurse Center context
- Responsive design with modern UI elements
- CSRF protection for secure form submissions

## Technology Stack

- **Backend**: Elixir with Phoenix Framework
- **Frontend**: HTML, CSS, JavaScript
- **Styling**: Custom CSS with Poppins font
- **Deployment**: Fly.io

## Getting Started

### Prerequisites

- Elixir 1.14 or later
- Phoenix Framework 1.7 or later
- Mix (Elixir's build tool)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/andrewlidong/sorting-octopus.git
   cd sorting-octopus
   ```

2. Install dependencies:
   ```
   mix deps.get
   ```

3. Start the Phoenix server:
   ```
   mix phx.server
   ```

4. Visit [`localhost:4000`](http://localhost:4000) in your browser

## Deployment

The app is deployed on Fly.io. To deploy your own instance:

1. Install the Fly.io CLI:
   ```
   brew install flyctl
   ```

2. Log in to Fly.io:
   ```
   fly auth login
   ```

3. Create a new app:
   ```
   fly apps create your-app-name
   ```

4. Set up a secret key:
   ```
   fly secrets set SECRET_KEY_BASE=$(mix phx.gen.secret)
   ```

5. Deploy the app:
   ```
   fly deploy
   ```

## Development Process

This project was built as a fun way to welcome new Recurse Center participants. The development process included:

1. Setting up a basic Phoenix application
2. Creating the chat interface with JavaScript
3. Implementing the sorting algorithm based on keyword analysis
4. Adding a timer for the conversation
5. Styling the application with a modern UI
6. Deploying to Fly.io

For more details about the development process, check out the [blog post](https://github.com/andrewlidong/sorting-octopus/blob/main/BLOG.md).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the Sorting Hat from Harry Potter
- Created for the Recurse Center community
