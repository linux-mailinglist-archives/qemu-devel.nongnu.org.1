Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A88B75B54E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXDk-0005Qz-4R; Thu, 20 Jul 2023 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMXDi-0005Qi-EV
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:13:42 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMXDg-0001VE-Ug
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:13:42 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4576729a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689873219; x=1690478019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oYIdy46tK3NI6A6O2BGDVkdFa1vfkDkDHQQqK46fJxU=;
 b=QZrkwbWu9J3p8tKVQx5vLqOo24jX+ysGsKC78CmVysh7q8Td3HHP03OZd7M2duYeGP
 RSzKXJhWJnJuU5Sx/1dC2VQdWH1o+KwqETMv+mQce8mpQnK9dDnAaofdgfKC8TImYf/G
 77/MNZCmyU5ZvOuAiucBqH1wzPM8zLpnHCNwvx8d55mCG1hWt/zpG08EMYI0eONPvuVe
 5Lo96rN+4h/VH8uaS77nUA28VREPaHrC+hcmwFdF1+dKe0QtHeuOFvIw4Xim0J8Hz5mu
 E5ztWxCLjHhC1j6UxzLfCBIkBGSmJZ7bts8FjbLSEYpHnUKslgL0W3jscFeN1CZfsWv3
 oTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873219; x=1690478019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYIdy46tK3NI6A6O2BGDVkdFa1vfkDkDHQQqK46fJxU=;
 b=Oy9dQkjMYZ7H2LF9unGjt6exDXj4Dp7rkiKvugFivl+ut7EBJyVjQcowK3N6UdYnP4
 81z4pAzu79gfTis8ZGYggRsx9HDeQIg4V+jABaawZ98FIeGsDXttkOYi3MLnBMQtIxFr
 GiBczU0ylUhiG8z4Gc3p3H34KbYZ0y52JDppVpRoS/06Ibt46yvY/oG6IhqqEsS9XwCT
 TceCWAvBFlvc95cyz6y4rC8ERLEX8McpkwdHJxCUOQI8r5oivlFhYQUMdGxIgXRyNu0I
 pIq/dk63sP8smjURBZNqwbxTr26ZzF3y+oX9XijRpT4JYTfq2LfQh5o9nVYfmUhC01YH
 pbCg==
X-Gm-Message-State: ABy/qLaVgbeiaKPKJ3f2HxhJkUfbKd96MGvIKWysJPnRirB7CbOmAHDw
 ZUVc/oKq/b7AwSF5FXDwrGBn+7GXsfNbNv3dwqmurQ==
X-Google-Smtp-Source: APBJJlGVihVvP2hvuf2oY/M0pWHOIXmJ+k0NKk9jQuyZADNp4dD8pAObUKqveZlzafCinZT8/TLWbbZcZeAvKPHa49c=
X-Received: by 2002:a05:6402:42c6:b0:51e:5206:d69e with SMTP id
 i6-20020a05640242c600b0051e5206d69emr6810004edc.10.1689873219465; Thu, 20 Jul
 2023 10:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-7-jean-philippe@linaro.org>
In-Reply-To: <20230719153018.1456180-7-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 18:13:28 +0100
Message-ID: <CAFEAcA-2Sd6OvM5eYfGPaCSwZcu+oQkCqXgdkV-=YM2SkyYQmg@mail.gmail.com>
Subject: Re: [PATCH 5/5] target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When FEAT_RME is implemented, these bits override the value of
> CNT[VP]_CTL_EL0.IMASK in Realm and Root state.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  target/arm/helper.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2017b11795..5b173a827f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2608,6 +2608,23 @@ static uint64_t gt_get_countervalue(CPUARMState *env)
>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
>  }
>
> +static bool gt_is_masked(CPUARMState *env, int timeridx)
> +{
> +    ARMSecuritySpace ss = arm_security_space(env);
> +
> +    /*
> +     * If bits CNTHCTL_EL2.CNT[VP]MASK are set, they override
> +     * CNT[VP]_CTL_EL0.IMASK. They are RES0 in Secure and NonSecure state.
> +     */
> +    if ((ss == ARMSS_Root || ss == ARMSS_Realm) &&
> +        ((timeridx == GTIMER_VIRT && extract64(env->cp15.cnthctl_el2, 18, 1)) ||
> +         (timeridx == GTIMER_PHYS && extract64(env->cp15.cnthctl_el2, 19, 1)))) {
> +        return true;
> +    }
> +
> +    return env->cp15.c14_timer[timeridx].ctl & 2;
> +}
> +
>  static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>  {
>      ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
> @@ -2627,7 +2644,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>
>          gt->ctl = deposit32(gt->ctl, 2, 1, istatus);
>
> -        irqstate = (istatus && !(gt->ctl & 2));
> +        irqstate = (istatus && !gt_is_masked(&cpu->env, timeridx));
>          qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
>
>          if (istatus) {
> @@ -2759,7 +2776,7 @@ static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>           * IMASK toggled: don't need to recalculate,
>           * just set the interrupt line based on ISTATUS
>           */
> -        int irqstate = (oldval & 4) && !(value & 2);
> +        int irqstate = (oldval & 4) && !gt_is_masked(env, timeridx);
>
>          trace_arm_gt_imask_toggle(timeridx, irqstate);
>          qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);

If these CNTHCTL bits now affect whether the timer interrupts
are masked, then we need to update the timer irq state
on writes to CNTHCTL that change the bits.

thanks
-- PMM

