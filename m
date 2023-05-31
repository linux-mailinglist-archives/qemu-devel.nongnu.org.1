Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D0718648
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NiM-0007du-UZ; Wed, 31 May 2023 11:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NiK-0007dT-UL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NiI-0007u7-FH
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685546773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJ0jG4K9ITQ95SWZj3aGT+I4DmumPIpYTQ9qwKxCeNc=;
 b=MWJyO4OmQ+UgzikrVYhmWnlyUaPel2T8T1rS1sQQnmaluyYCVuRfEkpmkhDdzJH3YJzl6R
 zbMy/YGwweLLGqRWO+2MvZBymzRxWiqum8vJ4EOf+cHB4fWixELDLcxbWPrnwaSf2+96xx
 VAOvcZEjyesa3hKadQN+4G9Nrv2U1Ww=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-kGzfnWA0NJaaLNsa6mMitw-1; Wed, 31 May 2023 11:26:12 -0400
X-MC-Unique: kGzfnWA0NJaaLNsa6mMitw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f6bb50f250so73553701cf.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685546771; x=1688138771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJ0jG4K9ITQ95SWZj3aGT+I4DmumPIpYTQ9qwKxCeNc=;
 b=eYWpsImfIyA19ua7Rr0YcbOFqLd/H9yQ8dvZdJVcqFgJyPSBFDISepKdJPGKfVyJve
 5BjR4jzxOdQLuKZl4Q6PYUQfdG+/DhWS6A2jnDslRumOiAlOvRLBY7YJQN9yPLwFa2Rc
 N0zdSFRnz6PAJKAPsVzf1i56Q5wHkrKI9Ed5MKd0WUgiT5zI4rXVTqfM71LgbhKP3LW4
 dwXpf/1ZJPkGeWh3jHS5qCY+SmMGIMBebn1KGLSo27H2+dasoo+aamq6bpVuo13C9KOC
 KiGiqTPLnp7ZnGHixBxq/BscnIYARiLbStviv2wg9UfqGrbgTc1StI4EuvjUfvhkkLmD
 wlfQ==
X-Gm-Message-State: AC+VfDycUAEEkLBcLhywcb206SZxfuQSh6O+OCVsw2cmmMXxPGwUXDO4
 s9sY1sRxs3+ddmiKBqCDi7yXP23hExRKHnWjgSF8iLwFBIcYwQecF7TGJy6UWNafFPXDHB+rWSh
 E6TF/RClsBp+qsQf+tWCaGtGTXnz3gIo=
X-Received: by 2002:a05:622a:15d1:b0:3f6:9cfd:ca49 with SMTP id
 d17-20020a05622a15d100b003f69cfdca49mr5809306qty.58.1685546771627; 
 Wed, 31 May 2023 08:26:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZC0qjVC5Ff36dvgoqR+ro8ejxphjDtVC0YAk12bWU3aYtu1K8yNL0LcoPJAjV2USVVp6v5SB8RpQa9KmQJu4=
X-Received: by 2002:a05:622a:15d1:b0:3f6:9cfd:ca49 with SMTP id
 d17-20020a05622a15d100b003f69cfdca49mr5809285qty.58.1685546771334; Wed, 31
 May 2023 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531140654.1141145-1-berrange@redhat.com>
In-Reply-To: <20230531140654.1141145-1-berrange@redhat.com>
From: Camilla Conte <cconte@redhat.com>
Date: Wed, 31 May 2023 16:25:35 +0100
Message-ID: <CACPOWh3x=YA1U4DNaoWm8aoZyFUkqTWXqpPuAuYp4KH5i4jyHw@mail.gmail.com>
Subject: Re: [PATCH] gitlab: switch from 'stable' to 'latest' docker container
 tags
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 31, 2023 at 3:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The 'stable' and 'stable-dind' tags are not documented as supported
> tags at:
>
>   https://hub.docker.com/_/docker
>
> Looking at their content they reflect docker 19.x.x release series,
> were last built in Dec 2020, and have 3 critical and 20 high rated
> CVEs unfixed. This obsolete status is attested by this commit:
>
>   https://github.com/docker-library/docker/commit/606c63960a4845af7077721=
eb3900c706f5d0c5e
>
> The 'stable-dind' tag in particular appears buggy as it is unable to
> resolve DNS for Fedora repos:
>
>   - Curl error (6): Couldn't resolve host name for https://mirrors.fedora=
project.org/metalink?repo=3Dfedora-37&arch=3Dx86_64&countme=3D1 [getaddrinf=
o() thread failed to start]
>
> We used the 'stable' tag previously at the recommendation of GitLab
> docs, but those docs are wrong and pending a fix:
>
>   https://gitlab.com/gitlab-org/gitlab/-/issues/409430
>
> Fixes: 5f63a67adb58478974b91f5e5c2b1222b5c7f2cc
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/container-template.yml | 4 ++--
>  .gitlab-ci.d/opensbi.yml            | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container=
-template.yml
> index 9ac4a0ee25..8c1370b8f0 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -1,9 +1,9 @@
>  .container_job_template:
>    extends: .base_job_template
> -  image: docker:stable
> +  image: docker:latest
>    stage: containers
>    services:
> -    - docker:stable-dind
> +    - docker:dind
>    before_script:
>      - export TAG=3D"$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
>      - export COMMON_TAG=3D"$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:lat=
est"
> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> index 2e9d51764e..b4d7eef688 100644
> --- a/.gitlab-ci.d/opensbi.yml
> +++ b/.gitlab-ci.d/opensbi.yml
> @@ -42,9 +42,9 @@
>  docker-opensbi:
>    extends: .opensbi_job_rules
>    stage: containers
> -  image: docker:stable
> +  image: docker:latest
>    services:
> -    - docker:stable-dind
> +    - docker:dind
>    variables:
>      GIT_DEPTH: 3
>      IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
> --
> 2.40.1
>

Reviewed-by: Camilla Conte <cconte@redhat.com>


