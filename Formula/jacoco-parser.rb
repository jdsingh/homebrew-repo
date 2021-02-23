class JacocoParser < Formula
  desc "Utility to parse JaCoCo xml reports"
  homepage "https://github.com/jdsingh/jacoco-parser"
  url "https://github.com/jdsingh/jacoco-parser/releases/download/0.0.1/jacoco-parser-0.0.1.zip"
  version "0.0.1"
  sha256 "d04167e826526c622503bf2c7ebc96c3dddd557ecac2e1d8ae2feb2952d79832"

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