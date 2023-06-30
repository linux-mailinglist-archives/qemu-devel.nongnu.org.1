Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56F7436DD
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9KE-0001Tn-Dz; Fri, 30 Jun 2023 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF9K0-0001SV-Ob; Fri, 30 Jun 2023 04:17:42 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF9Jy-0006Od-3P; Fri, 30 Jun 2023 04:17:40 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-98e011f45ffso171466566b.3; 
 Fri, 30 Jun 2023 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688113055; x=1690705055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b9FN69gRwTqTPyS5Ekny/wk+9eJ/SvBx2FfF63yuMg0=;
 b=eB6r9cNGtJdJJLmK0x1s3SLsDVMR7sY+i7HJlWPOeuRHQVCDkqTUP/Iv8yAlpTj8Xb
 7epKY9JUctu5SoGMqjn3AyLAWGzkUgyh4WWZ0SM1Ibc5/hAlUMKM0/LrJKXR9PHUos3X
 VeaUXpkElf+o+FedPYyaVrVNoRRQ7cdwXwJwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688113055; x=1690705055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9FN69gRwTqTPyS5Ekny/wk+9eJ/SvBx2FfF63yuMg0=;
 b=c1IUOvXzxzbjJgDJa8zilrM7Jj5sjEdvFwYW385rL6exT/2MITSO2ujx6N9kvhIhzI
 Q6Qc/Sqo7z0crk1nDLyFedVOv2Lqzl2p8nNp6QLag+dKjoZaeHkzzzeXAeb4IYzIf07F
 wo2YpUPlsgmXEjycUXrZltIkbU3nzF5ywPxXurs8Yhk7LmVHRNPIQEGwa8D1rjxivoJv
 aK9W3VQt5OeKOcm8gXtgea1SC9iKtO+ElveuogoN+gBPQHS7H5ObxIqsgEa30EupuaTK
 AXa19AJHpxmcpK/b7mGCZeZ0TgbedOFvDM/MeuhJ04x851RPpFHZN316FMBcIzIqquf1
 x/0w==
X-Gm-Message-State: ABy/qLYlqcfUwjNnsKLURKYugADqqVWtKsZIenK6d89mozPFAtDlE2Hi
 ayA4Qqf2YvgvwrafVCdhdiTirNd4iJ9+BpHJroj373kNuYo=
X-Google-Smtp-Source: APBJJlFfV6ydFyP+n88xET4AtK4A8J0BZ2/u1a4vpQl6R4lIGpO+cdLj9LgvTDS4J9MLypOU9lquxXGiqcg/pxTVl5k=
X-Received: by 2002:a17:906:fa12:b0:991:e458:d04 with SMTP id
 lo18-20020a170906fa1200b00991e4580d04mr1094567ejb.51.1688113055037; Fri, 30
 Jun 2023 01:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230629021633.328916-1-npiggin@gmail.com>
 <20230629021633.328916-2-npiggin@gmail.com>
In-Reply-To: <20230629021633.328916-2-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 30 Jun 2023 08:17:23 +0000
Message-ID: <CACPK8XcB7sFoUqn9Lw=Nw51qCKpUxX5Wm8p-hP5JoTo1iMwECw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] target/ppc: Add LPAR-per-core vs per-thread mode
 flag
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 29 Jun 2023 at 02:17, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The Power ISA has the concept of sub-processors:
>
>   Hardware is allowed to sub-divide a multi-threaded processor into
>   "sub-processors" that appear to privileged programs as multi-threaded
>   processors with fewer threads.
>
> POWER9 and POWER10 have two modes, either every thread is a
> sub-processor or all threads appear as one multi-threaded processor.
> In the user manuals these are known as "LPAR-per-thread" and "LPAR
> per core" (or "1LPAR"), respectively.
>
> The practical difference is in LPAR-per-thread mode, non-hypervisor SPRs
> are not shared between threads and msgsndp can not be used to message
> siblings. In 1LPAR mode some SPRs are shared and msgsndp is usable. LPPT
> allows multiple partitions to run concurrently on the same core,
> and is a requirement for KVM to run on POWER9/10.
>
> Traditionally, SMT in PAPR environments including PowerVM and the
> pseries machine with KVM acceleration beahves as in 1LPAR mode. In

