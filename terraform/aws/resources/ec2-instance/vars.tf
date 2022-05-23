variable "AWS_ACCESS_KEY" {
	default = "AKIA4TNG5PSZNJZYYOPX"
}

variable "AWS_SECRET_KEY" {
}

variable "security-group" {
	type = map(list(string))
	default = {
		"mysg" = ["sg-0946003082685286d"]
		
	}
}

variable "mykey" {
	type = string
	default = "radical-devops-march-2022-oregon"
	
}

variable "subnet" {
	default = "subnet1"
}

variable "subnets" {
	type = map(string)
	default = {
		subnet1 = "subnet-082e9a36b73ccb48e"
		subnet2 = "subnet-0d12be9bbcc82c7e4"
		subnet3 = "subnet-0001af35fc6367fbb"
	}
}


variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-0ca285d4c2cda3300"
    eu-west-1 = "ami-0d729a60"
  }
}


