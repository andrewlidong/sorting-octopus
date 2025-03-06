# Use the official Elixir image as the base image
FROM hexpm/elixir:1.14.4-erlang-25.3-debian-bullseye-20230227 as build

# Install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set environment variables
ENV MIX_ENV=prod

# Create app directory and copy the Elixir project into it
WORKDIR /app
COPY . .

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Fetch dependencies and compile
RUN mix deps.get --only prod
RUN mix compile

# Build the release
RUN mix release

# Prepare release image
FROM debian:bullseye-slim

# Install runtime dependencies
RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set environment variables
ENV MIX_ENV=prod
ENV PORT=8080
ENV PHX_SERVER=true

WORKDIR /app

# Copy the release from the build stage
COPY --from=build /app/_build/prod/rel/sorting_hat ./

# Expose the port
EXPOSE 8080

# Set the entrypoint
CMD ["bin/sorting_hat", "start"] 