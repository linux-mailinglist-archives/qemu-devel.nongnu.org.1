Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AB8772C00
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3fc-0000DE-Ps; Mon, 07 Aug 2023 13:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT3fW-0000CI-8U
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:05:23 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT3fU-0008Oe-8J
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:05:21 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e2a6a3768so6540583a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691427918; x=1692032718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Eb2iwDQi8uXQ7Vs6C6LMdZHQVqkmTYON29HiT8SG6I=;
 b=oTNZI5CXXn+WmFclgMsKMU+3W4Pstq9uAJBL3Spsz/tQ097Zb9UTOanWQ1a0F5NnLA
 OYPRaLpuhyD2oMGYr/v1RvnJF0wedjWml5IjO1uHt7PA7DYUiNUJFhypWK9Wb8tnw+Ci
 WOgKbMps1Z1MZRxvw7FPWktA1FUOKEfv2FbK9rubJ1pQHO/P7308Dz3+I0ZNK84sSSE/
 NDxgt/jAf18MDiyAEaJ9kUYyAI58R2e9516Co/tpuNKyXHFJd3dbnvnrEdj/VApL1SQn
 sFScLbssEGGTcXph5Ee2pZFLiXLsiJdZp4DsUPzfSarfUmgwTQTTzLANgzq1Eoommy6q
 /Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691427918; x=1692032718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Eb2iwDQi8uXQ7Vs6C6LMdZHQVqkmTYON29HiT8SG6I=;
 b=LE8hoZ3zrZ3AqHfumqWIp0e1HrTqff77tbt4agvKDIuA70efD3nZiaCk9IG+v6Ae9H
 2jKba6WbOak+B5s7d3Ow/VtQkchd3VMEWKr3IHT0+Zp3PoP0CAbXmXKX1QGhlkkmOz8f
 iph9IK4y7RyA9uJR9tlKm22jykKBOQFvqtHJxhYlDzp6H9nvAB4kWnD4B8CBChSfjR3K
 oI0HLZfL0Bvrqk6lcOesG12hVDnJvEaFtjWrVFKwcyiBVnBtL5NY+6DnjsNqQicex6vL
 Yap5C1Ke4JgLMqlECXkNYkniB6TrjYjEq0lj+JDHQnEAiz973uRdpCfXPr0CTnS4xxMf
 LIOw==
X-Gm-Message-State: AOJu0YymOnD0YoDgcCXoJMNIoaJW1jlMZ5KLgmUjFE5gorBxRQ0xsq6s
 JDFkubu4n6PEMlbJMIQaTqRr8gnw1Z69BqVShyEJSVwKmpIFscA9
X-Google-Smtp-Source: AGHT+IFFN6N4vek1O5xtMvcFPVqmlkXieAbpVfa9mmNA48shz1FmI3NPajt6DJH3WbgCXXslVKQmnN82hOJnLL/jigI=
X-Received: by 2002:aa7:d6cd:0:b0:522:21a1:5153 with SMTP id
 x13-20020aa7d6cd000000b0052221a15153mr9250367edr.11.1691427918579; Mon, 07
 Aug 2023 10:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-7-jean-philippe@linaro.org>
In-Reply-To: <20230802170157.401491-7-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 18:05:07 +0100
Message-ID: <CAFEAcA9rt7tfsjWitQA1HN5cY3y_8FjDNN=p07jB4B3WRdEZrw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] target/arm/helper: Implement
 CNTHCTL_EL2.CNT[VP]MASK
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
> When FEAT_RME is implemented, these bits override the value of
> CNT[VP]_CTL_EL0.IMASK in Realm and Root state. Move the IRQ state update
> into a new gt_update_irq() function and test those bits every time we
> recompute the IRQ state.
>
> Since we're removing the IRQ state from some trace events, add a new
> trace event for gt_update_irq().
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  target/arm/cpu.h        |  3 +++
>  target/arm/helper.c     | 54 ++++++++++++++++++++++++++++++++---------
>  target/arm/trace-events |  7 +++---
>  3 files changed, 50 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bcd65a63ca..bedc7ec6dc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1743,6 +1743,9 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>  #define HSTR_TTEE (1 << 16)
>  #define HSTR_TJDBX (1 << 17)
>
> +#define CNTHCTL_CNTVMASK      (1 << 18)
> +#define CNTHCTL_CNTPMASK      (1 << 19)
> +
>  /* Return the current FPSCR value.  */
>  uint32_t vfp_get_fpscr(CPUARMState *env);
>  void vfp_set_fpscr(CPUARMState *env, uint32_t val);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 77dd80ad28..68e915ddda 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2608,6 +2608,28 @@ static uint64_t gt_get_countervalue(CPUARMState *env)
>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
>  }
>
> +static void gt_update_irq(ARMCPU *cpu, int timeridx)
> +{
> +    CPUARMState *env = &cpu->env;
> +    uint64_t cnthctl = env->cp15.cnthctl_el2;
> +    ARMSecuritySpace ss = arm_security_space(env);
> +    /* ISTATUS && !IMASK */
> +    int irqstate = (env->cp15.c14_timer[timeridx].ctl & 6) == 4;
> +
> +    /*
> +     * If bit CNTHCTL_EL2.CNT[VP]MASK is set, it overrides IMASK.
> +     * It is RES0 in Secure and NonSecure state.
> +     */
> +    if ((ss == ARMSS_Root || ss == ARMSS_Realm) &&
> +        ((timeridx == GTIMER_VIRT && (cnthctl & CNTHCTL_CNTVMASK)) ||
> +         (timeridx == GTIMER_PHYS && (cnthctl & CNTHCTL_CNTPMASK)))) {
> +        irqstate = 0;
> +    }
> +
> +    qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
> +    trace_arm_gt_update_irq(timeridx, irqstate);
> +}

> @@ -2888,6 +2904,21 @@ static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      gt_ctl_write(env, ri, GTIMER_VIRT, value);
>  }
>
> +static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                             uint64_t value)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    uint32_t oldval = env->cp15.cnthctl_el2;
> +
> +    raw_write(env, ri, value);
> +
> +    if ((oldval ^ value) & CNTHCTL_CNTVMASK) {
> +        gt_update_irq(cpu, GTIMER_VIRT);
> +    } else if ((oldval ^ value) & CNTHCTL_CNTPMASK) {
> +        gt_update_irq(cpu, GTIMER_PHYS);
> +    }
> +}
> +
>  static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                uint64_t value)
>  {
> @@ -6200,7 +6231,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>         * reset values as IMPDEF. We choose to reset to 3 to comply with
>         * both ARMv7 and ARMv8.
>         */
> -      .access = PL2_RW, .resetvalue = 3,
> +      .access = PL2_RW, .type = ARM_CP_IO, .resetvalue = 3,
> +      .writefn = gt_cnthctl_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.cnthctl_el2) },

You also need to add ".raw_writefn = raw_write". Otherwise
on an inbound migration we will use the writefn to update
the register value from the inbound data, which will
update the irq line and potentially mess up the state of
the device on the other end of it.

>      { .name = "CNTVOFF_EL2", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 0, .opc2 = 3,

The other missing thing here is that we now need to recalculate
the interrupt state when the security state changes, because
a transition from (for instance) EL1 NonSecure to EL3 Root
means the CNTVMASK and CNTPMASK bits should now take effect.
The security state can only change on a transition either
into or out of EL3, so you can do this with an el_change_hook:
call arm_register_el_change_hook() in the same way we do
already to set up the pmu_post_el_change function. Then in
that function you can call gt_update_irq(). (The hook gets
called after the exception return has updated the CPU state
to the target exception level.)

thanks
-- PMM

