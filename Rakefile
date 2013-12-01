task :default do
  sh 'cat pkg/mono.gz_* | gunzip -c >pkg/mono-3.2.3.fpm2-1.x86_64.rpm'
  system 'vagrant up'
end
