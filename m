Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A92717820
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GD6-0006ne-1f; Wed, 31 May 2023 03:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4GD1-0006nL-8E; Wed, 31 May 2023 03:25:27 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4GCy-00059v-SH; Wed, 31 May 2023 03:25:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWLQ76b1Wz4x46;
 Wed, 31 May 2023 17:25:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWLQ54jf3z4x2k;
 Wed, 31 May 2023 17:25:17 +1000 (AEST)
Message-ID: <fa528286-13f7-ef7c-0472-8e02d0340c10@kaod.org>
Date: Wed, 31 May 2023 09:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 2/5] target/ppc: Add initial flags and helpers for SMT
 support
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531012313.19891-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vahk=BU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
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
> SMT TCG emulation needs to be able to iterate over siblings in a core,
> and needs to serialise core access to shared SPRs and state.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu.h       |  9 +++++++++
>   target/ppc/cpu_init.c  |  5 +++++
>   target/ppc/translate.c | 20 ++++++++++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 1f23b81e90..b594408a8d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -672,6 +672,8 @@ enum {
>       POWERPC_FLAG_TM       = 0x00100000,
>       /* Has SCV (ISA 3.00)                                                    */
>       POWERPC_FLAG_SCV      = 0x00200000,
> +    /* Has >1 thread per core                                                */
> +    POWERPC_FLAG_SMT      = 0x00400000,
>   };
>   
>   /*
> @@ -1266,6 +1268,13 @@ struct CPUArchState {
>       uint64_t pmu_base_time;
>   };
>   
> +#define _CORE_ID(cs)                                            \
> +    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
> +
> +#define THREAD_SIBLING_FOREACH(cs, cs_sibling)			\
> +    CPU_FOREACH(cs_sibling)                                     \
> +        if (_CORE_ID(cs) == _CORE_ID(cs_sibling))
> +


May be introduce these helpers when needed (and if needed).

>   #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
>   do {                                            \
>       env->fit_period[0] = (a_);                  \
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index aa364f36f6..5035f6dada 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6754,6 +6754,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
>       PowerPCCPU *cpu = POWERPC_CPU(dev);
> +    CPUPPCState *env = &cpu->env;
>       PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>       Error *local_err = NULL;
>   
> @@ -6785,6 +6786,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>   
>       pcc->parent_realize(dev, errp);
>   
> +    if (env_cpu(env)->nr_threads > 1) {
> +        env->flags |= POWERPC_FLAG_SMT;
> +    }
> +
>       return;
>   
>   unrealize:
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b6bab4c234..72270c2163 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -227,6 +227,26 @@ struct opc_handler_t {
>       void (*handler)(DisasContext *ctx);
>   };
>   
> +static inline bool gen_serialize(DisasContext *ctx)
> +{
> +    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +        /* Restart with exclusive lock.  */
> +        gen_helper_exit_atomic(cpu_env);
> +        ctx->base.is_jmp = DISAS_NORETURN;
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static inline bool gen_serialize_core(DisasContext *ctx)
> +{
> +    if (ctx->flags & POWERPC_FLAG_SMT) {
> +        return gen_serialize(ctx);
> +    }
> +
> +    return true;
> +}
> +
>   /* SPR load/store helpers */
>   static inline void gen_load_spr(TCGv t, int reg)
>   {


