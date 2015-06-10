name             'pkgconfig'
maintainer       'Ken Gotoh'
maintainer_email 'lss.ken8927@gmail.com'
license          'All rights reserved'
description      'Installs pkgconfig from source'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ fedora redhat centos ubuntu debian amazon }.each do |os|
  supports os
end

depends 'build-essential'