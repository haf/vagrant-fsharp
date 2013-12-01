# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
ENV['FACTER_ENVIRONMENT'] = 'dev'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'CentOS-6.4-x86_64-puppet'
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'
  config.cache.auto_detect = true if config.respond_to?(:cache)

  config.vm.synced_folder "hiera/", "/root/puppet/hiera"

  config.vm.provision 'shell', path: 'scripts/own-repo.sh'
  config.vm.provision :puppet do |p|
    p.manifests_path = 'manifests'
    p.manifest_file  = 'site.pp'
    p.module_path    = 'modules'
    p.options = %w|--hiera_config /root/puppet/hiera/hiera.yaml --verbose --debug|

    # Take any FACTER_ prefixed environment variable and set it as a fact for
    # vagrant to give to puppet during provisioning.
    p.facter = {}
    ENV.each do |key, value|
      next unless key =~ /^FACTER_/
      p.facter[key.gsub(/^FACTER_/, "")] = value
    end
  end

  config.vm.define 'fs-box' do |cfg|
    cfg.vm.hostname = 'fs-box.bit'
    cfg.vm.network :private_network, ip:'172.16.0.10'
    cfg.vm.provider 'virtualbox' do |v|
      v.customize ['modifyvm', :id, '--memory', 3072]
    end
  end
end
