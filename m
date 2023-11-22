Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8E7F404E
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 09:38:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ijD-0002wA-KJ; Wed, 22 Nov 2023 03:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5ijB-0002vY-Hh; Wed, 22 Nov 2023 03:36:57 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=osAF=HD=kaod.org=clg@ozlabs.org>)
 id 1r5ij9-0005tS-E4; Wed, 22 Nov 2023 03:36:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZvjr1Th2z4xVW;
 Wed, 22 Nov 2023 19:36:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZvjn19yFz4xSy;
 Wed, 22 Nov 2023 19:36:44 +1100 (AEDT)
Message-ID: <ebcaeaae-31b8-4531-8b6a-ebd2ac96872f@kaod.org>
Date: Wed, 22 Nov 2023 09:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: Initialize max_cpus limit to an allowed usable
 limit.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231122074802.868083-1-harshpb@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231122074802.868083-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=osAF=HD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/22/23 08:48, Harsh Prateek Bora wrote:
> Initialize the machine specific max_cpus limit to a usable limit 4096.
> Keeping between 4096 to 8192 will throw IRQ not free error due to XIVE
> limitation and keeping beyond 8192 will hit assert in tcg_region_init
> or spapr_xive_claim_irq.

The IRQ number space is defined in include/hw/ppc/spapr_irq.h. XICS and
XIVE have the same IRQ number space, it is not a XIVE limitation. It
is how we organized interrupt numbers in the pseries-3.1 machine.

SPAPR_XIRQ_BASE defines an offset, at which the device IRQ numbers
start, and below that offset, the range of IRQ numbers is reserved
for IPIs. An assumption is made on the fact the both ranges, IPIs and
devices, are contiguous and there is a little shortcut being done with
the SPAPR_XIRQ_BASE define.

hw/ppc/spapr_irq.c:        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
hw/ppc/spapr_irq.c:                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);

This should use a SPAPR_NR_IPIS define (like we have a SPAPR_NR_XIRQS
define) instead, which could be used to define mc->max_cpus like we
define smc->nr_xirqs.

Thanks,

C.

  
> Logs:
> 
> Without patch fix:
> 
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
> qemu-system-ppc64: IRQ 4096 is not free
> [root@host build]#
> 
> On LPAR:
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
> **
> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
> (region_size >= 2 * page_size)
> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
> (region_size >= 2 * page_size)
> Aborted (core dumped)
> [root@host build]#
> 
> On x86:
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
> Assertion `lisn < xive->nr_irqs' failed.
> Aborted (core dumped)
> [root@host build]#
> 
> With patch fix:
> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
> machine 'pseries-8.2' is 4096
> [root@host build]#
> 
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   hw/ppc/spapr.c         | 9 +++------
>   include/hw/ppc/spapr.h | 1 +
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index df09aa9d6a..1995949ea5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4647,13 +4647,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_SCSI;
>   
>       /*
> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
> -     * should be limited by the host capability instead of hardcoded.
> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
> -     * guests are welcome to have as many CPUs as the host are capable
> -     * of emulate.
> +     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
> +     * In TCG the limit is restricted by max-irqs setup by XIVE which is 4096.
>        */
> -    mc->max_cpus = INT32_MAX;
> +    mc->max_cpus = SPAPR_MAX_CPUS;
>   
>       mc->no_parallel = 1;
>       mc->default_boot_order = "";
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e91791a1a9..210849a494 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -23,6 +23,7 @@ typedef struct SpaprPendingHpt SpaprPendingHpt;
>   
>   typedef struct Vof Vof;
>   
> +#define SPAPR_MAX_CPUS          4096
>   #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>   #define SPAPR_ENTRY_POINT       0x100
> 


