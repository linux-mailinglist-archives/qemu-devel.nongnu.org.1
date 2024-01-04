Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C114E824950
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 20:59:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLTrw-0006nD-Qv; Thu, 04 Jan 2024 14:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rLTru-0006n5-Ow
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:59:06 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rLTrs-0006hz-Hw
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:59:06 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id D1091A00CF; Thu,  4 Jan 2024 20:58:53 +0100 (CET)
Date: Thu, 4 Jan 2024 20:58:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 Bruno Haible <bruno@clisp.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
In-Reply-To: <20240104183628.101366-2-deller@kernel.org>
Message-ID: <alpine.LMD.2.03.2401042055420.28870@eik.bme.hu>
References: <20240104183628.101366-1-deller@kernel.org>
 <20240104183628.101366-2-deller@kernel.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 4 Jan 2024, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> The physical hardware allows DIMMs of 4 MB size and above, allowing up
> to 3840 MB of memory, but is restricted by setup code to 3 GB.
> Increase the limit to allow up to the maximum amount of memory.
>
> Btw. the memory area from 0xf000.0000 to 0xffff.ffff is reserved by
> the architecture for firmware and I/O memory and can not be used for
> standard memory.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Noticed-by: Nelson H. F. Beebe <beebe@math.utah.edu>
> Fixes: b7746b1194c8 ("hw/hppa/machine: Restrict the total memory size to 3GB")
> ---
> hw/hppa/machine.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index c8da7c18d5..6181f4b747 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -276,6 +276,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>     unsigned int smp_cpus = machine->smp.cpus;
>     TranslateFn *translate;
>     MemoryRegion *cpu_region;
> +    ram_addr_t ram_max;
>
>     /* Create CPUs.  */
>     for (unsigned int i = 0; i < smp_cpus; i++) {
> @@ -288,8 +289,10 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>      */
>     if (hppa_is_pa20(&cpu[0]->env)) {
>         translate = translate_pa20;
> +        ram_max = 0xf0000000;      /* 3.75 GB (limited by 32-bit firmware) */
>     } else {
>         translate = translate_pa10;
> +        ram_max = 0xf0000000;      /* 3.75 GB (32-bit CPU) */

If the value is the same what's the point of setting it here and not once 
above at definition? It is's only the different comment then you could 
have a comment saying "3.75 GB, limited by 32-bit firmware on 64 bit CPU" 
or similar there.

Regards,
BALATON Zoltan

>     }
>
>     for (unsigned int i = 0; i < smp_cpus; i++) {
> @@ -311,9 +314,9 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>                                 cpu_region);
>
>     /* Main memory region. */
> -    if (machine->ram_size > 3 * GiB) {
> -        error_report("RAM size is currently restricted to 3GB");
> -        exit(EXIT_FAILURE);
> +    if (machine->ram_size > ram_max) {
> +        info_report("Max RAM size limited to %ld MB", ram_max / MiB);
> +        machine->ram_size = ram_max;
>     }
>     memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
>
> -- 
> 2.43.0
>
>
>

