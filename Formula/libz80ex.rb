class Libz80ex < Formula
  desc "ZiLOG Z80 CPU emulation library"
  homepage "https://sourceforge.net/projects/z80ex"
  url "https://github.com/wyan/libz80ex/archive/1.1.22.tar.gz"
  sha256 "b7bda7e4d9e447287f470ffd1e61f7e3a538e367484dc17b36420d3e6664bdf5"
  head "https://github.com/wyan/libz80ex", :using => :git

  def install
    ENV.deparallelize
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <z80ex/z80ex.h>

      int main(void)
      {
        Z80EX_VERSION *ver;
        ver = z80ex_get_version();
        printf(\"%s\\n\", ver->as_string);
        return(0);
      }
    EOS
    system ENV.cc, "-L#{lib}", "-lz80ex", "test.c", "-o", "test"
    system "./test"
  end
end
