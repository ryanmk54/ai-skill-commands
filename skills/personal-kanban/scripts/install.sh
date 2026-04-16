#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILL_NAME="personal-kanban"
CURSOR_SKILLS_DIR="${HOME}/.cursor/skills"
TARGET_LINK="${CURSOR_SKILLS_DIR}/${SKILL_NAME}"
EXAMPLE_CONFIG="${REPO_ROOT}/LOCAL_CONFIG.example.md"
LOCAL_CONFIG="${REPO_ROOT}/LOCAL_CONFIG.md"

mkdir -p "${CURSOR_SKILLS_DIR}"

if [ -e "${TARGET_LINK}" ] && [ ! -L "${TARGET_LINK}" ]; then
  echo "Refusing to replace non-symlink path: ${TARGET_LINK}" >&2
  echo "Move or remove it manually, then rerun this script." >&2
  exit 1
fi

ln -sfn "${REPO_ROOT}" "${TARGET_LINK}"

if [ ! -f "${LOCAL_CONFIG}" ] && [ -f "${EXAMPLE_CONFIG}" ]; then
  cp "${EXAMPLE_CONFIG}" "${LOCAL_CONFIG}"
  echo "Created ${LOCAL_CONFIG} from the example file."
fi

echo "Installed skill symlink:"
echo "  ${TARGET_LINK} -> ${REPO_ROOT}"
echo
echo "Next step:"
echo "  Edit ${LOCAL_CONFIG} with your local Kanban board root."
