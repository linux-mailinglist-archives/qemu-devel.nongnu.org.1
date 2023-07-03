Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F087F745B66
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHxk-0006vZ-7c; Mon, 03 Jul 2023 07:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGHxa-0006hH-Ss; Mon, 03 Jul 2023 07:43:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGHxY-0005ay-Ms; Mon, 03 Jul 2023 07:43:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvkZQ2mY8z4wqZ;
 Mon,  3 Jul 2023 21:43:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvkZM4Yktz4wxn;
 Mon,  3 Jul 2023 21:43:07 +1000 (AEST)
Message-ID: <1a0367d3-22d2-8465-1d70-166c75595f5f@kaod.org>
Date: Mon, 3 Jul 2023 13:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] target/ppc: Add LPAR-per-core vs per-thread mode flag
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
References: <20230703101700.24064-1-npiggin@gmail.com>
 <20230703101700.24064-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230703101700.24064-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/3/23 12:16, Nicholas Piggin wrote:
> The Power ISA has the concept of sub-processors:
> 
>    Hardware is allowed to sub-divide a multi-threaded processor into
>    "sub-processors" that appear to privileged programs as multi-threaded
>    processors with fewer threads.
> 
> POWER9 and POWER10 have two modes, either every thread is a
> sub-processor or all threads appear as one multi-threaded processor. In
> the user manuals these are known as "LPAR per thread" / "Thread LPAR",
> and "LPAR per core" / "1 LPAR", respectively.
> 
> The practical difference is: in thread LPAR mode, non-hypervisor SPRs
> are not shared between threads and msgsndp can not be used to message
> siblings. In 1 LPAR mode, some SPRs are shared and msgsndp is usable.
> Thrad LPAR allows multiple partitions to run concurrently on the same
> core, and is a requirement for KVM to run on POWER9/10 (which does not
> gang-schedule an LPAR on all threads of a core like POWER8 KVM).
> 
> Traditionally, SMT in PAPR environments including PowerVM and the
> pseries QEMU machine with KVM acceleration behaves as in 1 LPAR mode.
> In OPAL systems, Thread LPAR is used. When adding SMT to the powernv
> machine, it is therefore preferable to emulate Thread LPAR.
> 
> To account for this difference between pseries and powernv, an LPAR mode
> flag is added such that SPRs can be implemented as per-LPAR shared, and
> that becomes either per-thread or per-core depending on the flag.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>




Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   hw/ppc/spapr_cpu_core.c |  2 ++
>   target/ppc/cpu.h        |  3 +++
>   target/ppc/cpu_init.c   | 12 ++++++++++++
>   target/ppc/translate.c  | 16 +++++++++++++---
>   4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index a4e3c2fadd..b482d9754a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -270,6 +270,8 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
>       env->spr_cb[SPR_TIR].default_value = thread_index;
>   
> +    cpu_ppc_set_1lpar(cpu);
> +
>       /* Set time-base frequency to 512 MHz. vhyp must be set first. */
>       cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>   
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index af12c93ebc..951f73d89d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -674,6 +674,8 @@ enum {
>       POWERPC_FLAG_SCV      = 0x00200000,
>       /* Has >1 thread per core                                                */
>       POWERPC_FLAG_SMT      = 0x00400000,
> +    /* Using "LPAR per core" mode  (as opposed to per-thread)                */
> +    POWERPC_FLAG_SMT_1LPAR= 0x00800000,
>   };
>   
>   /*
> @@ -1437,6 +1439,7 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val);
>   void ppc_tlb_invalidate_all(CPUPPCState *env);
>   void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr);
>   void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
> +void cpu_ppc_set_1lpar(PowerPCCPU *cpu);
>   int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb, hwaddr *raddrp,
>                        target_ulong address, uint32_t pid);
>   int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 5f4969664e..905a59aea9 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6629,6 +6629,18 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>       env->msr_mask &= ~MSR_HVB;
>   }
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
> +        env->flags |= POWERPC_FLAG_SMT_1LPAR;
> +    }
> +}
>   #endif /* !defined(CONFIG_USER_ONLY) */
>   
>   #endif /* defined(TARGET_PPC64) */
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index db0ba49bdc..10598cde40 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -256,6 +256,16 @@ static inline bool gen_serialize_core(DisasContext *ctx)
>   }
>   #endif
>   
> +static inline bool gen_serialize_core_lpar(DisasContext *ctx)
> +{
> +    /* 1LPAR implies SMT */
> +    if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
> +        return gen_serialize(ctx);
> +    }
> +
> +    return true;
> +}
> +
>   /* SPR load/store helpers */
>   static inline void gen_load_spr(TCGv t, int reg)
>   {
> @@ -451,7 +461,7 @@ static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
>   
>   void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
>   {
> -    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> +    if (!(ctx->flags & POWERPC_FLAG_SMT_1LPAR)) {
>           spr_write_CTRL_ST(ctx, sprn, gprn);
>           goto out;
>       }
> @@ -815,7 +825,7 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
>   /* DPDES */
>   void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
>   {
> -    if (!gen_serialize_core(ctx)) {
> +    if (!gen_serialize_core_lpar(ctx)) {
>           return;
>       }
>   
> @@ -824,7 +834,7 @@ void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
>   
>   void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
>   {
> -    if (!gen_serialize_core(ctx)) {
> +    if (!gen_serialize_core_lpar(ctx)) {
>           return;
>       }
>   


