Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE674355B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7yY-0001yN-82; Fri, 30 Jun 2023 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qF7yV-0001x0-QF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:51:23 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qF7yT-0006aC-B4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:51:23 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.132])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7DDB720ADF;
 Fri, 30 Jun 2023 06:51:16 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 08:51:15 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0025973c955-8efb-4026-8942-e88d19ace37f,
 25BF4A4B9C2F464C2D2BE6A3C510F9005C21DAA1) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Fri, 30 Jun 2023 08:51:12 +0200
From: Greg Kurz <groug@kaod.org>
To: Gautam Menghani <gautam@linux.ibm.com>
CC: <danielhb413@gmail.com>, <harshpb@linux.ibm.com>, <clg@kaod.org>,
 <david@gibson.dropbear.id.au>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>, <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] ppc: spapr: Fix device tree entries in absence of XIVE
 native mode
Message-ID: <20230630085112.16d77032@bahia>
In-Reply-To: <20230630053056.14933-1-gautam@linux.ibm.com>
References: <20230630053056.14933-1-gautam@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: b6cf8421-da00-49ea-b21f-98c1a4412d22
X-Ovh-Tracer-Id: 8891231566893455724
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepvdejhedvfffggeffieegteekgeetfeefgfehteektddtgfejgfeuueektdffkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhophgvnhhpohifvghrrdhfohhunhgurghtihhonhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtkedpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgrghuthgrmheslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdphhgrrhhshhhpsgeslhhinhhugidrihgsmhdrtghomhdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqd
 guvghvvghlsehnohhnghhnuhdrohhrghdpfhgsrghrrhgrtheslhhinhhugidrihgsmhdrtghomhdptghlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.54.81; envelope-from=groug@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 30 Jun 2023 11:00:56 +0530
Gautam Menghani <gautam@linux.ibm.com> wrote:

> Currently, XIVE native exploitation mode is not supported in nested
> guests. When we boot up a nested guest on PowerNV platform, we observe 
> the following entries in the device tree of nested guest:
> 
> ```
> device_type = "power-ivpe";
> compatible = "ibm,power-ivpe";
> ```
> 
> But as per LoPAR section B.5.9[1], these entries should only be present
> when XIVE native exploitation mode is being used. Presently, there is no 
> support for nested virtualization in the context of XIVE, and hence, DT 
> shouldn't advertise support for XIVE interrupt controller to a nested guest. 
> 
> Also, according to the present behaviour, when we boot a nested KVM
> guest, the following QEMU warnings are reported	:
> ```
> Calling ibm,client-architecture-support...qemu-system-ppc64: warning: 
> kernel_irqchip allowed but unavailable: IRQ_XIVE capability must be present 
> for KVM
> Falling back to kernel-irqchip=off

This is expected since the XIVE native mode is only available
on bare metal... arguably the warning could be silenced but
it was deemed informative

> .
> .
> .
> [    0.000000][    T0] xive: Using IRQ range [0-0]
> [    0.000000][    T0] xive: Interrupt handling initialized with spapr backend
> [    0.000000][    T0] xive: Using priority 6 for all interrupts
> [    0.000000][    T0] xive: Using 64kB queues
> ```
> 
> With this patch, the above warnings are no longer observed in nested guest's 
> dmesg and also the device tree contains the following entries:
> ```
> device_type = "PowerPC-External-Interrupt-Presentation";
> compatible = "IBM,ppc-xicp";
> ```
> 

Hmm... this is a behavior change : same QEMU invocation that would run XIVE
before will now run XICS... :-\

> Also add an additional check to handle the scenarios where
> ic-mode=<mode> is explicitly specified by user - make the code error out
> when XIVE native capability is not there and user specifies
> ic-mode=xive.
> 
> Testing:
> 1. This patch has been tested on a P9 PowerNV machine by spinning up both a
> KVM guest and nested KVM guest. The guest can use XIVE native mode just fine 
> with correct DT entries and for nested guest, interrupt emulation is being used 
> and the DT contains correct entries.
> 
> 2. This patch also has been tested on KVM on PowerVM platform. In this
> scenario, we can boot up a KVM guest on top of a Power Hypervisor guest.
> Kernel patches - lore.kernel.org/linuxppc-dev/20230605064848.12319-1-jpn@linux.vnet.ibm.com
> QEMU tree to test - github.com/mikey/qemu/tree/kvm-papr
> 
> [1] : https://files.openpower.foundation/s/ZmtZyCGiJ2oJHim
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  hw/ppc/spapr.c     |  2 +-
>  hw/ppc/spapr_irq.c | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 54dbfd7fe9..6434742369 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2840,7 +2840,7 @@ static void spapr_machine_init(MachineState *machine)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
>  
>      /* advertise XIVE on POWER9 machines */
> -    if (spapr->irq->xive) {
> +    if (kvmppc_has_cap_xive() && spapr->irq->xive) {

Nak. The behavior of the machine is only dictated by the
command line arguments passed to QEMU, not by the host
capabilities. This is to guarantee migrability.

If the machine is expected to expose XIVE but the host
doesn't support it, e.g. boston P9 machines, then QEMU
falls back on emulating it.

>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>      }
>  
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index a0d1e1298e..856bba042a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -20,6 +20,7 @@
>  #include "hw/qdev-properties.h"
>  #include "cpu-models.h"
>  #include "sysemu/kvm.h"
> +#include "kvm_ppc.h"
>  
>  #include "trace.h"
>  
> @@ -294,6 +295,7 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +    bool cap_xive = kvmppc_has_cap_xive();
>  
>      if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>          error_setg(errp, "kernel_irqchip split mode not supported on pseries");
> @@ -304,6 +306,16 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          return;
>      }
>  
> +    /*
> +     * Check for valid ic-mode - XIVE native won't work if hypervisor doesn't
> +     * have support
> +     */
> +    if (!cap_xive && !spapr->irq->xics) {
> +        error_setg(errp,
> +            "XIVE native mode not available, don't use ic-mode=xive");
> +        return;
> +    }
> +
>      /* Initialize the MSI IRQ allocator. */
>      spapr_irq_msi_init(spapr);
>  
> @@ -323,7 +335,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          spapr->ics = ICS_SPAPR(obj);
>      }
>  
> -    if (spapr->irq->xive) {
> +    if (cap_xive && spapr->irq->xive) {
>          uint32_t nr_servers = spapr_max_server_number(spapr);
>          DeviceState *dev;
>          int i;



-- 
Greg

