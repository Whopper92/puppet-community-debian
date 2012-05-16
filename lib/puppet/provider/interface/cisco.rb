require 'puppet/provider/cisco'

Puppet::Type.type(:interface).provide :cisco, :parent => Puppet::Provider::Cisco do

  desc "Cisco switch/router provider for interface."

  mk_resource_methods

  def self.lookup(device, name)
    interface = nil
    device.command do |ng|
      interface = device.interface(name)
    end
    interface
  end

  def initialize(device, *args)
    super
  end

  def flush
    device.command do |device|
      device.new_interface(name).update(former_properties, properties)
    end
    super
  end
end
