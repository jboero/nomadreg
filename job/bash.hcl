job "bash" {
  datacenters = ["dc1"]
  type = "system"
  group "bash" {

    task "bash" {
      driver = "raw_exec"
      
      resources {
        cpu = 50
        memory = 10
      }
      config {
        command = "/bin/bash"
      }
    }
  }
}
