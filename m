Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE67A12B6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 03:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgxEb-0005Ct-M3; Thu, 14 Sep 2023 21:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgxEZ-00058s-Hz; Thu, 14 Sep 2023 21:02:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgxEW-0006D7-Up; Thu, 14 Sep 2023 21:02:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9ddso1333676b3a.0; 
 Thu, 14 Sep 2023 18:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694739774; x=1695344574; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4K7MHQ2OTbmCuiQ/ZCszuzu7R7xhILDFbqyfo8zCMXs=;
 b=GOe3Zt6i6XIR4fJIaIWC0qadeJpnB/dsDdN8saLFvjTiaefI5dL+jK4B5d7q0ciXIy
 K3S6HAskwfElUKZ8hDQmbmjMb1VRkMWRErpkqol1/stjzFP0uaZKZ6gRv1cMUz4t2Ev1
 JS16LyKNsa+zH5y8WmF5NZI1yE3YKu3HGlXP9gcstblzdtJ6vbUX2tEJ/vulD+e2Vu/N
 M+j+rJdSQYSVO4/tPu7fudPBSX0f3GO/Dprw16X5pCmoI3Ha+H1Q2TqekInY31QVMHXd
 qMm1plLt8taJc64/GjcJVmxkqBqHljz1+jdObdUHLy8DJXuAqdonVg5DKI+WxTYWaQ1k
 xFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694739774; x=1695344574;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4K7MHQ2OTbmCuiQ/ZCszuzu7R7xhILDFbqyfo8zCMXs=;
 b=en9Jd1OrpgRZDWElZQNRIoX8zZtFcKQUZjyJZvRkrjKWJTo1wlOj5EP6mjW4pmlgnW
 5lqUF4Cjn1NIl/G/nazQSDaR0gd4QNBtqnLsiEbFor6mmjmCb03cXMSXyMJ/5ApIff7F
 i+F8uM/rG1nBgtbY9Bt/FTIoNX2U9LmkKlSNNrsPwDZphKqkKBA3b0d7x/ocuug9Ha2a
 kwMypcuQOHs5/aGfvQu8F4la3ZmlRiIVxa2Z0uwWHocXQBAhBEtp2A6k33PKzhdV94O4
 u4Z+y06cR6vo4tyKv4cnX13rWluAZERHkVDLddsucF4uFKV0vFYS4D6gD5IBrN4tH0X9
 mCXQ==
X-Gm-Message-State: AOJu0Ywd5HgANpq2SW6LcdeBvT2hX40k/zUXZeCYHuYYN12FKrFyhw+q
 cSJt8H7EiA6ykTVVlyd/k7g=
X-Google-Smtp-Source: AGHT+IEa69Mf0wPvgu+u9rLHd/iO+Xdy4qC8AJzFbVM3yNzmKA9j1Pt0aoF7oUY49QoL7IzAeegmEQ==
X-Received: by 2002:a05:6a00:23c8:b0:68e:3eb6:d45 with SMTP id
 g8-20020a056a0023c800b0068e3eb60d45mr227798pfc.30.1694739773818; 
 Thu, 14 Sep 2023 18:02:53 -0700 (PDT)
Received: from localhost ([193.114.103.68]) by smtp.gmail.com with ESMTPSA id
 q20-20020a62ae14000000b0068fca9abbc3sm1885030pff.79.2023.09.14.18.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 18:02:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Sep 2023 11:02:48 +1000
