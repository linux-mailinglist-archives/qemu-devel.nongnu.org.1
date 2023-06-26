Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C173D926
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhG1-0007Qy-8T; Mon, 26 Jun 2023 04:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDhFj-0007LJ-M9; Mon, 26 Jun 2023 04:07:16 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDhFg-0007sR-Hu; Mon, 26 Jun 2023 04:07:15 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id C98F340D403D;
 Mon, 26 Jun 2023 08:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C98F340D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1687766829;
 bh=Jt5rQjWSmDiE+hjPUskZOhkfKkM/1ZblUzush2xxRu4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p6f7PcHk5mllp+MRZ14Swi3vp8xc1WZU6YaMHbwx2oBJpVFPLE6kmVIuqXvVyS3pU
 YDOSH2Ni7XhNgtacT84W7j4S6MhjdM6es8q861s1W5AT2Tol3gz84waw9rfTScKTbg
 5BDYaPWAJm6dHV7gSNFOn53LgWI1AoJs27GEeV8I=
Message-ID: <b1b7ab0d-caf2-46ca-eed2-7cdc87c0b600@ispras.ru>
Date: Mon, 26 Jun 2023 11:07:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming too
 many events
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-5-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230623125707.323517-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

e500 has the same problem, I think, according to this issue: 
https://gitlab.com/qemu-project/qemu/-/issues/1634

Btw, ARM virt platform rebuilds fdt only at initialization phase, not 
when reset.
Isn't this behavior correct? Shouldn't PPC platforms do the similar thing?

On 23.06.2023 15:57, Nicholas Piggin wrote:
> spapr_machine_reset gets a random number to populate the device-tree
> rng seed with. When loading a snapshot for record-replay, the machine
> is reset again, and that tries to consume the random event record
> again, crashing due to inconsistent record
> 
> Fix this by saving the seed to populate the device tree with, and
> skipping the rng on snapshot load.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c         | 12 +++++++++---
>   include/hw/ppc/spapr.h |  1 +
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d290acfa95..55948f233f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1017,7 +1017,6 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>   {
>       MachineState *machine = MACHINE(spapr);
>       SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
> -    uint8_t rng_seed[32];
>       int chosen;
>   
>       _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
> @@ -1095,8 +1094,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>           spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>       }
>   
> -    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> -    _FDT(fdt_setprop(fdt, chosen, "rng-seed", rng_seed, sizeof(rng_seed)));
> +    _FDT(fdt_setprop(fdt, chosen, "rng-seed", spapr->fdt_rng_seed, 32));
>   
>       _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-vec-5"));
>   }
> @@ -1649,6 +1647,14 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
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


