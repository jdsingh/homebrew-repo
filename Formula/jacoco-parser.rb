class JacocoParser < Formula
  desc "Utility to parse JaCoCo xml reports"
  homepage "https://github.com/jdsingh/jacoco-parser"
  url "https://github.com/jdsingh/jacoco-parser/releases/download/0.0.1/jacoco-parser-0.0.1.zip"
  version "0.0.1"
  sha256 "4008e4a8d2721b8dc88ffc8f15f9be6cb32b32ba792fab1491bb27023c587e1d"

  bottle :unneeded

  depends_on "openjdk"

  def install
    libexec.install %w[bin lib]
    (bin/"jacoco-parser").write_env_script libexec/"bin/jacoco-report-parser",
                                              :JAVA_HOME => "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
  end

  test do
    output = shell_output("#{bin}/jacoco-parser --help")
    assert_includes output, "Usage: jacoco-parser"
  end
end