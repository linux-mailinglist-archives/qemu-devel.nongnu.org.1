Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE7741FF4
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 07:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEkJn-0001of-N1; Thu, 29 Jun 2023 01:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEkJa-0001oH-Kz; Thu, 29 Jun 2023 01:35:37 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEkJW-0005Mi-JP; Thu, 29 Jun 2023 01:35:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qs6c01JL2z4whk;
 Thu, 29 Jun 2023 15:35:28 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qs6bx60V3z4wZp;
 Thu, 29 Jun 2023 15:35:25 +1000 (AEST)
Message-ID: <621dcb0b-eef9-3535-3b7b-58807f212575@kaod.org>
Date: Thu, 29 Jun 2023 07:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 3/3] ppc/pnv: SMT support for powernv
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230629021633.328916-1-npiggin@gmail.com>
 <20230629021633.328916-4-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230629021633.328916-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001,
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

On 6/29/23 04:16, Nicholas Piggin wrote:
> Set the TIR default value with the SMT thread index, and place some
> standard limits on SMT configurations. Now powernv is able to boot
> skiboot and Linux with a SMT topology, including booting a KVM guest.
> 
> There are several other per-core SPRs, but they are not so important to
> run OPAL/Linux. Some important per-LPAR ones to convert before powernv
> could run in 1LPAR mode. Broadcast msgsnd is not yet implemented either,
> but skiboot/Linux does not use that. KVM uses an implementation-specific
> detail of POWER9/10 TLBs where TLBIEL invalidates translations of all
> threads on a core, but that is not required here because KVM does not
> cache translations across PID or LPID switch. Most of these I have or
> aren't too hard to implement, but I start with a small bare bones for
> comments.
> 
> Not-yet-Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I am glad this becoming possible. You can model the missing parts
later on.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   hw/ppc/pnv.c      | 12 ++++++++++++
>   hw/ppc/pnv_core.c | 13 +++++--------
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index fc083173f3..f599ccad1d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -887,6 +887,18 @@ static void pnv_init(MachineState *machine)
>   
>       pnv->num_chips =
>           machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
> +
> +    if (machine->smp.threads > 8) {
> +        error_report("Cannot support more than 8 threads/core "
> +                     "on a powernv machine");
> +        exit(1);
> +    }
> +    if (!is_power_of_2(machine->smp.threads)) {
> +        error_report("Cannot support %d threads/core on a powernv"
> +                     "machine because it must be a power of 2",
> +                     machine->smp.threads);
> +        exit(1);
> +    }
>       /*
>        * TODO: should we decide on how many chips we can create based
>        * on #cores and Venice vs. Murano vs. Naples chip type etc...,
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 0bc3ad41c8..acd83caee8 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -167,12 +167,13 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> -static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
> +static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
> +                                 int thread_index)
>   {
>       CPUPPCState *env = &cpu->env;
>       int core_pir;
> -    int thread_index = 0; /* TODO: TCG supports only one thread */
>       ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
> +    ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
>       Error *local_err = NULL;
>       PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
>   
> @@ -188,11 +189,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
>   
>       core_pir = object_property_get_uint(OBJECT(pc), "pir", &error_abort);
>   
> -    /*
> -     * The PIR of a thread is the core PIR + the thread index. We will
> -     * need to find a way to get the thread index when TCG supports
> -     * more than 1. We could use the object name ?
> -     */
> +    tir->default_value = thread_index;
>       pir->default_value = core_pir + thread_index;
>   
>       /* Set time-base frequency to 512 MHz */
> @@ -241,7 +238,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>       }
>   
>       for (j = 0; j < cc->nr_threads; j++) {
> -        pnv_core_cpu_realize(pc, pc->threads[j], &local_err);
> +        pnv_core_cpu_realize(pc, pc->threads[j], &local_err, j);
>           if (local_err) {
>               goto err;
>           }


