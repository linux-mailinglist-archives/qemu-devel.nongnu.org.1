Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 410867CF253
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 10:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtOGZ-0001uk-Kp; Thu, 19 Oct 2023 04:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtOGO-0001ri-1c
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtOGL-0004S2-SX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697703612;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjQk1l1bubtvwFmYywbmcoGQEjbBBac+Uh0OJpVtHbs=;
 b=bAEMkKObScjS68sUwm1kpsAHyKd5jdBl1n+/HNIDAi169NZmuXpILCUnvDDpowbt4fkIc4
 8qNoPOykKn4RujstuTFZOWPsJw7H9FJDmQByeZ9aBf2N35ZfsxEKGbZ9yQyOtWMRuCmf52
 nrTw/HvzBVLFY9agGBGqUcXVvHmW0dI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-6dBE8WhIPsaMM3eut5DiuQ-1; Thu, 19 Oct 2023 04:20:09 -0400
X-MC-Unique: 6dBE8WhIPsaMM3eut5DiuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1D77857D0C;
 Thu, 19 Oct 2023 08:20:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA6271C060AE;
 Thu, 19 Oct 2023 08:20:06 +0000 (UTC)
Date: Thu, 19 Oct 2023 09:20:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, thuth@redhat.com, philmd@linaro.org,
 lvivier@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v5 02/10] hw/fsi: Introduce IBM's scratchpad
Message-ID: <ZTDmtBUkuvYNkFlQ@redhat.com>
References: <20231011151339.2782132-1-ninad@linux.ibm.com>
 <20231011151339.2782132-3-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011151339.2782132-3-ninad@linux.ibm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 11, 2023 at 10:13:31AM -0500, Ninad Palsule wrote:
> This is a part of patchset where scratchpad is introduced.
> 
> The scratchpad provides a set of non-functional registers. The firmware
> is free to use them, hardware does not support any special management
> support. The scratchpad registers can be read or written from LBUS
> slave.
> 
> In this model, The LBUS device is parent for the scratchpad.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v2:
> - Incorporated Joel's review comments.
> v5:
> - Incorporated review comments by Cedric.
> ---
>  include/hw/fsi/engine-scratchpad.h | 33 ++++++++++
>  hw/fsi/engine-scratchpad.c         | 99 ++++++++++++++++++++++++++++++
>  hw/fsi/Kconfig                     |  4 ++
>  hw/fsi/meson.build                 |  1 +
>  hw/fsi/trace-events                |  2 +
>  5 files changed, 139 insertions(+)
>  create mode 100644 include/hw/fsi/engine-scratchpad.h
>  create mode 100644 hw/fsi/engine-scratchpad.c
>  create mode 100644 hw/fsi/trace-events
> 
> diff --git a/include/hw/fsi/engine-scratchpad.h b/include/hw/fsi/engine-scratchpad.h
> new file mode 100644
> index 0000000000..17e9570c5c
> --- /dev/null
> +++ b/include/hw/fsi/engine-scratchpad.h
> @@ -0,0 +1,33 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM scratchpad engne
> + */
> +#ifndef FSI_ENGINE_SCRATCHPAD_H
> +#define FSI_ENGINE_SCRATCHPAD_H
> +
> +#include "qemu/bitops.h"
> +
> +#include "hw/fsi/lbus.h"
> +
> +#define ENGINE_CONFIG_NEXT              BE_BIT(0)
> +#define ENGINE_CONFIG_VPD               BE_BIT(1)
> +#define ENGINE_CONFIG_SLOTS             BE_GENMASK(8, 15)
> +#define ENGINE_CONFIG_VERSION           BE_GENMASK(16, 19)
> +#define ENGINE_CONFIG_TYPE              BE_GENMASK(20, 27)
> +#define   ENGINE_CONFIG_TYPE_PEEK       (0x02 << 4)
> +#define   ENGINE_CONFIG_TYPE_FSI        (0x03 << 4)
> +#define   ENGINE_CONFIG_TYPE_SCRATCHPAD (0x06 << 4)
> +#define ENGINE_CONFIG_CRC              BE_GENMASK(28, 31)
> +
> +#define TYPE_SCRATCHPAD "scratchpad"
> +#define SCRATCHPAD(obj) OBJECT_CHECK(ScratchPad, (obj), TYPE_SCRATCHPAD)
> +
> +typedef struct ScratchPad {
> +        FSILBusDevice parent;
> +
> +        uint32_t reg;
> +} ScratchPad;
> +
> +#endif /* FSI_ENGINE_SCRATCHPAD_H */
> diff --git a/hw/fsi/engine-scratchpad.c b/hw/fsi/engine-scratchpad.c
> new file mode 100644
> index 0000000000..60f678eec4
> --- /dev/null
> +++ b/hw/fsi/engine-scratchpad.c
> @@ -0,0 +1,99 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2023 IBM Corp.
> + *
> + * IBM scratchpad engine
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +#include "hw/fsi/engine-scratchpad.h"
> +
> +static uint64_t scratchpad_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    ScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_scratchpad_read(addr, size);
> +
> +    if (addr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);

