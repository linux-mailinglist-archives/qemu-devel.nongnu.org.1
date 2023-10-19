Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E887CF29F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 10:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtOQA-0005cQ-8L; Thu, 19 Oct 2023 04:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtOQ6-0005b1-5s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtOQ1-0000m5-Dn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697704212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7NjyhzIF+bfkK8LJE42urWGupvmh3O/r3UDDNbVG+w=;
 b=TSwuK6Ah3Igy1PKGG0y1oS/hSL3qLJ1dnvP71JteVZSc+B2xFqv66M0zl/e2lo/0rUoaRK
 I/BcGE+JfaF1fXxBoIUlcg/Of+SR33R3gMeuSNYeiIcnRjpiAJcofXc6VYzm/wiUXnJXjd
 s5bZzh0rbF3O4AMgtsyRzSY5XBn1B9g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-hM1zhTwTOYG9mndDlXvbaA-1; Thu, 19 Oct 2023 04:30:08 -0400
X-MC-Unique: hM1zhTwTOYG9mndDlXvbaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07EB03C0F448;
 Thu, 19 Oct 2023 08:30:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B2D2166B26;
 Thu, 19 Oct 2023 08:30:05 +0000 (UTC)
Date: Thu, 19 Oct 2023 09:30:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, thuth@redhat.com, philmd@linaro.org,
 lvivier@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v5 05/10] hw/fsi: IBM's On-chip Peripheral Bus
Message-ID: <ZTDpC/ymolhCpMdZ@redhat.com>
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-6-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011151339.2782132-6-ninad@linux.ibm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 11, 2023 at 10:13:34AM -0500, Ninad Palsule wrote:
> This is a part of patchset where IBM's Flexible Service Interface is
> introduced.
> 
> The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
> POWER processors. This now makes an appearance in the ASPEED SoC due
> to tight integration of the FSI master IP with the OPB, mainly the
> existence of an MMIO-mapping of the CFAM address straight onto a
> sub-region of the OPB address space.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
> - Incorporated review comment by Joel.
> v5:
> - Incorporated review comments by Cedric.
> ---
>  include/hw/fsi/opb.h |  43 ++++++++++
>  hw/fsi/fsi-master.c  |   3 +-
>  hw/fsi/opb.c         | 185 +++++++++++++++++++++++++++++++++++++++++++
>  hw/fsi/Kconfig       |   4 +
>  hw/fsi/meson.build   |   1 +
>  hw/fsi/trace-events  |   2 +
>  6 files changed, 236 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/fsi/opb.h
>  create mode 100644 hw/fsi/opb.c
> 
> diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
> new file mode 100644
> index 0000000000..f8ce00383e
> --- /dev/null
> +++ b/include/hw/fsi/opb.h
> @@ -0,0 +1,43 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM On-Chip Peripheral Bus
> + */
> +#ifndef FSI_OPB_H
> +#define FSI_OPB_H
> +
> +#include "exec/memory.h"
> +#include "hw/fsi/fsi-master.h"
> +
> +#define TYPE_OP_BUS "opb"
> +OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
> +
> +typedef struct OPBus {
> +        /*< private >*/
> +        BusState bus;
> +
> +        /*< public >*/
> +        MemoryRegion mr;
> +        AddressSpace as;
> +
> +        /* Model OPB as dumb enough just to provide an address-space */
> +        /* TODO: Maybe don't store device state in the bus? */
> +        FSIMasterState fsi;
> +} OPBus;
> +
> +typedef struct OPBusClass {
> +        BusClass parent_class;
> +} OPBusClass;
> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr);
> +uint16_t opb_read16(OPBus *opb, hwaddr addr);
> +uint32_t opb_read32(OPBus *opb, hwaddr addr);
> +void opb_write8(OPBus *opb, hwaddr addr, uint8_t data);
> +void opb_write16(OPBus *opb, hwaddr addr, uint16_t data);
> +void opb_write32(OPBus *opb, hwaddr addr, uint32_t data);
> +
> +void opb_fsi_master_address(OPBus *opb, hwaddr addr);
> +void opb_opb2fsi_address(OPBus *opb, hwaddr addr);
> +
> +#endif /* FSI_OPB_H */
> diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
> index 8f4ae641c7..ede1a58e98 100644
> --- a/hw/fsi/fsi-master.c
> +++ b/hw/fsi/fsi-master.c
> @@ -11,8 +11,7 @@
>  #include "trace.h"
>  
>  #include "hw/fsi/fsi-master.h"
> -
> -#define TYPE_OP_BUS "opb"
> +#include "hw/fsi/opb.h"
>  
>  #define TO_REG(x)                               ((x) >> 2)
>  
> diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
> new file mode 100644
> index 0000000000..7ffd7730f7
> --- /dev/null
> +++ b/hw/fsi/opb.c
> @@ -0,0 +1,185 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM On-chip Peripheral Bus
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/opb.h"
> +
> +static MemTxResult opb_read(OPBus *opb, hwaddr addr, void *data, size_t len)
> +{
> +    MemTxResult tx;
> +    tx = address_space_read(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> +                              len);
> +    if (tx) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: OPB read failed: 0x%"HWADDR_PRIx" for %lu\n",
> +                      __func__, addr, len);
> +    }
> +    return tx;
> +}

