Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B808387EA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 08:23:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSB72-0004KK-MJ; Tue, 23 Jan 2024 02:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSB6y-0004Iw-Tu; Tue, 23 Jan 2024 02:22:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSB6w-00071L-Lb; Tue, 23 Jan 2024 02:22:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TJz7D2rWcz4wcM;
 Tue, 23 Jan 2024 18:22:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJz7B6CFrz4wcK;
 Tue, 23 Jan 2024 18:22:14 +1100 (AEDT)
Message-ID: <3cfdde83-3409-4616-9342-733df3c048c9@kaod.org>
Date: Tue, 23 Jan 2024 08:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] target/ppc: Add SMT support to time facilities
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231201121636.142694-1-npiggin@gmail.com>
 <20231201121636.142694-9-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231201121636.142694-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9HdW=JB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 12/1/23 13:16, Nicholas Piggin wrote:
> The TB, VTB, PURR, HDEC SPRs are per-LPAR registers, and the TFMR is a
> per-core register. Add the necessary SMT synchronisation and value
> sharing.
> 
> The TFMR can only drive the timebase state machine via thread 0 of the
> core, which is almost certainly not right, but it is enough for skiboot
> and certain other proprietary firmware.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/timebase_helper.c | 105 ++++++++++++++++++++++++++++++++---
>   target/ppc/translate.c       |  42 +++++++++++++-
>   2 files changed, 136 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index bc1d54a427..a23fbf75ff 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -60,19 +60,55 @@ target_ulong helper_load_purr(CPUPPCState *env)
>   
>   void helper_store_purr(CPUPPCState *env, target_ulong val)
>   {
> -    cpu_ppc_store_purr(env, val);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        cpu_ppc_store_purr(env, val);
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cpu_ppc_store_purr(cenv, val);
> +    }
>   }
>   #endif
>   
>   #if !defined(CONFIG_USER_ONLY)
>   void helper_store_tbl(CPUPPCState *env, target_ulong val)
>   {
> -    cpu_ppc_store_tbl(env, val);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        cpu_ppc_store_tbl(env, val);
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cpu_ppc_store_tbl(cenv, val);
> +    }
>   }
>   
>   void helper_store_tbu(CPUPPCState *env, target_ulong val)
>   {
> -    cpu_ppc_store_tbu(env, val);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        cpu_ppc_store_tbu(env, val);
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cpu_ppc_store_tbu(cenv, val);
> +    }
>   }
>   
>   void helper_store_atbl(CPUPPCState *env, target_ulong val)
> @@ -102,17 +138,53 @@ target_ulong helper_load_hdecr(CPUPPCState *env)
>   
>   void helper_store_hdecr(CPUPPCState *env, target_ulong val)
>   {
> -    cpu_ppc_store_hdecr(env, val);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        cpu_ppc_store_hdecr(env, val);
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cpu_ppc_store_hdecr(cenv, val);
> +    }
>   }
>   
>   void helper_store_vtb(CPUPPCState *env, target_ulong val)
>   {
> -    cpu_ppc_store_vtb(env, val);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        cpu_ppc_store_vtb(env, val);
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cpu_ppc_store_vtb(cenv, val);
> +    }
>   }
>   
>   void helper_store_tbu40(CPUPPCState *env, target_ulong val)
>   {
> -    cpu_ppc_store_tbu40(env, val);
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +
> +    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> +        cpu_ppc_store_tbu40(env, val);
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cpu_ppc_store_tbu40(cenv, val);
> +    }
>   }
>   
>   target_ulong helper_load_40x_pit(CPUPPCState *env)
> @@ -211,6 +283,21 @@ static uint64_t tfmr_new_tb_state(uint64_t tfmr, unsigned int tbst)
>       return tfmr;
>   }
>   
> +static void write_tfmr(CPUPPCState *env, target_ulong val)
> +{
> +    CPUState *cs = env_cpu(env);
> +
> +    if (cs->nr_threads == 1) {
> +        env->spr[SPR_TFMR] = val;
> +    } else {
> +        CPUState *ccs;
> +        THREAD_SIBLING_FOREACH(cs, ccs) {
> +            CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +            cenv->spr[SPR_TFMR] = val;
> +        }
> +    }
> +}
> +
>   static void tb_state_machine_step(CPUPPCState *env)
>   {
>       uint64_t tfmr = env->spr[SPR_TFMR];
> @@ -224,7 +311,7 @@ static void tb_state_machine_step(CPUPPCState *env)
>           env->pnv_tod_tbst.tb_sync_pulse_timer--;
>       } else {
>           tfmr |= TFMR_TB_SYNC_OCCURED;
> -        env->spr[SPR_TFMR] = tfmr;
> +        write_tfmr(env, tfmr);
>       }
>   
>       if (env->pnv_tod_tbst.tb_state_timer) {
> @@ -262,7 +349,7 @@ static void tb_state_machine_step(CPUPPCState *env)
>           }
>       }
>   
> -    env->spr[SPR_TFMR] = tfmr;
> +    write_tfmr(env, tfmr);
>   }
>   
>   target_ulong helper_load_tfmr(CPUPPCState *env)
> @@ -357,7 +444,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>       }
>   
>   out:
> -    env->spr[SPR_TFMR] = tfmr;
> +    write_tfmr(env, tfmr);
>   }
>   #endif
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 329da4d518..bd103b1026 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -247,13 +247,24 @@ static inline bool gen_serialize(DisasContext *ctx)
>       return true;
>   }
>   
> -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> +#if !defined(CONFIG_USER_ONLY)
> +#if defined(TARGET_PPC64)
> +static inline bool gen_serialize_core(DisasContext *ctx)
> +{
> +    if (ctx->flags & POWERPC_FLAG_SMT) {
> +        return gen_serialize(ctx);
> +    }
> +    return true;
> +}
> +#endif
> +
>   static inline bool gen_serialize_core_lpar(DisasContext *ctx)
>   {
> +#if defined(TARGET_PPC64)
>       if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
>           return gen_serialize(ctx);
>       }
> -
> +#endif
>       return true;
>   }
>   #endif
> @@ -667,12 +678,20 @@ void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
>   #if !defined(CONFIG_USER_ONLY)
>   void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core_lpar(ctx)) {
> +        return;
> +    }
> +
>       translator_io_start(&ctx->base);
>       gen_helper_store_tbl(tcg_env, cpu_gpr[gprn]);
>   }
>   
>   void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core_lpar(ctx)) {
> +        return;
> +    }
> +
>       translator_io_start(&ctx->base);
>       gen_helper_store_tbu(tcg_env, cpu_gpr[gprn]);
>   }
> @@ -696,6 +715,9 @@ void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
>   
>   void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core_lpar(ctx)) {
> +        return;
> +    }
>       translator_io_start(&ctx->base);
>       gen_helper_store_purr(tcg_env, cpu_gpr[gprn]);
>   }
> @@ -709,6 +731,9 @@ void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
>   
>   void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core_lpar(ctx)) {
> +        return;
> +    }
>       translator_io_start(&ctx->base);
>       gen_helper_store_hdecr(tcg_env, cpu_gpr[gprn]);
>   }
> @@ -721,12 +746,18 @@ void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
>   
>   void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core_lpar(ctx)) {
> +        return;
> +    }
>       translator_io_start(&ctx->base);
>       gen_helper_store_vtb(tcg_env, cpu_gpr[gprn]);
>   }
>   
>   void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core_lpar(ctx)) {
> +        return;
> +    }
>       translator_io_start(&ctx->base);
>       gen_helper_store_tbu40(tcg_env, cpu_gpr[gprn]);
>   }
> @@ -1220,11 +1251,18 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>   
>   void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
>   {
> +    /* Reading TFMR can cause it to be updated, so serialize threads here too */
> +    if (!gen_serialize_core(ctx)) {
> +        return;
> +    }
>       gen_helper_load_tfmr(cpu_gpr[gprn], tcg_env);
>   }
>   
>   void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
>   {
> +    if (!gen_serialize_core(ctx)) {
> +        return;
> +    }
>       gen_helper_store_tfmr(tcg_env, cpu_gpr[gprn]);
>   }
>   


