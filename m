Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968CA78F8C8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 08:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qby2i-0002DT-Ck; Fri, 01 Sep 2023 02:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qby2g-0002DG-OE; Fri, 01 Sep 2023 02:54:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qby2Z-0007FJ-Ma; Fri, 01 Sep 2023 02:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JAnirxBEL+IAzhILLjRNBFhKX12vgJyXhdzNWt3u9gk=; b=O2hj1I4Hijbw5RW9QyZajaBTc5
 cL6zfu0X5FmEMtJgUas0fUkQP0VOAFiB2jEKbN/DYLSXavqec4CuiXoc5mL0/UX4iKKfBgR7ZaD1I
 VbY05A5sc+Ke9LJ1Ex0YG5uaStzsiGhEjejwVdOJScgv6irmRwZIafuWCmLqmyDZtLB9GWtskT7UC
 /G51aEie4LndPnVMMaXOBaoEH+rImiCfTj8xPPpkDUwDH2/mZW0xvMVLswkLfWzBtvpAIrNJoOS9e
 KbrD6A8qcSjhdjBQZQjKyLkAzg+Fy43naVqC0SHFNIBv4yceDl4dH47k7PCzd1HxwCWKZzqECYQco
 UPOEqBhhVz0Oxk58vtqFmJVGsxy2CKYYuUgmo4Emk5jupikqScdFrUGMStYUv+7SNQxLT3Jx8+XTE
 7iibMShXr4hYLjgniltcqyqIBgn9ktBWHGlrCVdoQaFyKspaB4BMJeibvuRc/dJza3ep6dyEKEdBN
 nRCXE8SN3Fy7GMIduddeLUaePo5lHpKRlt2qsi25iBNbg/D0rUBMMAEk/xJEgl5gd/SpwuUkBrj7c
 EpB3Q1iWldUXzMqkZcvzXZbYcXFYwiMYG88sTij6pRASpzcfo6Q+gFvV8MN0d8Nymj2BSEytVFD42
 c+bzwKN6E7IemcZYQs1RVgngB0nKXLu33paJBcCeE=;
Received: from [2a00:23c4:8bae:9a00:dd88:5208:9abb:2b35]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qby1v-0000k4-HL; Fri, 01 Sep 2023 07:53:23 +0100
Message-ID: <ec528b03-bace-59cc-a7fd-7741014cc07f@ilande.co.uk>
Date: Fri, 1 Sep 2023 07:53:49 +0100
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
 <20230830161425.91946-12-graf@amazon.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230830161425.91946-12-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:9a00:dd88:5208:9abb:2b35
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 11/12] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new barrier
> command.
> 
> This patch first creates a mechanism for virtio-blk downstream classes to
> handle unknown commands. It then creates such a downstream class and a new
> vmapple-virtio-blk-pci class which support the additional apple type config
> identifier as well as the barrier command.
> 
> It then exposes 2 subclasses from that that we can use to expose root and
> aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>    - Rework to make all vmapple virtio-blk logic a subclass
> ---
>   include/hw/pci/pci_ids.h        |   1 +
>   include/hw/virtio/virtio-blk.h  |  12 +-
>   include/hw/vmapple/virtio-blk.h |  39 ++++++
>   hw/block/virtio-blk.c           |  19 ++-
>   hw/vmapple/virtio-blk.c         | 212 ++++++++++++++++++++++++++++++++
>   hw/vmapple/Kconfig              |   3 +
>   hw/vmapple/meson.build          |   1 +
>   7 files changed, 282 insertions(+), 5 deletions(-)
>   create mode 100644 include/hw/vmapple/virtio-blk.h
>   create mode 100644 hw/vmapple/virtio-blk.c
> 
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index e4386ebb20..74e589a298 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -188,6 +188,7 @@
>   #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
>   #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
>   #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
>   
>   #define PCI_VENDOR_ID_SUN                0x108e
>   #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index dafec432ce..381a906410 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -23,7 +23,7 @@
>   #include "qom/object.h"
>   
>   #define TYPE_VIRTIO_BLK "virtio-blk-device"
> -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
> +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
>   
>   /* This is the last element of the write scatter-gather list */
>   struct virtio_blk_inhdr
> @@ -91,6 +91,16 @@ typedef struct MultiReqBuffer {
>       bool is_write;
>   } MultiReqBuffer;
>   
> +typedef struct VirtIOBlkClass {
> +    /*< private >*/
> +    VirtioDeviceClass parent;

This should be parent_class for consistency.

> +    /*< public >*/
> +    bool (*handle_unknown_request)(VirtIOBlockReq *req, MultiReqBuffer *mrb,
> +                                   uint32_t type);
> +} VirtIOBlkClass;
> +

Same as before you can drop the typedef and public/private comments, and a newline 
after parent_class.

