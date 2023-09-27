Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89B7B0950
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWnd-00046J-EL; Wed, 27 Sep 2023 11:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWna-00045b-TE
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:50:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWnY-0001fq-0P
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:50:02 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so10312785a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695829798; x=1696434598; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wA5Kmh+XAx86XM5lcRFTwfs4Gyb5oOZnqGKVQdHHICo=;
 b=E1cJSQUjUi6a03PMTIKYAjmiOKMSLZ7szZcx4H5+nwuQvyMLhFCg5WLl90RbPmsJVH
 2znOxDL/ukwfOFTvSo3EROV5pwHb8JKGe3kqJiHIXYPupXDNDy4AMyNk6PR73tF8oSVu
 zzLrYol8CQRKyot/U6inwfbXDDWaM4s0StxrkOB4ArPJmJr7h8gr+18Qi6RZ1MYmAyO8
 mfs5VJnTXlV0lpk0DDf8+qTADlQO4Y7Pu7k2eyKy9XasH6WJnJvOpMjVD6vojy8zdrZO
 qNv2BVJsbgu2h3irUdUcCrFxj7r0SJ2V77b12oCLqn1E6BjfW3oCA8VFDP+FlvdSzyz6
 8DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695829798; x=1696434598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wA5Kmh+XAx86XM5lcRFTwfs4Gyb5oOZnqGKVQdHHICo=;
 b=cSJOSY3/PkFgUSAm0achBmRlV8h4BhXq3P25Ns8i1qZDtsj6Xgu/Yv+e0/QF/Y8pEY
 hS9pkbfMFFY8+4w03DOynmf7OHNkntLyY2hG0ySg/l7uL72rhGdp5Dw/XYOLp2TgXJnS
 +jBpi8pQBJSkqcHrkFf1VEx1YDyTikacO+PeHOhCWDENbUH+cXYmr35Ii/vrVGEdSdJH
 v+UCor9WR/LBC9W5LIUUMBN3mKdaxBjQdbK5ULjg4SozOoc2Wkc7AbdZ9n2KnjhywBwe
 vdlvTt93GPA49RI/uYnXebWNsGU8/tnhQrfr0CmAyWK9KBBZtDvL90L221Inb09CM320
 bD7A==
X-Gm-Message-State: AOJu0YyJIRTZo7NriCCSgwqTck5nDdttCxCJj/ulHF0tcgz8FlIwkb7W
 p0CsjvgecYOmX1B7R6ma9+lBS7xl/VZ2mR3ECviNbw==
X-Google-Smtp-Source: AGHT+IHtzgJjzY3ozNnLpc9YttxbFJMxSW+aTnmvKzBFCHyAZEtZYdgBmMxYgny7ReSJFGvcspijFVeIFF6VJOUMR+o=
X-Received: by 2002:a05:6402:368:b0:534:7b49:9036 with SMTP id
 s8-20020a056402036800b005347b499036mr516214edw.12.1695829798132; Wed, 27 Sep
 2023 08:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230922132111.9149-1-michal.orzel@amd.com>
In-Reply-To: <20230922132111.9149-1-michal.orzel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2023 16:49:39 +0100
Message-ID: <CAFEAcA-Vbzt2q17-s_A4cw+sn2bx8uQS2QGFXt5b2nj9d0UJig@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
To: Michal Orzel <michal.orzel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefano.stabellini@amd.com, 
 Oleksandr_Tyshchenko@epam.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 22 Sept 2023 at 14:21, Michal Orzel <michal.orzel@amd.com> wrote:
>
> On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
> of Xen, a trap from EL2 was observed which is something not reproducible
> on HW (also, Xen does not trap accesses to physical counter).
>
> This is because gt_counter_access() checks for an incorrect bit (1
> instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
> physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
> When HCR_EL2.E2H is 0:
>  - EL1PCTEN, bit [0]: refers to physical counter
>  - EL1PCEN, bit [1]: refers to physical timer registers
>
> Fix it by checking for the right bit (i.e. 0) and update the comment
> referring to incorrect bit name.
>
> Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
> Signed-off-by: Michal Orzel <michal.orzel@amd.com>
> ---
> This is now in conformance to ARM ARM CNTPCT_EL0 pseudocode:
> if PSTATE.EL == EL0 then
> ...
>     elif EL2Enabled() && HCR_EL2.E2H == '0' && CNTHCTL_EL2.EL1PCTEN == '0' then
>         AArch64.SystemAccessTrap(EL2, 0x18);
> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3b22596eabf3..3a2d77b3f81e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2483,9 +2483,9 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
>                  return CP_ACCESS_TRAP_EL2;
>              }
>          } else {
> -            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
> +            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCTEN. */
>              if (has_el2 && timeridx == GTIMER_PHYS &&
> -                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
> +                !extract32(env->cp15.cnthctl_el2, 0, 1)) {
>                  return CP_ACCESS_TRAP_EL2;
>              }
>          }

I agree that the current logic is not correct, but this change
makes this code identical to the "case 1" handling, so we
can delete the whole "if (hcr & HCR_E2H) { ... } else { ...  }"
block and instead fall through, as we already do in gt_timer_access().

thanks
-- PMM

