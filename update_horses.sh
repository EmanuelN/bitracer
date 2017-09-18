#! /bin/bash
mix ecto.drop &&
mix ecto.create &&
mix ecto.migrate &&
mix run ./priv/repo/seeds.exs &&
mix run ./assets/run_trials.exs
