Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFD7120E1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Rph-0003h1-IJ; Fri, 26 May 2023 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2Rpf-0003gt-K7
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2Rpd-00039p-Kt
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685085946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enx9UTJ2lbBYfoLfgY15ZS7dEDLUXWEDJ9djDQPKYiQ=;
 b=BWbC8XT0EbwEx50HxEjh7XBl3PT72TUnCk8kehfhC/0h/MRY+zfCerX4bW9b+60HA6Rm1l
 O3s+ijzdojnD95fbMAGxoDsqqZdFWxRomMfH314mh6LOMqrSAl73eJMZaebdPWqot13ypz
 LpyjzCMHYH11GKcAw8dCZWek3l/+5Rk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-XEURKQf2O9eg-V7uRrohuA-1; Fri, 26 May 2023 03:25:42 -0400
X-MC-Unique: XEURKQf2O9eg-V7uRrohuA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60536450eso3014505e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685085941; x=1687677941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=enx9UTJ2lbBYfoLfgY15ZS7dEDLUXWEDJ9djDQPKYiQ=;
 b=TFW3IBssVSa+4sF5Ol/mCvo380ejcVzej3jdYAEaRhHWCXfvjffivuXCRFP5rPbwL9
 Zv9Qb8HBwtWXIzw+Oc5Jjve0/IwTBpbibeRHi95zuEJCrs8RK1g0ScA3On0KqJj5R/xP
 BCwfPbFcPc6V/nqWGA1WrdWHaU+Vm4fTORNoWmEkzsvLQkZhTdUDjXe42mzHaLOCj/vh
 QyhehAW9JaJufESjPNJROIkMnJa0YmuW5JfN7oWO95AcLNSqv//cDw3rHmek5V4uBqG1
 nnKGIJtGNOFA8yeyvc1hsRV5IClM6QOtFK7u2By7JreDiqh/F5Duq5qBMXzNeKKTgBfB
 bxuQ==
X-Gm-Message-State: AC+VfDzDNDyaXFT4hi2CCyv5wn8NheHgP1bHav+Lr5mHrQwaQsD3cnrD
 ieY06nrYK3OPPjCUL4R3HmYcqdgaiytUmfUluLVd/7II7dlK2q+bx+DWpwsBLbiX8FEkBwnfd/1
 vfeuUrCFyX1HBM8A=
X-Received: by 2002:adf:d4cb:0:b0:30a:bf2b:e020 with SMTP id
 w11-20020adfd4cb000000b0030abf2be020mr596468wrk.45.1685085941818; 
 Fri, 26 May 2023 00:25:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xMbmGPI5JM+PHOuB0u98zIoFyudY3/mAnCqYOF+Aj9aSuo5/0id+uz4f3lzYpzZgt4UYUnA==
X-Received: by 2002:adf:d4cb:0:b0:30a:bf2b:e020 with SMTP id
 w11-20020adfd4cb000000b0030abf2be020mr596458wrk.45.1685085941542; 
 Fri, 26 May 2023 00:25:41 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4082000000b002feea065cc9sm4109286wrp.111.2023.05.26.00.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 00:25:41 -0700 (PDT)
Message-ID: <0626bd64-581b-0324-a1d7-8eee741fc08f@redhat.com>
Date: Fri, 26 May 2023 09:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] gitlab: centralize the container tag name
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230517135448.262483-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/05/2023 15.54, Daniel P. Berrangé wrote:
> We use a fixed container tag of 'latest' so that contributors' forks
> don't end up with an ever growing number of containers as they work
> on throwaway feature branches.
> 
> This fixed tag causes problems running CI upstream in stable staging
> branches, however, because the stable staging branch will publish old
> container content that clashes with that needed by primary staging
> branch. This makes it impossible to reliably run CI pipelines in
> parallel in upstream for different staging branches.
> 
> This introduces $QEMU_CI_CONTAINER_TAG global variable as a way to
> change which tag container publishing uses. Initially it can be set
> by contributors as a git push option if they want to override the
> default use of 'latest' eg
> 
>    git push gitlab <branch> -o ci.variable=QEMU_CONTAINER_TAG=fish
> 
> this is useful if contributors need to run pipelines for different
> branches concurrently in their forks.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml                | 6 ++++++
>   .gitlab-ci.d/buildtest-template.yml  | 4 ++--
>   .gitlab-ci.d/buildtest.yml           | 4 ++--
>   .gitlab-ci.d/container-template.yml  | 3 ++-
>   .gitlab-ci.d/crossbuild-template.yml | 6 +++---
>   .gitlab-ci.d/static_checks.yml       | 4 ++--
>   docs/devel/ci-jobs.rst.inc           | 5 +++++
>   7 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 2fbb58d2a3..fba9d31cc6 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -1,4 +1,10 @@
>   
> +variables:
> +  # On stable branches this needs changing. Should also be
> +  # overridden per pipeline if running pipelines concurrently
> +  # for different branches in contributor forks.
> +  QEMU_CI_CONTAINER_TAG: latest
> +
>   # The order of rules defined here is critically important.
>   # They are evaluated in order and first match wins.
>   #
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index a6cfe9be97..094ae485b8 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -1,7 +1,7 @@
>   .native_build_job_template:
>     extends: .base_job_template
>     stage: build
> -  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
>     before_script:
>       - JOBS=$(expr $(nproc) + 1)
>     script:
> @@ -44,7 +44,7 @@
>   .common_test_job_template:
>     extends: .base_job_template
>     stage: test
> -  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
>     script:
>       - scripts/git-submodule.sh update
>           $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index bb3650a51c..35867dfe77 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -532,7 +532,7 @@ build-without-defaults:
>   build-libvhost-user:
>     extends: .base_job_template
>     stage: build
> -  image: $CI_REGISTRY_IMAGE/qemu/fedora:latest
> +  image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
>     needs:
>       job: amd64-fedora-container
>     script:
> @@ -572,7 +572,7 @@ build-tools-and-docs-debian:
>   # of what topic branch they're currently using
>   pages:
>     extends: .base_job_template
> -  image: $CI_REGISTRY_IMAGE/qemu/debian-amd64:latest
> +  image: $CI_REGISTRY_IMAGE/qemu/debian-amd64:$QEMU_CI_CONTAINER_TAG
>     stage: test
>     needs:
>       - job: build-tools-and-docs-debian
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index 519b8a9482..83c693c807 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -5,7 +5,8 @@
>     services:
>       - docker:dind
>     before_script:
> -    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
> +    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:$QEMU_CI_CONTAINER_TAG"
> +    # Always ':latest' because we always use upstream as a common cache source
>       - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
>       - apk add python3
>       - docker info

This patch no longer applies ... could you please rebase and resend a v2? 
Thanks!

  Thomas



