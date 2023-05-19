Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A211D70925D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvye-0006tV-8Q; Fri, 19 May 2023 05:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzvyc-0006sm-77
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzvyZ-0000qI-Qo
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HQ2OKeG+EDciB1PzvRUKfmV16cWMLw+AnN3xBjgMz40=;
 b=VIznzF206F7bPgXbNH+xXSP9+YyWDh1jY1vhcFkWhAH1M/Rg1mNWc5Z9G+tY7Yzg28oUh6
 4VgLljoI3qRgZDXqq8IomKPuCtyQ+rDlVvEDsL5MBR1nfZA6IinCta0X/akRtinyxy2HC6
 P0/KzIAPSu0w+A67bafwIUevDopnoDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-g7Se1fOCOEak4jh2Q5OFBg-1; Fri, 19 May 2023 05:00:38 -0400
X-MC-Unique: g7Se1fOCOEak4jh2Q5OFBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C74CC101B048
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 09:00:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38967C0004B;
 Fri, 19 May 2023 09:00:37 +0000 (UTC)
Date: Fri, 19 May 2023 10:00:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] Add CI configuration for Kubernetes
Message-ID: <ZGc6srab3Q7IcUpx@redhat.com>
References: <20230407145252.32955-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230407145252.32955-1-cconte@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Apr 07, 2023 at 03:52:51PM +0100, Camilla Conte wrote:
> Configure Gitlab CI to run on Kubernetes
> according to the official documentation.
> https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#docker-in-docker-with-tls-enabled-in-kubernetes
> 
> These changes are needed because of the CI jobs
> using Docker-in-Docker (dind).
> As soon as Docker-in-Docker is replaced with Kaniko,
> these changes can be reverted.
> 
> I documented what I did to set up the Kubernetes runner on the wiki:
> https://wiki.qemu.org/Testing/CI/KubernetesRunners
> 
> Signed-off-by: Camilla Conte <cconte@redhat.com>
> ---
>  .gitlab-ci.d/container-template.yml |  6 +++---
>  .gitlab-ci.d/default.yml            |  3 +++
>  .gitlab-ci.d/opensbi.yml            |  8 +++-----
>  .gitlab-ci.d/qemu-project.yml       | 17 +++++++++++++++++
>  4 files changed, 26 insertions(+), 8 deletions(-)
>  create mode 100644 .gitlab-ci.d/default.yml
> 
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index 519b8a9482..f55a954741 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -1,14 +1,14 @@
>  .container_job_template:
>    extends: .base_job_template
> -  image: docker:stable
> +  image: docker:20.10.16
>    stage: containers
>    services:
> -    - docker:dind
> +    - docker:20.10.16-dind
>    before_script:
>      - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
>      - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
>      - apk add python3
> -    - docker info
> +    - until docker info; do sleep 1; done
>      - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
>    script:
>      - echo "TAG:$TAG"
> diff --git a/.gitlab-ci.d/default.yml b/.gitlab-ci.d/default.yml
> new file mode 100644
> index 0000000000..292be8b91c
> --- /dev/null
> +++ b/.gitlab-ci.d/default.yml
> @@ -0,0 +1,3 @@
> +default:
> +  tags:
> +    - $RUNNER_TAG

Can we just put this in base.yml instead of creating a new file.

> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> index 9a651465d8..5b0b47b57b 100644
> --- a/.gitlab-ci.d/opensbi.yml
> +++ b/.gitlab-ci.d/opensbi.yml
> @@ -42,17 +42,15 @@
>  docker-opensbi:
>    extends: .opensbi_job_rules
>    stage: containers
> -  image: docker:stable
> +  image: docker:20.10.16
>    services:
> -    - docker:stable-dind
> +    - docker:20.10.16-dind

Can you elaborate on this ?  I know the docs about use that particular
version tag, but they don't appear to explain why. If this is not
actually a hard requirements, we should keep using the stable tag.

>    variables:
>      GIT_DEPTH: 3
>      IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
> -    # We don't use TLS
> -    DOCKER_HOST: tcp://docker:2375
> -    DOCKER_TLS_CERTDIR: ""

So IIUC, this was always redundant when using gitlab CI. We should just
remove these in a standalone commit.

>    before_script:
>      - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
> +    - until docker info; do sleep 1; done

Was this really needed ?  The docs don't show that, and docker login is
synchronous, so I wouldn't expect us to them poll on 'docker info'.

In container-template.yml we in fact do the reverse

    - docker info
    - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"

imho best make this opensbi.yml file match contanier-template.yml, and
could be part of the same cleanup commit that removes thhose two docker
env vars.

>    script:
>      - docker pull $IMAGE_TAG || true
>      - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
> index a7ed447fe4..57b175f5c2 100644
> --- a/.gitlab-ci.d/qemu-project.yml
> +++ b/.gitlab-ci.d/qemu-project.yml
> @@ -1,7 +1,24 @@
>  # This file contains the set of jobs run by the QEMU project:
>  # https://gitlab.com/qemu-project/qemu/-/pipelines
>  
> +variables:
> +  RUNNER_TAG: ""
> +
> +workflow:
> +  rules:
> +    # Set additional variables when running on Kubernetes.
> +    # https://wiki.qemu.org/Testing/CI/KubernetesRunners
> +    - if: $RUNNER_TAG == "k8s"
> +      variables:
> +        DOCKER_HOST: tcp://docker:2376
> +        DOCKER_TLS_CERTDIR: "/certs"
> +        DOCKER_TLS_VERIFY: 1
> +        DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"

Is there anyway we can get the runner itself to set these
correctly by default ?

IMHO the ideal would be that the k8s runners are registerd with the
qemu project to run *any* jobs without requiring tags. That way the
runners will "just work" when share runners are unavailable/exhausted,
like we have with Eldon's runner

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


