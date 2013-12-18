base     = node[:monit][:binary][:base]

if node[:monit][:source] == "installer"
  case node["platform"]
  when "debian", "ubuntu"
    filename = node[:monit][:binary][:filename_deb]
    remote_file "/tmp/" + filename do
      source base + monit
      mode "0666"
      action :create_if_missing
    end

    dpkg_package "monit" do
      source "/tmp/" + monit
      action :install
    end
  when "redhat", "centos", "fedora"
    filename = node[:monit][:binary][:filename_rpm]
    remote_file "/tmp/" + filename do
      source "http://str.cloudn-service.com/pkg/" + filename
      mode "0666"
      action :create_if_missing
    end

    rpm_package "monit" do
      source "/tmp/" + monit
      action :install
    end
  end
elsif node[:monit][:source] == "package"
  package "monit"
end

directory "/etc/monit/conf.d/" do
  action :create
  owner  'root'
  group 'root'
  mode 0755
  recursive true
end

template "/etc/monit/monitrc" do
  source 'monitrc.erb'
  owner "root"
  group "root"
  mode 0700
  notifies :restart, "service[monit]"
end

service "monit" do
  action [:enable, :start]
  enabled true
  supports [:start, :restart, :stop]
end
