class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.36.tar.gz"
  sha256 "1c3c99c1c79f699a632fd7f679fc89c1a1492c2cd049aa4eb37ae2566e6568f5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "52bed6585d365ce331feff5d584ae57f458a379e621f0599064c0cd52f44c46f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb366995f6a3ce19b7811b5c70499269e9545f0b251bc7eaaa6d6f7f03115066"
  end

  depends_on "rust" => :build
  depends_on "openssl"
  depends_on "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin / "af", "completions")

    system "cargo", "genman"
    man1.install Dir["docs/man/man1/*.1"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/af --version")
  end
end
