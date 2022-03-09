#!/bin/bash

curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -sSL https://get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm
rvm install ruby
GEMSSLPATH=$(gem which rubygems | sed -e 's/rubygems.rb/rubygems/')
cd $GEMSSLPATH/ssl_certs/rubygems.org
curl -O https://raw.githubusercontent.com/rubygems/rubygems/master/lib/rubygems/ssl_certs/rubygems.org/GlobalSignRootCA_R3.pem
cd -  
gem install bundler
gem update --system
gem install rdoc
gem install fpm
## MONKEY PATCH FPM https://github.com/jordansissel/fpm/issues/1777#issuecomment-810409151
RUVER=$(which ruby | awk -F\/ '{print $6}')
FPMVER=$(gem list | grep fpm | awk -F\( '{print $2}' | awk -F\) '{print $1}')
cp /rpm.erb.patched /usr/local/rvm/gems/${RUVER}/gems/fpm-${FPMVER}/templates/rpm.erb
