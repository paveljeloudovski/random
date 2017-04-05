command = Mixlib::ShellOut.new('echo ~root') 
command.run_command 

root_home_dir = command.stdout.to_s.strip 
puts 'Homedir:' + root_home_dir 

directory '/opt/chef/embedded/etc' do 
  owner 'root' 
  group 'root' 
  mode 00755 
  recursive true 
end.run_action(:create) 

file '/opt/chef/embedded/etc/gemrc' do 
  content <<-EOF 
--- 
:backtrace: false 
:bulk_threshold: 1000 
:sources: 
  - #{node['bnhp-gems']['source']} 
:update_sources: true 
:verbose: true 
:ssl_verify_mode: 0 
install: "--user --no-document" 
update: "--user --no-document" 
   EOF 
end.run_action(:create) 

file "#{root_home_dir}/.gemrc" do 
  content <<-EOF 
--- 
:backtrace: false 
:bulk_threshold: 1000 
:sources: 
  - #{node['bnhp-gems']['source']} 
:update_sources: true 
:verbose: true 
:ssl_verify_mode: 0 
install: "--user --no-document" 
update: "--user --no-document" 
   EOF 
end.run_action(:create)
