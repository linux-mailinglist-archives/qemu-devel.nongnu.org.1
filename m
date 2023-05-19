Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD5709795
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 14:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzzZz-0004hJ-8R; Fri, 19 May 2023 08:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzzZw-0004gx-OR
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzzZu-0007Et-Cz
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684500684;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylUenFu88QVLlPPiBS6tOYSxa0+u44vNeMRD8IlvACo=;
 b=JUSkaAevbeSyaCQiCGRU1p6wBld1yNMiLj1pPxQddXEu9M8E3NOYBJhcr6YdBZV4nHbVyZ
 vuYfeBc7prX3RL42GWo8C5jteAWjHWyVaMuahHso3qoHS940NOJuE2PLct+EMgZVHmjbWV
 pLFaUmHK7797fL+ZX22+TUnShyKVH98=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-vmHBUc1zMte6NXjszzTBVA-1; Fri, 19 May 2023 08:51:23 -0400
X-MC-Unique: vmHBUc1zMte6NXjszzTBVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58ADE3C11CC3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 12:51:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB89B2166B25;
 Fri, 19 May 2023 12:51:22 +0000 (UTC)
Date: Fri, 19 May 2023 13:51:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] Add CI configuration for Kubernetes
Message-ID: <ZGdwyNmhLmBMwaKp@redhat.com>
References: <20230407145252.32955-1-cconte@redhat.com>
 <ZGc6srab3Q7IcUpx@redhat.com>
 <CACPOWh1QSdSiEoSeTyVW2RDpENU0jdyDGWzQAjeKy5g0ShEsOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACPOWh1QSdSiEoSeTyVW2RDpENU0jdyDGWzQAjeKy5g0ShEsOA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Fri, May 19, 2023 at 01:33:50PM +0100, Camilla Conte wrote:
> On Fri, May 19, 2023 at 10:00 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Apr 07, 2023 at 03:52:51PM +0100, Camilla Conte wrote:
> > > Configure Gitlab CI to run on Kubernetes
> > > according to the official documentation.
> > > https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#docker-in-docker-with-tls-enabled-in-kubernetes
> > >
> > > These changes are needed because of the CI jobs
> > > using Docker-in-Docker (dind).
> > > As soon as Docker-in-Docker is replaced with Kaniko,
> > > these changes can be reverted.
> > >
> > > I documented what I did to set up the Kubernetes runner on the wiki:
> > > https://wiki.qemu.org/Testing/CI/KubernetesRunners
> > >
> > > Signed-off-by: Camilla Conte <cconte@redhat.com>
> > > ---
> > >  .gitlab-ci.d/container-template.yml |  6 +++---
> > >  .gitlab-ci.d/default.yml            |  3 +++
> > >  .gitlab-ci.d/opensbi.yml            |  8 +++-----
> > >  .gitlab-ci.d/qemu-project.yml       | 17 +++++++++++++++++
> > >  4 files changed, 26 insertions(+), 8 deletions(-)
> > >  create mode 100644 .gitlab-ci.d/default.yml
> > >
> > > diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> > > index 519b8a9482..f55a954741 100644
> > > --- a/.gitlab-ci.d/container-template.yml
> > > +++ b/.gitlab-ci.d/container-template.yml
> > > @@ -1,14 +1,14 @@
> > >  .container_job_template:
> > >    extends: .base_job_template
> > > -  image: docker:stable
> > > +  image: docker:20.10.16
> > >    stage: containers
> > >    services:
> > > -    - docker:dind
> > > +    - docker:20.10.16-dind
> > >    before_script:
> > >      - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
> > >      - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
> > >      - apk add python3
> > > -    - docker info
> > > +    - until docker info; do sleep 1; done
> > >      - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
> > >    script:
> > >      - echo "TAG:$TAG"
> > > diff --git a/.gitlab-ci.d/default.yml b/.gitlab-ci.d/default.yml
> > > new file mode 100644
> > > index 0000000000..292be8b91c
> > > --- /dev/null
> > > +++ b/.gitlab-ci.d/default.yml
> > > @@ -0,0 +1,3 @@
> > > +default:
> > > +  tags:
> > > +    - $RUNNER_TAG
> >
> > Can we just put this in base.yml instead of creating a new file.
> 
> Sure.
> 
> > > diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> > > index 9a651465d8..5b0b47b57b 100644
> > > --- a/.gitlab-ci.d/opensbi.yml
> > > +++ b/.gitlab-ci.d/opensbi.yml
> > > @@ -42,17 +42,15 @@
> > >  docker-opensbi:
> > >    extends: .opensbi_job_rules
> > >    stage: containers
> > > -  image: docker:stable
> > > +  image: docker:20.10.16
> > >    services:
> > > -    - docker:stable-dind
> > > +    - docker:20.10.16-dind
> >
> > Can you elaborate on this ?  I know the docs about use that particular
> > version tag, but they don't appear to explain why. If this is not
> > actually a hard requirements, we should keep using the stable tag.
> 
> Yes, we can keep using "stable".
> Then, we should be ready to address future issues that may arise from
> "stable" not being compatible with the runner.
> 
> > >    variables:
> > >      GIT_DEPTH: 3
> > >      IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
> > > -    # We don't use TLS
> > > -    DOCKER_HOST: tcp://docker:2375
> > > -    DOCKER_TLS_CERTDIR: ""
> >
> > So IIUC, this was always redundant when using gitlab CI. We should just
> > remove these in a standalone commit.
> 
> Okay, I'll put this in a separate commit.
> 
> > >    before_script:
> > >      - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
> > > +    - until docker info; do sleep 1; done
> >
> > Was this really needed ?  The docs don't show that, and docker login is
> > synchronous, so I wouldn't expect us to them poll on 'docker info'.
> 
> Unfortunately, yes. We need to wait until the "docker info" command is
> successful. This ensures that the Docker server has started and the
> subsequent docker commands won't fail.

