class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.44.tar.gz"
  sha256 "313890f423c2be52746a78ad374ba193509a2eb31bcc45e547a6ef2771f60881"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "b1fe47a90f841f69a2f1aadd709b6e4000ea4760b138369356a15794eddb4271"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b8e03d7999fb81dedb1805ef490a0f6ad0f6c882b8ded0d6ab285286567da2d"
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
