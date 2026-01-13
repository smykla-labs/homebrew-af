class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.51.tar.gz"
  sha256 "708a42c2545833ceac9f751bca6933d1c9799f5c72bf899c0c5126770e0cb2f9"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "9d26aea0c6a12de452648187acff824c72f9a79425ac062039b84b9e4a3ed61b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cba220613034fe4d376810015014ac8e151eb507ebb67e8788af1e8798ae1071"
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
