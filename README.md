# Repo for Packer Build Files
HCL Packer files for building out images in Azure to make it easier.  Update the following variables in packer files:

- **CLIENT_ID** = Azure client ID allowed to access the subscription.
- **CLIENT_SECRET** = Azure secret password that goes with the client ID.
- **SUBSCRIPTION_ID** = Azure subscription where the build images will be placed.
- **TENANT_ID** = Azure Tenant ID where the images will be built and placed.

## Alma Linux CIS Level 1 Server
[alma-linux-cis-l1.pkr.hcl](https://github.com/igthorn99/packer-files/blob/main/alma-linux-cis-l1.pkr.hcl)

The packer file is for building an Alma Linux Server with latest patches and CIS Level 1 Server Security applied. Some things will need to be adjusted after the server is running but the following is good way to start.

### Alma Linux with CIS L1 Server Results
![Compliance](https://github.com/igthorn99/packer-files/blob/main/alma-linux-cis-l1-results.png)

## Alma Linux DOD STIG Server
[alma-linux-cis-dodstig-pkr.hcl](https://github.com/igthorn99/packer-files/blob/main/alma-linux-dodstig.pkr.hcl)

Packer file for building out an Alma Linux server with most of the DOD STIGs applied.  This build file will update the image with the latest patches and apply most of the DOD STIGs.  There are a few things that will need to be adjusted.

### Alma Linux with DOD STIG Results
![Compliance](https://github.com/igthorn99/packer-files/blob/main/alma-linux-dodstig-results.png)

## Validation
In order to validate the compliance you will need to build out the Alma Linux server from the Azure Image.

- Build out the Alma Linux image
- Login to the server over SSH
- Run the following command to verify the results:
```
sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_stig --report ~/stig-results.html --fetch-remote-resources /usr/share/xml/scap/ssg/content/ssg-almalinux9-ds.xml
```

# Packer Build Reference
This is the site to start using Packer to build images in Azure.

[Microsoft Learn Create Linux VM Images](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer)
