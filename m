Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC7709744
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 14:35:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzzJm-000181-Fc; Fri, 19 May 2023 08:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1pzzJZ-00017G-Il
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1pzzJV-0003Nu-Ik
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684499668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AkAUSrYIpxbYZgndFFi6klLkl3LQUDRW0F1tiewiAM=;
 b=RsO7L4KAaqfaALzdmkoPLBFoJFOl/PY9rPQjkzEqju27x3Ju30BtzNhNh1YBlE5/CdndGf
 AMxqBSQPwL2wDHEV6UbuTo9haXgejjBOufgTPGROa2nIPhIUGQMhUcksOahYv1qiPYUBlw
 Jjq+H4uYRtuGJ5AcxjQSeTuDFUAQwAo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-wyp2uxd0Ny63dGFqsgoImA-1; Fri, 19 May 2023 08:34:27 -0400
X-MC-Unique: wyp2uxd0Ny63dGFqsgoImA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f4d7e97a37so21603301cf.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 05:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684499666; x=1687091666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7AkAUSrYIpxbYZgndFFi6klLkl3LQUDRW0F1tiewiAM=;
 b=IXxmXPO5Y1qDFjuHtxsKUf2i18DX4XcL3k/4BR6V0VSJbqGezTg97j4AW4zz3ZjT/e
 qbycavZ0F8C7FfzUj1hkMaACsp6dFXMRBsYmP/fMbYDwxyMN9DE2S1lB7Ef0LHCD7Dh5
 /JywUQcyKj3tWUoteU5K/8YXh70do9sV2rai+jnAwQQ9KDEYCci70JXGVrg2H9gnjuzz
 DJYPkYYGW0xtkqKxXPM5XGDpKRQxUkLwtggpqyJaBQS80A2Y9WGMFEc5dg5AnAgWrd3P
 yfFkLHV3iGssgz4riEBjA+KI9dL3hAMtmSanu1wGrhdj05SnAUwyaPLJhTj5RbLDl1t7
 +s9Q==
X-Gm-Message-State: AC+VfDx50/9koeGaERLY6ncxn2J/67Vp715M0olHNhUPsUzF8wzWD5q5
 0S5f3WaILWgCh70iTVRMUaou+v3GHo4JWBaCqlJoTu7t+PuMaN34FidPNLqahKF1+UQ6O2n861p
 LTKSuN6jhl9bvqef+5keCulpwsj0CFhZ9V58IXeCkgw==
X-Received: by 2002:a05:622a:1a8c:b0:3e4:d1c0:36a9 with SMTP id
 s12-20020a05622a1a8c00b003e4d1c036a9mr3387300qtc.48.1684499666250; 
 Fri, 19 May 2023 05:34:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ738OICkRe3nBzTy5869I0anTpQaaxT4GrZPrs2vp4y4vsuS9eL+nHghOfd7MAtLFhd/64jqFuMsR/lPQSY8f0=
X-Received: by 2002:a05:622a:1a8c:b0:3e4:d1c0:36a9 with SMTP id
 s12-20020a05622a1a8c00b003e4d1c036a9mr3387262qtc.48.1684499665931; Fri, 19
 May 2023 05:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230407145252.32955-1-cconte@redhat.com>
 <ZGc6srab3Q7IcUpx@redhat.com>
In-Reply-To: <ZGc6srab3Q7IcUpx@redhat.com>
From: Camilla Conte <cconte@redhat.com>
Date: Fri, 19 May 2023 13:33:50 +0100
Message-ID: <CACPOWh1QSdSiEoSeTyVW2RDpENU0jdyDGWzQAjeKy5g0ShEsOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add CI configuration for Kubernetes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, May 19, 2023 at 10:00=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Fri, Apr 07, 2023 at 03:52:51PM +0100, Camilla Conte wrote:
> > Configure Gitlab CI to run on Kubernetes
> > according to the official documentation.
> > https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#docker-in-=
docker-with-tls-enabled-in-kubernetes
> >
> > These changes are needed because of the CI jobs
> > using Docker-in-Docker (dind).
> > As soon as Docker-in-Docker is replaced with Kaniko,
> > these changes can be reverted.
> >
> > I documented what I did to set up the Kubernetes runner on the wiki:
> > https://wiki.qemu.org/Testing/CI/KubernetesRunners
> >
> > Signed-off-by: Camilla Conte <cconte@redhat.com>
> > ---
> >  .gitlab-ci.d/container-template.yml |  6 +++---
> >  .gitlab-ci.d/default.yml            |  3 +++
> >  .gitlab-ci.d/opensbi.yml            |  8 +++-----
> >  .gitlab-ci.d/qemu-project.yml       | 17 +++++++++++++++++
> >  4 files changed, 26 insertions(+), 8 deletions(-)
> >  create mode 100644 .gitlab-ci.d/default.yml
> >
> > diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/contain=
er-template.yml
> > index 519b8a9482..f55a954741 100644
> > --- a/.gitlab-ci.d/container-template.yml
> > +++ b/.gitlab-ci.d/container-template.yml
> > @@ -1,14 +1,14 @@
> >  .container_job_template:
> >    extends: .base_job_template
> > -  image: docker:stable
> > +  image: docker:20.10.16
> >    stage: containers
> >    services:
> > -    - docker:dind
> > +    - docker:20.10.16-dind
> >    before_script:
> >      - export TAG=3D"$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
> >      - export COMMON_TAG=3D"$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:l=
atest"
> >      - apk add python3
> > -    - docker info
> > +    - until docker info; do sleep 1; done
> >      - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTR=
Y_PASSWORD"
> >    script:
> >      - echo "TAG:$TAG"
> > diff --git a/.gitlab-ci.d/default.yml b/.gitlab-ci.d/default.yml
> > new file mode 100644
> > index 0000000000..292be8b91c
> > --- /dev/null
> > +++ b/.gitlab-ci.d/default.yml
> > @@ -0,0 +1,3 @@
> > +default:
> > +  tags:
> > +    - $RUNNER_TAG
>
> Can we just put this in base.yml instead of creating a new file.

