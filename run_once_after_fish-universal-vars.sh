#!/bin/bash
fish -c "set -U nvm_default_version v24.18.0"
fish -c "set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud distrobox toolbox terraform aws nix_shell crystal elixir zig"
