require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'dovecot class' do

  context 'basic setup' do
    it "vmail dir" do
      expect(shell("bash -c 'mkdir -p /var/vmail; chmod 777 /var/vmail'").exit_code).to be_zero
    end

    #/etc/puppetlabs/code/environments/production/modules
    apply_manifest_opts = {
      :catch_failures => true,
      # I seem to need this otherwise Puppet doesn't pick up the required modules.
      # :modulepath     => '/etc/puppetlabs/code/modules',
      :debug          => true,
    }

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
      expect(apply_manifest(pp, apply_manifest_opts).exit_code).to_not eq(1)
      expect(apply_manifest(pp, apply_manifest_opts).exit_code).to eq(0)
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
