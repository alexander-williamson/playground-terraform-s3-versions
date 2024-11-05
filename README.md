# playground-terraform-s3-versions
Understanding how s3 versioning works with terraform

### 1. Init and deploy

```bash
terraform init
terraform apply --auto-approve
```

You'll see that two files are created:
- first_file.txt
- first_file_without_etag.txt


### 2. Create an update

Update `/data/first_file.txt` - add a new line with some content and save the file.

Upload the file via Terraform `apply`:

```bash
terraform apply --auto-approve
```

You'll see that the file with an eTag is updated because the md5 has been evaluated. You will also spot the file without an etag has not been updated - Terraform state holds that the file has been uploaded, then further updates are ignored.