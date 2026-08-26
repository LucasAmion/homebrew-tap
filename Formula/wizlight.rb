class Wizlight < Formula
  desc "Async client for Philips WiZ smart bulbs over the local UDP protocol, plus the wizlight CLI"
  homepage "https://github.com/LucasAmion/wizlight-rs"
  version "0.1.0-alpha.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.3/wizlight-aarch64-apple-darwin.tar.xz"
      sha256 "70f44678e1080d87fbd58faf043432ef6774be1d1e76de91daf615ef417b6b6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.3/wizlight-x86_64-apple-darwin.tar.xz"
      sha256 "9420c05b16739582a59cdb8b3a791a18957387040195ffbb9ad5032f16272028"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.3/wizlight-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3402d98acc285f934033d2baaebc1f74db8fc382f4102d7ea743f0ff58d37491"
    end
    if Hardware::CPU.intel?
      url "https://github.com/LucasAmion/wizlight-rs/releases/download/v0.1.0-alpha.3/wizlight-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c820c95b1b9ae4127d926396c12f21300438e041b5e5907f73f2e24832c5f34a"
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
