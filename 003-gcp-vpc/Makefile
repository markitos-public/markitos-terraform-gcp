init:
	terraform init
reinit:
	terraform init -upgrade

plan:
	terraform plan

apply:
	terraform apply

aapply:
	terraform apply -auto-approve=true

validate:
	terraform validate

format:
	terraform fmt

version:
	terraform version

destroy:
	terraform destroy

adestroy:
	terraform destroy -auto-approve=true

show:
	terraform show

clean:
	rm -fr .terraform* *.tfstate*

install-terraform:
	echo "Instalando Terraform 1.12.2 en ~/.local/bin ..."
	mkdir -p ~/.local/bin
	wget https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip -O /tmp/terraform.zip
	unzip -o /tmp/terraform.zip -d ~/.local/bin
	chmod +x ~/.local/bin/terraform
	rm /tmp/terraform.zip
	echo "Terraform instalado correctamente en ~/.local/bin"
	echo 'export PATH=$$PATH:$$HOME/.local/bin' >> $$HOME/.bashrc
