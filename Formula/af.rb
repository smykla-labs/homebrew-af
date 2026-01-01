class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.39.tar.gz"
  sha256 "8058ccaa394981b7de7023eb7be12b52e142f7bfff597c2c3a15202811c22e14"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "6dfbf1a6a21728e5226740ba628ce196d5039baed28441120a45edcbcb3358c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7cf8b8af2aaace908135b6d5859f2b789322cc58fbf1880937c80d5dc031518c"
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