behaves

> OPAL systems, LPAR-per-thread is used. When adding SMT to the powernv
> machine, it is preferable to emulate OPAL LPAR-per-thread, so to
> account for this difference a flag is added and SPRs may become either
> per-thread, per-core shared, or per-LPAR shared. Per-LPAR registers
> become either per-thread or per-core shared depending on the mode.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Nice description.

Reviewed-by: Joel Stanley <joel@jms.id.au>

As we make the emulation more accurate, we will want the 1LPAR state
to be reflected in the xscoms too.

> ---
>  hw/ppc/spapr_cpu_core.c |  2 ++
>  target/ppc/cpu.h        |  3 +++
>  target/ppc/cpu_init.c   | 12 ++++++++++++
>  target/ppc/translate.c  | 16 +++++++++++++---
>  4 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index a4e3c2fadd..b482d9754a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -270,6 +270,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
>      env->spr_cb[SPR_TIR].default_value = thread_index;
>
> +    cpu_ppc_set_1lpar(cpu);
> +
>      /* Set time-base frequency to 512 MHz. vhyp must be set first. */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 94497aa115..beddc5db5b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -674,6 +674,8 @@ enum {
>      POWERPC_FLAG_SCV      = 0x00200000,
>      /* Has >1 thread per core                                                */
>      POWERPC_FLAG_SMT      = 0x00400000,
> +    /* Using "LPAR per core" mode  (as opposed to per-thread)                */
> +    POWERPC_FLAG_1LPAR    = 0x00800000,
>  };
>
>  /*
> @@ -1435,6 +1437,7 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
>  void ppc_tlb_invalidate_all(CPUPPCState *env);
>  void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
>  void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
> +void cpu_ppc_set_1lpar(PowerPCCPU *cpu);
>  int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
>                       target_ulong address, uint32_t pid);
>  int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index aeff71d063..dc3a65a575 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6601,6 +6601,18 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>      env->msr_mask &= ~MSR_HVB;
>  }
>
> +void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env = &cpu->env;
> +
> +    /*
> +     * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
> +     * between threads.
> +     */
> +    if (env->flags & POWERPC_FLAG_SMT) {
> +        env->flags |= POWERPC_FLAG_1LPAR;
> +    }
> +}
>  #endif /* !defined(CONFIG_USER_ONLY) */
>
>  #endif /* defined(TARGET_PPC64) */
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 372ee600b2..ef186396b4 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -256,6 +256,16 @@ static inline bool gen_serialize_core(DisasContext *ctx)
>  }
>  #endif
>
> +static inline bool gen_serialize_core_lpar(DisasContext *ctx)
> +{
> +    /* 1LPAR implies SMT */
> +    if (ctx->flags & POWERPC_FLAG_1LPAR) {
> +        return gen_serialize(ctx);
> +    }
> +
> +    return true;
> +}
> +
>  /* SPR load/store helpers */
>  static inline void gen_load_spr(TCGv t, int reg)
>  {
> @@ -451,7 +461,7 @@ static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
>
>  void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
>  {
> -    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> +    if (!(ctx->flags & POWERPC_FLAG_1LPAR)) {
>          spr_write_CTRL_ST(ctx, sprn, gprn);
>          goto out;
>      }
> @@ -815,7 +825,7 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
>  /* DPDES */
>  void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
>  {
> -    if (!gen_serialize_core(ctx)) {
> +    if (!gen_serialize_core_lpar(ctx)) {
>          return;
>      }
>
> @@ -824,7 +834,7 @@ void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
>
>  void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
>  {
> -    if (!gen_serialize_core(ctx)) {
> +    if (!gen_serialize_core_lpar(ctx)) {
>          return;
>      }
>
> --
> 2.40.1
>
>

