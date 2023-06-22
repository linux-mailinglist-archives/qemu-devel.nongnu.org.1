Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AA73A753
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOBS-0006Em-33; Thu, 22 Jun 2023 13:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCOBP-0006Dl-Ri; Thu, 22 Jun 2023 13:33:23 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCOBN-0005wL-Rf; Thu, 22 Jun 2023 13:33:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qn6sR0ZT3z4x07;
 Fri, 23 Jun 2023 03:33:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qn6sN36brz4wgj;
 Fri, 23 Jun 2023 03:33:12 +1000 (AEST)
Message-ID: <104b0621-41f2-5145-9822-e9f2f4adcd76@kaod.org>
Date: Thu, 22 Jun 2023 19:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/7] target/ppc: Add initial flags and helpers for SMT
 support
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230622093357.255649-1-npiggin@gmail.com>
 <20230622093357.255649-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230622093357.255649-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yb1G=CK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/22/23 11:33, Nicholas Piggin wrote:
> TGC SMT emulation needs to know whether it is running with SMT siblings,
> to be able to iterate over siblings in a core, and to serialise
> threads to access per-core shared SPRs. Add infrastructure to do these
> things.
> 
> For now the sibling iteration and serialisation are implemented in a
> simple but inefficient way. SMT shared state and sibling access is not
> too common, and SMT configurations are mainly useful to test system
> code, so performance is not to critical.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu.h       |  9 +++++++++
>   target/ppc/cpu_init.c  |  5 +++++
>   target/ppc/translate.c | 20 ++++++++++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bfa1777289..0087ce66e2 100644
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
> @@ -1270,6 +1272,13 @@ struct CPUArchState {
>       uint64_t pmu_base_time;
>   };
>   
> +#define _CORE_ID(cs)                                            \
> +    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
> +
> +#define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
> +    CPU_FOREACH(cs_sibling)                                     \
> +        if (_CORE_ID(cs) == _CORE_ID(cs_sibling))
> +
>   #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
>   do {                                            \
>       env->fit_period[0] = (a_);                  \
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index dccc064053..aeff71d063 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6755,6 +6755,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
>       PowerPCCPU *cpu = POWERPC_CPU(dev);
> +    CPUPPCState *env = &cpu->env;
>       PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>       Error *local_err = NULL;
>   
> @@ -6786,6 +6787,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
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
> index b62b624682..5d585393c5 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -236,6 +236,26 @@ struct opc_handler_t {
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


