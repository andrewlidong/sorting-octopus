defmodule SortingHatWeb.PageController do
  use SortingHatWeb, :controller

  def index(conn, _params) do
    csrf_token = Plug.CSRFProtection.get_csrf_token()
    
    html = """
    <!DOCTYPE html>
    <html>
    <head>
      <title>Recurse Center Sorting Octopus</title>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
      <style>
        :root {
          --primary: #6366f1;
          --primary-dark: #4f46e5;
          --secondary: #06b6d4;
          --accent: #8b5cf6;
          --background: #f8fafc;
          --surface: #ffffff;
          --text: #334155;
          --text-light: #64748b;
          --success: #10b981;
          --error: #ef4444;
          --border: #e2e8f0;
        }
        
        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
        }
        
        body { 
          font-family: 'Poppins', sans-serif;
          max-width: 900px; 
          margin: 0 auto; 
          padding: 30px 20px;
          background-color: var(--background);
          color: var(--text);
          line-height: 1.6;
        }
        
        h1 {
          font-size: 2.5rem;
          margin-bottom: 0.5rem;
          color: var(--primary-dark);
          text-align: center;
        }
        
        p {
          margin-bottom: 1.5rem;
          text-align: center;
          color: var(--text-light);
        }
        
        .chat-container {
          background-color: var(--surface);
          border-radius: 12px;
          box-shadow: 0 4px 20px rgba(0,0,0,0.08);
          padding: 30px;
          margin-bottom: 30px;
          border: 1px solid var(--border);
        }
        
        .timer-container {
          text-align: center;
          margin-bottom: 20px;
          padding: 10px;
          background-color: rgba(99, 102, 241, 0.1);
          border-radius: 8px;
        }
        
        .timer {
          font-size: 1.5rem;
          font-weight: 600;
          color: var(--primary-dark);
        }
        
        .chat-header {
          display: flex;
          align-items: center;
          margin-bottom: 20px;
        }
        
        .octopus-avatar {
          width: 50px;
          height: 50px;
          background-color: var(--secondary);
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          margin-right: 15px;
          color: white;
          font-size: 24px;
        }
        
        .chat-title {
          font-size: 1.2rem;
          font-weight: 600;
        }
        
        .chat-subtitle {
          font-size: 0.9rem;
          color: var(--text-light);
        }
        
        .chat-messages {
          height: 350px;
          overflow-y: auto;
          margin-bottom: 20px;
          padding: 15px;
          border: 1px solid var(--border);
          border-radius: 8px;
          background-color: #f9fafc;
        }
        
        .message {
          margin-bottom: 15px;
          padding: 12px 16px;
          border-radius: 18px;
          max-width: 80%;
          word-wrap: break-word;
          position: relative;
          line-height: 1.5;
        }
        
        .bot-message {
          background-color: #e9f2ff;
          color: #1e3a8a;
          margin-right: auto;
          border-bottom-left-radius: 4px;
        }
        
        .user-message {
          background-color: var(--primary);
          color: white;
          margin-left: auto;
          border-bottom-right-radius: 4px;
        }
        
        .input-area {
          display: flex;
          gap: 12px;
          position: relative;
        }
        
        input[type="text"] {
          flex-grow: 1;
          padding: 14px 20px;
          border: 1px solid var(--border);
          border-radius: 8px;
          font-size: 1rem;
          font-family: inherit;
          transition: border-color 0.2s;
        }
        
        input[type="text"]:focus {
          outline: none;
          border-color: var(--primary);
          box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
        }
        
        button {
          padding: 12px 24px;
          background-color: var(--primary);
          color: white;
          border: none;
          border-radius: 8px;
          cursor: pointer;
          font-weight: 500;
          font-size: 1rem;
          font-family: inherit;
          transition: background-color 0.2s;
        }
        
        button:hover {
          background-color: var(--primary-dark);
        }
        
        .hidden {
          display: none;
        }
        
        .house-result {
          text-align: center;
          padding: 40px 30px;
          margin-top: 30px;
          border-radius: 12px;
          background-color: var(--surface);
          box-shadow: 0 4px 20px rgba(0,0,0,0.08);
          border: 1px solid var(--border);
        }
        
        .house-name {
          font-size: 2.5rem;
          font-weight: 700;
          margin: 20px 0;
          background: linear-gradient(90deg, #4f46e5, #8b5cf6);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .gryffindor { 
          background: linear-gradient(90deg, #740001, #ae0001);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .ravenclaw { 
          background: linear-gradient(90deg, #0e1a40, #222f5b);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .hufflepuff { 
          background: linear-gradient(90deg, #ecb939, #f0c75e);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .slytherin { 
          background: linear-gradient(90deg, #1a472a, #2a623d);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .typing-indicator {
          display: inline-block;
          padding: 10px 15px;
          background-color: #e9f2ff;
          border-radius: 18px;
          margin-bottom: 15px;
          color: #1e3a8a;
          border-bottom-left-radius: 4px;
        }
        
        .typing-indicator span {
          display: inline-block;
          width: 8px;
          height: 8px;
          background-color: #1e3a8a;
          border-radius: 50%;
          margin-right: 5px;
          animation: typing 1.4s infinite both;
        }
        
        .typing-indicator span:nth-child(2) {
          animation-delay: 0.2s;
        }
        
        .typing-indicator span:nth-child(3) {
          animation-delay: 0.4s;
        }
        
        @keyframes typing {
          0% { opacity: 0.4; transform: scale(0.8); }
          50% { opacity: 1; transform: scale(1); }
          100% { opacity: 0.4; transform: scale(0.8); }
        }
        
        @media (max-width: 768px) {
          body {
            padding: 20px 15px;
          }
          
          h1 {
            font-size: 2rem;
          }
          
          .chat-container {
            padding: 20px;
          }
          
          .message {
            max-width: 90%;
          }
        }
      </style>
    </head>
    <body>
      <h1>Recurse Center Sorting Octopus</h1>
      <p>Chat with the Sorting Octopus for 1 minute, and it will determine which house you belong to!</p>
      
      <div class="chat-container">
        <div class="timer-container">
          <div class="timer">Time remaining: <span id="countdown">60</span> seconds</div>
        </div>
        
        <div class="chat-header">
          <div class="octopus-avatar">🐙</div>
          <div>
            <div class="chat-title">Sorting Octopus</div>
            <div class="chat-subtitle">Online</div>
          </div>
        </div>
        
        <div class="chat-messages" id="chatMessages">
          <div class="message bot-message">Hello! I'm the Recurse Center Sorting Octopus. Tell me about yourself and your interests in programming!</div>
        </div>
        
        <div class="input-area">
          <input type="text" id="userInput" placeholder="Type your message here..." autocomplete="off">
          <button id="sendButton">Send</button>
        </div>
      </div>
      
      <div id="sortingResult" class="house-result hidden">
        <h2>The Sorting Octopus has decided!</h2>
        <p>Based on our conversation, I've determined that you belong in:</p>
        <div id="houseName" class="house-name"></div>
        <button id="restartButton">Chat Again</button>
      </div>

      <form id="sortForm" action="/sort" method="post" class="hidden">
        <input type="hidden" name="_csrf_token" value="#{csrf_token}">
        <input type="hidden" name="name" id="userName" value="">
        <input type="hidden" name="trait" id="userTrait" value="">
        <input type="hidden" name="action" id="userAction" value="">
      </form>
      
      <script>
        document.addEventListener('DOMContentLoaded', function() {
          const chatMessages = document.getElementById('chatMessages');
          const userInput = document.getElementById('userInput');
          const sendButton = document.getElementById('sendButton');
          const countdownElement = document.getElementById('countdown');
          const sortingResult = document.getElementById('sortingResult');
          const houseName = document.getElementById('houseName');
          const restartButton = document.getElementById('restartButton');
          const sortForm = document.getElementById('sortForm');
          const userNameField = document.getElementById('userName');
          const userTraitField = document.getElementById('userTrait');
          const userActionField = document.getElementById('userAction');
          
          let timeLeft = 60; // 1 minute
          let userName = '';
          let messages = [];
          let timer;
          let typingIndicator = null;
          
          // Bot responses
          const botResponses = [
            "That's interesting! What kind of projects are you working on?",
            "How do you approach learning new technologies?",
            "Do you prefer working on frontend or backend?",
            "What's your favorite programming language and why?",
            "How do you handle challenging coding problems?",
            "Do you enjoy pair programming?",
            "What's your approach to debugging?",
            "Are you more interested in building things or understanding how they work?",
            "Do you prefer working alone or in a team?",
            "What's your favorite part about programming?",
            "What are you hoping to learn during your time at Recurse Center?",
            "Have you contributed to any open source projects?",
            "What's a recent technical challenge you've overcome?",
            "Do you have any side projects you're passionate about?",
            "What's your learning style when it comes to programming?"
          ];
          
          // Start the timer
          timer = setInterval(function() {
            timeLeft--;
            countdownElement.textContent = timeLeft;
            
            if (timeLeft <= 0) {
              clearInterval(timer);
              analyzeConversation();
            }
          }, 1000);
          
          // Send message when button is clicked
          sendButton.addEventListener('click', sendMessage);
          
          // Send message when Enter key is pressed
          userInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
              sendMessage();
            }
          });
          
          // Restart button
          restartButton.addEventListener('click', function() {
            location.reload();
          });
          
          function sendMessage() {
            const message = userInput.value.trim();
            if (message === '') return;
            
            // Save the first message as the user's name
            if (userName === '') {
              if (message.toLowerCase().startsWith('my name is') || message.toLowerCase().startsWith('i am') || message.toLowerCase().startsWith("i'm")) {
                const nameParts = message.split(' ');
                userName = nameParts[nameParts.length - 1];
              } else {
                userName = message.split(' ')[0];
              }
              userNameField.value = userName;
            }
            
            // Add user message to chat
            addMessage(message, 'user');
            messages.push({ role: 'user', content: message });
            
            // Clear input
            userInput.value = '';
            
            // Show typing indicator
            showTypingIndicator();
            
            // Get bot response after a short delay
            setTimeout(function() {
              hideTypingIndicator();
              const botResponse = getBotResponse();
              addMessage(botResponse, 'bot');
              messages.push({ role: 'bot', content: botResponse });
            }, 1500);
          }
          
          function addMessage(message, sender) {
            const messageElement = document.createElement('div');
            messageElement.classList.add('message');
            messageElement.classList.add(sender + '-message');
            messageElement.textContent = message;
            chatMessages.appendChild(messageElement);
            chatMessages.scrollTop = chatMessages.scrollHeight;
          }
          
          function showTypingIndicator() {
            typingIndicator = document.createElement('div');
            typingIndicator.className = 'typing-indicator';
            typingIndicator.innerHTML = '<span></span><span></span><span></span>';
            chatMessages.appendChild(typingIndicator);
            chatMessages.scrollTop = chatMessages.scrollHeight;
          }
          
          function hideTypingIndicator() {
            if (typingIndicator) {
              typingIndicator.remove();
              typingIndicator = null;
            }
          }
          
          function getBotResponse() {
            return botResponses[Math.floor(Math.random() * botResponses.length)];
          }
          
          function analyzeConversation() {
            // Disable input
            userInput.disabled = true;
            sendButton.disabled = true;
            
            // Add final message
            addMessage("Thank you for chatting with me! I'm now ready to sort you...", 'bot');
            
            // Simple analysis of conversation to determine traits
            let traits = {
              bravery: 0,
              intelligence: 0,
              loyalty: 0,
              ambition: 0
            };
            
            // Keywords that might indicate traits
            const traitKeywords = {
              bravery: ['challenge', 'try', 'risk', 'adventure', 'bold', 'courage', 'brave', 'fearless', 'new', 'difficult', 'hard', 'tough'],
              intelligence: ['learn', 'understand', 'knowledge', 'curious', 'research', 'analyze', 'think', 'problem', 'solve', 'study', 'explore', 'discover'],
              loyalty: ['team', 'help', 'support', 'together', 'community', 'friend', 'collaborate', 'share', 'assist', 'mentor', 'pair', 'group'],
              ambition: ['goal', 'achieve', 'success', 'improve', 'better', 'advance', 'lead', 'accomplish', 'create', 'build', 'develop', 'launch', 'ship']
            };
            
            // Analyze user messages
            messages.forEach(msg => {
              if (msg.role === 'user') {
                const content = msg.content.toLowerCase();
                
                // Check for trait keywords
                for (const [trait, keywords] of Object.entries(traitKeywords)) {
                  keywords.forEach(keyword => {
                    if (content.includes(keyword)) {
                      traits[trait]++;
                    }
                  });
                }
              }
            });
            
            // Determine dominant trait
            let dominantTrait = 'intelligence'; // Default
            let maxScore = traits.intelligence;
            
            for (const [trait, score] of Object.entries(traits)) {
              if (score > maxScore) {
                dominantTrait = trait;
                maxScore = score;
              }
            }
            
            // Set trait and action for form submission
            userTraitField.value = dominantTrait;
            userActionField.value = 'investigate'; // Default action
            
            // Submit form to get house
            setTimeout(function() {
              sortForm.submit();
            }, 2000);
          }
        });
      </script>
    </body>
    </html>
    """
    
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  def sort(conn, %{"name" => name, "trait" => trait, "action" => action}) do
    house = determine_house(trait, action)
    
    html = """
    <!DOCTYPE html>
    <html>
    <head>
      <title>Sorting Result - Recurse Center</title>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
      <style>
        :root {
          --primary: #6366f1;
          --primary-dark: #4f46e5;
          --secondary: #06b6d4;
          --accent: #8b5cf6;
          --background: #f8fafc;
          --surface: #ffffff;
          --text: #334155;
          --text-light: #64748b;
          --success: #10b981;
          --error: #ef4444;
          --border: #e2e8f0;
        }
        
        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
        }
        
        body { 
          font-family: 'Poppins', sans-serif;
          max-width: 900px; 
          margin: 0 auto; 
          padding: 30px 20px;
          background-color: var(--background);
          color: var(--text);
          line-height: 1.6;
          min-height: 100vh;
          display: flex;
          flex-direction: column;
          justify-content: center;
        }
        
        h1 {
          font-size: 2.5rem;
          margin-bottom: 1rem;
          color: var(--primary-dark);
          text-align: center;
        }
        
        h2 {
          font-size: 1.8rem;
          margin-bottom: 1rem;
          color: var(--primary-dark);
        }
        
        p {
          margin-bottom: 1.5rem;
          font-size: 1.1rem;
        }
        
        .result-container {
          background-color: var(--surface);
          border-radius: 16px;
          box-shadow: 0 10px 30px rgba(0,0,0,0.1);
          padding: 50px 30px;
          margin-bottom: 30px;
          text-align: center;
          position: relative;
          overflow: hidden;
        }
        
        .result-container::before {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          height: 8px;
          background: linear-gradient(90deg, #4f46e5, #8b5cf6);
        }
        
        .house { 
          font-size: 3.5rem; 
          font-weight: 700; 
          margin: 30px 0; 
          position: relative;
          display: inline-block;
        }
        
        .house::after {
          content: '';
          position: absolute;
          bottom: -10px;
          left: 50%;
          transform: translateX(-50%);
          width: 100px;
          height: 4px;
          background: currentColor;
          border-radius: 2px;
        }
        
        .gryffindor { 
          background: linear-gradient(90deg, #740001, #ae0001);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .gryffindor::after {
          background: #ae0001;
        }
        
        .ravenclaw { 
          background: linear-gradient(90deg, #0e1a40, #222f5b);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .ravenclaw::after {
          background: #222f5b;
        }
        
        .hufflepuff { 
          background: linear-gradient(90deg, #ecb939, #f0c75e);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .hufflepuff::after {
          background: #f0c75e;
        }
        
        .slytherin { 
          background: linear-gradient(90deg, #1a472a, #2a623d);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }
        
        .slytherin::after {
          background: #2a623d;
        }
        
        .description {
          max-width: 700px;
          margin: 0 auto 40px auto;
          line-height: 1.8;
          font-size: 1.1rem;
          background-color: rgba(99, 102, 241, 0.05);
          padding: 20px;
          border-radius: 8px;
        }
        
        .octopus {
          font-size: 60px;
          margin-bottom: 20px;
        }
        
        a { 
          display: inline-block; 
          padding: 14px 28px; 
          background: var(--primary);
          color: white; 
          text-decoration: none; 
          border-radius: 8px; 
          font-weight: 500;
          transition: all 0.2s;
        }
        
        a:hover {
          background: var(--primary-dark);
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(79, 70, 229, 0.2);
        }
        
        @media (max-width: 768px) {
          body {
            padding: 20px 15px;
          }
          
          h1 {
            font-size: 2rem;
          }
          
          .house {
            font-size: 2.8rem;
          }
          
          .result-container {
            padding: 30px 20px;
          }
        }
      </style>
    </head>
    <body>
      <div class="result-container">
        <div class="octopus">🐙</div>
        <h1>The Sorting Octopus has decided!</h1>
        <p>After chatting with you, #{name}, I've determined that you belong in:</p>
        <div class="house #{String.downcase(house)}">#{house}</div>
        
        <div class="description">
          #{get_house_description(house)}
        </div>
        
        <a href="/">Chat with the Sorting Octopus again</a>
      </div>
    </body>
    </html>
    """
    
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  defp determine_house("bravery", _action), do: "Gryffindor"
  defp determine_house("intelligence", _action), do: "Ravenclaw"
  defp determine_house("loyalty", _action), do: "Hufflepuff"
  defp determine_house("ambition", _action), do: "Slytherin"
  
  defp get_house_description("Gryffindor") do
    "At Recurse Center, Gryffindors are known for tackling challenging projects, 
    stepping outside their comfort zones, and being unafraid to ask questions. 
    They dive into new technologies headfirst and are always willing to help others.
    Your courage in facing difficult programming challenges will serve you well!"
  end
  
  defp get_house_description("Ravenclaw") do
    "Ravenclaws at Recurse Center are driven by curiosity and a deep desire to understand 
    how things work. They enjoy exploring computer science fundamentals, optimizing algorithms, 
    and sharing their knowledge with others. Your analytical mind and love of learning
    will help you thrive in the Recurse community."
  end
  
  defp get_house_description("Hufflepuff") do
    "Hufflepuffs thrive in the Recurse Center community. They're collaborative programmers 
    who value pair programming, knowledge sharing, and creating a supportive environment. 
    They're dedicated to helping everyone succeed. Your commitment to teamwork and
    supporting others will make Recurse a better place for everyone."
  end
  
  defp get_house_description("Slytherin") do
    "Slytherins at Recurse Center are ambitious builders who create impressive projects 
    and aren't afraid to set high goals. They're resourceful problem-solvers who find 
    clever ways to overcome challenges and are determined to make their mark.
    Your drive and determination will help you accomplish great things during your time at Recurse."
  end
end 