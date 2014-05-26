if node[:monit][:source] == "installer"
  base = node[:monit][:installer][:base]

  case node["platform"]
  when "debian", "ubuntu"
    filename = node[:monit][:installer][:filename_deb]
    remote_file "/tmp/" + filename do
      source base + filename
      mode "0700"
      action :create_if_missing
    end

    dpkg_package "monit" do
      source "/tmp/" + filename
      action :install
    end
  when "redhat", "centos", "fedora"
    filename = node[:monit][:installer][:filename_rpm]
    remote_file "/tmp/" + filename do
      source base + filename
      mode "0700"
      action :create_if_missing
    end

    rpm_package "monit" do
      source "/tmp/" + filename
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

unless node[:monit][:disable_monitrc]
  template "/etc/monit/monitrc" do
    source 'monitrc.erb'
    owner "root"
    group "root"
    mode 0700
    notifies :restart, "service[monit]"
  end
end

service "monit" do
  action [:enable, :start]
  enabled true
  supports [:start, :restart, :stop]
end
