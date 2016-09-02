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
let
  lib = (import <nixpkgs> {}).lib;
  tpl = lib.mapAttrs (name: value: lib.recursiveUpdate {
    tags.name = name;
    ami = "ami-0d729a60";
    instance_type = "t2.micro";
  } value);
in {
  provider.aws.region = "us-east-1";
  resource.aws_instance = tpl {
    one.tags.description = "First!";
    two.instance_type = "t2.micro";
  };
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
            "tags" : {
               "name" : "one",
               "description" : "First!"
            },
            "ami" : "ami-0d729a60",
            "instance_type" : "t2.micro"
         }
      }
   },
   "provider" : {
      "aws" : {
         "region" : "us-east-1"
      }
   }
}
```
