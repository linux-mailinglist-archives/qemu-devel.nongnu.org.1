Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B678F3BD
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbntU-0005X0-2I; Thu, 31 Aug 2023 16:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbntP-0005W9-A8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbntL-0005Jm-AT
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693512226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AcKCTvHinaemMP4MaRz+3FlPYQ2mgOnZDdKIyfqpGVk=;
 b=JpCOK9zzN6jlbtTQAmB4+f+S+hWynVhZq25OaQiLLXf2Mzx7LkqvnsOLp+5BBMTsL1uDBC
 v+1ZpM1XqFzvRi/y/zfCRkbuT569e/2M3gdXkpT8vOw7bWMqUGJGDb3Qv7rSwUDsyNqn8+
 Adn1ILiIpBx6K4UCLLWt85YujvqnX2U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-vNUXNvY8MQuWngffP7iXyw-1; Thu, 31 Aug 2023 16:03:45 -0400
X-MC-Unique: vNUXNvY8MQuWngffP7iXyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 826E33C025AC;
 Thu, 31 Aug 2023 20:03:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADF1EC15BAE;
 Thu, 31 Aug 2023 20:03:43 +0000 (UTC)
Date: Thu, 31 Aug 2023 16:03:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 11/12] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
Message-ID: <20230831200342.GF532982@fedora>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-12-graf@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1SzFviYoAvpIfnZo"
Content-Disposition: inline
In-Reply-To: <20230830161425.91946-12-graf@amazon.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--1SzFviYoAvpIfnZo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 04:14:24PM +0000, Alexander Graf wrote:
> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new barrier
> command.
>=20
> This patch first creates a mechanism for virtio-blk downstream classes to
> handle unknown commands. It then creates such a downstream class and a new
> vmapple-virtio-blk-pci class which support the additional apple type conf=
ig
> identifier as well as the barrier command.
>=20
> It then exposes 2 subclasses from that that we can use to expose root and
> aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".
>=20
> Signed-off-by: Alexander Graf <graf@amazon.com>

