packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}


source "azure-arm" "autogenerated_1" {

  client_id                         = "CLIENT_ID"
  client_secret                     = "CLIENT_SECRET"
  image_offer                       = "almalinux-x86_64"
  image_publisher                   = "almalinux"
  image_sku                         = "9-gen2"
  location                          = "East US"
  managed_image_name                = "almaimg-dodstig-v1"
  managed_image_resource_group_name = "packer-rg"
  os_type                           = "Linux"
  subscription_id                   = "SUBSCRIPTION_ID"
  tenant_id                         = "TENANT_ID"
  vm_size                           = "Standard_B2s"
}

build {
  sources = ["source.azure-arm.autogenerated_1"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = [
		"yum update -y", 
    "yum install -y openscap openscap-scanner openscap-utils scap-security-guide",
    "oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_stig --remediate --fetch-remote-resources /usr/share/xml/scap/ssg/content/ssg-almalinux9-ds.xml",
		"/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
	]
    inline_shebang  = "/bin/sh -x"
  }
}
