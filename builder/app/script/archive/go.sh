#!/usr/bin/zsh
set -e

go env -w GOPATH="$HOME/.go"
go env -w CGO_CFLAGS='-O3 -g'
go env -w CGO_CXXFLAGS='-O3 -g'
go env -w CGO_FFLAGS='-O3 -g'
go env -w CGO_LDFLAGS='-O3 -g'

go install github.com/cheat/cheat/cmd/cheat@latest
go install github.com/rs/curlie@latest
go install github.com/jesseduffield/lazygit@latest
