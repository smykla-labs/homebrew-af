class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.36.tar.gz"
  sha256 "1c3c99c1c79f699a632fd7f679fc89c1a1492c2cd049aa4eb37ae2566e6568f5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "0ccaf89d2bda0175c02013d798a82f44ddc7521f8f863a72285e746b8b26a122"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43403a9534b2acd1fc2b914ef6dcd9597143d3b0e75bf287a25c9b12f8f10f17"
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
