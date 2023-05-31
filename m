Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B97184D0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Mj3-0004no-Vy; Wed, 31 May 2023 10:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Mio-0004lA-Jl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Mim-0002TP-Hi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685542959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJ6HMSYP5hSPXMgVZ85XwUVmmsLHXT1gKWH0QeRnlvE=;
 b=D0Cn+OwHroNJkO5fITRcelzelk0bbDwIiZ5VKhOilYpKMRs/xUOwXZHjh67E4DjzqXhmlR
 FHWRtcjbgic+hm9caJV7+xx4u+NG/MSFFialk3M6ywS89irlNNKp0a3e4ys1TiUrIcLk6Z
 x0ZJ//e0l4W4Y3hsKUpBhkQxllnJnzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-EOZWpr1oOeatm2n1js_KIg-1; Wed, 31 May 2023 10:22:37 -0400
X-MC-Unique: EOZWpr1oOeatm2n1js_KIg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60911a417so26805115e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542956; x=1688134956;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sJ6HMSYP5hSPXMgVZ85XwUVmmsLHXT1gKWH0QeRnlvE=;
 b=gKky1afF+OB4KOPlE50vxoRI+nFSNYZPr0lRx5pNHUBokgpXBgJlBr9wyTYv6tgE2m
 kLODXMsnONz/9IO1U/Aj/DtfUQltxo54U9MruqGEI4l8YxJC66UBJnIQ+ZSW6Zg3O3hJ
 hAzurfLi5vlXxfk1rOAKCeDQpbRIwhHFrH0HJL4xQrHEgDU/rcV8ObhSNm4+dkyCS13z
 KSJPS/ajAj3WCukewGIyYhK+74sbdJt8Nf46mHsn0/mRteA57ONRz7SsETlyz57IK+BQ
 N+H3kQ8grHyQKBygjLKOJeq7Dud4l3reUZE1mKn/KnbsESwKDgHIkUu3tnb3Mu/oLkvT
 EBrw==
X-Gm-Message-State: AC+VfDxDguVb9RXtfP2FvthXZIY+r5ryyeqp51bymau8YOxiYtXMFlAl
 PnnbSQoPX+afSiNQaAXZp26I6iVn+41cgyh8UEvrdv2TzyeDkndlPOzaC1zqWaa9s9tr1coRSlV
 +m5vydkXf9IAXlLU=
X-Received: by 2002:a1c:f710:0:b0:3f5:ffe3:46a7 with SMTP id
 v16-20020a1cf710000000b003f5ffe346a7mr4792529wmh.9.1685542956591; 
 Wed, 31 May 2023 07:22:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VIuO4L4RF3tfUPDsOmO8IJR0CpXkFQjbMDcUgro7+eOtv5KZ/3yaACPgsUE1Vl+9WGCcO1g==
X-Received: by 2002:a1c:f710:0:b0:3f5:ffe3:46a7 with SMTP id
 v16-20020a1cf710000000b003f5ffe346a7mr4792507wmh.9.1685542956245; 
 Wed, 31 May 2023 07:22:36 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a05600c21c400b003f0aefcc457sm24759186wmj.45.2023.05.31.07.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:22:35 -0700 (PDT)
Message-ID: <740eaa77-a217-8272-2eb3-51df11764447@redhat.com>
Date: Wed, 31 May 2023 16:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230523133117.2278587-1-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] docs: build-system: rename "default-configs" to
 "configs"
In-Reply-To: <20230523133117.2278587-1-kchamart@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On 23/05/2023 15.31, Kashyap Chamarthy wrote:
> Commit 812b31d3f9 (configs: rename default-configs to configs and
> reorganise, 2021-07-07) did the rename.
> 
> Reflect that update also in the documentation.
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>   docs/devel/build-system.rst | 12 +++++------
>   docs/devel/kconfig.rst      | 40 ++++++++++++++++++++-----------------
>   2 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 1894721743..20ebcc9ac6 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
...
> @@ -457,7 +457,7 @@ Built by Meson:
>     TARGET-NAME is again the name of a system or userspace emulator. The
>     config-devices.mak file is automatically generated by make using the
>     scripts/make_device_config.sh program, feeding it the
> -  default-configs/$TARGET-NAME file as input.
> +  configs/$TARGET-NAME file as input.

