class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.40.tar.gz"
  sha256 "5925d64619a14a65012af6ce0a921796f71552e7e6b15cf3016fd89817e6d5bd"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "942346ad25f37dd78c14b8517424eaec67504b160f9f67e3a3b0f18209a0a13d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed6006591cd4065fe3005f9c73784f8dd36c3c34d948dbdcbe099f31b778aadb"
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
