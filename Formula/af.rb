class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.44.tar.gz"
  sha256 "313890f423c2be52746a78ad374ba193509a2eb31bcc45e547a6ef2771f60881"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "d933828bd94249ce55bfe2cf5026069ec8f5d4dfc1214bc81c4ec6b806f16b0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c14d395c0ed9c4389cba6b469697b42ab7063bf029ea850b36baae06f099a677"
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