This hunk does not apply anymore - but I think it can simply be dropped now.

>   ``config-host.h``, ``$TARGET_NAME-config-target.h``, ``$TARGET_NAME-config-devices.h``
>     These files are used by source code to determine what features are
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> index e3a544e463..73118e5106 100644
> --- a/docs/devel/kconfig.rst
> +++ b/docs/devel/kconfig.rst
> @@ -38,11 +38,11 @@ originated in the Linux kernel, though it was heavily simplified and
>   the handling of dependencies is stricter in QEMU.
>   
>   Unlike Linux, there is no user interface to edit the configuration, which
> -is instead specified in per-target files under the ``default-configs/``
> +is instead specified in per-target files under the ``configs/target/``

I think the Kconfig-related files are rather the ones in configs/devices/ , 
so I'd use that directory here instead.

>   directory of the QEMU source tree.  This is because, unlike Linux,
> -configuration and dependencies can be treated as a black box when building
> -QEMU; the default configuration that QEMU ships with should be okay in
> -almost all cases.
> +configuration and dependencies can be treated as a black box when
> +building QEMU; the default configuration that QEMU ships with should be
> +okay in almost all cases.

Why did you change the above three lines?

>   The Kconfig language
>   --------------------
> @@ -103,11 +103,12 @@ directives can be included:
>   **default value**: ``default <value> [if <expr>]``
>   
>     Default values are assigned to the config symbol if no other value was
> -  set by the user via ``default-configs/*.mak`` files, and only if
> -  ``select`` or ``depends on`` directives do not force the value to true
> -  or false respectively.  ``<value>`` can be ``y`` or ``n``; it cannot
> -  be an arbitrary Boolean expression.  However, a condition for applying
> -  the default value can be added with ``if``.
> +  set by the user via
> +  ``configs/devices/TARGETNAME-softmmu/*.mak`` files, and only
> +  if ``select`` or ``depends on`` directives do not force the value to
> +  true or false respectively.  ``<value>`` can be ``y`` or ``n``; it
> +  cannot be an arbitrary Boolean expression.  However, a condition for
> +  applying the default value can be added with ``if``.
>   
>     A configuration element can have any number of default values (usually,
>     if more than one default is present, they will have different
> @@ -119,8 +120,8 @@ directives can be included:
>     This is similar to ``select`` as it applies a lower limit of ``y``
>     to another symbol.  However, the lower limit is only a default
>     and the "implied" symbol's value may still be set to ``n`` from a
> -  ``default-configs/*.mak`` files.  The following two examples are
> -  equivalent::
> +  ``configs/devices/TARGETNAME-softmmu/*.mak`` files.  The following
> +  two examples are equivalent::
>   
>       config FOO
>         bool
> @@ -146,8 +147,9 @@ declares its dependencies in different ways:
>         bool
>   
>     Subsystems always default to false (they have no ``default`` directive)
> -  and are never visible in ``default-configs/*.mak`` files.  It's
> -  up to other symbols to ``select`` whatever subsystems they require.
> +  and are never visible in ``configs/devices/TARGETNAME-softmmu/*.mak``
> +  files.  It's up to other symbols to ``select`` whatever subsystems
> +  they require.
>   
>     They sometimes have ``select`` directives to bring in other required
>     subsystems or buses.  For example, ``AUX`` (the DisplayPort auxiliary
> @@ -229,7 +231,8 @@ declares its dependencies in different ways:
>     cannot be started at all without it.  It should be listed under
>     ``imply`` if (depending on the QEMU command line) the board may or
>     may not be started without it.  Boards also default to false; they are
> -  enabled by the ``default-configs/*.mak`` for the target they apply to.
> +  enabled by the ``configs/targets/TARGETNAME-softmmu/*.mak`` for the

Should be configs/devices/... here, too, I think.

  Thomas


