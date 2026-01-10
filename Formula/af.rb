class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.48.tar.gz"
  sha256 "57310415aa0978b6eeb997390f3529dc983835db4b8c677f83492ebe8cb3f801"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "5b1cb0915121e823cd2c73871c3f5ee9b2150044900081044b4f75757bd0e646"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4fb6a46790fde2eec85376174149ab3776852e2c5d8764f08317a56668f72c0"
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
