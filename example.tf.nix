let
  lib = (import <nixpkgs> {}).lib;
  tpls = lib.mapAttrs (name: value: lib.recursiveUpdate {
    tags.name = name;
    ami = "ami-0d729a60";
    instance_type = "t2.nano";
  } value);
in {
  provider.aws.region = "us-east-1";
  resource.aws_instance = tpls {
    one = {};
    two = {
      tags.description = "First!";
      instance_type = "t2.micro";
    };
  };
}
