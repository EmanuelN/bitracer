defmodule Bitracer.Presence do
  use Phoenix.Presence, otp_app: :bitracer,
                        pubsub_server: Bitracer.PubSub
end