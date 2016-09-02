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
