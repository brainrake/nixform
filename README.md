# nixform
define terraform infrastructure in Nix

Terraform by Hashicorp is a great tool with a meh language. Fixed.

## Installation

First, [install nix](https://nixos.org/nix/download.html). Then,

```
$ # install terraform
$ nix-env -i terraform
$ # get the script
$ wget https://raw.githubusercontent.com/brainrape/nixform/master/nixform
```

## Usage

Create a file `main.nf` containing a nix expression that evaluates to a set that looks like terraform's json syntax.

```nix
{
  resource.aws_instance.example = {
    ami           = "ami-0d729a60";
    instance_type = "t2.micro";
  };
}
```

Then use `nixform` instead of `terraform`.

```
nixform apply
```
