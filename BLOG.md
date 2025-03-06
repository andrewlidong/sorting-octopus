# Building the Sorting Octopus: A Fun Chatbot for Recurse Center

## Introduction

When I joined the Recurse Center, I wanted to create something fun that would help new participants feel welcome and part of the community. Inspired by the Sorting Hat from Harry Potter, I built the "Sorting Octopus" - an interactive chatbot that sorts users into programming houses based on their conversation.

In this blog post, I'll walk through the development process, challenges faced, and lessons learned while building this application.

## The Concept

The Sorting Octopus is a modern take on the Hogwarts Sorting Hat, reimagined for programmers and the Recurse Center community. The concept is simple:

1. Users engage in a 60-second conversation with the Sorting Octopus
2. The chatbot asks questions about their programming interests and approaches
3. Behind the scenes, the application analyzes their responses for keywords associated with different traits
4. After the timer expires, users are sorted into one of four houses that best matches their dominant trait

The houses are based on the Hogwarts houses but reinterpreted for the programming context:

- **Gryffindor**: For brave programmers who tackle challenging problems and new technologies
- **Ravenclaw**: For intellectually curious programmers who value learning and knowledge
- **Hufflepuff**: For team players who value collaboration and community
- **Slytherin**: For ambitious programmers who strive for excellence and achievement

## Technology Stack

For this project, I chose:

- **Elixir with Phoenix Framework**: For its reliability, scalability, and real-time capabilities
- **Vanilla JavaScript**: For the interactive chat interface and timer
- **Custom CSS**: For a modern, responsive design

I specifically chose Elixir and Phoenix because:

1. I wanted to learn a functional programming language
2. Phoenix's real-time capabilities via channels would be useful for future enhancements
3. Elixir's concurrency model makes it perfect for handling multiple chat sessions

## Development Process

### 1. Setting Up the Phoenix Application

I started by creating a new Phoenix application without LiveView, as I wanted to keep things simple for this first version:

```bash
mix phx.new sorting_hat --no-live
```

After setting up the basic structure, I modified the router to handle our main routes:

```elixir
scope "/", SortingHatWeb do
  pipe_through :browser

  get "/", PageController, :index
  post "/sort", PageController, :sort
end
```

### 2. Creating the Chat Interface

The chat interface was built using HTML, CSS, and JavaScript. The key components included:

- A chat container with messages area
- A user input field
- A countdown timer
- An octopus avatar (🐙) for the chatbot

The JavaScript code handles:
- Displaying the timer countdown
- Capturing user input
- Displaying bot responses
- Analyzing messages for trait keywords
- Submitting the form when the timer expires

One of the interesting parts was implementing the typing indicator to make the chatbot feel more natural:

```javascript
function showTypingIndicator() {
  const typingIndicator = document.createElement('div');
  typingIndicator.className = 'typing-indicator';
  typingIndicator.innerHTML = '<span></span><span></span><span></span>';
  chatMessages.appendChild(typingIndicator);
  chatMessages.scrollTop = chatMessages.scrollHeight;
  return typingIndicator;
}
```

### 3. Implementing the Sorting Algorithm

The sorting algorithm is the heart of the application. It works by:

1. Defining keyword lists for each trait
2. Counting occurrences of these keywords in user messages
3. Determining the dominant trait based on the highest count

```javascript
const traitKeywords = {
  bravery: ['challenge', 'brave', 'courage', 'risk', 'adventure', 'bold', 'daring', 'fearless'],
  intelligence: ['learn', 'knowledge', 'curious', 'problem', 'think', 'analyze', 'understand', 'study'],
  loyalty: ['team', 'help', 'friend', 'community', 'support', 'together', 'collaborate', 'share'],
  ambition: ['goal', 'achieve', 'lead', 'success', 'ambitious', 'determined', 'win', 'excel']
};

function analyzeMessage(message) {
  const lowerMessage = message.toLowerCase();
  
  for (const [trait, keywords] of Object.entries(traitKeywords)) {
    for (const keyword of keywords) {
      if (lowerMessage.includes(keyword)) {
        traitCounts[trait]++;
      }
    }
  }
}
```

