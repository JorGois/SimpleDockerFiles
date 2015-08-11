Based on Centos7 and it has ssh running


Build a image

'''sh
$ docker build -t=jgois/docker_centos7_with_ssh
'''

Run a container

'''sh
$ docker run -d -P -t -i jgois/docker_centos7_with_ssh
'''

or

'''sh
$ docker run -d -P -p 0.0.0.0:2222:22 -t -i jgois/docker_centos7_with_ssh
'''

Connect with ssh

'''sh
$ ssh -p 2222 root@localhost
'''

and the password is password
