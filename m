Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDF7F5A86
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 09:52:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r65Qq-0006kA-5X; Thu, 23 Nov 2023 03:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r65Qn-0006eU-TG; Thu, 23 Nov 2023 03:51:29 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r65Qm-0000Wi-3l; Thu, 23 Nov 2023 03:51:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SbX0C0qG6z4x5n;
 Thu, 23 Nov 2023 19:51:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbX090xhHz4wdF;
 Thu, 23 Nov 2023 19:51:20 +1100 (AEDT)
Message-ID: <e320f1d3-7f8e-4d75-b10a-35d54d4ee26a@kaod.org>
Date: Thu, 23 Nov 2023 09:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_IRQ_NR_IPIS.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231123055733.1002890-1-harshpb@linux.ibm.com>
 <20231123055733.1002890-3-harshpb@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231123055733.1002890-3-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=WthQ=HE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/23/23 06:57, Harsh Prateek Bora wrote:
> Initialize the machine specific max_cpus limit as per the maximum range
> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
> assert in tcg_region_init or spapr_xive_claim_irq.
> 
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


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
>   hw/ppc/spapr.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index df09aa9d6a..222d926f46 100644
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
> +     * In TCG the limit is restricted by the range of CPU IPIs available.
>        */
> -    mc->max_cpus = INT32_MAX;
> +    mc->max_cpus = SPAPR_IRQ_NR_IPIS;
>   
>       mc->no_parallel = 1;
>       mc->default_boot_order = "";


