

## Installation
- jx binary
   - ```curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-darwin-amd64.tar.gz" | tar xzv "jx"```
   or
   - ```curl -L https://github.com/jenkins-x/jx/releases/download/v2.1.155/jx-darwin-amd64.tar.gz | tar xzv "jx"```
   - sudo mv jx /usr/local/bin
   - jx version --short

```
February 2021, Jenkins X does not yet sup- port Helm v3+. Make sure that you’re using Helm CLI v2+.
``` 

## Configure jx-requirements.yml
- git clone  https://github.com/jenkins-x/jenkins-x-boot-config.git  environment-$CLUSTER_NAME-dev
- cd environment-$CLUSTER_NAME-dev
- cat jx-requirements.yml
  - the cluster section
    - Set *cluster.clusterName* to the name of your cluster.
    - Set *cluster.environmentGitOwner* to your GitHub user.
    - Set *cluster.project* to the name of your GKE project, only if that’s where your Kubernetes cluster is running. Otherwise, leave that value intact (empty).
    - Set *cluster.provider* to gke or to eks or to any other provider if you decided that you are brave and want to try currently unsupported platforms.
    - Set *cluster.zone* to whichever zone your cluster is running in.
      - If, for example, you used our Gist to create a GKE cluster, the value should be us-east1-b. Similarly, the one for EKS is us-east-1.
  - the gitops value
    - It doesn’t make sense to change it to false, so we’ll leave it as is (true).
  - the environment section
    - The keys are the suffixes, and the final names will be a combination of *environment-* with the name of the cluster followed by the key.
  - ingress section
    - The parameters related to external access to the cluster (domain, TLS, and so on).
  - the kaniko value
    - When set to **true**, the system will build container images using *kaniko* instead of, let’s say, Docker.
    - That is a much better choice since Docker cannot run in a container and, as such, poses a significant security risk (mounted sockets are evil), and it messes with the Kubernetes scheduler given that it bypasses its API
    - *kaniko* is the only supported way to build container images when using *Tekton*, so we’ll leave it as is (**true**).
  - the secretStorage value
    - **local**: If you changed it to local, that location is your laptop. While that is better than a Git repository, you can probably imagine why that is not the right solution.
    - **vault**: A much better place for Secrets is HashiCorp Vault. It is the most commonly used solution for Secret management in Kubernetes (and beyond), and Jenkins X supports it out of the box.
  - the section that defines storage for logs, reports, and repositories.
    - If enabled, those artifacts will be stored on a network drive. As you already know, containers and nodes are short lived, and if we want to preserve any of those, we need to store them elsewhere.
    - Later on, you might choose to change that and, let’s say, ship logs to a central database like Elasticsearch, Papertrail, Cloudwatch, Stackdriver, and so on.
    - For now, we’ll keep it simple and enable network storage for all three types of artifacts:
      - Set the value of *storage.logs.enabled* to true.
      - Set the value of *storage.reports.enabled* to true.
      - Set the value of *storage.repository.enabled* to true.
  - The versionStream section
    - the repository that contains versions of all the packages (charts) used by Jenkins X.
    - You might choose to fork that repository and control versions yourself. Before you jump into doing just that, please note that Jen- kins X versioning is quite complex, given that many packages are involved. Leave it be unless you have a very good reason to take over control of the Jenkins X versioning and you’re ready to maintain it.
  - the webhook section
    - prow: Only supports GitHub. If that’s not your Git provider, Prow is a no-go.
    - lighthouse: Support all major Git providers (such as GitHub, GitHub Enterprise, Bitbucket Server, Bitbucket Cloud, GitLab, and so on).
    
    
## EKS specific configuration
- Add additional information related to **Vault**, namely, the IAM user that has sufficient permissions to interact with it. Make sure to replace [...] with your IAM user that has sufficient permissions (being admin always works):
  - export IAM_USER=[...] # such as jx-boot
  - echo "vault:
      aws:
        autoCreate: true
        iamUserName: \"$IAM_USER\"" \
        | tee -a jx-requirements.yml
        
- for AWS we need a region
  - cat jx-requirements.yml \
        | sed -e \
        's@zone@region@g' \
        | tee jx-requirements.yml
        

```
You might be worried that we missed some of the values. We’ll let boot create the resources that are missing and thus convert the unknowns into knowns.
```        

## Let’s install Jenkins X:
- jx boot: The jx boot interprets the boot pipeline using your local jx binary. The underlying pipeline for booting Jenkins X can later be run inside Kubernetes via Tekton. If ever something goes wrong with Tekton you can always jx boot again to get things back up and running (e.g., if someone accidentally deletes your cluster).
- jx boot --requirements jx-requirements.yml 

## Generate Bot Token
[Optional]
- jx create git server -k GitHub -u https://github.com -a rajat965ng -s <PersonalAccessToken> -n rajat965ng          
- jx create git token rajat965ng

[Required]
- Regex: ^[0-9a-f]{40}$
- Visit: https://www.browserling.com/tools/text-from-regex and generate a token using above regex

- jx step verify env
- jx edit env


## Remove jx
- jx uninstall