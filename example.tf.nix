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
