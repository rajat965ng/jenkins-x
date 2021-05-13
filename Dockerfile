from jenkins/jenkins


# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher
RUN /usr/local/bin/install-plugins.sh image-tag-parameter

# SCM
RUN /usr/local/bin/install-plugins.sh gitlab-plugin generic-webhook-trigger
RUN /usr/local/bin/install-plugins.sh gitlab-plugin gitee pipeline-github pipeline-maven multibranch-scan-webhook-trigger
RUN /usr/local/bin/install-plugins.sh gitlab-plugin jjwt-api urltrigger copyartifact
RUN /usr/local/bin/install-plugins.sh gitlab-plugin terraform hashicorp-vault-plugin hashicorp-vault-pipeline thycotic-vault semantic-versioning-plugin


# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin
RUN /usr/local/bin/install-plugins.sh blueocean blueocean-dashboard workflow-aggregator ant nodejs sonar jira test-results-aggregator

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes nexus-jenkins-plugin
RUN /usr/local/bin/install-plugins.sh kubernetes-cli
RUN /usr/local/bin/install-plugins.sh qualys-cs
RUN /usr/local/bin/install-plugins.sh docker-slaves docker-build-step


USER root
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce docker-ce-cli containerd.io -y
RUN usermod -aG docker jenkins
EXPOSE 8080 50000