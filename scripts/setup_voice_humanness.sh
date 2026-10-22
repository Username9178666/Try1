#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST_DIR="${ROOT_DIR}/third_party/voice_humanness"
VENV_DIR="${ROOT_DIR}/.venv-voice"

mkdir -p "${DEST_DIR}"

clone_or_update() {
  local repo_url="$1"
  local target="$2"
  if [ -d "${target}/.git" ]; then
    git -C "${target}" fetch --depth 1 origin
    git -C "${target}" reset --hard origin/HEAD
  else
    git clone --depth 1 "${repo_url}" "${target}"
  fi
}

clone_or_update "https://github.com/VapiAI/humanness-index.git" "${DEST_DIR}/humanness-index"
clone_or_update "https://github.com/HEAR-6/HEAR.git" "${DEST_DIR}/hear"
clone_or_update "https://github.com/lmxue/NVV-SuperBench.git" "${DEST_DIR}/nvv-superbench"
clone_or_update "https://github.com/ASLP-lab/HumDial-FDBench.git" "${DEST_DIR}/humdial-fdbench"

if [ "${SKIP_PYTHON_DEPS:-0}" = "1" ]; then
  echo "SKIP_PYTHON_DEPS=1: skipped Python environment setup."
  exit 0
fi

python3 -m venv "${VENV_DIR}"
"${VENV_DIR}/bin/python" -m pip install --upgrade pip
"${VENV_DIR}/bin/python" -m pip install "numpy>=1.26,<3" "scipy>=1.11,<2"

if [ -f "${DEST_DIR}/hear/reproducibility/requirements.txt" ]; then
  "${VENV_DIR}/bin/python" -m pip install -r "${DEST_DIR}/hear/reproducibility/requirements.txt"
fi

echo
echo "Voice benchmark sources: ${DEST_DIR}"
echo "Python environment: ${VENV_DIR}"
echo "Activate with: source .venv-voice/bin/activate"
