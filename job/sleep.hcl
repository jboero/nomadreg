job "sleep" {
  datacenters = ["dc1"]
  type = "system"
  group "sleep" {

    task "sleep" {
      driver = "exec"
      
      resources {
        cpu = 50
        memory = 10
      }
      config {
        command = "sleep"
        args = ["3600"]
      }
    }
  }
}
