class AwsRotateIamKeys < Formula
  desc "Automatically set up a cron job to rotate your IAM keys"
  url "https://github.com/SMARTeacher/aws-rotate-iam-keys/archive/v0.8.2.tar.gz"
  sha256 "07bd5068232b7f4434222a954223f29039f43a5d097769c2d2800220c552b1ea"
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