Use a tracepoint rather than an always-on log

> +
> +uint8_t opb_read8(OPBus *opb, hwaddr addr)
> +{
> +    uint8_t data = -1;
> +
> +    (void)opb_read(opb, addr, &data, sizeof(data));
> +
> +    return data;
> +}
> +
> +uint16_t opb_read16(OPBus *opb, hwaddr addr)
> +{
> +    uint16_t data = -1;
> +
> +    (void)opb_read(opb, addr, &data, sizeof(data));
> +
> +    return data;
> +}
> +
> +uint32_t opb_read32(OPBus *opb, hwaddr addr)
> +{
> +    uint32_t data = -1;
> +
> +    (void)opb_read(opb, addr, &data, sizeof(data));
> +
> +    return data;
> +}
> +
> +static void opb_write(OPBus *opb, hwaddr addr, void *data, size_t len)
> +{
> +    MemTxResult tx;
> +    tx = address_space_write(&opb->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> +                               len);
> +    if (tx) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: OPB write failed: %"HWADDR_PRIx" for %lu\n",
> +                      __func__, addr, len);
> +    }
> +}

Again tracepoint


> +static void opb_realize(BusState *bus, Error **errp)
> +{
> +    OPBus *opb = OP_BUS(bus);
> +    Error *err = NULL;
> +
> +    memory_region_init_io(&opb->mr, OBJECT(opb), &opb_unimplemented_ops, opb,
> +                          NULL, UINT32_MAX);
> +    address_space_init(&opb->as, &opb->mr, "opb");
> +
> +    object_property_set_bool(OBJECT(&opb->fsi), "realized", true, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }

Redundant local error object

> +    memory_region_add_subregion(&opb->mr, 0x80000000, &opb->fsi.iomem);
> +
> +    /* OPB2FSI region */
> +    /*
> +     * Avoid endianness issues by mapping each slave's memory region directly.
> +     * Manually bridging multiple address-spaces causes endian swapping
> +     * headaches as memory_region_dispatch_read() and
> +     * memory_region_dispatch_write() correct the endianness based on the
> +     * target machine endianness and not relative to the device endianness on
> +     * either side of the bridge.
> +     */
> +    /*
> +     * XXX: This is a bit hairy and will need to be fixed when I sort out the
> +     * bus/slave relationship and any changes to the CFAM modelling (multiple
> +     * slaves, LBUS)
> +     */
> +    memory_region_add_subregion(&opb->mr, 0xa0000000, &opb->fsi.opb2fsi);
> +}
> +

> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> index d7afef0460..ec9bab2fe8 100644
> --- a/hw/fsi/trace-events
> +++ b/hw/fsi/trace-events
> @@ -9,3 +9,5 @@ fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>  fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>  fsi_master_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>  fsi_master_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> +opb_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +opb_unimplemented_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64

Please consistently use an 'fsi_' prefix for all trace points, as it
makes it possible to enable all tracing for this subsystem using a
wildcard match


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


