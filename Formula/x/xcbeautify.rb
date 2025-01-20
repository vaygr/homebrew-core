class Xcbeautify < Formula
  desc "Little beautifier tool for xcodebuild"
  homepage "https://github.com/cpisciotta/xcbeautify"
  url "https://github.com/cpisciotta/xcbeautify/archive/refs/tags/2.18.0.tar.gz"
  sha256 "5e1201ca5e1e26b56c65b24d6284d16d56b7c56c65ef05d514c69c90d1abb150"
  license "MIT"
  head "https://github.com/cpisciotta/xcbeautify.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2df7bc91c2f49d64f9a170e388027bb36610c78e4530d7a14b691e55b85c33c2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8abf63b3b6d7d95ee98c46595c31ea5cdf29a13f3cdb0155486594199d9380d8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1db1f144289ff3775e6718ef11723006dc7078b8eaf2ba4bc36bbad17e71fb76"
    sha256 cellar: :any_skip_relocation, sonoma:        "6f8df0e91dbe391b973a11feaf2984afac9330f033f287e4b806c1adac658cc0"
    sha256 cellar: :any_skip_relocation, ventura:       "9ee60d779eaeac51655d59d8c1d48f227e7b906d751be7182acaa6cf61d23c6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e587e89a975626b619b28373011d0f69428dd34021564d2bdc33347e02c98b3b"
  end

  # needs Swift tools version 5.9.0
  depends_on xcode: ["15.0", :build]

  uses_from_macos "swift" => :build
  uses_from_macos "libxml2"

  def install
    args = if OS.mac?
      ["--disable-sandbox"]
    else
      ["--static-swift-stdlib"]
    end
    system "swift", "build", *args, "--configuration", "release"
    bin.install ".build/release/xcbeautify"
  end

  test do
    log = "CompileStoryboard /Users/admin/MyApp/MyApp/Main.storyboard (in target: MyApp)"
    assert_match "[MyApp] Compiling Main.storyboard",
      pipe_output("#{bin}/xcbeautify --disable-colored-output", log).chomp
    assert_match version.to_s,
      shell_output("#{bin}/xcbeautify --version").chomp
  end
end
