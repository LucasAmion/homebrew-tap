class Wizlight < Formula
  desc "Async client for Philips WiZ smart bulbs over the local UDP protocol, plus the wizlight CLI"
  homepage "https://github.com/LucasAmion/wizlight-rs"
  version "0.1.0-beta.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-beta.1/wizlight-aarch64-apple-darwin.tar.xz"
      sha256 "4a64e6dde8e0e963a2e3b58d71d94b619669eb10b83b7a79571f8a91c9107af1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-beta.1/wizlight-x86_64-apple-darwin.tar.xz"
      sha256 "175c7f6fb15033ac002813fc8532679a998f724dd7afc542c7216d6b6ef54c78"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-beta.1/wizlight-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a1c9cfa72af238e531ef42ae862f89c94ac6093f7603232c56d740bac7964f68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-beta.1/wizlight-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8a4565e831a823f94eafe14b086f88c6abca748d7fbe2f2d5c070b7ce6e60b7a"
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
