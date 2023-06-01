Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5167193F7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4cVJ-0002zM-6A; Thu, 01 Jun 2023 03:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4cVD-0002yh-76; Thu, 01 Jun 2023 03:13:44 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4cV8-0003Vi-4i; Thu, 01 Jun 2023 03:13:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWy5w4bB7z4x41;
 Thu,  1 Jun 2023 17:13:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWy5t215fz4x3g;
 Thu,  1 Jun 2023 17:13:21 +1000 (AEST)
Message-ID: <60f0d393-f0b5-cc06-feff-a8f00e5a32b3@kaod.org>
Date: Thu, 1 Jun 2023 09:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 4/5] target/ppc: Add msgsnd/p and DPDES SMT support
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-5-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531012313.19891-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
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

On 5/31/23 03:23, Nicholas Piggin wrote:
> Doorbells in SMT need to coordinate msgsnd/msgclr and DPDES access from
> multiple threads that affect the same state.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/ppc.c                                  |  6 ++
>   include/hw/ppc/ppc.h                          |  1 +
>   target/ppc/cpu.h                              |  7 +-
>   target/ppc/excp_helper.c                      | 86 +++++++++++++------
>   target/ppc/gdbstub.c                          |  2 +-
>   target/ppc/helper.h                           |  2 +-
>   target/ppc/misc_helper.c                      | 60 +++++++++++--
>   target/ppc/translate.c                        |  8 ++
>   .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
>   9 files changed, 140 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 80b4706db2..e30853413b 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1434,6 +1434,12 @@ int ppc_cpu_pir(PowerPCCPU *cpu)
>       return env->spr_cb[SPR_PIR].default_value;
>   }
>   
> +int ppc_cpu_tir(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env = &cpu->env;
> +    return env->spr_cb[SPR_PIR].default_value;

PIR or TIR ?

> +}
> +
>   PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
>   {
>       CPUState *cs;
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 02af03ada2..e095c002dc 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -6,6 +6,7 @@
>   void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
>   PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
>   int ppc_cpu_pir(PowerPCCPU *cpu);
> +int ppc_cpu_tir(PowerPCCPU *cpu);
>   
>   /* PowerPC hardware exceptions management helpers */
>   typedef void (*clk_setup_cb)(void *opaque, uint32_t freq);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b594408a8d..b04b309c71 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1056,7 +1056,12 @@ FIELD(FPSCR, FI, FPSCR_FI, 1)
>   
>   #define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
>   
> -#define DBELL_BRDCAST                  PPC_BIT(37)
> +/* XXX: make sure this does not break BookE */
> +#define DBELL_BRDCAST_MASK             PPC_BITMASK(37, 38)
> +#define DBELL_BRDCAST_SHIFT            25
> +#define DBELL_BRDCAST_SUBPROC          (0x1 << DBELL_BRDCAST_SHIFT)
> +#define DBELL_BRDCAST_CORE             (0x2 << DBELL_BRDCAST_SHIFT)
> +
>   #define DBELL_LPIDTAG_SHIFT            14
>   #define DBELL_LPIDTAG_MASK             (0xfff << DBELL_LPIDTAG_SHIFT)
>   #define DBELL_PIRTAG_MASK              0x3fff
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 4925996cf3..5fc2e17269 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3085,7 +3085,7 @@ void helper_msgsnd(target_ulong rb)
>           PowerPCCPU *cpu = POWERPC_CPU(cs);
>           CPUPPCState *cenv = &cpu->env;
>   
> -        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
> +        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
>               ppc_set_irq(cpu, irq, 1);
>           }
>       }
> @@ -3104,6 +3104,16 @@ static bool dbell_type_server(target_ulong rb)
>       return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
>   }
>   
> +static inline bool dbell_type_bcast_core(target_ulong rb)
> +{
> +    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
> +}
> +
> +static inline bool dbell_type_bcast_subproc(target_ulong rb)
> +{
> +    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
> +}
> +
>   void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
>   {
>       if (!dbell_type_server(rb)) {
> @@ -3113,32 +3123,40 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
>       ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
>   }
>   
> -static void book3s_msgsnd_common(int pir, int irq)
> +void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
>   {
> -    CPUState *cs;
> -
> -    qemu_mutex_lock_iothread();
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -        CPUPPCState *cenv = &cpu->env;
> +    int pir = rb & DBELL_PROCIDTAG_MASK;
> +    int brdcast = rb & DBELL_BRDCAST_MASK;
> +    CPUState *cs, *ccs;
> +    PowerPCCPU *cpu;
>   
> -        /* TODO: broadcast message to all threads of the same  processor */
> -        if (cenv->spr_cb[SPR_PIR].default_value == pir) {
> -            ppc_set_irq(cpu, irq, 1);
> -        }
> +    if (!dbell_type_server(rb)) {
> +        return;
>       }
> -    qemu_mutex_unlock_iothread();
> -}
>   
> -void helper_book3s_msgsnd(target_ulong rb)
> -{
> -    int pir = rb & DBELL_PROCIDTAG_MASK;
> +    cpu = ppc_get_vcpu_by_pir(pir);
> +    if (!cpu) {
> +        return;
> +    }
> +    cs = CPU(cpu);
>   
> -    if (!dbell_type_server(rb)) {
> +    if (cs->nr_threads == 1 || !brdcast) {
> +        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
>           return;
>       }
>   
> -    book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
> +    /* WHy does iothread need to be locked for walking CPU list? */
> +    /* Answer seems to be because ppc irq handling needs it, but it now takes
> +     * the lock itself if needed. Could remove this then.
> +     */
> +    qemu_mutex_lock_iothread();
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
> +        if (cpu != ccpu) {
> +            ppc_set_irq(ccpu, PPC_INTERRUPT_HDOORBELL, 1);
> +        }
> +    }
> +    qemu_mutex_unlock_iothread();
>   }
>   
>   #if defined(TARGET_PPC64)
> @@ -3154,22 +3172,42 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
>   }
>   
>   /*
> - * sends a message to other threads that are on the same
> + * sends a message to another thread  on the same
>    * multi-threaded processor
>    */
>   void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
>   {
> -    int pir = env->spr_cb[SPR_PIR].default_value;
> +    CPUState *cs = env_cpu(env);
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +    int ttir = rb & PPC_BITMASK(57, 63);
>   
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
>   
> -    if (!dbell_type_server(rb)) {
> +    if (!dbell_type_server(rb) || ttir >= nr_threads) {

may be log bad ttir values ? even if the insn is a no-op in that case,
telling the user would be good since it should be a guest os issue

> +        return;
> +    }
> +
> +    if (nr_threads == 1) {
> +        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
>           return;
>       }
>   
> -    /* TODO: TCG supports only one thread */
> +    /* WHy does iothread need to be locked for walking CPU list? */
> +    qemu_mutex_lock_iothread();
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
> +        uint32_t thread_id = ppc_cpu_tir(ccpu);
> +
> +        if (ttir == thread_id) {
> +            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
> +            qemu_mutex_unlock_iothread();
> +            return;
> +        }
> +    }
>   
> -    book3s_msgsnd_common(pir, PPC_INTERRUPT_DOORBELL);
> +    assert(0);
>   }
>   #endif /* TARGET_PPC64 */
>   
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index ca39efdc35..f0304e5bb6 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -117,7 +117,7 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
>    * regs and PC, MSR, CR, and so forth.  We hack round this by giving
>    * the FP regs zero size when talking to a newer gdb.
>    */
> -
> +/* XXX: read/write dpdes correctly */
>   int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>   {
>       PowerPCCPU *cpu = POWERPC_CPU(cs);
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index fda40b8a60..5ce49c7ebc 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -690,7 +690,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
>   
>   DEF_HELPER_1(msgsnd, void, tl)
>   DEF_HELPER_2(msgclr, void, env, tl)
> -DEF_HELPER_1(book3s_msgsnd, void, tl)
> +DEF_HELPER_2(book3s_msgsnd, void, env, tl)
>   DEF_HELPER_2(book3s_msgclr, void, env, tl)
>   #endif
>   
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index ffe54a4310..ca84f1b134 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -192,14 +192,38 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
>    */
>   target_ulong helper_load_dpdes(CPUPPCState *env)
>   {
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);

you could add an helper for the above.

>       target_ulong dpdes = 0;
>   
> +    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
> +
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_MSGP);
>   
> -    /* TODO: TCG supports only one thread */
> -    if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> -        dpdes = 1;
> +    if (nr_threads == 1) {
> +        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> +            dpdes = 1;
> +        }
> +        return dpdes;
> +    }
> +
> +    qemu_mutex_lock_iothread();
> +    CPU_FOREACH(ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        uint32_t ccore_id = cenv->spr[SPR_PIR] & ~(nr_threads - 1);
> +        uint32_t thread_id = cenv->spr[SPR_TIR];
> +
> +        assert(ccore_id == cenv->spr[SPR_PIR] - cenv->spr[SPR_TIR]);
> +
> +        if (ccore_id == core_id) {
> +            if (cenv->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> +                dpdes |= (0x1 << thread_id);
> +            }
> +        }
>       }
> +    qemu_mutex_unlock_iothread();
>   
>       return dpdes;
>   }
> @@ -207,17 +231,41 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
>   void helper_store_dpdes(CPUPPCState *env, target_ulong val)
>   {
>       PowerPCCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
> +
> +    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
>   
>       helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
>   
> -    /* TODO: TCG supports only one thread */
> -    if (val & ~0x1) {
> +    if (val & ~(nr_threads - 1)) {
>           qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
>                         TARGET_FMT_lx"\n", val);
> +        val &= ~(nr_threads - 1);
> +        /* Ignore the invalid bits */
> +    }
> +
> +    if (nr_threads == 1) {
> +        /* XXX: don't need iothread lock? */
> +        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
>           return;
>       }
>   
> -    ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
> +    qemu_mutex_lock_iothread();
> +    CPU_FOREACH(ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        uint32_t ccore_id = cenv->spr[SPR_PIR] & ~(nr_threads - 1);
> +        uint32_t thread_id = cenv->spr[SPR_TIR];
> +
> +        assert(ccore_id == cenv->spr[SPR_PIR] - cenv->spr[SPR_TIR]);
> +
> +        if (ccore_id == core_id) {
> +            ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
> +        }
> +    }
> +    qemu_mutex_unlock_iothread();
>   }
>   #endif /* defined(TARGET_PPC64) */
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 31821f92f5..0aa49323d3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -820,11 +820,19 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
>   /* DPDES */
>   void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
>   {
> +    if (!gen_serialize_core(ctx)) {
> +        return;
> +    }
> +
>       gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
>   }
>   
>   void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core(ctx)) {
> +        return;
> +    }
> +
>       gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
>   }
>   #endif
> diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
> index cc7a50d579..7dfbcd781f 100644
> --- a/target/ppc/translate/processor-ctrl-impl.c.inc
> +++ b/target/ppc/translate/processor-ctrl-impl.c.inc
> @@ -59,7 +59,7 @@ static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
>   
>   #if !defined(CONFIG_USER_ONLY)
>       if (is_book3s_arch2x(ctx)) {
> -        gen_helper_book3s_msgsnd(cpu_gpr[a->rb]);
> +        gen_helper_book3s_msgsnd(cpu_env, cpu_gpr[a->rb]);
>       } else {
>           gen_helper_msgsnd(cpu_gpr[a->rb]);
>       }


