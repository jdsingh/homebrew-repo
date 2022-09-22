class JacocoParser < Formula
  desc "Utility to parse JaCoCo xml reports"
  homepage "https://github.com/jdsingh/jacoco-parser"
  url "https://artifactory-gojek.golabs.io/artifactory/gojek-release-local/com/gojek/blade/1.0.6/blade-1.0.6.zip"
  version "1.0.7"
  sha256 "132fcfa44bacd905cf5da886c22127680a829fb2ae5fb0e4b2aeed6b05446a59"

  depends_on "openjdk"

  def install
    libexec.install %w[bin lib]
    (bin/"jacoco-parser").write_env_script libexec/"bin/jacoco-parser",
                                              :JAVA_HOME => "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
  end

  test do
    output = shell_output("#{bin}/jacoco-parser --help")
    assert_includes output, "Usage: jacoco-parser"
  end
end
