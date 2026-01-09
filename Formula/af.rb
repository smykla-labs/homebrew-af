class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.47.tar.gz"
  sha256 "4170877feebdd868dd6e4c2a34203cd66b5bc2e0053754161b5f36b01a26453c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "7d7ad4309da653a35d5fa208c22e65cc1b7e736df93a401454e9283dfa3cebdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e46f379e1c19f664beaef54473050205aba72e4d55cf2b9055a4763007cf4107"
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
