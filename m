Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4B75017F
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJVCR-0002rJ-9O; Wed, 12 Jul 2023 04:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/n7z=C6=kaod.org=clg@ozlabs.org>)
 id 1qJVCO-0002nP-GD; Wed, 12 Jul 2023 04:27:48 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=/n7z=C6=kaod.org=clg@ozlabs.org>)
 id 1qJVCL-0005lh-QS; Wed, 12 Jul 2023 04:27:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R19pf1kZ2z4wy7;
 Wed, 12 Jul 2023 18:27:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R19pb60tyz4wxR;
 Wed, 12 Jul 2023 18:27:35 +1000 (AEST)
Message-ID: <f89abc5c-6356-1124-b6be-7cdb0c3e280c@kaod.org>
Date: Wed, 12 Jul 2023 10:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Generate storage interrupts for radix RC
 changes
Content-Language: en-US
To: Shawn Anastasio <sanastasio@raptorengineering.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Timothy Pearson <tpearson@raptorengineering.com>
References: <20230711222405.2712188-1-sanastasio@raptorengineering.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230711222405.2712188-1-sanastasio@raptorengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=/n7z=C6=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

Hello Shawn,

On 7/12/23 00:24, Shawn Anastasio wrote:
> Change radix64_set_rc to always generate a storage interrupt when the
> R/C bits are not set appropriately instead of setting the bits itself.
> According to the ISA both behaviors are valid, but in practice this
> change more closely matches behavior observed on the POWER9 CPU.
> 
>  From the POWER9 Processor User's Manual, Section 4.10.13.1: "When
> performing Radix translation, the POWER9 hardware triggers the
> appropriate interrupt ... for the mode and type of access whenever
> Reference (R) and Change (C) bits require setting in either the guest or
> host page-table entry (PTE)."
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
>   target/ppc/mmu-radix64.c | 57 ++++++++++++++++++++++++++++------------
>   1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 920084bd8f..06e1cced31 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -219,27 +219,48 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu, MMUAccessType access_type,
>       return false;
>   }
>   
> -static void ppc_radix64_set_rc(PowerPCCPU *cpu, MMUAccessType access_type,
> -                               uint64_t pte, hwaddr pte_addr, int *prot)
> +static int ppc_radix64_check_rc(PowerPCCPU *cpu, MMUAccessType access_type,
> +                               uint64_t pte, vaddr eaddr, bool partition_scoped,
> +                               hwaddr g_raddr)
>   {
> -    CPUState *cs = CPU(cpu);
> -    uint64_t npte;
> +    uint64_t lpid = 0;
> +    uint64_t pid = 0;
>   
> -    npte = pte | R_PTE_R; /* Always set reference bit */
> +    switch (access_type) {
> +    case MMU_DATA_STORE:
> +        if (!(pte & R_PTE_C)) {
> +            break;
> +        }
> +        /* fall through */
> +    case MMU_INST_FETCH:
> +    case MMU_DATA_LOAD:
> +        if (!(pte & R_PTE_R)) {
> +            break;
> +        }
>   
> -    if (access_type == MMU_DATA_STORE) { /* Store/Write */
> -        npte |= R_PTE_C; /* Set change bit */
> -    } else {
> -        /*
> -         * Treat the page as read-only for now, so that a later write
> -         * will pass through this function again to set the C bit.
> -         */
> -        *prot &= ~PAGE_WRITE;
> +        /* R/C bits are already set appropriately for this access */
> +        return 0;
>       }
>   
> -    if (pte ^ npte) { /* If pte has changed then write it back */
> -        stq_phys(cs->as, pte_addr, npte);
> +    /* Obtain effLPID */
> +    (void)ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr, &lpid, &pid);
> +
> +    /*
> +     * Per ISA 3.1 Book III, 7.5.3 and 7.5.5, failure to set R/C during
> +     * partition-scoped translation when effLPID = 0 results in normal
> +     * (non-Hypervisor) Data and Instruction Storage Interrupts respectively.
> +     *
> +     * ISA 3.0 is ambiguous about this, but tests on POWER9 hardware seem to
> +     * exhibit the same behavior.
> +     */
> +    if (partition_scoped && lpid > 0) {
> +        ppc_radix64_raise_hsi(cpu, access_type, eaddr, g_raddr,
> +                              DSISR_ATOMIC_RC);
> +    } else {
> +        ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_ATOMIC_RC);
>       }

I would raise the exception in the callers :

   ppc_radix64_partition_scoped_xlate()
   ppc_radix64_process_scoped_xlate()

lpid could be passed to these routines also, this to avoid the call to
ppc_radix64_get_fully_qualified_addr().

This requires a little more changes but would be cleaner I think.

Thanks,

C.

> +    return 1;
>   }
>   
>   static bool ppc_radix64_is_valid_level(int level, int psize, uint64_t nls)
> @@ -418,7 +439,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
>       }
>   
>       if (guest_visible) {
> -        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, h_prot);
> +        return ppc_radix64_check_rc(cpu, access_type, pte, eaddr, true,
> +                                    g_raddr);
>       }
>   
>       return 0;
> @@ -580,7 +602,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
>       }
>   
>       if (guest_visible) {
> -        ppc_radix64_set_rc(cpu, access_type, pte, pte_addr, g_prot);
> +        return ppc_radix64_check_rc(cpu, access_type, pte, eaddr, false,
> +                                    *g_raddr);
>       }
>   
>       return 0;


