#! /bin/bash
mix ecto.drop &&
mix ecto.create &&
mix ecto.migrate &&
node ./assets/gen_horses.js &&
mix run ./assets/run_trials.exs
