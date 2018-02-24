<img src="https://cloutainer.github.io/documentation/images/cloutainer.svg?v5" align="right">

# k8s-jenkins-slave-php

[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-430.svg)](https://hub.docker.com/r/cloutainer/k8s-jenkins-slave-php/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-ubuntu-16.04.svg)](https://www.ubuntu.com/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Kubernetes Docker image providing Jenkins Slave JNLP with PHP and Composer.


-----
&nbsp;

### Preinstalled Tools

| tool | version |
|------|---------|
| composer | 1.6.3 |
| php | 7.0.25 |
| git | apt-get |
| curl, wget | apt-get |
| zip, bzip2 | apt-get |
| jq | apt-get |

-----
&nbsp;

### Usage

Use with [Kubernetes Jenkins Plugin](https://github.com/jenkinsci/kubernetes-plugin) like so:

```groovy
podTemplate(
  name: 'php-v1',
  label: 'k8s-jenkins-slave-php-v1',
  cloud: 'mycloud',
  nodeSelector: 'failure-domain.beta.kubernetes.io/zone=eu-west-1a',
  containers: [
    containerTemplate(
      name: 'jnlp',
      image: 'cloutainer/k8s-jenkins-slave-php:v1',
      privileged: false,
      command: '/opt/docker-entrypoint.sh',
      args: '',
      alwaysPullImage: false,
      workingDir: '/home/jenkins',
      resourceRequestCpu: '500m',
      resourceLimitCpu: '1',
      resourceRequestMemory: '3000Mi',
      resourceLimitMemory: '3000Mi'
    )
  ]
) {
  node('k8s-jenkins-slave-php-v1') {
    stage('build and test') {
      sh 'mvn -version'
      sh 'git clone https://github.com/clouless/WHATEVERAPP.git'
      dir('whateverapp') {
        sh 'composer require'
      }
    }
  }
}
```


-----
&nbsp;

### License

[MIT](https://github.com/cloutainer/k8s-jenkins-slave-php/blob/master/LICENSE) © [Bernhard Grünewaldt](https://github.com/clouless)
