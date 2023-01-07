# 테라폼 변수 정의 및 선언
variable "myvar" {
    type = string
    default = "hello terraform"
}

variable "mymap" {
    type = map(string)
    default = {
        mykey = "my value"
    }
}

variable "mylist" {
    type = list(string)
    default = ["a","b","c"]
}