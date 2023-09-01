Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9578F81D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 07:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbwtl-00078z-Rz; Fri, 01 Sep 2023 01:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbwtX-00075H-Ej; Fri, 01 Sep 2023 01:40:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbwtR-0008MC-1Y; Fri, 01 Sep 2023 01:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q6nzOL2b9zJ7cvcLcOqBKSIrc1JY9fFqQW0QJAWJOm4=; b=eNdPugL6o6NxH7dSIOWmJPnSdH
 ccnwAZkuu7NQ22yWJehgGdUoL07+jQfXlUEe3YFLceFlfLoF08ra/uCbDAwhz7PsoT2ONQYnjgTaZ
 UAgJWx/iLYGQ7LTCrsFXxOr6NRi8/7/IdYjYSc7uzxoxsY2OlQ2kB/iDRpzgZwGn5kWvp6bPOhBje
 sei4b+MeXMKd6a4BCPL1uzH8s4x2dMowpQ7teaVaM/q7A6v0bDd3+IehF2KiqKjTQf9YMZ/T2IbIf
 D9dXLweI6UQQE4G/sOsedfL+mwqoPrgMTm2lCAUzynvFgnjzvzzsH9xTGmk4AGPVl5u3XGJ60Zp3k
 k667GhD1Wu9/kTu2jzfKjZfj0xIqsjMqYU5v2Knj8s0+rnut/GWyksDEr5TYym6RUQ8tBQqwNVshx
 CKo80JYkHMQD0MLofXFldMZ78PlTsIFNDY4gonGZhCBV9O9x+ADf2pzaL2EJpSDzsXQri5smFS7y4
 GBQw+3a1bmoXhev5jsu1RI8ygT8hPJN0FLySG4Riy8cyQNYwMyzvY+2MsR27JV7nZID9AuqphVwIv
 a5tZZVi+jEzrD07nKoTgY+H3/4MUn8Rovj79nFEUq/OFPhjO3Q1Hczrv6EgPN32ksHrwbtbt4sSzJ
 HDh3wuJZTxgNNQ71ow3s0ieid7ngxRdhCSxEjk2vc=;
Received: from [2a00:23c4:8bae:9a00:e29b:2528:c042:5a0c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbwso-0000OM-Sa; Fri, 01 Sep 2023 06:39:54 +0100
Message-ID: <f238791e-3667-975d-5908-33327d12a688@ilande.co.uk>
Date: Fri, 1 Sep 2023 06:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-9-graf@amazon.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230830161425.91946-9-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:9a00:e29b:2528:c042:5a0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 08/12] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 30/08/2023 17:14, Alexander Graf wrote:

Hi Alex,

