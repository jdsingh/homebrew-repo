class S3sync < Formula
  desc "macOS CLI + launchd daemon that watches local folders and syncs to AWS S3"
  homepage "https://github.com/jdsingh/s3sync"
  url "https://github.com/jdsingh/s3sync/releases/download/v0.1.4/s3sync-0.1.4-macos-arm64.tar.gz"
  sha256 "7476564e8f2c3680b91528f3aba4a289f9047ab4d5a6cebbc3e68205e6f99e00"
  version "0.1.4"

  def install
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"s3sync"
  end

  test do
    assert_match "s3sync", shell_output("#{bin}/s3sync --help")
  end
end
