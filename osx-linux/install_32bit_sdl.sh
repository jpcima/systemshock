#!/usr/bin/env bash

set -euo pipefail

SDL_version=2.0.9
SDL2_mixer_version=2.0.4

function build_sdl {
	curl -O https://www.libsdl.org/release/SDL2-${SDL_version}.tar.gz
	tar xf SDL2-${SDL_version}.tar.gz
	pushd SDL2-${SDL_version}

	./configure "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
	make -j2
	make install

	popd
}

function build_sdl_mixer {
	curl -O https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-${SDL2_mixer_version}.tar.gz
	tar xf SDL2_mixer-${SDL2_mixer_version}.tar.gz
	pushd SDL2_mixer-${SDL2_mixer_version}

	export SDL2_CONFIG="/usr/local/bin/sdl2-config"
	./configure "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
	make -j2
	make install

	popd
}

build_sdl
build_sdl_mixer

# Clean up download artifacts
rm SDL2-${SDL_version}.tar.gz
rm -fr SDL2-${SDL_version}
rm SDL2_mixer-${SDL2_mixer_version}.tar.gz
rm -fr SDL2_mixer-${SDL2_mixer_version}
