class AwsRotateIamKeys < Formula
  desc "Automatically set up a cron job to rotate your IAM keys"
  url "https://github.com/SMARTeacher/aws-rotate-iam-keys/archive/v0.8.3.tar.gz"
  sha256 "38e10c7677365be661cb11a0011798263b91e04df7ba3e8d1c76f52df26ab5f3"
  depends_on "awscli"
  depends_on "jq"
  depends_on "gnu-getopt"

  def install
    bin.install "src/bin/aws-rotate-iam-keys"
  end

  test do
    system bin/"aws-rotate-iam-keys", "--version"
  end
end
