Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538B890245
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Mar 2024 15:52:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpr5e-0005Xb-Qx; Thu, 28 Mar 2024 10:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpr5Z-0005WW-0f
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:50:45 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpr5W-0006ON-Ht
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:50:44 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56bb22ff7baso1194171a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711637441; x=1712242241; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LoJhiSQMgbnriZ5qJ9TJewtlb/1Oql+iO0DbpBLB4ng=;
 b=BXIWbC/04N0wTX7CieDv21IUqE/s5Gcf3AA+aK1/9lhuizJ1KfGqb4t/NtI45nplnK
 eQL8D3TkGO/SIK7BDB6MM19Qgn7GlCaan1MbsBnPUNxI2+5PRItvM4slQZGmf+M91VKB
 XL7Ei4Iitd7Udxsiaf4sBh/FLzHGMAxW6mKEeACrjP0Rd2aHNcdzZw/IMPJr6qAS8wLK
 p9aoun7Lqi3vY2i1TFobVXr0/24DZ7W+sEuzMI6AuXNYelRPzdU4ZitARn7wig2mtsas
 pWAoXQ4dlBx9HK/bHJhWgRPY7gZ/00j/GSb5LcMEPmDRNjtrqVvg25Yco8//PS/Q6+SS
 2AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711637441; x=1712242241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LoJhiSQMgbnriZ5qJ9TJewtlb/1Oql+iO0DbpBLB4ng=;
 b=YZV1JbwYjcWXOpEZFY9WAZUrzsJefLpTO7tBOcEAuEi7CD8gBc6/pjvFF4ILzfuXSc
 PHbMADuNjS4+cGMATnkgIrQPGHnpSIA+IysqZ08aL4ulUrexanGfwmWmQKNTb6R9ZgWM
 W/9bg5j6KdLjed5OM5O1kCLuClKjZJmtuk+fZVJncy6F18TybuwogI+Ko8Nq7WY7PtCB
 pNYLvXdmoTUMdMAUam2i/c5CbN8+oUZEXpkBTiWD+xtHWV+SF2sZAntuACtrddMVURIJ
 DXRfR23sU+fuhp6Wo4vu4JcobvYXpycq6EGG8FYUwBPG0gBXZgSX4bgK9YIoasxHXvYE
 GdvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFYkgP2mZCTJutFjoElGqeCVTskv2XYLu2D/zD3ls88XToZcsFSf+fgYmupUXRiY9VWsWPV+dsn/G9eZKvJpVp2/Cle90=
X-Gm-Message-State: AOJu0YzQfOLi2xtxo4oEy3n08FYNaIts9w/ShECavtdVCF3ucG+eC3U/
 PLOMT/W1Szy6MPZYvsqpexV42Fewd4KUbuEtrRTlqN5Cxp0xEhCKZLxKjxaFZl2lzke8N1Atz1M
 fKuwYXMyyqfpGPKpWHaYX2Nm/9fSK4D+fOvku9A==
X-Google-Smtp-Source: AGHT+IEhF5aKcSCjq+vETRg/OsadUqEXt/5AoIaMr3a1ixbdRODLM4QvUjWmllgaW8ViYHMR/RFPYvFAuqDejN26isI=
X-Received: by 2002:a50:9f2c:0:b0:566:18ba:6b80 with SMTP id
 b41-20020a509f2c000000b0056618ba6b80mr2327057edf.31.1711637440804; Thu, 28
 Mar 2024 07:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-18-ruanjinjie@huawei.com>
