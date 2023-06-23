Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE473B523
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdv3-0006Yb-UT; Fri, 23 Jun 2023 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCdv2-0006YR-Kt
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:21:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCdv1-00071T-47
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:21:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51be61663c8so409401a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687515689; x=1690107689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wt3/81B8+abMu9/ShyXbtiCXB34kRx3p7cj0Epq+jcE=;
 b=NanM8YhjIPWcYWlkGQK2cgQyQxYcIv7uiTAxQEUQpv+lphUB/gSeVJfRgRwy+Pl42g
 9mr481P/nYD+ZZIP9ulQxibrJaJhSmLUWOms/aJnWKLu8FKQInUh6mrRC0+MhdCQNlkZ
 TGG2uDj9xklokHyjCa79jUsIF5gAo7nMPNJ6KeQjwsP4NBkowvsTLIl6efdcB+vsEzws
 w/eVV3b/RtinF5gHrdW8AKcyR5VhOqn5YX74hUDx3MoJ64Jv7Q8YAe5CHWeE1D1juJ6K
 xwjMs/I0E17gqziX+6uk/9XnE8n81ZL0Q5IXByjiWp26uAs3gTFUvgAtTp6/172tMK9Z
 IyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687515689; x=1690107689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wt3/81B8+abMu9/ShyXbtiCXB34kRx3p7cj0Epq+jcE=;
 b=ELX9yYy+UsKgcow961gf+tCyHDN5GS02SwgPSsWgNN9sgLR0lgDtgQboPdWRg6kq63
 czoQSPOpymQ8UgcPFEk+2rPYhF2TZN7NKQOcStZYtUx2kD1gv0L5NMX0nHWEiaggdb6t
 NBmVm8H5UfIb/K1la5E/qNbYnuFyIqGDCRLH6sd2cufyMDnSW5SxdaCDW8OHSouFj178
 PFvv3QAUxMRxiuxDWqypXog/fSP+P5bxAjpRQamnrumuFD8+KZHCroD9ouIIzBwCtqs8
 ftK+Az7I/NUCinhPsKy17fFb0qjsohdRev6Em0eXAyP7Aa9PKqY03vmEglir9+zB4mWy
 60IQ==
X-Gm-Message-State: AC+VfDzTmVHHFaG9aIWdYKHFf0sIFAzE/ONSO5ILSOmGjtAuRFbgPQ7m
 Y+X06mfOwOYqrYXR8m/Mv8vhetClOETXI659DuicJQ==
X-Google-Smtp-Source: ACHHUZ76n8djCC6hD38XIlhX8/ziq+Uim4JnbtKMDyTbomj+dg5yQf/JxMOtagl5WgLPEs9OTyq6zoIv50uygnXiAaE=
X-Received: by 2002:a05:6402:451:b0:51a:5956:e56c with SMTP id
 p17-20020a056402045100b0051a5956e56cmr10301189edw.38.1687515688930; Fri, 23
 Jun 2023 03:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230622143046.1578160-1-richard.henderson@linaro.org>
In-Reply-To: <20230622143046.1578160-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 11:21:18 +0100
Message-ID: <CAFEAcA-DfDMi2SHp2BiCvw4ad_+hueoVB3XZJEOgJXYAe88Tnw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Document FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 22 Jun 2023 at 15:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/system/arm/cpu-features.rst | 23 +++++++++++++++++++++++
>  docs/system/arm/emulation.rst    |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index f4524b6d3e..741bf3a299 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -435,3 +435,26 @@ As with ``sve-default-vector-length``, if the default length is larger
>  than the maximum vector length enabled, the actual vector length will
>  be reduced.  If this property is set to ``-1`` then the default vector
>  length is set to the maximum possible length.
> +
> +RME CPU Properties
> +==================
> +
> +The status of RME support with QEMU is experimental.  At this time We

I fixed the capital 'W' here...

> +only support RME within the CPU proper, not within the SMMU or GIC.
> +The feature is enabled by the CPU property ``x-rme``, with the ``x-``
> +prefix present as a reminder of the experimental status, and defaults off.


> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -66,6 +66,7 @@ the following architecture extensions:
>  - FEAT_RAS (Reliability, availability, and serviceability)
>  - FEAT_RASv1p1 (RAS Extension v1.1)
>  - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
> +- FEAT_RME (Realm Management Extension)

...and added "(NB: support status in QEMU is experimental)"
to this line, and have applied it to target-arm.next; thanks.

-- PMM

