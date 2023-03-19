w = File.open('README.md', 'w')
w.print <<-EOS
# Free Nagasaki Collection
Source: https://opennagasaki.nerc.or.jp/
EOS

wait = 60 * 1000
File.foreach('../free-nagasaki/convert/dst/list.csv') {|l|
  (fn, cid) = l.strip.split(',')
  dst_path = "img/#{fn.sub('copc.laz', 'jpg')}"
  url = "https://viewer.copc.io/?copc=https://smb.optgeo.org/ipfs/#{cid}"
  cmd = <<-EOS
npx playwright screenshot --wait-for-timeout=#{wait} "#{url}" #{dst_path}
  EOS
  print "#{cmd}"
  w.print <<-EOS
## [#{fn}](#{url})
[![screenshot](#{dst_path})](#{url})
  EOS
  w.flush
  system cmd
}

w.close
