class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.64.tar.gz"
  sha256 "48429db9ead213c1b635a11939a3f83211bab8b90ee9ae933b8e9e5a81e6f5f5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "72d4da828ed17399c2fd4a3bb20f7876952ed703314c2ed486c4020d37dd0b8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7362e33b51091f59db880eaadeaabf77d58c0dbf22b4b8c1d2d3ddd766386633"
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
