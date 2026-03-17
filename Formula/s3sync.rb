class S3sync < Formula
  desc "macOS CLI + launchd daemon that watches local folders and syncs to AWS S3"
  homepage "https://github.com/jdsingh/s3sync"
  url "https://github.com/jdsingh/s3sync/releases/download/v0.1.3/s3sync-0.1.3-macos-arm64.tar.gz"
  sha256 "719592a0f31c0e7488fe56205e17a0a89fd5e2491291c8c4cfdeb9d6e868a5a8"
  version "0.1.3"

  def install
    libexec.install Dir["s3sync/*"]
    bin.write_exec_script libexec/"s3sync"
  end

  test do
    assert_match "s3sync", shell_output("#{bin}/s3sync --help")
  end
end