>   void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
> +void virtio_blk_free_request(VirtIOBlockReq *req);
> +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status);
>   
>   #endif
> diff --git a/include/hw/vmapple/virtio-blk.h b/include/hw/vmapple/virtio-blk.h
> new file mode 100644
> index 0000000000..b23106a3df
> --- /dev/null
> +++ b/include/hw/vmapple/virtio-blk.h
> @@ -0,0 +1,39 @@
> +/*
> + * VMApple specific VirtIO Block implementation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VMAPPLE_CFG_H
> +#define HW_VMAPPLE_CFG_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-blk.h"
> +
> +#define TYPE_VMAPPLE_VIRTIO_BLK "vmapple-virtio-blk"
> +#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
> +#define TYPE_VMAPPLE_VIRTIO_AUX "vmapple-virtio-aux"
> +
> +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIRTIO_BLK)
> +
> +typedef struct VMAppleVirtIOBlkClass {
> +    /*< private >*/
> +    VirtIOBlkClass parent;
> +    /*< public >*/
> +    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
> +} VMAppleVirtIOBlkClass;

Same here.

> +typedef struct VMAppleVirtIOBlk {
> +    /* <private> */
> +    VirtIOBlock parent_obj;
> +
> +    /* <public> */
> +    uint32_t apple_type;
> +} VMAppleVirtIOBlk;

And here.

> +#endif /* HW_VMAPPLE_CFG_H */
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 39e7f23fab..1645cdccbe 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -48,12 +48,12 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>       req->mr_next = NULL;
>   }
>   
> -static void virtio_blk_free_request(VirtIOBlockReq *req)
> +void virtio_blk_free_request(VirtIOBlockReq *req)
>   {
>       g_free(req);
>   }
>   
> -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
> +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
>   {
>       VirtIOBlock *s = req->dev;
>       VirtIODevice *vdev = VIRTIO_DEVICE(s);
> @@ -1121,8 +1121,18 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>           break;
>       }
>       default:
> -        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> -        virtio_blk_free_request(req);
> +    {
> +        /*
> +         * Give subclasses a chance to handle unknown requests. This way the
> +         * class lookup is not in the hot path.
> +         */
> +        VirtIOBlkClass *vbk = VIRTIO_BLK_GET_CLASS(s);
> +        if (!vbk->handle_unknown_request ||
> +            !vbk->handle_unknown_request(req, mrb, type)) {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> +            virtio_blk_free_request(req);
> +        }
> +    }
>       }
>       return 0;
>   }
> @@ -1764,6 +1774,7 @@ static const TypeInfo virtio_blk_info = {
>       .instance_size = sizeof(VirtIOBlock),
>       .instance_init = virtio_blk_instance_init,
>       .class_init = virtio_blk_class_init,
> +    .class_size = sizeof(VirtIOBlkClass),
>   };
>   
>   static void virtio_register_types(void)
> diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> new file mode 100644
> index 0000000000..720eaa61a8
> --- /dev/null
> +++ b/hw/vmapple/virtio-blk.c
> @@ -0,0 +1,212 @@
> +/*
> + * VMApple specific VirtIO Block implementation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * VMApple uses almost standard VirtIO Block, but with a few key differences:
> + *
> + *  - Different PCI device/vendor ID
> + *  - An additional "type" identifier to differentiate AUX and Root volumes
> + *  - An additional BARRIER command
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vmapple/virtio-blk.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +
> +#define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
> +
> +#define VIRTIO_APPLE_TYPE_ROOT 1
> +#define VIRTIO_APPLE_TYPE_AUX  2
> +
> +static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
> +                                                      MultiReqBuffer *mrb,
> +                                                      uint32_t type)
> +{
> +    switch (type) {
> +    case VIRTIO_BLK_T_APPLE_BARRIER:
> +        /* We ignore barriers for now. YOLO. */
> +        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> +        virtio_blk_free_request(req);
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +/*
> + * VMApple virtio-blk uses the same config format as normal virtio, with one
> + * exception: It adds an "apple type" specififer at the same location that
> + * the spec reserves for max_secure_erase_sectors. Let's hook into the
> + * get_config code path here, run it as usual and then patch in the apple type.
> + */
> +static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VMAppleVirtIOBlk *dev = VMAPPLE_VIRTIO_BLK(vdev);
> +    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
> +    struct virtio_blk_config *blkcfg = (struct virtio_blk_config *)config;
> +
> +    vvbk->get_config(vdev, config);
> +
> +    g_assert(dev->parent_obj.config_size >= endof(struct virtio_blk_config, zoned));

You want to use a QOM cast macro instead of using parent_obj directly here.

> +    /* Apple abuses the field for max_secure_erase_sectors as type id */
> +    blkcfg->max_secure_erase_sectors = dev->apple_type;
> +}
> +
> +static Property vmapple_virtio_blk_properties[] = {
> +    DEFINE_PROP_UINT32("apple-type", VMAppleVirtIOBlk, apple_type, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmapple_virtio_blk_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtIOBlkClass *vbk = VIRTIO_BLK_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +    VMAppleVirtIOBlkClass *vvbk = VMAPPLE_VIRTIO_BLK_CLASS(klass);
> +
> +    vbk->handle_unknown_request = vmapple_virtio_blk_handle_unknown_request;
> +    vvbk->get_config = vdc->get_config;
> +    vdc->get_config = vmapple_virtio_blk_get_config;
> +    device_class_set_props(dc, vmapple_virtio_blk_properties);
> +}
> +
> +static const TypeInfo vmapple_virtio_blk_info = {
> +    .name          = TYPE_VMAPPLE_VIRTIO_BLK,
> +    .parent        = TYPE_VIRTIO_BLK,
> +    .instance_size = sizeof(VMAppleVirtIOBlk),
> +    .class_init    = vmapple_virtio_blk_class_init,
> +};
> +
> +/* PCI Devices */
> +
> +typedef struct VMAppleVirtIOBlkPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VMAppleVirtIOBlk vdev;
> +    uint32_t apple_type;
> +} VMAppleVirtIOBlkPCI;

