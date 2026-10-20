class Invocra < Formula
  desc "Terminal dashboard for GitLab CI/CD pipelines"
  homepage "https://github.com/dsszs3333/invocra"
  url "https://github.com/dsszs3333/invocra/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ac0bb1770aebb8ef8d8f25065cfb028d0561218b76e5ce0bf4a6ce82e47edb7d"
  license "MIT"

  depends_on "rust" => :build

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/app")
  end

  test do
    assert_match "Invocra", shell_output("#{bin}/invocra --help")
    assert_match "invocra #{version}", shell_output("#{bin}/invocra --version")
    config_file = testpath/".config/invocra/projects.toml"
    assert_equal config_file.to_s, shell_output("#{bin}/invocra config path").strip
    assert_path_exists config_file
    assert_match 'url = "https://gitlab.com"', config_file.read
  end
end
