Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90787737BEF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:17:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBs5l-0005QP-1k; Wed, 21 Jun 2023 03:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBs5i-0005Q9-2S
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBs5f-0000ud-Ua
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687331839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hjH+NNI2d1enNQ9JMwMXztNaTsFcJ6lMuYS8EU2qC5U=;
 b=QS3XWT18bi/4FvjeumM1zGFIw+jxz2W+FYxbOlben8NGmlKLnkcNAVTA792Uf/Hj67VqRT
 FBJOihoIpLeCgDEPJgV/KIn8Cyug2lPEybYBqNMHMpPr6dCYLQJJBQq+ZVCByj3/WxfSh3
 I8KMEpV1oya1EADtMx1QK5b0rND1FHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-DL2PhZoIOjGyK3ktCPn9Fw-1; Wed, 21 Jun 2023 03:17:13 -0400
X-MC-Unique: DL2PhZoIOjGyK3ktCPn9Fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D252104458B;
 Wed, 21 Jun 2023 07:17:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 869EC112132C;
 Wed, 21 Jun 2023 07:17:11 +0000 (UTC)
Date: Wed, 21 Jun 2023 08:17:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Joel Upham <jupham125@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v1 01/23] pc/xen: Xen Q35 support: provide IRQ handling
 for PCI devices
Message-ID: <ZJKj9YQfOVzVXOno@redhat.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <1c547c5581ce6192b70c68f39de108cdb2c73f7e.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c547c5581ce6192b70c68f39de108cdb2c73f7e.1687278381.git.jupham125@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 20, 2023 at 01:24:34PM -0400, Joel Upham wrote:
> 
> Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>

This isn't a valid email address for Alexey - I presume you grabbed
these patches from the xen-devel mail archives, which have mangled
the addresses for anti-spam reasons.

Fortunately there are alternative archives which don't mangle the
patches:

  https://lore.kernel.org/xen-devel/6067bc3c91c9ee629a35723dfb474ef168ff4ebf.1520867955.git.x1917x@gmail.com/

  Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>

This affects all patches in the series, but I won't repeat my
comment on each one.