### 4. Adding the Timer

The 60-second timer creates a sense of urgency and makes the experience more engaging. It's implemented using JavaScript's `setInterval`:

```javascript
let timeLeft = 60;
const timerElement = document.getElementById('timer');

const timerInterval = setInterval(() => {
  timeLeft--;
  timerElement.textContent = timeLeft;
  
  if (timeLeft <= 0) {
    clearInterval(timerInterval);
    endConversation();
  }
}, 1000);
```

### 5. Styling the Application

For the UI, I wanted something modern and engaging. I used:

- The Poppins font for a clean, contemporary look
- A gradient background to create visual interest
- Card-based design for the chat interface
- Subtle animations for the typing indicator and messages
- Responsive design to work well on mobile devices

### 6. Adding CSRF Protection

Security is important even for fun applications. I implemented CSRF protection using Phoenix's built-in mechanisms:

```elixir
<input type="hidden" name="_csrf_token" value={Plug.CSRFProtection.get_csrf_token()} />
```

### 7. Deploying to Fly.io

For deployment, I chose Fly.io for its simplicity and free tier. The deployment process involved:

1. Creating a `fly.toml` configuration file
2. Setting up a Dockerfile for the application
3. Configuring environment variables
4. Deploying with `fly deploy`

## Challenges and Solutions

### Challenge 1: Port Configuration

One of the initial deployment challenges was getting the application to listen on the correct port. The error message was:

```
WARNING The app is not listening on the expected address and will not be reachable by fly-proxy.
You can fix this by configuring your app to listen on the following addresses:
  - 0.0.0.0:8080
```

**Solution**: I updated the configuration in `config/prod.exs` and `config/runtime.exs` to explicitly bind to `0.0.0.0:8080` and set the `PORT` environment variable in the Dockerfile.

### Challenge 2: Elixir Version Compatibility

Initially, I specified Elixir 1.18.3 in the Dockerfile, but this version wasn't available in the Docker registry.

**Solution**: I updated the Dockerfile to use a verified version:

```dockerfile
FROM hexpm/elixir:1.14.4-erlang-25.3-debian-bullseye-20230227 as build
```

### Challenge 3: CSRF Protection

Early testing revealed issues with CSRF protection when submitting the form.

**Solution**: I added a hidden CSRF token field to the form and ensured it was properly validated on submission.

## Future Enhancements

There are several ways I plan to enhance the Sorting Octopus in the future:

1. **More sophisticated language analysis**: Using NLP to better understand user responses
2. **Personalized house descriptions**: Tailoring the descriptions based on specific keywords used
3. **Multi-language support**: Making the Sorting Octopus accessible to non-English speakers
4. **User accounts**: Allowing users to save their results and compare with friends
5. **Real-time chat with Phoenix Channels**: Upgrading to a true real-time experience

## Lessons Learned

Building the Sorting Octopus taught me several valuable lessons:

1. **Start simple**: Beginning with a basic version allowed me to iterate quickly
2. **Focus on user experience**: The chat interface and timer make the application engaging
3. **Deployment configuration matters**: Small details in configuration files can make a big difference
4. **Security is always important**: Even for fun projects, implementing proper security measures is essential
5. **Elixir and Phoenix are powerful**: The framework made it easy to build a robust application quickly

## Conclusion

The Sorting Octopus was a fun project that combines programming with community building. It showcases how a relatively simple application can create an engaging experience when thoughtfully designed.

I hope this blog post inspires you to build your own fun projects and experiment with new technologies. If you'd like to try the Sorting Octopus yourself, visit [https://sorting-octopus.fly.dev](https://sorting-octopus.fly.dev) or check out the [GitHub repository](https://github.com/andrewlidong/sorting-octopus) to see the code.

Happy coding, and may the Sorting Octopus place you in the perfect programming house! 