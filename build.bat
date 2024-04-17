packer.exe init ubuntu.pkr.hcl
packer.exe build -var-file=variables.pkr.hcl -var-file=sensitive.variables.pkr.hcl -force ubuntu.pkr.hcl