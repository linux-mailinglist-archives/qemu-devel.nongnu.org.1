Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97614770791
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:08:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzDm-0006Y6-PN; Fri, 04 Aug 2023 14:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRzDl-0006Xi-Ap
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:08:17 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRzDj-00010h-B0
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:08:17 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52256241c66so5110632a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691172493; x=1691777293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g2TFQc0kLQiX84NeC5kg50/Pv9dqPY/kGIzFvDbzhIo=;
 b=xse3vzbQMKXJMD4Sla4NAbKxr3f15uFXmaSJd6/UXzA9l4kSfJax/EW0hl2WDCFmht
 mSFwURz9U/pGIlS1odoNUh9iYQL8IEoKuH54ZAbSlwKGeX5mumZruEDieU0eKN/5N9A8
 Ub00jpa9VWxIgr0J/Eq2ILmwsJLXxu6WcmT12qfjfCX+5vrk3Q3i4ed3iVdn+0wF7tCQ
 BekZhbrOSlqTAcAZNipO6LWWrtxtIkioggDdHQU6wQmTLHl/snw03y6dbyOmYuJ7hFNT
 HZteNTyUQHIBMbUWUZ40uh0c2peEas4oqERdxSLuTc/omU1esQExmkqRTseHrSpeZAwj
 Bi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691172493; x=1691777293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g2TFQc0kLQiX84NeC5kg50/Pv9dqPY/kGIzFvDbzhIo=;
 b=PSD1OnPNIXNVWq4+SfRM4p1JUq/ZmsYbWGZOyqQIYgugXHnvwf9ODA6EwF5m4TjvXP
 r48fTG50xG5kSp+CFYnvTxGCUd1tbCiDTNVaz203FtsBkvZ5u0hTnX/YK9tkUUuHA1EO
 UgAYRgu6i7LM2MhunXif90fGxmnwtgIwDjgJAf0Uon1/XqsUlRR9tAQZG04d7sluPSYA
 EE7qSX1JA+IykE8ewM9aOAHD7SjaSectuno5k0UARbu7Q3W0xgngY2oRaZOCZQuiQQ1g
 FMNVVqR3HtdzJDKdIxIAZz4FFHWqZyydcEamsyXm/UFUvhmKX4A/qBEfjlfivOGrJNHE
 kGzg==
X-Gm-Message-State: AOJu0YztzRmrADMavS+CuDij6Jr78gSg7udoddMRrjO58H0DKGJqftaf
 9JV5B7SBSM1ukvjAvXhN4UjPVDPw0X5iE9VaN28Ghw==
X-Google-Smtp-Source: AGHT+IEKPNbooud2RCnWqbkX5ar0+X2/n5jrf52lo5DVDYcBxhoIESDVCifKl/yay/Q7sgi8CCjx33oOEpTQ5fcUgAI=
X-Received: by 2002:a05:6402:387:b0:522:2b23:b5ea with SMTP id
 o7-20020a056402038700b005222b23b5eamr489794edv.9.1691172493466; Fri, 04 Aug
 2023 11:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-6-jean-philippe@linaro.org>
In-Reply-To: <20230802170157.401491-6-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 19:08:02 +0100
Message-ID: <CAFEAcA-0p2UhURwgLRnUxSK8ktFsULsHz5x3pu+h80VOPBrZvQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] target/arm/helper: Check SCR_EL3.{NSE, NS} encoding
 for AT instructions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2 Aug 2023 at 18:02, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The AT instruction is UNDEFINED if the {NSE,NS} configuration is
> invalid. Add a function to check this on all AT instructions that apply
> to an EL lower than 3.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  target/arm/helper.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index fbb03c364b..77dd80ad28 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3616,6 +3616,20 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  #endif /* CONFIG_TCG */
>  }
>
> +static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                     bool isread)
> +{
> +    /*
> +     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
> +     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved.
> +     */
> +    if (cpu_isar_feature(aa64_rme, env_archcpu(env)) &&
> +        (env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
> +        return CP_ACCESS_TRAP;
> +    }

The AArch64.AT() pseudocode and the text in the individual
AT insn descriptions ("When FEAT_RME is implemented, if the Effective
value of SCR_EL3.{NSE, NS} is a reserved value, this instruction is
UNDEFINED at EL3") say that this check needs an "arm_current_el(env) == 3"
condition too.

> +    return CP_ACCESS_OK;
> +}
> +
>  static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
>                                       bool isread)
>  {

thanks
-- PMM

