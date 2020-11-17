# John Boero - jboero@hashicorp.com
# A job spec to install and run podman with 'exec' driver - no Docker.
# podman not used by default.  Add podman to config template
# Artifact checksum is for linux-amd64 by default.
job "podman" {
  datacenters = ["dc1"]
  type = "system"
  group "podman" {
    restart {
      attempts = 1
    }
    task "podman" {
      driver = "raw_exec"
      artifact {
        source      = "https://github.com/containers/podman/releases/download/v1.9.2/podman-remote-static"
        destination = "/usr/bin"
      }

      artifact {
        source      = "https://releases.hashicorp.com/nomad-driver-podman/0.1.0/nomad-driver-podman_0.1.0_linux_amd64.zip"
        destination = "/var/lib/nomad/data/plugins"
      }

      config {
        command = "/usr/bin/podman-remote-static"
        args = ["system", "service"]
      }
    }

    #task "hupnomad" {
    #  driver = "raw_exec"
    #  config {
    #    command = "pkill -HUP nomad"
    #  }
    #}
  }
}
