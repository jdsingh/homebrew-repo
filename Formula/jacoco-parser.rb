class JacocoParser < Formula
  desc "Utility to parse JaCoCo xml reports"
  homepage "https://github.com/jdsingh/jacoco-parser"
  url "https://github.com/jdsingh/jacoco-parser/releases/download/0.0.2/jacoco-parser-0.0.2.zip"
  version "0.0.2"
  sha256 "e0080520b4da90c6bca1b73b6801b9c783bc20f42ed285de49dac227be25c9cd"

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
