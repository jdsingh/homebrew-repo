class JacocoParser < Formula
  desc "Utility to parse JaCoCo xml reports"
  homepage "https://github.com/jdsingh/jacoco-parser"
  url "https://github.com/jdsingh/jacoco-parser/releases/download/v0.0.4/jacoco-parser-0.0.4.zip"
  version "0.0.4"
  sha256 "b4823a3e2eb15742b51b3c6dbe3477744b4ac3de1f7288148943ea6bc3272f12"

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
