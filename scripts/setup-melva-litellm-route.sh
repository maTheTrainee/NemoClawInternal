#!/usr/bin/env bash

set -euo pipefail

provider_name="${MELVA_LITELLM_PROVIDER_NAME:-compatible-endpoint}"
base_url="${MELVA_LITELLM_BASE_URL:-http://127.0.0.1:4000/v1}"
model="${MELVA_LITELLM_MODEL:-melva-primary}"
credential_env="${MELVA_LITELLM_CREDENTIAL_ENV:-COMPATIBLE_API_KEY}"
credential_value="${!credential_env:-dummy}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
env_file="${MELVA_LITELLM_ENV_FILE:-$repo_root/melva/config/litellm.env}"

if [ -f "$env_file" ]; then
  set -a
  # shellcheck disable=SC1090
  . "$env_file"
  set +a
  credential_value="${!credential_env:-$credential_value}"
fi

if [ -z "${credential_value:-}" ] || [ "$credential_value" = "change-me" ]; then
  echo "Set $credential_env in $env_file or the environment before routing through LiteLLM"
  exit 1
fi

export "$credential_env=$credential_value"

if openshell provider get "$provider_name" >/dev/null 2>&1; then
  openshell provider update "$provider_name" --credential "$credential_env" --config "OPENAI_BASE_URL=$base_url"
else
  openshell provider create --name "$provider_name" --type openai --credential "$credential_env" --config "OPENAI_BASE_URL=$base_url"
fi

openshell inference set --no-verify --provider "$provider_name" --model "$model"
openshell inference get
