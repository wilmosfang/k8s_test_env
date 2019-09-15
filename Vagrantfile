
Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "10.1.0.155"
  config.vm.network "private_network", ip: "10.1.0.165"
  config.vm.hostname = "k8s"

   config.vm.provider "virtualbox" do |vb|
  
     vb.memory = "4096"
     vb.cpus = "4"
   end

   config.vm.provision "file", source: "./package", destination: "/tmp/package"
   config.vm.provision "shell",path: "./init.bash"
   config.vm.provision "shell",inline: "sudo su - root -c '/usr/local/bin/minikube stop; /usr/local/bin/minikube start --registry-mirror=https://registry.docker-cn.com --vm-driver=none'", run: "always"
end
