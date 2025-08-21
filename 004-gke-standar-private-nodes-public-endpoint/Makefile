init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

validate:
	terraform validate

list:
	terraform state list

show:
	terraform state show ${uri}

clean:
	rm -rf .terraform*
	rm -f terraform.tfstate*

install-terraform:
	echo "Instalando Terraform 1.12.2 en ~/.local/bin ..."
	mkdir -p ~/.local/bin
	wget https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip -O /tmp/terraform.zip
	unzip -o /tmp/terraform.zip -d ~/.local/bin
	chmod +x ~/.local/bin/terraform
	rm /tmp/terraform.zip
	echo "Terraform instalado correctamente en ~/.local/bin"
	echo 'export PATH=$$PATH:$$HOME/.local/bin' >> $$HOME/.bashrc
