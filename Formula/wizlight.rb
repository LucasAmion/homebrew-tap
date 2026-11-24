class Wizlight < Formula
  desc "Async client for Philips WiZ smart bulbs over the local UDP protocol, plus the wizlight CLI"
  homepage "https://github.com/LucasAmion/wizlight-rs"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0/wizlight-aarch64-apple-darwin.tar.xz"
      sha256 "ec7f77f8ba24444e10201c07c0bf9ba3e14b7b662921cdbe599964028dc6c83f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0/wizlight-x86_64-apple-darwin.tar.xz"
      sha256 "32ca4e46b204275045f544c1f6b45b988266ab5917381abce3cf438cf166c6a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0/wizlight-aarch64-unknown-linux-musl.tar.xz"
      sha256 "76891d674ff039f806998a057ca3514f2c0a9a859eee08974c5c26ee06599abd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0/wizlight-x86_64-unknown-linux-musl.tar.xz"
      sha256 "63d7a35984be269dc13a191e079d011119be8f20ecb164a65c5cb09e1107a910"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "wizlight"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "wizlight"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "wizlight"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "wizlight"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
