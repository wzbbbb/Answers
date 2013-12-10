fpm : package builder
http://www.tuxz.net/blog/archives/2012/09/08/how_to_easily_build_native_packages_of_everything/
https://github.com/jordansissel/fpm

mrepo(yam)
reprepo
pulp
.................................
package { "vim": 
	ensure => present, 
} 

type { title: 
	attribute => value, 
} 

save as test.pp, then:
puppet apply test.pp

...........
factor
......................
Installing on Red Hat Enterprise Linux and Fedora
# yum install ruby ruby-libs ruby-shadow

Next, to get the latest releases of Puppet, you will need to add the EPEL repository (see sidebar) to your host and then install packages from that repository. You can add the EPEL repository by adding the epel-releaseRPM (.rpm package manager). 
# rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3.noarch.rpm 

On the master,
# yum install puppet puppet-server facter
On the agent,
# yum install puppet facter 
.................................
config file
/etc/puppetlabs/puppet/puppet.conf

If not exist:
# puppetmasterd --genconfig > puppet.conf 
.................................
github
[root@learn puppetlabs]# git config --global user.name 'zwa'
[root@learn puppetlabs]# git config --global user.email 'zwa@orsyp.com'

To add /etc/puppetlabs to git repository.
root@cookbook:/etc/puppet# git init
Initialized empty Git repository in /etc/puppet/.git/
root@cookbook:/etc/puppet# git add manifests/ modules/
root@cookbook:/etc/puppet# git commit -m "initial commit"
[master (root-commit) c7a24cf] initial commit
 59 files changed, 1790 insertions(+), 0 deletions(-)
 create mode 100644 manifests/site.pp
 create mode 100644 manifests/utils.pp
 ...

env GIT_SSL_NO_VERIFY=true  git push -u origin master
.................................
Here’s a notify resource that depends on a file resource:

    file {'/tmp/test1':
      ensure  => present,
      content => "Hi.",
    }

    notify {'/tmp/test1 has already been synced.':
      require => File['/tmp/test1'],
    }

.................................
    file { '/etc/ssh/sshd_config':
      ensure => file,
      mode   => 600,
      source => 'puppet:///modules/ssh/sshd_config',
    }
    service { 'sshd':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/ssh/sshd_config'],    
    }

In this example, the sshd service will be restarted if Puppet has to edit its
config file.
This "source" 'puppet:///modules/ssh/sshd_config' is a local file.
.................................
creat a file:

    # /root/examples/file-1.pp

    file {'testfile':
      path    => '/tmp/testfile',
      ensure  => present,
      mode    => 0640,
      content => "I'm a test file.",
    }
.................................

    # /root/examples/file-2.pp

    file {'/tmp/test1':
      ensure  => file,
      content => "Hi.\n",
    }

    file {'/tmp/test2':
      ensure => directory,
      mode   => 0644,
    }

    file {'/tmp/test3':
      ensure => link,
      target => '/tmp/test1',
    }

    user {'katie':
      ensure => absent,
    }

    notify {"I'm notifying you.":}
    notify {"So am I!":}



