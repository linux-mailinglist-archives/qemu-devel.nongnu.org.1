Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8908A719410
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4cc5-0005o6-Na; Thu, 01 Jun 2023 03:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4cc3-0005m5-AP; Thu, 01 Jun 2023 03:20:47 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4cc1-00055K-0U; Thu, 01 Jun 2023 03:20:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWyGJ2Hb6z4x4K;
 Thu,  1 Jun 2023 17:20:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWyGG4h2vz4x41;
 Thu,  1 Jun 2023 17:20:38 +1000 (AEST)
Message-ID: <ce866fc5-0287-a7ea-a1c3-79d23f5b6447@kaod.org>
Date: Thu, 1 Jun 2023 09:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 5/5] spapr: Allow up to 8 threads SMT configuration
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531012313.19891-6-npiggin@gmail.com>
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
> TCG now supports multi-threaded configuration at least enough for
> pseries to be functional enough to boot Linux.
> 
> This requires PIR and TIR be set, because that's how sibling thread
> matching is done.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c          | 4 ++--
>   hw/ppc/spapr_cpu_core.c | 7 +++++--
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index dcb7f1c70a..11074cefea 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2524,8 +2524,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>       int ret;
>       unsigned int smp_threads = ms->smp.threads;
>   
> -    if (!kvm_enabled() && (smp_threads > 1)) {
> -        error_setg(errp, "TCG cannot support more than 1 thread/core "
> +    if (!kvm_enabled() && (smp_threads > 8)) {
> +        error_setg(errp, "TCG cannot support more than 8 threads/core "
>                      "on a pseries machine");

I think we should add test on the CPU also.

>           return;
>       }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 9b88dd549a..f35ee600f1 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -255,7 +255,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
>   }
>   
>   static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
> -                               SpaprCpuCore *sc, Error **errp)
> +                               SpaprCpuCore *sc, int thread_nr, Error **errp)

thread_index may be ?

>   {
>       CPUPPCState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> @@ -267,6 +267,9 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>       kvmppc_set_papr(cpu);

so, spapr_create_vcpu() set cs->cpu_index :
     cs->cpu_index = cc->core_id + i;

and spapr_realize_vcpu :
    
> +    env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
> +    env->spr_cb[SPR_TIR].default_value = thread_nr;
> +
it would be cleaner to do the SPR assignment in one place.


>       /* Set time-base frequency to 512 MHz. vhyp must be set first. */
>       cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>   
> @@ -337,7 +340,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < cc->nr_threads; i++) {
>           sc->threads[i] = spapr_create_vcpu(sc, i, errp);
>           if (!sc->threads[i] ||
> -            !spapr_realize_vcpu(sc->threads[i], spapr, sc, errp)) {
> +            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
>               spapr_cpu_core_unrealize(dev);
>               return;
>           }


