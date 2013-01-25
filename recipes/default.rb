include_recipe "java::default"

remote_file "/tmp/#{node['openfire']['tarball']}" do
  source "http://www.igniterealtime.org/downloadServlet?filename=openfire/#{node['openfire']['tarball']}"
  mode "0644"
  # check the checksum
end

execute "tar" do
  cwd "/opt"
  command "tar xzf /tmp/#{source_tarball}"
  creates "/opt/openfire"
end


link  "/etc/init.d/openfire" do
  to "/opt/openfire/bin/openfire"
end

service "openfire" do
  supports :status => true, 
           :stop => true
  action [ :enable, :start ]
end

log "And now remember to visit the server on :9090 to run the openfire wizard."
log "You'll also probably want to turn of anonymous sign-ups and whatnot."
