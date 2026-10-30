#!/bin/bash

setup_dart_sass() {
    local version="1.77.8"
    local install_dir="$PWD/tools/dart-sass"
    local binary="$install_dir/sass"
    local url="https://github.com/sass/dart-sass/releases/download/${version}/dart-sass-${version}-linux-x64.tar.gz"
    local tmp_dir

    if [[ ! -x "$binary" ]]; then
        echo "Instalando Dart Sass ${version}..."

        if [[ "$(uname -s)" != "Linux" || "$(uname -m)" != "x86_64" ]]; then
            echo "ERROR: Se requiere Linux x86_64." >&2
            return 1
        fi

        tmp_dir="$(mktemp -d)"

        if ! (
            set -e
            trap 'rm -rf "$tmp_dir"' EXIT

            curl -fsSL "$url" -o "$tmp_dir/dart-sass.tar.gz"
            tar -xzf "$tmp_dir/dart-sass.tar.gz" -C "$tmp_dir"

            mkdir -p "$PWD/tools"
            rm -rf "$install_dir"
            mv "$tmp_dir/dart-sass" "$install_dir"
        ); then
            echo "ERROR: No se pudo instalar Dart Sass." >&2
            return 1
        fi
    fi

    if ! "$binary" --embedded --version >/dev/null 2>&1; then
        echo "ERROR: Dart Sass no funciona en modo embedded." >&2
        return 1
    fi

    export PATH="$install_dir:$PATH"
    echo "Dart Sass: $("$binary" --version)"
}

build_site() {
    echo "Limpiando compilaciones anteriores..."
    rm -rf public
    rm -rf static/pagefind

    echo "Generando el blog..."
    hugo
}

build_search_index() {
    local mode="${1:?Debes indicar development o production}"
    local output_dir

    case "$mode" in
        development)
            output_dir="static/pagefind"
            ;;
        production)
            output_dir="public/pagefind"
            ;;
        *)
            echo "ERROR: Modo desconocido: $mode" >&2
            return 1
            ;;
    esac

    echo "Generando índice Pagefind ($mode)..."

    npx --no-install pagefind \
        --site public \
        --output-path "$output_dir"

    test -s "$output_dir/pagefind-ui.js"
    test -s "$output_dir/pagefind-ui.css"
}