> 
> > In container-template.yml we in fact do the reverse
> >
> >     - docker info
> >     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
> 
> About "docker login", as far as I understand it's a client-only
> command. It doesn't involve the Docker server at all. These two
> commands are not related to each other, it doesn't matter if "docker
> login" runs before or after "docker info".
> 
> > imho best make this opensbi.yml file match contanier-template.yml, and
> > could be part of the same cleanup commit that removes thhose two docker
> > env vars.
> 
> You mean to replace the "docker-opensbi" job in the "opensbi.yml" file
> with the same as the ".container_job_template" from the
> "container-template.yml" file?
> These two look too much different to me. I think we need to keep both.

No, I didn't mean we have to merge them. Just that the container-template.yml
file merely does 'docker info' without any loop. So either that one is broken,
or using a loop in opensbi.yml is redundant.

Assuming you've tested this series on k8s successfully, it would indicate
that the looping is not required, otherwise all the container jobs would
have failed.

> > >    script:
> > >      - docker pull $IMAGE_TAG || true
> > >      - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
> > > diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
> > > index a7ed447fe4..57b175f5c2 100644
> > > --- a/.gitlab-ci.d/qemu-project.yml
> > > +++ b/.gitlab-ci.d/qemu-project.yml
> > > @@ -1,7 +1,24 @@
> > >  # This file contains the set of jobs run by the QEMU project:
> > >  # https://gitlab.com/qemu-project/qemu/-/pipelines
> > >
> > > +variables:
> > > +  RUNNER_TAG: ""
> > > +
> > > +workflow:
> > > +  rules:
> > > +    # Set additional variables when running on Kubernetes.
> > > +    # https://wiki.qemu.org/Testing/CI/KubernetesRunners
> > > +    - if: $RUNNER_TAG == "k8s"
> > > +      variables:
> > > +        DOCKER_HOST: tcp://docker:2376
> > > +        DOCKER_TLS_CERTDIR: "/certs"
> > > +        DOCKER_TLS_VERIFY: 1
> > > +        DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
> >
> > Is there anyway we can get the runner itself to set these
> > correctly by default ?
> 
> Yes, the runner can set environment variables for its jobs.
> 
> My concern here is that over time we lose visibility of these
> customizations if we put them in the runner configuration.
> This can be solved by having a repo in the qemu-project namespace to
> host the runner configuration, something like I did here:
> https://gitlab.com/spotlesstofu/qemu-ci-kubernetes.

Cleber put configs for the current QEMU private runners into
the main qemu.git at scripts/ci/setup/  We should have any
setup for the k8s runner somewhere nearby too. Or move all
of it out into a separate repository.

> > IMHO the ideal would be that the k8s runners are registerd with the
> > qemu project to run *any* jobs without requiring tags. That way the
> > runners will "just work" when share runners are unavailable/exhausted,
> > like we have with Eldon's runner
> 
> The problem here is that the Kubernetes (k8s) runner can't run windows
> jobs at the moment. If we wait for the shared runners to be exhausted,
> those few windows jobs in the pipeline won't be able to run.

Hmm, that's awkward. I'm not convinced we should be expecting the maintainer
doing staging builds to decide whether or not to the set tag when running a
pipeline. I guess maybe we can set 'RUNNER_TAG' in the web UI settings for
CI, to turn it on globally for qemu.git upstream.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


