class Tack < Formula
  desc "The Amsterdam Compiler Kit"
  homepage "http://tack.sourceforge.net"
  url "https://github.com/wyan/ack/archive/homebrew-0.1.tar.gz"
  version "2020.06.03"
  sha256 "8f7104ca8bf45af015c9aec39dbfa109db471ce5b4f1db2427f57709f3117827"

  def install
    ENV.deparallelize
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"hello.c").write <<~EOF
#include <stdio.h>
int main(void)
{
        printf(\"Hello world\\n\");
        return 0;
}
    EOF
    system "#{bin}/ack", "-mcpm", "hello.c", "-o", "hello.com"
    assert_predicate testpath/"hello.o", :exist?
    assert_predicate testpath/"hello.com", :exist?
  end
end
