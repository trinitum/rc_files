if [[ -d ~/.cargo/bin ]]; then
    path=(~/.cargo/bin $path)
    which rustc &> /dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
