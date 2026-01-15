class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.53.tar.gz"
  sha256 "503289b78a2af3165e5c83375553160a4bfcfcea0d89d59f237381dc03eaa9f7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "9f3d43c8566c8058e152ae77b761f4dd29d1cc75a975d7b8fab3e92aac91d7c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2029212ec4d3cfab967f2d1264cc4663a283c2065d61dd691c4f76570047100c"
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