Aside from my comments below:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>=20
> ---
>=20
> v1 -> v2:
>=20
>   - Rework to make all vmapple virtio-blk logic a subclass
> ---
>  include/hw/pci/pci_ids.h        |   1 +
>  include/hw/virtio/virtio-blk.h  |  12 +-
>  include/hw/vmapple/virtio-blk.h |  39 ++++++
>  hw/block/virtio-blk.c           |  19 ++-
>  hw/vmapple/virtio-blk.c         | 212 ++++++++++++++++++++++++++++++++
>  hw/vmapple/Kconfig              |   3 +
>  hw/vmapple/meson.build          |   1 +
>  7 files changed, 282 insertions(+), 5 deletions(-)
>  create mode 100644 include/hw/vmapple/virtio-blk.h
>  create mode 100644 hw/vmapple/virtio-blk.c
>=20
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index e4386ebb20..74e589a298 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -188,6 +188,7 @@
>  #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
>  #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
>  #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
> =20
>  #define PCI_VENDOR_ID_SUN                0x108e
>  #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
> index dafec432ce..381a906410 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -23,7 +23,7 @@
>  #include "qom/object.h"
> =20
>  #define TYPE_VIRTIO_BLK "virtio-blk-device"
> -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
> +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
> =20
>  /* This is the last element of the write scatter-gather list */
>  struct virtio_blk_inhdr
> @@ -91,6 +91,16 @@ typedef struct MultiReqBuffer {
>      bool is_write;
>  } MultiReqBuffer;
> =20
> +typedef struct VirtIOBlkClass {
> +    /*< private >*/
> +    VirtioDeviceClass parent;
> +    /*< public >*/
> +    bool (*handle_unknown_request)(VirtIOBlockReq *req, MultiReqBuffer *=
mrb,
> +                                   uint32_t type);

Vendor-specific commands ;_;

> +} VirtIOBlkClass;
> +
>  void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
> +void virtio_blk_free_request(VirtIOBlockReq *req);
> +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status);
> =20
>  #endif
> diff --git a/include/hw/vmapple/virtio-blk.h b/include/hw/vmapple/virtio-=
blk.h
> new file mode 100644
> index 0000000000..b23106a3df
> --- /dev/null
> +++ b/include/hw/vmapple/virtio-blk.h
> @@ -0,0 +1,39 @@
> +/*
> + * VMApple specific VirtIO Block implementation
> + *
> + * Copyright =A9 2023 Amazon.com, Inc. or its affiliates. All Rights Res=
erved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VMAPPLE_CFG_H
> +#define HW_VMAPPLE_CFG_H
> +
> +#include "hw/sysbus.h"

I'm surprised to see this header since this isn't a SysBus device. Is it
really needed?

> +#include "qom/object.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-blk.h"
> +
> +#define TYPE_VMAPPLE_VIRTIO_BLK "vmapple-virtio-blk"
> +#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
> +#define TYPE_VMAPPLE_VIRTIO_AUX "vmapple-virtio-aux"
> +
> +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_VIR=
TIO_BLK)
> +
> +typedef struct VMAppleVirtIOBlkClass {
> +    /*< private >*/
> +    VirtIOBlkClass parent;
> +    /*< public >*/
> +    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
> +} VMAppleVirtIOBlkClass;
> +
> +typedef struct VMAppleVirtIOBlk {
> +    /* <private> */
> +    VirtIOBlock parent_obj;
> +
> +    /* <public> */
> +    uint32_t apple_type;
> +} VMAppleVirtIOBlk;
> +
> +#endif /* HW_VMAPPLE_CFG_H */
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 39e7f23fab..1645cdccbe 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -48,12 +48,12 @@ static void virtio_blk_init_request(VirtIOBlock *s, V=
irtQueue *vq,
>      req->mr_next =3D NULL;
>  }
> =20
> -static void virtio_blk_free_request(VirtIOBlockReq *req)
> +void virtio_blk_free_request(VirtIOBlockReq *req)
>  {
>      g_free(req);
>  }
> =20
> -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char s=
tatus)
> +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
>  {
>      VirtIOBlock *s =3D req->dev;
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> @@ -1121,8 +1121,18 @@ static int virtio_blk_handle_request(VirtIOBlockRe=
q *req, MultiReqBuffer *mrb)
>          break;
>      }
>      default:
> -        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> -        virtio_blk_free_request(req);
> +    {
> +        /*
> +         * Give subclasses a chance to handle unknown requests. This way=
 the
> +         * class lookup is not in the hot path.
> +         */
> +        VirtIOBlkClass *vbk =3D VIRTIO_BLK_GET_CLASS(s);
> +        if (!vbk->handle_unknown_request ||
> +            !vbk->handle_unknown_request(req, mrb, type)) {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> +            virtio_blk_free_request(req);
> +        }
> +    }
>      }
>      return 0;
>  }
> @@ -1764,6 +1774,7 @@ static const TypeInfo virtio_blk_info =3D {
>      .instance_size =3D sizeof(VirtIOBlock),
>      .instance_init =3D virtio_blk_instance_init,
>      .class_init =3D virtio_blk_class_init,
> +    .class_size =3D sizeof(VirtIOBlkClass),
>  };
> =20
>  static void virtio_register_types(void)
> diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> new file mode 100644
> index 0000000000..720eaa61a8
> --- /dev/null
> +++ b/hw/vmapple/virtio-blk.c
> @@ -0,0 +1,212 @@
> +/*
> + * VMApple specific VirtIO Block implementation
> + *
> + * Copyright =A9 2023 Amazon.com, Inc. or its affiliates. All Rights Res=
erved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + * VMApple uses almost standard VirtIO Block, but with a few key differe=
nces:
> + *
> + *  - Different PCI device/vendor ID
> + *  - An additional "type" identifier to differentiate AUX and Root volu=
mes

Strange, virtio-blk has a serial string that is intended for
differentiating between devices. Maybe that is already being used as a
volume label that varies between root volumes, but I would have expected
that identifier to live in the file system superblock, partition tables,
etc.

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
> +static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *re=
q,
> +                                                      MultiReqBuffer *mr=
b,
> +                                                      uint32_t type)
> +{
> +    switch (type) {
> +    case VIRTIO_BLK_T_APPLE_BARRIER:
> +        /* We ignore barriers for now. YOLO. */
> +        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> +        virtio_blk_free_request(req);
> +        return true;

