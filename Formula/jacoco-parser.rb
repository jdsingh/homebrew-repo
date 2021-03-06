class JacocoParser < Formula
  desc "Utility to parse JaCoCo xml reports"
  homepage "https://github.com/jdsingh/jacoco-parser"
  url "https://github.com/jdsingh/jacoco-parser/releases/download/1.0.0/jacoco-parser-1.0.0.zip"
  version "1.0.0"
  sha256 "7efa7830238cc01ac93e88f026583e5469ca7c5533af099b9d33c98b8d68253d"

  bottle :unneeded

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
