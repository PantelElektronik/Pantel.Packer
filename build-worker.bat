packer.exe init rancher.node.pkr.hcl
packer.exe build -var-file=rancher-worker.pkrvars.hcl -var-file=sensitive.variables.pkr.hcl -force rancher.node.pkr.hcl