This is fine when --blockdev/--drive have cache=3Dunsafe. Can you add a
check into .realize() that refuses to start when block_get_flags(blk) &
BDRV_O_NO_FLUSH =3D=3D 0?

> +    default:
> +        return false;
> +    }
> +}
> +
> +/*
> + * VMApple virtio-blk uses the same config format as normal virtio, with=
 one
> + * exception: It adds an "apple type" specififer at the same location th=
at

"specifier"

> + * the spec reserves for max_secure_erase_sectors. Let's hook into the
> + * get_config code path here, run it as usual and then patch in the appl=
e type.
> + */
> +static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t *c=
onfig)
> +{
> +    VMAppleVirtIOBlk *dev =3D VMAPPLE_VIRTIO_BLK(vdev);
> +    VMAppleVirtIOBlkClass *vvbk =3D VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
> +    struct virtio_blk_config *blkcfg =3D (struct virtio_blk_config *)con=
fig;
> +
> +    vvbk->get_config(vdev, config);
> +
> +    g_assert(dev->parent_obj.config_size >=3D endof(struct virtio_blk_co=
nfig, zoned));
> +
> +    /* Apple abuses the field for max_secure_erase_sectors as type id */
> +    blkcfg->max_secure_erase_sectors =3D dev->apple_type;
> +}
> +
> +static Property vmapple_virtio_blk_properties[] =3D {
> +    DEFINE_PROP_UINT32("apple-type", VMAppleVirtIOBlk, apple_type, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmapple_virtio_blk_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtIOBlkClass *vbk =3D VIRTIO_BLK_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +    VMAppleVirtIOBlkClass *vvbk =3D VMAPPLE_VIRTIO_BLK_CLASS(klass);
> +
> +    vbk->handle_unknown_request =3D vmapple_virtio_blk_handle_unknown_re=
quest;
> +    vvbk->get_config =3D vdc->get_config;
> +    vdc->get_config =3D vmapple_virtio_blk_get_config;
> +    device_class_set_props(dc, vmapple_virtio_blk_properties);
> +}
> +
> +static const TypeInfo vmapple_virtio_blk_info =3D {
> +    .name          =3D TYPE_VMAPPLE_VIRTIO_BLK,
> +    .parent        =3D TYPE_VIRTIO_BLK,
> +    .instance_size =3D sizeof(VMAppleVirtIOBlk),
> +    .class_init    =3D vmapple_virtio_blk_class_init,
> +};
> +
> +/* PCI Devices */
> +
> +typedef struct VMAppleVirtIOBlkPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VMAppleVirtIOBlk vdev;
> +    uint32_t apple_type;
> +} VMAppleVirtIOBlkPCI;
> +
> +/*
> + * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-base"
> +DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI,
> +                         TYPE_VMAPPLE_VIRTIO_BLK_PCI)
> +
> +static Property vmapple_virtio_blk_pci_properties[] =3D {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Err=
or **errp)
> +{
> +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> +    VirtIOBlkConf *conf =3D &dev->vdev.parent_obj.conf;
> +
> +    if (conf->num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues =3D virtio_pci_optimal_num_queues(0);
> +    }
> +
> +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors =3D conf->num_queues + 1;
> +    }
> +
> +    /*
> +     * We don't support zones, but we need the additional config space s=
ize.
> +     * Let's just expose the feature so the rest of the virtio-blk logic
> +     * allocates enough space for us. The guest will ignore zones anyway.
> +     */
> +    virtio_add_feature(&dev->vdev.parent_obj.host_features, VIRTIO_BLK_F=
_ZONED);
> +    /* Propagate the apple type down to the virtio-blk device */
> +    qdev_prop_set_uint32(DEVICE(&dev->vdev), "apple-type", dev->apple_ty=
pe);
> +    /* and spawn the virtio-blk device */
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +
> +    /*
> +     * The virtio-pci machinery adjusts its vendor/device ID based on wh=
ether
> +     * we support modern or legacy virtio. Let's patch it back to the Ap=
ple
> +     * identifiers here.
> +     */
> +    pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APP=
LE);
> +    pci_config_set_device_id(vpci_dev->pci_dev.config, PCI_DEVICE_ID_APP=
LE_VIRTIO_BLK);
> +}
> +
> +static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, void *=
data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    device_class_set_props(dc, vmapple_virtio_blk_pci_properties);
> +    k->realize =3D vmapple_virtio_blk_pci_realize;
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_APPLE;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
> +}
> +
> +static void vmapple_virtio_blk_pci_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VMAPPLE_VIRTIO_BLK);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info =3D {
> +    .base_name     =3D TYPE_VMAPPLE_VIRTIO_BLK_PCI,
> +    .generic_name  =3D "vmapple-virtio-blk-pci",
> +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init =3D vmapple_virtio_blk_pci_instance_init,
> +    .class_init    =3D vmapple_virtio_blk_pci_class_init,
> +};
> +
> +static void vmapple_virtio_root_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    dev->apple_type =3D VIRTIO_APPLE_TYPE_ROOT;
> +}
> +
> +static const TypeInfo vmapple_virtio_root_info =3D {
> +    .name          =3D TYPE_VMAPPLE_VIRTIO_ROOT,
> +    .parent        =3D "vmapple-virtio-blk-pci",
> +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init =3D vmapple_virtio_root_instance_init,
> +};
> +
> +static void vmapple_virtio_aux_instance_init(Object *obj)
> +{
> +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> +
> +    dev->apple_type =3D VIRTIO_APPLE_TYPE_AUX;
> +}
> +
> +static const TypeInfo vmapple_virtio_aux_info =3D {
> +    .name          =3D TYPE_VMAPPLE_VIRTIO_AUX,
> +    .parent        =3D "vmapple-virtio-blk-pci",
> +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> +    .instance_init =3D vmapple_virtio_aux_instance_init,
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
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index ba37fc5b81..f06eae8039 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -9,3 +9,6 @@ config VMAPPLE_CFG
> =20
>  config VMAPPLE_PVG
>      bool
> +
> +config VMAPPLE_VIRTIO_BLK
> +    bool
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index 74a0d7a5f1..3b4a16f619 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files=
('aes.c'))
>  system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
>  system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
>  system_ss.add(when: 'CONFIG_VMAPPLE_PVG',  if_true: [files('apple-gfx.m'=
), pvg, metal])
> +system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio=
-blk.c'))
> --=20
> 2.39.2 (Apple Git-143)
>=20
>=20
>=20
>=20
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>=20
>=20

--1SzFviYoAvpIfnZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTw8h4ACgkQnKSrs4Gr
c8jYawf/ez8JFM/aCtIF6ocfTurdDcXu1wurEluE6VUlHY/jVSb8ESHTp5eJ8E0S
hB/lBZaxqKi9S/Cxq9HO+BwhfkhIDszVfk2vXuc7JVDNLvYeZpMc32Oyj5ZxU63b
hP9giDoQYCxMlqaL/5/VC3X08L1gXfkE6EhBy6dnUkc9i2vKZE4PI0sbGcrwC65W
sjJBvupnGsU2EJ0adVBMf97SYz4XfOw7SHKbTZDcw2rTBaMrpcEWhnH+AzZVShL+
YnxnaW5cxaH7zVE9EWk4e1iTqagFv4TWuGlYhyhn+hY4VqkFfaezfsmqWRLmcUqN
uWeGJdGODyFbJCt3ckV+c/Q8zhIgcw==
=6wcS
-----END PGP SIGNATURE-----

--1SzFviYoAvpIfnZo--


