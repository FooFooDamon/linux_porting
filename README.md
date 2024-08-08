# Linux移植 | Linux Porting

## 简介 | Introduction

* 若干个自娱自乐的Linux内核移植项目。
    > Several Linux kernel porting projects for fun.

* 所有项目**仅供学习之用**！强烈**不建议**在**生产环境使用**！
    > All projects are **for STUDYINIG ONLY**!
    **Use in PRODUCTION environment** is STRONGLY **DISCOURAGED**!

## 简单演示 | Simple Demonstration

进入你感兴趣的样例目录，并执行以下操作：

> Switch to one of the example directories that interests you,
and perform the following operations:

````
$ make prepare # Only needed at the first time
$
$ make help # If you need help
$
$ make menuconfig && make # Or other directives depending on your need and the help info above
$
$ sudo -E make xxx_install # Some directives need sudo command and its -E option
````

## 许可证 | License

`GPL-2.0`