Message-Id: <CVJ33XKZ3RO0.22BRA1VHY26PJ@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 2/4] target/ppc: Add recording of taken branches to BHRB
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202421.3381779-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230912202421.3381779-1-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Sep 13, 2023 at 6:24 AM AEST, Glenn Miles wrote:
> This commit continues adding support for the Branch History
> Rolling Buffer (BHRB) as is provided starting with the P8
> processor and continuing with its successors.  This commit
> is limited to the recording and filtering of taken branches.
>
> The following changes were made:
>
>   - Added a BHRB buffer for storing branch instruction and
>     target addresses for taken branches
>   - Renamed gen_update_cfar to gen_update_branch_history and
>     added a 'target' parameter to hold the branch target
>     address and 'inst_type' parameter to use for filtering
>   - Added a combination of jit-time and run-time checks to
>     gen_update_branch_history for determining if a branch
>     should be recorded
>   - Added TCG code to gen_update_branch_history that stores
>     data to the BHRB and updates the BHRB offset.
>   - Added BHRB resource initialization and reset functions
>   - Enabled functionality for P8, P9 and P10 processors.
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.h                       |  18 +++-
>  target/ppc/cpu_init.c                  |  41 ++++++++-
>  target/ppc/helper_regs.c               |  32 +++++++
>  target/ppc/helper_regs.h               |   1 +
>  target/ppc/power8-pmu.c                |   2 +
>  target/ppc/power8-pmu.h                |   7 ++
>  target/ppc/translate.c                 | 114 +++++++++++++++++++++++--
>  target/ppc/translate/branch-impl.c.inc |   2 +-
>  8 files changed, 205 insertions(+), 12 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 20ae1466a5..bda1afb700 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -454,8 +454,9 @@ FIELD(MSR, LE, MSR_LE, 1)
>  #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
>                           MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
> =20
> -#define MMCRA_BHRBRD    PPC_BIT(26)            /* BHRB Recording Disable=
 */
> -
> +#define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */

Fold this tidying into patch 1.

> +#define MMCRA_IFM_MASK  PPC_BITMASK(32, 33) /* BHRB Instruction Filterin=
g */
> +#define MMCRA_IFM_SHIFT PPC_BIT_NR(33)
> =20
>  #define MMCR1_EVT_SIZE 8
>  /* extract64() does a right shift before extracting */
> @@ -682,6 +683,8 @@ enum {
>      POWERPC_FLAG_SMT      =3D 0x00400000,
>      /* Using "LPAR per core" mode  (as opposed to per-thread)           =
     */
>      POWERPC_FLAG_SMT_1LPAR =3D 0x00800000,
> +    /* Has BHRB */
> +    POWERPC_FLAG_BHRB      =3D 0x01000000,
>  };

Interesting question of which patch to add different flags. I'm
strongly in add when you add code that uses them like this one,
but it's a matter of taste and not always practical to be an
absolute rule. I don't mind too much what others do, but maybe
this and the pcc->flags init should go in patch 1 since that's adding
flags that aren't yet used?

> =20
>  /*
> @@ -1110,6 +1113,9 @@ DEXCR_ASPECT(PHIE, 6)
>  #define PPC_CPU_OPCODES_LEN          0x40
>  #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
> =20
> +#define BHRB_MAX_NUM_ENTRIES_LOG2 (5)
> +#define BHRB_MAX_NUM_ENTRIES      (1 << BHRB_MAX_NUM_ENTRIES_LOG2)
> +
>  struct CPUArchState {
>      /* Most commonly used resources during translated code execution fir=
st */
>      target_ulong gpr[32];  /* general purpose registers */
> @@ -1196,6 +1202,14 @@ struct CPUArchState {
>      int dcache_line_size;
>      int icache_line_size;
> =20
> +    /* Branch History Rolling Buffer (BHRB) resources */
> +    target_ulong bhrb_num_entries;
> +    target_ulong bhrb_base;
> +    target_ulong bhrb_filter;
> +    target_ulong bhrb_offset;
> +    target_ulong bhrb_offset_mask;
> +    uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];

Put these under ifdef TARGET_PPC64?

