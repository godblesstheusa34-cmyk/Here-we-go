#!/usr/bin/env bash
# Explicit text-only bootstrap; this is not a Gradle wrapper with a missing JAR.
set -euo pipefail
TASK_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
TASK_VERSION=8.10.2
TASK_CACHE="$TASK_ROOT/.toolchain"
TASK_GRADLE="$TASK_CACHE/gradle-$TASK_VERSION/bin/gradle"
if [[ ! -f "$TASK_GRADLE" ]]; then
  command -v java >/dev/null || { echo 'Install JDK 17 first.' >&2; exit 1; }
  command -v python3 >/dev/null || { echo 'Python 3 is needed for the first download.' >&2; exit 1; }
  mkdir -p "$TASK_CACHE"
  python3 - "$TASK_CACHE" "$TASK_VERSION" <<'PY'
from pathlib import Path
import sys, urllib.request, zipfile
cache, version = Path(sys.argv[1]), sys.argv[2]
archive = cache / f'gradle-{version}-bin.zip'
if not archive.exists():
    temporary = archive.with_suffix('.download')
    urllib.request.urlretrieve(f'https://services.gradle.org/distributions/gradle-{version}-bin.zip', temporary)
    temporary.replace(archive)
with zipfile.ZipFile(archive) as package:
    package.extractall(cache)
PY
fi
cd "$TASK_ROOT"
exec bash "$TASK_GRADLE" "$@"
