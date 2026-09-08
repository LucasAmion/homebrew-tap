class Wizlight < Formula
  desc "Async client for Philips WiZ smart bulbs over the local UDP protocol, plus the wizlight CLI"
  homepage "https://github.com/LucasAmion/wizlight-rs"
  version "0.1.0-alpha.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.4/wizlight-aarch64-apple-darwin.tar.xz"
      sha256 "106d1725140b6e2a01ff6c9da1feb0a00fff431575d7ce6e60df88255f929de1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.4/wizlight-x86_64-apple-darwin.tar.xz"
      sha256 "8042e3d8666967654d8c498029a0b8d1ae1648935a22ace9a17832c4ecbbaef8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.4/wizlight-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b584492a9f107cc3dcf1c3bf8db2de6c542aca9223643455958c31b0e857c7dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.4/wizlight-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c6b9aea3b93f658188959d9bda46b3f7b443c7d692fedc82ed53d458a0835ad3"
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