> +
>      /* These resources are used during exception processing */
>      /* CPU model definition */
>      target_ulong msr_mask;
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 568f9c3b88..19d7505a73 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6100,6 +6100,28 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data=
)
>      pcc->l1_icache_size =3D 0x8000;
>  }
> =20
> +static void bhrb_init_state(CPUPPCState *env, target_long num_entries_lo=
g2)
> +{
> +    if (env->flags & POWERPC_FLAG_BHRB) {
> +        if (num_entries_log2 > BHRB_MAX_NUM_ENTRIES_LOG2) {
> +            num_entries_log2 =3D BHRB_MAX_NUM_ENTRIES_LOG2;
> +        }
> +        env->bhrb_num_entries =3D 1 << num_entries_log2;
> +        env->bhrb_base =3D (target_long)&env->bhrb[0];
> +        env->bhrb_offset_mask =3D (env->bhrb_num_entries * sizeof(uint64=
_t)) - 1;
> +    }
> +}
> +
> +static void bhrb_reset_state(CPUPPCState *env)
> +{
> +    if (env->flags & POWERPC_FLAG_BHRB) {
> +        env->bhrb_offset =3D 0;
> +        env->bhrb_filter =3D 0;
> +        memset(env->bhrb, 0, sizeof(env->bhrb));
> +    }
> +}
> +
> +#define POWER8_BHRB_ENTRIES_LOG2 5
>  static void init_proc_POWER8(CPUPPCState *env)
>  {
>      /* Common Registers */
> @@ -6141,6 +6163,8 @@ static void init_proc_POWER8(CPUPPCState *env)
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> =20
> +    bhrb_init_state(env, POWER8_BHRB_ENTRIES_LOG2);
> +
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER8(env);
>      ppcPOWER7_irq_init(env_archcpu(env));
> @@ -6241,7 +6265,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>                   POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>                   POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM;
> +                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM |
> +                 POWERPC_FLAG_BHRB;
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>  }
> @@ -6265,6 +6290,7 @@ static struct ppc_radix_page_info POWER9_radix_page=
_info =3D {
>  };
>  #endif /* CONFIG_USER_ONLY */
> =20
> +#define POWER9_BHRB_ENTRIES_LOG2 5
>  static void init_proc_POWER9(CPUPPCState *env)
>  {
>      /* Common Registers */
> @@ -6315,6 +6341,8 @@ static void init_proc_POWER9(CPUPPCState *env)
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> =20
> +    bhrb_init_state(env, POWER9_BHRB_ENTRIES_LOG2);
> +
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER9(env);
>      ppcPOWER9_irq_init(env_archcpu(env));
> @@ -6434,7 +6462,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>                   POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>                   POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
> +                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV |
> +                 POWERPC_FLAG_BHRB;
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>  }
> @@ -6458,6 +6487,7 @@ static struct ppc_radix_page_info POWER10_radix_pag=
e_info =3D {
>  };
>  #endif /* !CONFIG_USER_ONLY */
> =20
> +#define POWER10_BHRB_ENTRIES_LOG2 5
>  static void init_proc_POWER10(CPUPPCState *env)
>  {
>      /* Common Registers */
> @@ -6505,6 +6535,8 @@ static void init_proc_POWER10(CPUPPCState *env)
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> =20
> +    bhrb_init_state(env, POWER10_BHRB_ENTRIES_LOG2);
> +
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER10(env);
>      ppcPOWER9_irq_init(env_archcpu(env));
> @@ -6610,7 +6642,8 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data=
)
>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
>                   POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
>                   POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
> +                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV |
> +                 POWERPC_FLAG_BHRB;
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>  }
> @@ -7178,6 +7211,8 @@ static void ppc_cpu_reset_hold(Object *obj)
>          }
>          env->spr[i] =3D spr->default_value;
>      }
> +
> +    bhrb_reset_state(env);
>  }
> =20
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index 4ff054063d..68b27196d9 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -752,3 +752,35 @@ void register_usprgh_sprs(CPUPPCState *env)
>                   &spr_read_ureg, SPR_NOACCESS,
>                   0x00000000);
>  }
> +
> +void hreg_bhrb_filter_update(CPUPPCState *env)
> +{
> +    target_long ifm;
> +
> +    if (!(env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
> +        /* disable recording to BHRB */
> +        env->bhrb_filter =3D BHRB_TYPE_NORECORD;
> +        return;
> +    }
> +
> +    ifm =3D (env->spr[SPR_POWER_MMCRA] & MMCRA_IFM_MASK) >> MMCRA_IFM_SH=
IFT;
> +    switch (ifm) {
> +    case 0:
> +        /* record all branches */
> +        env->bhrb_filter =3D -1;
> +        break;
> +    case 1:
> +        /* only record calls (LK =3D 1) */
> +        env->bhrb_filter =3D BHRB_TYPE_CALL;
> +        break;
> +    case 2:
> +        /* only record indirect branches */
> +        env->bhrb_filter =3D BHRB_TYPE_INDIRECT;
> +        break;
> +    case 3:
> +        /* only record conditional branches */
> +        env->bhrb_filter =3D BHRB_TYPE_COND;
> +        break;
> +    }
> +}
> +
> diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> index 8196c1346d..ab6aba1c24 100644
> --- a/target/ppc/helper_regs.h
> +++ b/target/ppc/helper_regs.h
> @@ -25,6 +25,7 @@ void hreg_compute_hflags(CPUPPCState *env);
>  void hreg_update_pmu_hflags(CPUPPCState *env);
>  void cpu_interrupt_exittb(CPUState *cs);
>  int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv);
> +void hreg_bhrb_filter_update(CPUPPCState *env);
> =20
>  #ifdef CONFIG_USER_ONLY
>  static inline void check_tlb_flush(CPUPPCState *env, bool global) { }
> diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
> index 6f5d4e1256..18149a15b2 100644
> --- a/target/ppc/power8-pmu.c
> +++ b/target/ppc/power8-pmu.c
> @@ -261,6 +261,7 @@ void helper_store_mmcr0(CPUPPCState *env, target_ulon=
g value)
>      env->spr[SPR_POWER_MMCR0] =3D value;
> =20
>      pmu_mmcr01a_updated(env);
> +    hreg_bhrb_filter_update(env);
> =20
>      /* Update cycle overflow timers with the current MMCR0 state */
>      pmu_update_overflow_timers(env);
> @@ -280,6 +281,7 @@ void helper_store_mmcrA(CPUPPCState *env, uint64_t va=
lue)
>      env->spr[SPR_POWER_MMCRA] =3D value;
> =20
>      pmu_mmcr01a_updated(env);
> +    hreg_bhrb_filter_update(env);
>  }
> =20

