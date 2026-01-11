class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.49.tar.gz"
  sha256 "6ccc9eb8e31c08ab8c6ad9341494ee1b90a71d5461fbf6b4856a0c20f5617207"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "47aca79452bc46afe857d7c61e9df15e057766671c9b7dde21acb1341133c0cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02a69c6637d0fd8bb82f30796da79c82273d23952e9743b0c24b04b836267cb8"
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