We already have a trace point in the line above. I don't think we should
be unconditionally logging errors like this, as this becomes a guest
triggerable denial of service on the host log collector for the guest.
eg it could flood the logfile connected to stderr with unlimited data
by repeatedly doing bad reads/writes.

> +        return 0;
> +    }
> +
> +    return s->reg;
> +}
> +
> +static void scratchpad_write(void *opaque, hwaddr addr, uint64_t data,
> +                                 unsigned size)
> +{
> +    ScratchPad *s = SCRATCHPAD(opaque);
> +
> +    trace_scratchpad_write(addr, size, data);
> +
> +    if (addr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for %u\n",
> +                      __func__, addr, size);
> +        return;
> +    }
> +
> +    s->reg = data;
> +}
> +
> +static const struct MemoryRegionOps scratchpad_ops = {
> +    .read = scratchpad_read,
> +    .write = scratchpad_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void scratchpad_realize(DeviceState *dev, Error **errp)
> +{
> +    FSILBusDevice *ldev = FSI_LBUS_DEVICE(dev);
> +
> +    memory_region_init_io(&ldev->iomem, OBJECT(ldev), &scratchpad_ops,
> +                          ldev, TYPE_SCRATCHPAD, 0x400);
> +}
> +
> +static void scratchpad_reset(DeviceState *dev)
> +{
> +    ScratchPad *s = SCRATCHPAD(dev);
> +
> +    s->reg = 0;
> +}
> +
> +static void scratchpad_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    FSILBusDeviceClass *ldc = FSI_LBUS_DEVICE_CLASS(klass);
> +
> +    dc->realize = scratchpad_realize;
> +    dc->reset = scratchpad_reset;
> +
> +    ldc->config =
> +          ENGINE_CONFIG_NEXT            /* valid */
> +        | 0x00010000                    /* slots */
> +        | 0x00001000                    /* version */
> +        | ENGINE_CONFIG_TYPE_SCRATCHPAD /* type */
> +        | 0x00000007;                   /* crc */

More common QEMU style would be for the "|" to be on the end
of line rather than start.

End of line:

$ git grep '.*\s|\s*$' "*.c" | wc -l
5381

Start of line:

$ git grep '^\s*|\s.*' "*.c" | wc -l
581


> +}
> +
> +static const TypeInfo scratchpad_info = {
> +    .name = TYPE_SCRATCHPAD,
> +    .parent = TYPE_FSI_LBUS_DEVICE,
> +    .instance_size = sizeof(ScratchPad),
> +    .class_init = scratchpad_class_init,
> +    .class_size = sizeof(FSILBusDeviceClass),
> +};
> +
> +static void scratchpad_register_types(void)
> +{
> +    type_register_static(&scratchpad_info);
> +}
> +
> +type_init(scratchpad_register_types);
> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
> index e650c660f0..f7c7fd1b28 100644
> --- a/hw/fsi/Kconfig
> +++ b/hw/fsi/Kconfig
> @@ -1,2 +1,6 @@
> +config FSI_SCRATCHPAD
> +    bool
> +    select FSI_LBUS
> +
>  config FSI_LBUS
>      bool
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 4074d3a7d2..d45a98c223 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1 +1,2 @@
>  system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
> +system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
> new file mode 100644
> index 0000000000..97fd070354
> --- /dev/null
> +++ b/hw/fsi/trace-events
> @@ -0,0 +1,2 @@
> +scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
> +scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
> -- 
> 2.39.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


