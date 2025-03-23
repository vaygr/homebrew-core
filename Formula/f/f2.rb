class F2 < Formula
  desc "Command-line batch renaming tool"
  homepage "https://github.com/ayoisaiah/f2"
  url "https://github.com/ayoisaiah/f2/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "0c0e22f2f19cbaae5746f09cd42c9178b338f21314fdc8067fafa163e85cb4de"
  license "MIT"
  head "https://github.com/ayoisaiah/f2.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8302833ac2fb9359a9219c8157f0f2b89cfc0a1c77878d333def7a43386aa33b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8302833ac2fb9359a9219c8157f0f2b89cfc0a1c77878d333def7a43386aa33b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8302833ac2fb9359a9219c8157f0f2b89cfc0a1c77878d333def7a43386aa33b"
    sha256 cellar: :any_skip_relocation, sonoma:        "8bd506a72e01572496aec534f019ba39752b8f8c9974cdae26c0aad3c2f9b247"
    sha256 cellar: :any_skip_relocation, ventura:       "8bd506a72e01572496aec534f019ba39752b8f8c9974cdae26c0aad3c2f9b247"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42b70125dde40f56f721d1f02904018d5ce9bfaf048a5c0cd4d22465a2a25851"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/f2"

    bash_completion.install "scripts/completions/f2.bash" => "f2"
    fish_completion.install "scripts/completions/f2.fish"
    zsh_completion.install "scripts/completions/f2.zsh" => "_f2"
  end

  test do
    touch "test1-foo.foo"
    touch "test2-foo.foo"
    system bin/"f2", "-s", "-f", ".foo", "-r", ".bar", "-x"
    assert_path_exists testpath/"test1-foo.bar"
    assert_path_exists testpath/"test2-foo.bar"
    refute_path_exists testpath/"test1-foo.foo"
    refute_path_exists testpath/"test2-foo.foo"
  end
end