Sure.

> > diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> > index 9a651465d8..5b0b47b57b 100644
> > --- a/.gitlab-ci.d/opensbi.yml
> > +++ b/.gitlab-ci.d/opensbi.yml
> > @@ -42,17 +42,15 @@
> >  docker-opensbi:
> >    extends: .opensbi_job_rules
> >    stage: containers
> > -  image: docker:stable
> > +  image: docker:20.10.16
> >    services:
> > -    - docker:stable-dind
> > +    - docker:20.10.16-dind
>
> Can you elaborate on this ?  I know the docs about use that particular
> version tag, but they don't appear to explain why. If this is not
> actually a hard requirements, we should keep using the stable tag.

Yes, we can keep using "stable".
Then, we should be ready to address future issues that may arise from
"stable" not being compatible with the runner.

> >    variables:
> >      GIT_DEPTH: 3
> >      IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
> > -    # We don't use TLS
> > -    DOCKER_HOST: tcp://docker:2375
> > -    DOCKER_TLS_CERTDIR: ""
>
> So IIUC, this was always redundant when using gitlab CI. We should just
> remove these in a standalone commit.

Okay, I'll put this in a separate commit.

> >    before_script:
> >      - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_R=
EGISTRY
> > +    - until docker info; do sleep 1; done
>
> Was this really needed ?  The docs don't show that, and docker login is
> synchronous, so I wouldn't expect us to them poll on 'docker info'.

Unfortunately, yes. We need to wait until the "docker info" command is
successful. This ensures that the Docker server has started and the
subsequent docker commands won't fail.

> In container-template.yml we in fact do the reverse
>
>     - docker info
>     - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_P=
ASSWORD"

About "docker login", as far as I understand it's a client-only
command. It doesn't involve the Docker server at all. These two
commands are not related to each other, it doesn't matter if "docker
login" runs before or after "docker info".

> imho best make this opensbi.yml file match contanier-template.yml, and
> could be part of the same cleanup commit that removes thhose two docker
> env vars.

You mean to replace the "docker-opensbi" job in the "opensbi.yml" file
with the same as the ".container_job_template" from the
"container-template.yml" file?
These two look too much different to me. I think we need to keep both.

> >    script:
> >      - docker pull $IMAGE_TAG || true
> >      - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$C=
I_COMMIT_SHA
> > diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.=
yml
> > index a7ed447fe4..57b175f5c2 100644
> > --- a/.gitlab-ci.d/qemu-project.yml
> > +++ b/.gitlab-ci.d/qemu-project.yml
> > @@ -1,7 +1,24 @@
> >  # This file contains the set of jobs run by the QEMU project:
> >  # https://gitlab.com/qemu-project/qemu/-/pipelines
> >
> > +variables:
> > +  RUNNER_TAG: ""
> > +
> > +workflow:
> > +  rules:
> > +    # Set additional variables when running on Kubernetes.
> > +    # https://wiki.qemu.org/Testing/CI/KubernetesRunners
> > +    - if: $RUNNER_TAG =3D=3D "k8s"
> > +      variables:
> > +        DOCKER_HOST: tcp://docker:2376
> > +        DOCKER_TLS_CERTDIR: "/certs"
> > +        DOCKER_TLS_VERIFY: 1
> > +        DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
>
> Is there anyway we can get the runner itself to set these
> correctly by default ?

Yes, the runner can set environment variables for its jobs.

My concern here is that over time we lose visibility of these
customizations if we put them in the runner configuration.
This can be solved by having a repo in the qemu-project namespace to
host the runner configuration, something like I did here:
https://gitlab.com/spotlesstofu/qemu-ci-kubernetes.

> IMHO the ideal would be that the k8s runners are registerd with the
> qemu project to run *any* jobs without requiring tags. That way the
> runners will "just work" when share runners are unavailable/exhausted,
> like we have with Eldon's runner

The problem here is that the Kubernetes (k8s) runner can't run windows
jobs at the moment. If we wait for the shared runners to be exhausted,
those few windows jobs in the pipeline won't be able to run.


> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


