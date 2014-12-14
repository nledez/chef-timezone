#
# Cookbook Name:: timezone
# Recipe:: default
#

execute "update-tzdata" do
  command "dpkg-reconfigure -f noninteractive tzdata"
  action :nothing
end

template node[:timezone][:tz_file] do
  owner "root"
  group "root"
  mode "00644"
    variables({
      :zone => node[:timezone][:zone]
    })
  notifies :run, "execute[update-tzdata]"
end

package "tzdata" do
  action :install
end
