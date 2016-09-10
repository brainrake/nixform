let
  lib = (import <nixpkgs> {}).lib;
  tpls = lib.mapAttrs (name: lib.recursiveUpdate {
    tags.name = name;
    ami = "ami-0d729a60";
    instance_type = "t2.nano";
  });
in {
  provider.aws.region = "us-east-1";
  resource.aws_instance = tpls {
    one = {};
    two = {
      tags.description = "Second!";
      instance_type = "t2.micro";
    };
  };
}
