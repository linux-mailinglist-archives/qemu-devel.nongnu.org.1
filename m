Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 006917EA1A8
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:05:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aMN-0007fG-3H; Mon, 13 Nov 2023 12:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2aMH-0007Xi-9s
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:04:22 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2aMF-0004PK-Az
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:04:21 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso7089959a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699895057; x=1700499857; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tXoTXFWOeQYOegr331Fli9ECx2LaIgBkkd5shOsuOag=;
 b=mfRueeFA/TIBNaXsiQ1+Eflvl6fV2lJcjr4OknZ7kUHCsw9q5B8HlFTTv+x+U3sinb
 SgFpgocCIT2ZozG+3QR3qe1DSRU0NWZS9aiyBKXw6UeXrLI/Q1ZF0YehyCKTxeMzGIKj
 iEzRX2z7hA0agfT8bOA1wAME0BGC9fnsXLI9JN8EfPB/8q3fDk0JrBMKvojXSAOqXsfq
 izeHikygA88Okss7izV+ZuUiaSAfU3JsohniKXNak4TpJ7S8adF2dTAt0eM7Q+ssfiHY
 35QMFDcv/BwLC1orthLuPwWKQieUuL6iFKvOLgyGtRW8++1g9TEbznMX9/L6Zna5GHgY
 5Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699895057; x=1700499857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tXoTXFWOeQYOegr331Fli9ECx2LaIgBkkd5shOsuOag=;
 b=Fc362o2vKro2eLbjIanMJWa+CGSqfGZxPyNeuZzFrVAkBpejDLQ4UJdVs9BYrVCL7w
 3iNObPbQY54s1vH7Fw0jrnEmuYY+N0IGMT11efJ+nFs7/h2/yt7KpuHqQcEAYSEqmKun
 mKirLsyN7o0IfUeVxiTufUBpLHkJrNyUlLQpQwU5DwDm7BuEnZvaEJjXwc0Rxczg1/cw
 KNl1JWwlC5gABqBWdZNfvbZ8DY3jo2jL3WAekvJFhoJiC9Nr0dONtd+lWQWjOjkfmorL
 hfEJLUBZGAmnqmDK7oqgD2HD+Fo24eo0lkJuZfXrUBBeL0yUovkamp1Eb2UsaDWy2OlI
 U/jQ==
X-Gm-Message-State: AOJu0YywWlH7VrQvXccAmLztx0l7iMSiI3R/Y2xynm22DcNChfMCkVsc
 mcoiAwup8+wxDSW1TctOfiIHRwnn+xfRsX0FWVgrHw==
X-Google-Smtp-Source: AGHT+IGNB4C0aKc23XbY66q8whoA7OHSXHRK+jgvY64ZhepcLnWGUBmF8KgPUvblpW9y4SI1SV3OSK6d6jQiUPhuC4U=
X-Received: by 2002:a05:6402:1052:b0:543:52be:e6ad with SMTP id
 e18-20020a056402105200b0054352bee6admr5217435edu.5.1699895057359; Mon, 13 Nov
 2023 09:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20231112165658.2335-1-n.ostrenkov@gmail.com>
In-Reply-To: <20231112165658.2335-1-n.ostrenkov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2023 17:04:06 +0000
Message-ID: <CAFEAcA_qmKctYajg2fXSd0GU0YtD_HBPGq5_BzdDDj0aLw1J9g@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm/tcg: enable pmu feature for cortex a9
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sun, 12 Nov 2023 at 16:57, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>
> According to the technical reference manual Cortex A9 like Cortex A7 and Cortex A15 has Perfomance Unit Monitor (PMU)
> https://developer.arm.com/documentation/100511/0401/performance-monitoring-unit/about-the-performance-monitoring-unit
>
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  target/arm/tcg/cpu32.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 0d5d8e307d..0008c3f890 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -418,6 +418,7 @@ static void cortex_a9_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_NEON);
>      set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
>      set_feature(&cpu->env, ARM_FEATURE_EL3);
> +    set_feature(&cpu->env, ARM_FEATURE_PMU);
>      /*
>       * Note that A9 supports the MP extensions even for
>       * A9UP and single-core A9MP (which are both different

Thanks for this patch.

There definitely seem to be some weirdnesses in our PMU emulation
for older CPUs like the A9. In particular we define the registers
in v7_cp_reginfo[], so you get them on all v7 cores, even if
ARM_FEATURE_PMU is turned off; they just don't actually do anything.
This seems to affect the cortex-a8 and cortex-a9; everything
newer defines ARM_FEATURE_PMU. We really ought to have the PMU
registers separated out and only defined for ARM_FEATURE_PMU CPUs.
(Annoyingly, we can't drop ARM_FEATURE_PMU and look at ID_DFR0
instead, because the A8 and A9 have a PMU but don't advertise
it in ID_DFR0, because they predate the PMUv2 standardization
of the ID_DFR0 field for that.)

The other thing here is that these CPUs are older versions
of the PMU, so strictly we ought to check whether they
have deviations from the registers we define. But since
we're already defining all those registers anyway, it seems
safe enough to let them actually work.

I've applied this to target-arm.next, with an update to also
set ARM_FEATURE_PMU for the Cortex-A8, since that was the
only other CPU in this odd "PMU registers present but not
really working" state.

thanks
-- PMM

