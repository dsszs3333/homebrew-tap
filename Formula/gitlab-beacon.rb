class GitlabBeacon < Formula
  desc "Terminal dashboard for GitLab CI/CD pipelines"
  homepage "https://github.com/dsszs3333/gitlab-beacon"
  url "https://github.com/dsszs3333/gitlab-beacon/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "819a0225fa29a478fc6edac1212975218ab675da8a465a10940daf43df3d74b5"
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
    assert_match "GitLab Beacon", shell_output("#{bin}/gitlab-beacon --help")
    assert_match "gitlab-beacon #{version}", shell_output("#{bin}/gitlab-beacon --version")
    config_file = testpath/".config/gitlab-beacon/projects.toml"
    assert_equal config_file.to_s, shell_output("#{bin}/gitlab-beacon config path").strip
    assert_path_exists config_file
    assert_match 'url = "https://gitlab.com"', config_file.read
  end
end
