require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'dovecot class' do

  context 'basic setup' do

    it "workarround for ubuntu14.04 docker image" do
      expect(shell("lsb_release -a | grep trusty; if [ $? -eq 0 ]; then mv /sbin/initctl /sbin/oldinitctl; echo -e '#!/bin/bash\nif [ $1 == \"--version\" ]\nthen\n  echo \"initctl (upstart 1.12.1)\"\nfi\n/sbin/oldinitctl \"$@\"' > /sbin/initctl; chmod 755 /sbin/initctl; fi").exit_code).to be_zero
    end

    it "vmail dir" do
      expect(shell("bash -c 'mkdir -p /var/vmail; chmod 777 /var/vmail'").exit_code).to be_zero
    end

    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'dovecot':
        default_login_user => 'dovecot',
        mail_access_groups => 'dovecot',
      }

    	class { 'dovecot::userdb': }
    	class { 'dovecot::passdb': }
    	class { 'dovecot::auth': }
    	class { 'dovecot::auth::unixlistener': }
    	class { 'dovecot::imaplogin': }

    	dovecot::account { 'jordi@prats.cat':
    	  password => 'demopassw0rd',
    	}

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it "sleep 10 to make sure dovecot is started" do
      expect(shell("sleep 10").exit_code).to be_zero
    end

    it "check banner" do
      expect(shell("bash -c '(sleep 1; echo \". LOGOUT\"; sleep 1)| telnet 127.0.0.1 143 | grep \"ready to rock\"'").exit_code).to be_zero
    end

    it "check login" do
      expect(shell("bash -c '(sleep 1; echo \". login jordi@prats.cat demopassw0rd\"; sleep 5; echo \". LOGOUT\"; sleep 5;) | telnet 127.0.0.1 143 | grep \"Logged in\"'").exit_code).to be_zero
    end


  end
end
