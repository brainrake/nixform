# nixform
define terraform infrastructure in Nix

Terraform by Hashicorp is a great tool with a meh language. Fixed.

## Installation

First, [install nix](https://nixos.org/nix/download.html). Then,

```
# clone the repo
git clone https://github.com/brainrape/nixform.git
cd nixform

# start a shell in an env with all tools and dependencies installed
nix-shell
```

## Usage

Create a file [example.tf.nix](example.tf.nix) containing a nix expression that evaluates to a set that looks like terraform's json format.

```nix
{
  provider.aws.region = "us-east-1";
  resource.aws_instance = builtins.listToAttrs (map (name : {
    name = name;
    value = {
      ami = "ami-0d729a60";
      instance_type = "t2.micro";
      tags.name = name;
    };
  }) ["one" "two"]);
}
```

Then use `nixform` instead of `terraform`.

```
./nixform apply
```


## How?

Before running `terraform` with the given arguments, `*.tf.nix` is evaluated strictly and output in terraform json format. The above example will produce an [example.tf.json](example.tf.json) like this:
```json
{
   "provider" : {
      "aws" : {
         "region" : "us-east-1"
      }
   },
   "resource" : {
      "aws_instance" : {
         "two" : {
            "instance_type" : "t2.micro",
            "ami" : "ami-0d729a60",
            "tags" : {
               "name" : "two"
            }
         },
         "one" : {
            "ami" : "ami-0d729a60",
            "instance_type" : "t2.micro",
            "tags" : {
               "name" : "one"
            }
         }
      }
   }
}
```
