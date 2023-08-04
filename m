Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B576FC88
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqVo-0007PE-6s; Fri, 04 Aug 2023 04:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qRqVl-0007Of-JS; Fri, 04 Aug 2023 04:50:17 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qRqVj-0000of-I8; Fri, 04 Aug 2023 04:50:17 -0400
Received: from [192.168.8.108] (unknown [188.162.65.112])
 by mail.ispras.ru (Postfix) with ESMTPSA id C2C5B40AC4FE;
 Fri,  4 Aug 2023 08:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C2C5B40AC4FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1691139009;
 bh=xBcehmfetCcr0ZqPlI/OEOfSB1eQzV/c0mW79T1FTMA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EI3iKaIn8zNWTcfHow+wdMrA3uvF0+9FdJ17GglZAXGGxV5EI7UZIYMVg2RDylBW5
 bCLTwic+611CHWsfIr1yrlT9MwYdHFSnA64JsvTLA5SNuX1WpXqzP0Bj/13Dk+QAZ6
 thRAHI7litNqs7wAWVAAa2X+QBPRG8jiPDW3+HNc=
Message-ID: <3be75aa3-780d-2d4d-a68c-1f8d1d000ee8@ispras.ru>
Date: Fri, 4 Aug 2023 11:50:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming too
 many events
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-5-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230726183532.434380-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

BTW, there is a function qemu_register_reset_nosnapshotload that can be 
used in similar cases.
Can you just use it without changing the code of the reset handler?

On 26.07.2023 21:35, Nicholas Piggin wrote:
> spapr_machine_reset gets a random number to populate the device-tree
> rng seed with. When loading a snapshot for record-replay, the machine
> is reset again, and that tries to consume the random event record
> again, crashing due to inconsistent record
> 
> Fix this by saving the seed to populate the device tree with, and
> skipping the rng on snapshot load.
> 
> Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c         | 12 +++++++++---
>   include/hw/ppc/spapr.h |  1 +
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7d84244f03..ecfbdb0030 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1022,7 +1022,6 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>   {
>       MachineState *machine = MACHINE(spapr);
>       SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
> -    uint8_t rng_seed[32];
>       int chosen;
>   
>       _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
> @@ -1100,8 +1099,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>           spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>       }
>   
> -    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> -    _FDT(fdt_setprop(fdt, chosen, "rng-seed", rng_seed, sizeof(rng_seed)));
> +    _FDT(fdt_setprop(fdt, chosen, "rng-seed", spapr->fdt_rng_seed, 32));
>   
>       _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-vec-5"));
>   }
> @@ -1654,6 +1652,14 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
>       void *fdt;
>       int rc;
>   
> +    if (reason != SHUTDOWN_CAUSE_SNAPSHOT_LOAD) {
> +        /*
> +         * Record-replay snapshot load must not consume random, this was
> +         * already replayed from initial machine reset.
> +         */
> +        qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
> +    }
> +
>       pef_kvm_reset(machine->cgs, &error_fatal);
>       spapr_caps_apply(spapr);
>   
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f47e8419a5..f4bd204d86 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -204,6 +204,7 @@ struct SpaprMachineState {
>       uint32_t fdt_size;
>       uint32_t fdt_initial_size;
>       void *fdt_blob;
> +    uint8_t fdt_rng_seed[32];
>       long kernel_size;
>       bool kernel_le;
>       uint64_t kernel_addr;


