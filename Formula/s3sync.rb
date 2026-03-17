class S3sync < Formula
  desc "macOS CLI + launchd daemon that watches local folders and syncs to AWS S3"
  homepage "https://github.com/jdsingh/s3sync"
  url "https://github.com/jdsingh/s3sync/releases/download/v0.1.0/s3sync-0.1.0-macos-arm64.tar.gz"
  sha256 "placeholder"
  version "0.1.0"

  def install
    bin.install "s3sync"
  end

  test do
    assert_match "s3sync", shell_output("#{bin}/s3sync --help")
  end
end