Can these just be moved into pmu_mmcr01a_updated? AFAIKS they only
depend on MMCR0/A.

>  target_ulong helper_read_pmc(CPUPPCState *env, uint32_t sprn)
> diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
> index 87fa8c9334..a887094045 100644
> --- a/target/ppc/power8-pmu.h
> +++ b/target/ppc/power8-pmu.h
> @@ -17,6 +17,13 @@
> =20
>  #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
> =20
> +#define BHRB_TYPE_NORECORD      0x00
> +#define BHRB_TYPE_CALL          0x01
> +#define BHRB_TYPE_INDIRECT      0x02
> +#define BHRB_TYPE_COND          0x04
> +#define BHRB_TYPE_OTHER         0x08
> +#define BHRB_TYPE_XL_FORM       0x10
> +
>  void cpu_ppc_pmu_init(CPUPPCState *env);
>  void pmu_mmcr01a_updated(CPUPPCState *env);
>  #else
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index d93fbd4574..7824475f54 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -177,6 +177,7 @@ struct DisasContext {
>  #if defined(TARGET_PPC64)
>      bool sf_mode;
>      bool has_cfar;
> +    bool has_bhrb;
>  #endif
>      bool fpu_enabled;
>      bool altivec_enabled;
> @@ -4104,12 +4105,100 @@ static void gen_rvwinkle(DisasContext *ctx)
>  }
>  #endif /* #if defined(TARGET_PPC64) */
> =20
> -static inline void gen_update_cfar(DisasContext *ctx, target_ulong nip)
> +
> +static inline void gen_update_branch_history(DisasContext *ctx,
> +                                             target_ulong nip,
> +                                             TCGv target,
> +                                             target_long inst_type)
>  {
>  #if defined(TARGET_PPC64)
> +    TCGv t0;
> +    TCGv t1;
> +    TCGv t2;
> +    TCGv t3;
> +    TCGLabel *no_update;
> +
>      if (ctx->has_cfar) {
>          tcg_gen_movi_tl(cpu_cfar, nip);
>      }
> +
> +    if (!ctx->has_bhrb || inst_type =3D=3D BHRB_TYPE_NORECORD) {
> +        return;
> +    }
> +
> +    /* ISA 3.1 adds the PMCRA[BRHBRD] and problem state checks */
> +    if ((ctx->insns_flags2 & PPC2_ISA310) && (ctx->mmcra_bhrbrd || !ctx-=
>pr)) {
> +        return;
> +    }
> +
> +    /* Check for BHRB "frozen" conditions */
> +    if (ctx->mmcr0_fcpc) {
> +        if (ctx->mmcr0_fcp) {
> +            if ((ctx->hv) && (ctx->pr)) {
> +                return;
> +            }
> +        } else if (!(ctx->hv) && (ctx->pr)) {
> +            return;
> +        }
> +    } else if ((ctx->mmcr0_fcp) && (ctx->pr)) {
> +        return;
> +    }
> +
> +    t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new();
> +    t2 =3D tcg_temp_new();
> +    t3 =3D tcg_temp_new();
> +    no_update =3D gen_new_label();
> +
> +    /* check for bhrb filtering */
> +    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUPPCState, bhrb_filter));
> +    tcg_gen_andi_tl(t0, t0, inst_type);
> +    tcg_gen_brcondi_tl(TCG_COND_EQ, t0, 0, no_update);
> +
> +    /* load bhrb base address into t2 */
> +    tcg_gen_ld_tl(t2, cpu_env, offsetof(CPUPPCState, bhrb_base));
> +
> +    /* load current bhrb_offset into t0 */
> +    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUPPCState, bhrb_offset));
> +
> +    /* load a BHRB offset mask into t3 */
> +    tcg_gen_ld_tl(t3, cpu_env, offsetof(CPUPPCState, bhrb_offset_mask));
> +
> +    /* add t2 to t0 to get address of bhrb entry */
> +    tcg_gen_add_tl(t1, t0, t2);
> +
> +    /* store nip into bhrb at bhrb_offset */
> +    tcg_gen_st_i64(tcg_constant_i64(nip), (TCGv_ptr)t1, 0);
> +
> +    /* add 8 to current bhrb_offset */
> +    tcg_gen_addi_tl(t0, t0, 8);
> +
> +    /* apply offset mask */
> +    tcg_gen_and_tl(t0, t0, t3);

