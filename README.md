# Sorting Octopus for Recurse Center

A fun, interactive chatbot that sorts Recurse Center students into Hogwarts houses based on their programming interests and personality traits.

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

## Technology Stack

- **Backend**: Elixir with Phoenix Framework
- **Frontend**: HTML, CSS, JavaScript
- **Styling**: Custom CSS with Poppins font

## Getting Started

### Prerequisites

- Elixir 1.14 or later
- Phoenix Framework 1.7 or later
- Mix (Elixir's build tool)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/sorting-octopus.git
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

## How It Works

The Sorting Octopus analyzes your conversation for keywords associated with different traits:

- **Bravery** (Gryffindor): Words like "challenge," "courage," "risk," "adventure"
- **Intelligence** (Ravenclaw): Words like "learn," "knowledge," "curious," "problem"
- **Loyalty** (Hufflepuff): Words like "team," "help," "friend," "community"
- **Ambition** (Slytherin): Words like "goal," "achieve," "lead," "success"

After the 60-second conversation, you'll be sorted into the house that best matches your dominant trait.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by the Sorting Hat from Harry Potter
- Created for the Recurse Center community