Same here re: typedef, newline after parent_obj. And again this definition and the 
QOM declaration macro should be in a separate .h file.

> +/*
> + * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-base"
> +DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI,
> +                         TYPE_VMAPPLE_VIRTIO_BLK_PCI)

I believe you can just use OBJECT_DECLARE_SIMPLE_TYPE() here?

> +static Property vmapple_virtio_blk_pci_properties[] = {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +    VirtIOBlkConf *conf = &dev->vdev.parent_obj.conf;

Here you should use the appropriate QOM cast macro instead of referencing parent_obj 
directly.

> +
> +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues = virtio_pci_optimal_num_queues(0);
> +    }
> +
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = conf->num_queues + 1;
> +    }
> +
> +    /*
> +     * We don't support zones, but we need the additional config space size.
> +     * Let's just expose the feature so the rest of the virtio-blk logic
> +     * allocates enough space for us. The guest will ignore zones anyway.
> +     */
> +    virtio_add_feature(&dev->vdev.parent_obj.host_features, VIRTIO_BLK_F_ZONED);

And here too.

> +    /* Propagate the apple type down to the virtio-blk device */
> +    qdev_prop_set_uint32(DEVICE(&dev->vdev), "apple-type", dev->apple_type);
> +    /* and spawn the virtio-blk device */
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);

It took me a while to figure out how virtio_blk_device_realize() could be called, but 
that appears to be done via VirtioDeviceClass::realize?

> +    /*
> +     * The virtio-pci machinery adjusts its vendor/device ID based on whether
> +     * we support modern or legacy virtio. Let's patch it back to the Apple
> +     * identifiers here.
> +     */
> +    pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
> +    pci_config_set_device_id(vpci_dev->pci_dev.config, PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
> +}
> +
> +static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    device_class_set_props(dc, vmapple_virtio_blk_pci_properties);
> +    k->realize = vmapple_virtio_blk_pci_realize;
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_APPLE;
> +    pcidev_k->device_id = PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
> +}
> +
> +static void vmapple_virtio_blk_pci_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VMAPPLE_VIRTIO_BLK);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info = {
> +    .base_name     = TYPE_VMAPPLE_VIRTIO_BLK_PCI,
> +    .generic_name  = "vmapple-virtio-blk-pci",

Does it make sense to use a macro for the generic name?

> +    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init = vmapple_virtio_blk_pci_instance_init,
> +    .class_init    = vmapple_virtio_blk_pci_class_init,
> +};
> +
> +static void vmapple_virtio_root_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    dev->apple_type = VIRTIO_APPLE_TYPE_ROOT;
> +}
> +
> +static const TypeInfo vmapple_virtio_root_info = {
> +    .name          = TYPE_VMAPPLE_VIRTIO_ROOT,

Is there any need to mention VIRTIO_BLK as opposed to VIRTIO in the typename?

> +    .parent        = "vmapple-virtio-blk-pci",

Same question here re: using a macro.

> +    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init = vmapple_virtio_root_instance_init,
> +};
> +
> +static void vmapple_virtio_aux_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev = VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    dev->apple_type = VIRTIO_APPLE_TYPE_AUX;
> +}
> +
> +static const TypeInfo vmapple_virtio_aux_info = {
> +    .name          = TYPE_VMAPPLE_VIRTIO_AUX,

Similar question here re: VIRTIO vs. VIRTIO_BLK.

> +    .parent        = "vmapple-virtio-blk-pci",

Similar question here re: using a macro.

> +    .instance_size = sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init = vmapple_virtio_aux_instance_init,
> +};
> +
> +static void vmapple_virtio_blk_register_types(void)
> +{
> +    type_register_static(&vmapple_virtio_blk_info);
> +    virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
> +    type_register_static(&vmapple_virtio_root_info);
> +    type_register_static(&vmapple_virtio_aux_info);
> +}
> +
> +type_init(vmapple_virtio_blk_register_types)

And again use DEFINE_TYPES().

> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index ba37fc5b81..f06eae8039 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -9,3 +9,6 @@ config VMAPPLE_CFG
>   
>   config VMAPPLE_PVG
>       bool
> +
> +config VMAPPLE_VIRTIO_BLK
> +    bool
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index 74a0d7a5f1..3b4a16f619 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_PVG',  if_true: [files('apple-gfx.m'), pvg, metal])
> +system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio-blk.c'))


ATB,

Mark.