> Signed-off-by: Joel Upham <jupham125@gmail.com>
> ---
>  hw/i386/pc_piix.c             |  3 +-
>  hw/i386/xen/xen-hvm.c         |  7 +++--
>  hw/isa/lpc_ich9.c             | 53 ++++++++++++++++++++++++++++++++---
>  hw/isa/piix3.c                |  2 +-
>  include/hw/southbridge/ich9.h |  1 +
>  include/hw/xen/xen.h          |  4 +--
>  stubs/xen-hw-stub.c           |  4 +--
>  7 files changed, 61 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d5b0dcd1fe..8c1b20f3bc 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -62,6 +62,7 @@
>  #endif
>  #include "hw/xen/xen-x86.h"
>  #include "hw/xen/xen.h"
> +#include "sysemu/xen.h"
>  #include "migration/global_state.h"
>  #include "migration/misc.h"
>  #include "sysemu/numa.h"
> @@ -233,7 +234,7 @@ static void pc_init1(MachineState *machine,
>                                x86ms->above_4g_mem_size,
>                                pci_memory, ram_memory);
>          pci_bus_map_irqs(pci_bus,
> -                         xen_enabled() ? xen_pci_slot_get_pirq
> +                         xen_enabled() ? xen_cmn_pci_slot_get_pirq
>                                         : pc_pci_slot_get_pirq);
>          pcms->bus = pci_bus;
>  
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 56641a550e..540ac46639 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -15,6 +15,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/i386/pc.h"
> +#include "hw/southbridge/ich9.h"
>  #include "hw/irq.h"
>  #include "hw/hw.h"
>  #include "hw/i386/apic-msidef.h"
> @@ -136,14 +137,14 @@ typedef struct XenIOState {
>      Notifier wakeup;
>  } XenIOState;
>  
> -/* Xen specific function for piix pci */
> +/* Xen-specific functions for pci dev IRQ handling */
>  
> -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
> +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>  {
>      return irq_num + (PCI_SLOT(pci_dev->devfn) << 2);
>  }
>  
> -void xen_piix3_set_irq(void *opaque, int irq_num, int level)
> +void xen_cmn_set_irq(void *opaque, int irq_num, int level)
>  {
>      xen_set_pci_intx_level(xen_domid, 0, 0, irq_num >> 2,
>                             irq_num & 3, level);
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 9c47a2f6c7..733a99d443 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -51,6 +51,9 @@
>  #include "hw/core/cpu.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/cutils.h"
> +#include "hw/xen/xen.h"
> +#include "sysemu/xen.h"
> +#include "hw/southbridge/piix.h"
>  #include "hw/acpi/acpi_aml_interface.h"
>  #include "trace.h"
>  
> @@ -535,11 +538,49 @@ static int ich9_lpc_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> +static void ich9_lpc_config_write_xen(PCIDevice *d,
> +                                  uint32_t addr, uint32_t val, int len)
> +{
> +    static bool pirqe_f_warned = false;
> +    if (ranges_overlap(addr, len, ICH9_LPC_PIRQA_ROUT, 4)) {
> +        /* handle PIRQA..PIRQD routing */
> +        /* Scan for updates to PCI link routes (0x60-0x63). */
> +        int i;
> +        for (i = 0; i < len; i++) {
> +            uint8_t v = (val >> (8 * i)) & 0xff;
> +            if (v & 0x80) {
> +                v = 0;
> +            }
> +            v &= 0xf;
> +            if (((addr + i) >= PIIX_PIRQCA) && ((addr + i) <= PIIX_PIRQCD)) {
> +                xen_set_pci_link_route(addr + i - PIIX_PIRQCA, v);
> +            }
> +        }
> +    } else if (ranges_overlap(addr, len, ICH9_LPC_PIRQE_ROUT, 4)) {
> +        while (len--) {
> +            if (range_covers_byte(ICH9_LPC_PIRQE_ROUT, 4, addr) &&
> +                (val & 0x80) == 0) {
> +                /* print warning only once */
> +                if (!pirqe_f_warned) {
> +                    pirqe_f_warned = true;
> +                    fprintf(stderr, "WARNING: guest domain attempted to use PIRQ%c "
> +                            "routing which is not supported for Xen/Q35 currently\n",
> +                            (char)(addr - ICH9_LPC_PIRQE_ROUT + 'E'));
> +                    break;
> +                }
> +            }
> +            addr++, val >>= 8;
> +        }
> +    }
> +}
> +
>  static void ich9_lpc_config_write(PCIDevice *d,
>                                    uint32_t addr, uint32_t val, int len)
>  {
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(d);
>      uint32_t rcba_old = pci_get_long(d->config + ICH9_LPC_RCBA);
> +    if (xen_enabled())
> +        ich9_lpc_config_write_xen(d, addr, val, len);
>  
>      pci_default_write_config(d, addr, val, len);
>      if (ranges_overlap(addr, len, ICH9_LPC_PMBASE, 4) ||
> @@ -731,10 +772,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>          return;
>      }
>  
> -    pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
> -    pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
> -    pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> -
> +    if (xen_enabled()) {
> +        pci_bus_irqs(pci_bus, xen_cmn_set_irq, d, ICH9_XEN_NUM_IRQ_SOURCES);
> +        pci_bus_map_irqs(pci_bus, xen_cmn_pci_slot_get_pirq);
> +    } else {
> +        pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
> +        pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
> +        pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> +    }
>      ich9_lpc_pm_init(lpc);
>  }
>  
> diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
> index f9103ea45a..3d0545eb0e 100644
> --- a/hw/isa/piix3.c
> +++ b/hw/isa/piix3.c
> @@ -420,7 +420,7 @@ static void piix3_xen_realize(PCIDevice *dev, Error **errp)
>       * connected to the IOAPIC directly.
>       * These additional routes can be discovered through ACPI.
>       */
> -    pci_bus_irqs(pci_bus, xen_piix3_set_irq, piix3, XEN_PIIX_NUM_PIRQS);
> +    pci_bus_irqs(pci_bus, xen_cmn_set_irq, piix3, XEN_PIIX_NUM_PIRQS);
>  }
>  
>  static void piix3_xen_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index fd01649d04..07b84d5227 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -130,6 +130,7 @@ struct ICH9LPCState {
>  
>  #define ICH9_A2_LPC_REVISION                    0x2
>  #define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
> +#define ICH9_XEN_NUM_IRQ_SOURCES                128
>  
>  #define ICH9_LPC_PMBASE                         0x40
>  #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       ICH9_MASK(32, 15, 7)
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index 2bd8ec742d..a2c3d98eaa 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -37,9 +37,9 @@ extern uint32_t xen_domid;
>  extern enum xen_mode xen_mode;
>  extern bool xen_domid_restrict;
>  
> -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
> +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>  int xen_set_pci_link_route(uint8_t link, uint8_t irq);
> -void xen_piix3_set_irq(void *opaque, int irq_num, int level);
> +void xen_cmn_set_irq(void *opaque, int irq_num, int level);
>  void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
>  int xen_is_pirq_msi(uint32_t msi_data);
>  
> diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
> index 34a22f2ad7..f06fbf48c8 100644
> --- a/stubs/xen-hw-stub.c
> +++ b/stubs/xen-hw-stub.c
> @@ -10,12 +10,12 @@
>  #include "hw/xen/xen.h"
>  #include "hw/xen/xen-x86.h"
>  
> -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
> +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>  {
>      return -1;
>  }
>  
> -void xen_piix3_set_irq(void *opaque, int irq_num, int level)
> +void xen_cmn_set_irq(void *opaque, int irq_num, int level)
>  {
>  }
>  
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