> The VMApple machine exposes AUX and ROOT block devices (as well as USB OTG
> emulation) via virtio-pci as well as a special, simple backdoor platform
> device.
> 
> This patch implements this backdoor platform device to the best of my
> understanding. I left out any USB OTG parts; they're only needed for
> guest recovery and I don't understand the protocol yet.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>    - Adapt to system_ss meson.build target
> ---
>   include/hw/vmapple/bdif.h |  31 +++++
>   hw/vmapple/bdif.c         | 245 ++++++++++++++++++++++++++++++++++++++
>   hw/vmapple/Kconfig        |   2 +
>   hw/vmapple/meson.build    |   1 +
>   hw/vmapple/trace-events   |   5 +
>   5 files changed, 284 insertions(+)
>   create mode 100644 include/hw/vmapple/bdif.h
>   create mode 100644 hw/vmapple/bdif.c
> 
> diff --git a/include/hw/vmapple/bdif.h b/include/hw/vmapple/bdif.h
> new file mode 100644
> index 0000000000..65ee43457b
> --- /dev/null
> +++ b/include/hw/vmapple/bdif.h
> @@ -0,0 +1,31 @@
> +/*
> + * VMApple Backdoor Interface
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VMAPPLE_BDIF_H
> +#define HW_VMAPPLE_BDIF_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VMAPPLE_BDIF "vmapple-bdif"
> +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleBdifState, VMAPPLE_BDIF)
> +
> +struct VMAppleBdifState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    BlockBackend *aux;
> +    BlockBackend *root;
> +    MemoryRegion mmio;
> +};

This looks better :). You can drop the private/public comments though.

> +
> +#define VMAPPLE_BDIF_SIZE 0x00200000
> +
> +#endif /* HW_VMAPPLE_BDIF_H */
> diff --git a/hw/vmapple/bdif.c b/hw/vmapple/bdif.c
> new file mode 100644
> index 0000000000..36b5915ff3
> --- /dev/null
> +++ b/hw/vmapple/bdif.c
> @@ -0,0 +1,245 @@
> +/*
> + * VMApple Backdoor Interface
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vmapple/bdif.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/block/block.h"
> +#include "sysemu/block-backend.h"
> +
> +#define REG_DEVID_MASK      0xffff0000
> +#define DEVID_ROOT          0x00000000
> +#define DEVID_AUX           0x00010000
> +#define DEVID_USB           0x00100000
> +
> +#define REG_STATUS          0x0
> +#define REG_STATUS_ACTIVE     BIT(0)
> +#define REG_CFG             0x4
> +#define REG_CFG_ACTIVE        BIT(1)
> +#define REG_UNK1            0x8
> +#define REG_BUSY            0x10
> +#define REG_BUSY_READY        BIT(0)
> +#define REG_UNK2            0x400
> +#define REG_CMD             0x408
> +#define REG_NEXT_DEVICE     0x420
> +#define REG_UNK3            0x434
> +
> +typedef struct vblk_sector {
> +    uint32_t pad;
> +    uint32_t pad2;
> +    uint32_t sector;
> +    uint32_t pad3;
> +} VblkSector;
> +
> +typedef struct vblk_req_cmd {
> +    uint64_t addr;
> +    uint32_t len;
> +    uint32_t flags;
> +} VblkReqCmd;
> +
> +typedef struct vblk_req {
> +    VblkReqCmd sector;
> +    VblkReqCmd data;
> +    VblkReqCmd retval;
> +} VblkReq;
> +
> +#define VBLK_DATA_FLAGS_READ  0x00030001
> +#define VBLK_DATA_FLAGS_WRITE 0x00010001
> +
> +#define VBLK_RET_SUCCESS  0
> +#define VBLK_RET_FAILED   1
> +
> +static uint64_t bdif_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t ret = -1;
> +    uint64_t devid = (offset & REG_DEVID_MASK);
> +
> +    switch (offset & ~REG_DEVID_MASK) {
> +    case REG_STATUS:
> +        ret = REG_STATUS_ACTIVE;
> +        break;
> +    case REG_CFG:
> +        ret = REG_CFG_ACTIVE;
> +        break;
> +    case REG_UNK1:
> +        ret = 0x420;
> +        break;
> +    case REG_BUSY:
> +        ret = REG_BUSY_READY;
> +        break;
> +    case REG_UNK2:
> +        ret = 0x1;
> +        break;
> +    case REG_UNK3:
> +        ret = 0x0;
> +        break;
> +    case REG_NEXT_DEVICE:
> +        switch (devid) {
> +        case DEVID_ROOT:
> +            ret = 0x8000000;
> +            break;
> +        case DEVID_AUX:
> +            ret = 0x10000;
> +            break;
> +        }
> +        break;
> +    }
> +
> +    trace_bdif_read(offset, size, ret);
> +    return ret;
> +}
> +
> +static void le2cpu_sector(VblkSector *sector)
> +{
> +    sector->sector = le32_to_cpu(sector->sector);
> +}
> +
> +static void le2cpu_reqcmd(VblkReqCmd *cmd)
> +{
> +    cmd->addr = le64_to_cpu(cmd->addr);
> +    cmd->len = le32_to_cpu(cmd->len);
> +    cmd->flags = le32_to_cpu(cmd->flags);
> +}
> +
> +static void le2cpu_req(VblkReq *req)
> +{
> +    le2cpu_reqcmd(&req->sector);
> +    le2cpu_reqcmd(&req->data);
> +    le2cpu_reqcmd(&req->retval);
> +}
> +
> +static void vblk_cmd(uint64_t devid, BlockBackend *blk, uint64_t value,
> +                     uint64_t static_off)
> +{
> +    VblkReq req;
> +    VblkSector sector;
> +    uint64_t off = 0;
> +    char *buf = NULL;
> +    uint8_t ret = VBLK_RET_FAILED;
> +    int r;
> +
> +    cpu_physical_memory_read(value, &req, sizeof(req));
> +    le2cpu_req(&req);
> +
> +    if (req.sector.len != sizeof(sector)) {
> +        ret = VBLK_RET_FAILED;
> +        goto out;
> +    }
> +
> +    /* Read the vblk command */
> +    cpu_physical_memory_read(req.sector.addr, &sector, sizeof(sector));
> +    le2cpu_sector(&sector);
> +
> +    off = sector.sector * 512ULL + static_off;
> +
> +    /* Sanity check that we're not allocating bogus sizes */
> +    if (req.data.len > (128 * 1024 * 1024)) {
> +        goto out;
> +    }
> +
> +    buf = g_malloc0(req.data.len);
> +    switch (req.data.flags) {
> +    case VBLK_DATA_FLAGS_READ:
> +        r = blk_pread(blk, off, req.data.len, buf, 0);
> +        trace_bdif_vblk_read(devid == DEVID_AUX ? "aux" : "root",
> +                             req.data.addr, off, req.data.len, r);
> +        if (r < 0) {
> +            goto out;
> +        }
> +        cpu_physical_memory_write(req.data.addr, buf, req.data.len);
> +        ret = VBLK_RET_SUCCESS;
> +        break;
> +    case VBLK_DATA_FLAGS_WRITE:
> +        /* Not needed, iBoot only reads */
> +        break;
> +    default:
> +        break;
> +    }
> +
> +out:
> +    g_free(buf);
> +    cpu_physical_memory_write(req.retval.addr, &ret, 1);
> +}
> +
> +static void bdif_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned size)
> +{
> +    VMAppleBdifState *s = opaque;
> +    uint64_t devid = (offset & REG_DEVID_MASK);
> +
> +    trace_bdif_write(offset, size, value);
> +
> +    switch (offset & ~REG_DEVID_MASK) {
> +    case REG_CMD:
> +        switch (devid) {
> +        case DEVID_ROOT:
> +            vblk_cmd(devid, s->root, value, 0x0);
> +            break;
> +        case DEVID_AUX:
> +            vblk_cmd(devid, s->aux, value, 0x0);
> +            break;
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps bdif_ops = {
> +    .read = bdif_read,
> +    .write = bdif_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Similar comment here re: DEVICE_NATIVE_ENDIAN.

> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +    },
> +};
> +
> +static void bdif_init(Object *obj)
> +{
> +    VMAppleBdifState *s = VMAPPLE_BDIF(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &bdif_ops, obj,
> +                         "VMApple Backdoor Interface", VMAPPLE_BDIF_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static Property bdif_properties[] = {
> +    DEFINE_PROP_DRIVE("aux", VMAppleBdifState, aux),
> +    DEFINE_PROP_DRIVE("root", VMAppleBdifState, root),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void bdif_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "VMApple Backdoor Interface";
> +    device_class_set_props(dc, bdif_properties);
> +}
> +
> +static const TypeInfo bdif_info = {
> +    .name          = TYPE_VMAPPLE_BDIF,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(VMAppleBdifState),
> +    .instance_init = bdif_init,
> +    .class_init    = bdif_class_init,
> +};
> +
> +static void bdif_register_types(void)
> +{
> +    type_register_static(&bdif_info);
> +}
> +
> +type_init(bdif_register_types)

And same again re: DEFINE_TYPES().

> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index a73504d599..388a2bc60c 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -1,3 +1,5 @@
>   config VMAPPLE_AES
>       bool
>   
> +config VMAPPLE_BDIF
> +    bool
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index bcd4dcb28d..d4624713de 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -1 +1,2 @@
>   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> +system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
> diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> index 03585cdf0f..45c69de2e0 100644
> --- a/hw/vmapple/trace-events
> +++ b/hw/vmapple/trace-events
> @@ -18,3 +18,8 @@ aes_2_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
>   aes_2_write_unknown(uint64_t offset) "offset=0x%"PRIx64
>   aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
>   aes_dump_data(const char *desc, const char *hex) "%s%s"
> +
> +# bdif.c
> +bdif_read(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
> +bdif_write(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
> +bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset, uint32_t len, int r) "dev=%s addr=0x%"PRIx64" off=0x%"PRIx64" size=0x%x r=%d"

Out of curiosity I see that this and the AES device both make use of 
cpu_physical_memory_read() and cpu_physical_memory_write(): would it make sense to 
pass in a target MemoryRegion or use an AddressSpace here?


ATB,

Mark.