For some cases where the value remains live for a time and not reused,
maybe use a more descriptive name? I know existing code is pretty lazy
with names (and I share some blame). t0,t2,t3 could be base, offset,
mask respectively, and t1 could be tmp that is used for filter and
address generation. Just a suggestion?


> +
> +    if (inst_type & BHRB_TYPE_XL_FORM) {
> +        /* Also record the target address for XL-Form branches */
> +
> +        /* add t2 to t0 to get address of bhrb entry */
> +        tcg_gen_add_tl(t1, t0, t2);
> +
> +        /* Set the 'T' bit for target entries */
> +        tcg_gen_ori_tl(t2, target, 0x2);
> +
> +        /* Store target address in bhrb */
> +        tcg_gen_st_tl(t2, (TCGv_ptr)t1, 0);
> +
> +        /* add 8 to current bhrb_offset */
> +        tcg_gen_addi_tl(t0, t0, 8);
> +
> +        /* apply offset mask */
> +        tcg_gen_and_tl(t0, t0, t3);
> +    }

I would say this is bordering on warranting a new function since it
mostly duplicates previous block. You could have it take base, mask,
offset and value to store, and have it return new offset.

> +
> +    /* save updated bhrb_offset for next time */
> +    tcg_gen_st_tl(t0, cpu_env, offsetof(CPUPPCState, bhrb_offset));
> +
> +    gen_set_label(no_update);
>  #endif
>  }

It all looks pretty good otherwise. I do worry about POWER8/9 which
do not have BHRB disable bit. How much do they slow down I wonder?

Thanks,
Nick

