class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.42.tar.gz"
  sha256 "37ab324ef8cc7d0a529108ca6608d67f237012b7fa8b19527406cfbbeffcc197"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "b68f22dfd72485c87bd702fbd1639c36b822059ae7aeb018778cce7146822fa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b943c72459a270e1d66ec4ecd7be757f4b84e5f4445c4f7aa1b6947b74ec973e"
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
