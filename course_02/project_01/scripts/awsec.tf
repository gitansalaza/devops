provider "aws" {
access_key = "ASIA6RJVA5HBQFNC2M6P"
secret_key = "JUIa+KnQKcAW5UtKn7g8zwHN0YHNJqOhz9bF2Ksy"
token = "FwoGZXIvYXdzEGEaDIV8B4Amjh4GN9x+iSK6AewEQnCUpVzQJIpHaVLj8erKsQJpcXwLnE8c4ySr5ehJAPc1W/3en/JyhSKXaYoD0WLg2KV9x7AuZUGrkBF0yGaSOFy4RS5Ws7xZ1HnhLqVOcg/XTWsb9gR3tA8Sp5VYyF7r8l9FZWxkh4UZOCZ0G3FoWN/vu0IUb5BFb63MIWKXczGiWKiBvsAWeR4rVHSILJoWA2ey9cIqUAoYz5EVHwTs0A9xiLplr0jOXPmge1YLzn7Re/uAt4m49SiP1s6VBjItVGVHyRmpiA8Yg6c5t3TE6VYSj8E3DufOSVDEm0bqZqc4NjQw1fO1OLiVIbE4"
region = "us-east-1"
}

resource "aws_instance" "terraform_demo" {
ami = "ami-09e67e426f25ce0d7"
instance_type = "t2.micro"
}
