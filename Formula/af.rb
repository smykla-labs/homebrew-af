class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.53.tar.gz"
  sha256 "503289b78a2af3165e5c83375553160a4bfcfcea0d89d59f237381dc03eaa9f7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "064103beaaffee2160e18a49d6cd6a268b477c7ccf0cad54b629cd4e51c85fe4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1e0c9fd96cb356bd5628af270aca62e2b6e2cf5479a94eee5a81d58bbe0024c"
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
