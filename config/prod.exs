import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.

# Configuring the endpoint
config :sorting_hat, SortingHatWeb.Endpoint,
  url: [host: "sorting-octopus.fly.dev", port: 80],
  http: [
    ip: {0, 0, 0, 0},
    port: 8080
  ],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