In-Reply-To: <20240325084854.3010562-18-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 14:50:29 +0000
Message-ID: <CAFEAcA_p6i5KNcQW3NLZY=kwUXuUPXM+8ncC8T-gPNVUWJ6CHA@mail.gmail.com>
Subject: Re: [PATCH v10 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 25 Mar 2024 at 08:53, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
>
> When introduce NMI interrupt, there are some updates to the semantics for the
> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
> should return 1022 if the intid has non-maskable property. And for
> ICC_NMIAR1_EL1 register, it should return 1023 if the intid do not have
> non-maskable property. Howerever, these are not necessary for ICC_HPPIR1_EL1
> register.
>
> And the APR and RPR has NMI bits which should be handled correctly.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v10:
> - is_nmi -> nmi.
> - is_hppi -> hppi.
> - Exchange the order of nmi and hppi parameters.
> - superprio -> nmi.
> - Handle APR and RPR NMI bits.
> - Update the commit message, super priority -> non-maskable property.
> v7:
> - Add Reviewed-by.
> v4:
> - Define ICC_NMIAR1_EL1 only if FEAT_GICv3_NMI is implemented.
> - Check sctrl_elx.SCTLR_NMI to return 1022 for icc_iar1_read().
> - Add gicv3_icc_nmiar1_read() trace event.
> - Do not check icc_hppi_can_preempt() for icc_nmiar1_read().
> - Add icv_nmiar1_read() and call it when EL2Enabled() and HCR_EL2.IMO == '1'
> ---
>  hw/intc/arm_gicv3_cpuif.c | 115 ++++++++++++++++++++++++++++++++++----
>  hw/intc/gicv3_internal.h  |   5 ++
>  hw/intc/trace-events      |   1 +
>  3 files changed, 110 insertions(+), 11 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index e1a60d8c15..76e2286e70 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -795,6 +795,13 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      return intid;
>  }
>
> +static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /* todo */
> +    uint64_t intid = INTID_SPURIOUS;
> +    return intid;
> +}
> +
>  static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
>  {
>      /*
> @@ -825,11 +832,15 @@ static inline int icc_num_aprs(GICv3CPUState *cs)
>      return aprmax;
>  }
>
> -static int icc_highest_active_prio(GICv3CPUState *cs)
> +static uint64_t icc_highest_active_prio(GICv3CPUState *cs)
>  {
>      /* Calculate the current running priority based on the set bits
>       * in the Active Priority Registers.
>       */
> +    ARMCPU *cpu = ARM_CPU(cs->cpu);
> +    CPUARMState *env = &cpu->env;
> +
> +    uint64_t prio;
>      int i;
>
>      for (i = 0; i < icc_num_aprs(cs); i++) {
> @@ -839,7 +850,32 @@ static int icc_highest_active_prio(GICv3CPUState *cs)
>          if (!apr) {
>              continue;
>          }
> -        return (i * 32 + ctz32(apr)) << (icc_min_bpr(cs) + 1);
> +        prio = (i * 32 + ctz32(apr)) << (icc_min_bpr(cs) + 1);
> +
> +        if (cs->gic->nmi_support) {
> +            if (cs->gic->gicd_ctlr & GICD_CTLR_DS) {
> +                if ((cs->icc_apr[GICV3_G0][i] & ICC_AP1R_EL1_NMI) ||
> +                    (cs->icc_apr[GICV3_G1][i] & ICC_AP1R_EL1_NMI) ||
> +                    (cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI)) {
> +                    prio |= ICC_RPR_EL1_NMI;
> +                }
> +            } else if (!arm_is_secure(env)) {
> +                if (cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI) {
> +                    prio |= ICC_RPR_EL1_NMI;
> +                }
> +            } else {
> +                if (cs->icc_apr[GICV3_G1][i] & ICC_AP1R_EL1_NMI) {
> +                    prio |= ICC_RPR_EL1_NMI;
> +                }
> +            }
> +
> +            if (arm_feature(env, ARM_FEATURE_EL3) &&
> +                cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI) {
> +                prio |= ICC_RPR_EL1_NSNMI;
> +            }
> +        }
> +
> +        return prio;

This function is used both for getting the ICC_RPR value,
and also in icc_hppi_can_preempt(). So we can't put the
special RPR NMI bits in here. Also doing that will not work well
with the way the code in icc_rpr_read() adjusts the priority
for non-secure accesses. I think we should follow the structure
of the pseudocode here, and do the setting of the RPR bits 62 and 63
in icc_rpr_read(). (In the pseudocode this is ICC_RPR_EL1 calling
GetHighestActivePriority() and then doing the NMI bits locally.)

The NMI bit also exists only in the AP1R0 bit, not in every AP
register. So you can check it before the for() loop, something like this:

    if (cs->gic->nmi_support) {
        /*
         * If an NMI is active this takes precedence over anything else
         * for priority purposes; the NMI bit is only in the AP1R0 bit.
         * We return here the effective priority of the NMI, which is
         * either 0x0 or 0x80. Callers will need to check NMI again for
         * purposes of either setting the RPR register bits or for
         * prioritization of NMI vs non-NMI.
         */
        prio = 0;
        if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
            return 0;
        }
        if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
            return (cs->gic->gicd_ctlr & GICD_CTLR_DS) ? 0 : 0x80;
        }
    }

