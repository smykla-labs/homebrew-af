class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.51.tar.gz"
  sha256 "708a42c2545833ceac9f751bca6933d1c9799f5c72bf899c0c5126770e0cb2f9"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "d5ad072a74f52cd5ddb873a5f1103201d6351eb70c0863c0f9ce44f7575b6b9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7728a349ea945a51856013c49ae24d404775350c78a473f54aae8a8e65eb9a95"
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
