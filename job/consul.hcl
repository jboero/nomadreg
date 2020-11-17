# John Boero - jboero@hashicorp.com
# A job spec to install and run consul with 'exec' driver - no Docker.
# Consul not used by default.  Add Consul to config template
# Artifact checksum is for linux-amd64 by default.
job "consul" {
  datacenters = ["dc1"]
  type = "system"
  group "consul" {

    task "consul" {
      driver = "raw_exec"
      user = "root"
      
      resources {
        cpu = 500
        memory = 256
      }

      artifact {
        source      = "https://releases.hashicorp.com/consul/1.9.0+ent-beta3/consul_1.9.0+ent-beta3_${attr.kernel.name}_${attr.cpu.arch}.zip"
        destination = "/usr/bin/"
      }

      template {
        data        = <<EOF
        ui = true
        disable_mlock = true
        # Disable this if you switch to Consul.
        storage "file" {
          path = "/opt/consul/data"
        }
        # Switch to this for Consul
        #storage "consul" {
        #  address = "127.0.0.1:8500"
        #  path    = "consul"
        #}
        # Listen on all IPv4 and IPv6 interfaces.
        listener "tcp" {
          address = ":8200"
          tls_disable = 1
        }
        EOF
        destination = "/etc/consul.d/consul.hcl"
      }
      config {
        command = "/usr/bin/consul"
        args = ["agent", "-config=/etc/consul.d/consul.hcl"]
      }
    }
  }
}