Then in icc_rpr_read() we can pretty much directly write the same
logic that the pseudocode uses to determine whether to set the RPR
NMI bits, after the point where we do the shifting of the prio for
the NS view:

    if (cs->gic->nmi_support) {
        /* NMI info is reported in the high bits of RPR */
        if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
                prio |= ICC_RPR_EL1_NMI;
            }
        } else {
            if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
                prio |= ICC_RPR_EL1_NSNMI;
            }
            if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
                prio |= ICC_RPR_EL1_NMI;
            }
        }
    }

>      }
>      /* No current active interrupts: return idle priority */
>      return 0xff;
> @@ -896,7 +932,7 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
>      /* Return true if we have a pending interrupt of sufficient
>       * priority to preempt.
>       */
> -    int rprio;
> +    uint64_t rprio;

You won't need to change the type of this variable with the change above.

>      uint32_t mask;
>
>      if (icc_no_enabled_hppi(cs)) {

icc_hppi_can_preempt() needs more changes than this (check the
pseudocode in CanSignalInterrupt(), and the text in 4.8, particularly
4.8.6):

 * the (cs->hppi.prio >= cs->icc_pmr_el1) check only applies
   if !cs->hppi.nmi
 * if this is an NMI and GICD_CTLR.DS is 0 and it's a G1NS
   interrupt, then we mask if the PMR is < 0x80, or if
   we're in Secure state and the PMR == 0x80
 * if this is an NMI and the (masked) hppi.prio is equal to the
   (masked) running priority, then we preempt if there's not
   already an active NMI, ie if the APR NMI bit is clear

> @@ -1034,7 +1070,7 @@ static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      gicv3_cpuif_update(cs);
>  }
>
> -static void icc_activate_irq(GICv3CPUState *cs, int irq)
> +static void icc_activate_irq(GICv3CPUState *cs, int irq, bool nmi)
>  {

When activating an interrupt, we set the NMI bit in the
priority register based only on the interrupt's config,
not on what register was used to activate it. So we don't
want a 'bool nmi' argument, we want a local:
   bool nmi = cs->hppi.nmi;

(Compare the pseudocode in the spec: ICC_IAR0_EL1, ICC_IAR1_EL1,
and ICC_NMIAR1_EL1 all call AcknowledgeInterrupt(pendID)
to activate it.)

>      /* Move the interrupt from the Pending state to Active, and update
>       * the Active Priority Registers
> @@ -1047,6 +1083,10 @@ static void icc_activate_irq(GICv3CPUState *cs, int irq)
>
>      cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
>
> +    if (cs->gic->nmi_support) {
> +        cs->icc_apr[cs->hppi.grp][regno] |= (nmi ? ICC_AP1R_EL1_NMI : 0);
> +    }

In the APRs, we set only the NMI bit for an NMI and the ordinary priority
bit for a non-NMI; so this should be

     if (cs->gic->nmi_support && nmi) {
         cs->icc_apr[cs->hppi.grp][regno] |= ICC_AP1R_EL1_NMI;
     } else {
         cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
     }

(Otherwise if we had a non-NMI that was interrupted by an NMI
at the same priority we wouldn't be able to distinguish this
from the NMI interrupting when nothing else was active.)

> +
>      if (irq < GIC_INTERNAL) {
>          cs->gicr_iactiver0 = deposit32(cs->gicr_iactiver0, irq, 1, 1);
>          cs->gicr_ipendr0 = deposit32(cs->gicr_ipendr0, irq, 1, 0);
> @@ -1097,7 +1137,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
>      return cs->hppi.irq;
>  }
>
> -static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
> +static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env, bool hppi,
> +                                 bool nmi)
>  {
>      /* Return the highest priority pending interrupt register value
>       * for group 1.
> @@ -1108,6 +1149,18 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
>          return INTID_SPURIOUS;
>      }
>
> +    if (!hppi) {
> +        int el = arm_current_el(env);
> +
> +        if (nmi && (!cs->hppi.nmi)) {
> +            return INTID_SPURIOUS;
> +        }
> +
> +        if (!nmi && cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
> +            return INTID_NMI;
> +        }
> +    }
> +

Rather than passing two extra boolean arguments into this
function, I think it's better to follow the pseudocode's
structure, and have the "should we instead return a
special INTID_*" checks be done in the callers of this function.
They all end up different so they don't really share code
by pushing the checks into this function.

>      /* Check whether we can return the interrupt or if we should return
>       * a special identifier, as per the CheckGroup1ForSpecialIdentifiers
>       * pseudocode. (We can simplify a little because for us ICC_SRE_EL1.RM
> @@ -1149,7 +1202,7 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      }
>
>      if (!gicv3_intid_is_special(intid)) {
> -        icc_activate_irq(cs, intid);
> +        icc_activate_irq(cs, intid, false);
>      }
>
>      trace_gicv3_icc_iar0_read(gicv3_redist_affid(cs), intid);
> @@ -1168,17 +1221,36 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      if (!icc_hppi_can_preempt(cs)) {
>          intid = INTID_SPURIOUS;
>      } else {
> -        intid = icc_hppir1_value(cs, env);
> +        intid = icc_hppir1_value(cs, env, false, false);
>      }
>
>      if (!gicv3_intid_is_special(intid)) {
> -        icc_activate_irq(cs, intid);
> +        icc_activate_irq(cs, intid, false);
>      }
>
>      trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
>      return intid;
>  }
>
> +static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    GICv3CPUState *cs = icc_cs_from_env(env);
> +    uint64_t intid;
> +
> +    if (icv_access(env, HCR_IMO)) {
> +        return icv_nmiar1_read(env, ri);
> +    }
> +
> +    intid = icc_hppir1_value(cs, env, false, true);
> +
> +    if (!gicv3_intid_is_special(intid)) {
> +        icc_activate_irq(cs, intid, true);
> +    }
> +
> +    trace_gicv3_icc_nmiar1_read(gicv3_redist_affid(cs), intid);
> +    return intid;
> +}
> +
>  static void icc_drop_prio(GICv3CPUState *cs, int grp)
>  {
>      /* Drop the priority of the currently active interrupt in
> @@ -1207,6 +1279,10 @@ static void icc_drop_prio(GICv3CPUState *cs, int grp)
>          }
>          /* Clear the lowest set bit */
>          *papr &= *papr - 1;
> +
> +        if (cs->gic->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
> +            *papr &= (~ICC_AP1R_EL1_NMI);
> +        }

The NMI bit is only in the AP1R0 register, and if it is set then
we should clear only it and not any other AP bits. At the moment
this code clears the lowest set bit and also the NMI bit.

>          break;
>      }
>
> @@ -1555,7 +1631,7 @@ static uint64_t icc_hppir1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>          return icv_hppir_read(env, ri);
>      }
>
> -    value = icc_hppir1_value(cs, env);
> +    value = icc_hppir1_value(cs, env, true, false);
>      trace_gicv3_icc_hppir1_read(gicv3_redist_affid(cs), value);
>      return value;
>  }
> @@ -1693,7 +1769,11 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
>          return;
>      }
>
> -    cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
> +    if (cs->gic->nmi_support) {
> +        cs->icc_apr[grp][regno] = value & (0xFFFFFFFFU | ICC_AP1R_EL1_NMI);
> +    } else {
> +        cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
> +    }
>      gicv3_cpuif_update(cs);
>  }
>
> @@ -1783,7 +1863,7 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      GICv3CPUState *cs = icc_cs_from_env(env);
> -    int prio;
> +    uint64_t prio;
>
>      if (icv_access(env, HCR_FMO | HCR_IMO)) {
>          return icv_rpr_read(env, ri);
> @@ -2482,6 +2562,15 @@ static const ARMCPRegInfo gicv3_cpuif_icc_apxr23_reginfo[] = {
>      },
>  };
>
> +static const ARMCPRegInfo gicv3_cpuif_gicv3_nmi_reginfo[] = {
> +    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
> +      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
> +      .type = ARM_CP_IO | ARM_CP_NO_RAW,
> +      .access = PL1_R, .accessfn = gicv3_irq_access,
> +      .readfn = icc_nmiar1_read,
> +    },
> +};
> +
>  static uint64_t ich_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      GICv3CPUState *cs = icc_cs_from_env(env);
> @@ -2838,6 +2927,10 @@ void gicv3_init_cpuif(GICv3State *s)
>           */
>          define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
>
> +        if (s->nmi_support) {
> +            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
> +        }
> +
>          /*
>           * The CPU implementation specifies the number of supported
>           * bits of physical priority. For backwards compatibility

icc_highest_active_group() also needs to be changed, because
if the NMI bit is set in an AP register that is what defines
the group of the highest priority active interrupt. Something
like this at the top of icc_highest_active_group() should do:

+    if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
+        return GICV3_G1;
+    }
+    if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
+        return GICV3_G1NS;
+    }

thanks
-- PMM

