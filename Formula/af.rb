class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.38.tar.gz"
  sha256 "efb5abb408fcf07687d8a471642284a0ff0dac102c6b57d9de79252affbc1e6d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "dce438f14e63472bed54a001bcd41c01665a43c63ec71d4bfbedb8fb240b4c32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb42314794bbf8c4a0f91865dd325d3bf23e112d8a2b5917c72346a12b10f607"
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
