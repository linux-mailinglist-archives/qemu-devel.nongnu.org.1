Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FF745B68
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHxK-0006CF-FD; Mon, 03 Jul 2023 07:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGHxH-0006BG-Jt; Mon, 03 Jul 2023 07:42:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGHxF-0005Ya-Kg; Mon, 03 Jul 2023 07:42:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvkZ20rP6z4wxp;
 Mon,  3 Jul 2023 21:42:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvkYz4f7pz4wxn;
 Mon,  3 Jul 2023 21:42:47 +1000 (AEST)
Message-ID: <b71aca81-1a28-f06f-be8b-bc2a4a798b3c@kaod.org>
Date: Mon, 3 Jul 2023 13:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] target/ppc: SMT support for the HID SPR
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230703101700.24064-1-npiggin@gmail.com>
 <20230703101700.24064-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230703101700.24064-3-npiggin@gmail.com>
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
> HID is a per-core shared register, skiboot sets this (e.g., setting
> HILE) on one thread and that must affect all threads of the core.
> 
> Tested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu_init.c    |  2 +-
>   target/ppc/helper.h      |  1 +
>   target/ppc/misc_helper.c | 21 +++++++++++++++++++++
>   target/ppc/spr_common.h  |  1 +
>   target/ppc/translate.c   | 16 ++++++++++++++++
>   5 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 905a59aea9..720aad9e05 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5638,7 +5638,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
>       spr_register_hv(env, SPR_HID0, "HID0",
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> +                 &spr_read_generic, &spr_core_write_generic,
>                    0x00000000);
>       spr_register_hv(env, SPR_TSCR, "TSCR",
>                    SPR_NOACCESS, SPR_NOACCESS,
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 828f7844c8..abec6fe341 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -704,6 +704,7 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
>   
>   DEF_HELPER_2(load_dump_spr, void, env, i32)
>   DEF_HELPER_2(store_dump_spr, void, env, i32)
> +DEF_HELPER_3(spr_core_write_generic, void, env, i32, tl)
>   DEF_HELPER_3(spr_write_CTRL, void, env, i32, tl)
>   
>   DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 1f1af21f33..0da335472e 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -43,6 +43,27 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
>                env->spr[sprn]);
>   }
>   
> +void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
> +                                   target_ulong val)
> +{
> +    CPUState *cs = env_cpu(env);
> +    CPUState *ccs;
> +    uint32_t nr_threads = cs->nr_threads;
> +    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
> +
> +    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
> +
> +    if (nr_threads == 1) {
> +        env->spr[sprn] = val;
> +        return;
> +    }
> +
> +    THREAD_SIBLING_FOREACH(cs, ccs) {
> +        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
> +        cenv->spr[sprn] = val;
> +    }
> +}
> +
>   void helper_spr_write_CTRL(CPUPPCState *env, uint32_t sprn,
>                              target_ulong val)
>   {
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index fbf52123b5..5995070eaf 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -82,6 +82,7 @@ void spr_noaccess(DisasContext *ctx, int gprn, int sprn);
>   void spr_read_generic(DisasContext *ctx, int gprn, int sprn);
>   void spr_write_generic(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
> +void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
>   void spr_write_PMC(DisasContext *ctx, int sprn, int gprn);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 10598cde40..07c491df62 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -448,6 +448,22 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
>   #endif
>   }
>   
> +void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn)
> +{
> +    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> +        spr_write_generic(ctx, sprn, gprn);
> +        return;
> +    }
> +
> +    if (!gen_serialize(ctx)) {
> +        return;
> +    }
> +
> +    gen_helper_spr_core_write_generic(cpu_env, tcg_constant_i32(sprn),
> +                                      cpu_gpr[gprn]);
> +    spr_store_dump_spr(sprn);
> +}
> +
>   static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
>   {
>       /* This does not implement >1 thread */


