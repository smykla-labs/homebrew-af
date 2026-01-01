class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.39.tar.gz"
  sha256 "8058ccaa394981b7de7023eb7be12b52e142f7bfff597c2c3a15202811c22e14"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "2e69da7f41d2a3379d772cc6b974cbfb9249fdeb28b00d854c926861de4b8e69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5e305d722a559ef7d5ba8abfc848010c7d5e8d23979fe5890d9209ae3479ee0"
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
