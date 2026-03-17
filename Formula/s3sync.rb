class S3sync < Formula
  desc "macOS CLI + launchd daemon that watches local folders and syncs to AWS S3"
  homepage "https://github.com/jdsingh/s3sync"
  url "https://github.com/jdsingh/s3sync/releases/download/v0.1.2/s3sync-0.1.2-macos-arm64.tar.gz"
  sha256 "4307e21ee18b0861220f363b26aefaf68a6f16382cfd02158a5f5413a9c2242a"
  version "0.1.2"

  def install
    bin.install "s3sync"
  end

  test do
    assert_match "s3sync", shell_output("#{bin}/s3sync --help")
  end
end
