class S3sync < Formula
  desc "macOS CLI + launchd daemon that watches local folders and syncs to AWS S3"
  homepage "https://github.com/jdsingh/s3sync"
  url "https://github.com/jdsingh/s3sync/releases/download/v0.1.1/s3sync-0.1.1-macos-arm64.tar.gz"
  sha256 "d1f2c00d67faa7cb4ac87a263e8894a66ae0a73cc4f754b3f01d38172cd62c56"
  version "0.1.1"

  def install
    bin.install "s3sync"
  end

  test do
    assert_match "s3sync", shell_output("#{bin}/s3sync --help")
  end
end
