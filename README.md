# Packer AMI Pipeline
This project will be assocaited with an upcoming featured blog post based on 
efforts of the Fanatical Support on AWS Professional Services team. The content
is meant to provide documentation and examples to support this blog post.

A focus was spent on automation using AWS native tools and CloudFormation. Using this, we can
easily set up a full build pipeline using CodeCommit, S3, CodePipeline, CodeBuild 
and [HashiCorp Packer](https://www.packer.io/).

There are dozens, maybe hundreds of ways to do this using other build systems,
such as Jenkins. Comparatively there is less done using AWS sevices, expecially
on their newest service called [CodeBuild](https://aws.amazon.com/documentation/codebuild/).
We saw this as a challenge and opportunity to gain knowledge on these services,
and ultimately set out to help get that knowlege out to others based on our work.

## Automation
Cloudformation templates are provided for setting up CodePipeline and the S3
buckets used. The templates also set up CodeBuild projects which pull another
project from CodeCommit. This project houses the required `buildspec.yml` and
automation scripts used to install and run Packer.

### Assumptions
- Base AMI used is Ubuntu 16.04
- Instance size used is t2.micro
- Simple linux commands using the shell provisioner were used to configure the 
instance with Packer to install Apache. This is provided as an example and is 
not in the scope of this project.

## Usage
It is encouraged to follow the directions step by step if this is your first time
ever interacting with these services. You can then examine the results and focus
more on what Cloudformation has provisioned rather than the Cloudformation
templates themselves.

General steps for usage:

1. Provistion and push the CodeCommit repository using the files from the 
 codecommit directory in this project.
2. Deploy Cloudformation template for necessary IAM roles.
3. Deploy Cloudformation template to build pipeline and refence created
 CodeCommit and IAM roles.
4. Push a change or manually run CodePipeline to build a new AMI.

### Limitations
- CodeBuild does not run inside your VPC, which makes the Packer SSH access
require a public instance to configure.
- Packer has a bug with the go-sdk where is does not properly source ECS role
credentials. We have implemented a workaround in the buildspec.yml and filed
the bug with HashiCorp [here](https://github.com/hashicorp/packer/issues/4279).

## Takeaways
It is important to note that once you get a grasp for what
is taking place, you can mold this into whatever you see fit.

Some examples are:
- Replacing CodeCommit with Github.
- Using other Packer provisioners such as Chef, Ansible or Salt.
- Tying additional steps into CodePipeline to add testing or further automation.
