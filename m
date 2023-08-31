Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF678F38C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbncp-0000tE-3u; Thu, 31 Aug 2023 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbnci-0000rS-Ce
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbncd-0007zW-OF
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693511191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGnlElHHr3wTjqvHK6Of41sL3B2HP5xl8hpvoa4Uvo4=;
 b=LMnblmHZGcT74qjrADG6LG+qsDF/1gEhz4iKqGxoN6TkfG6sbCh0TJQvjRPwie94/o3JtX
 olLPyOYjLBt9ZwXIR7DVqVycVjfDOIucRdr2XSbW5ChtqYD9iEQBHPT/A+bTHb0EvNBoBj
 SDs+Lye+dLKHR2r6sElf17y/WX6czyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-UIz-Ab5BNzGMxJFnkkr0_Q-1; Thu, 31 Aug 2023 15:46:27 -0400
X-MC-Unique: UIz-Ab5BNzGMxJFnkkr0_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C8BB833951;
 Thu, 31 Aug 2023 19:46:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7F66140E96E;
 Thu, 31 Aug 2023 19:46:25 +0000 (UTC)
Date: Thu, 31 Aug 2023 15:46:24 -0400
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
Subject: Re: [PATCH v2 08/12] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
Message-ID: <20230831194624.GE532982@fedora>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-9-graf@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BkagG4ZhWHPJdn3E"
Content-Disposition: inline
In-Reply-To: <20230830161425.91946-9-graf@amazon.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


--BkagG4ZhWHPJdn3E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 04:14:21PM +0000, Alexander Graf wrote:
> The VMApple machine exposes AUX and ROOT block devices (as well as USB OTG
> emulation) via virtio-pci as well as a special, simple backdoor platform
> device.
>=20
> This patch implements this backdoor platform device to the best of my
> understanding. I left out any USB OTG parts; they're only needed for
> guest recovery and I don't understand the protocol yet.

Out of curiosity: This interface has no way to check the size of the
block device? I guess that's not necessary in a boot loader that just
parses a boot record and then loads the next stage...

I posted comments below. Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>=20
> Signed-off-by: Alexander Graf <graf@amazon.com>
>=20
> ---
>=20
> v1 -> v2:
>=20
>   - Adapt to system_ss meson.build target
> ---
>  include/hw/vmapple/bdif.h |  31 +++++
>  hw/vmapple/bdif.c         | 245 ++++++++++++++++++++++++++++++++++++++
>  hw/vmapple/Kconfig        |   2 +
>  hw/vmapple/meson.build    |   1 +
>  hw/vmapple/trace-events   |   5 +
>  5 files changed, 284 insertions(+)
>  create mode 100644 include/hw/vmapple/bdif.h
>  create mode 100644 hw/vmapple/bdif.c
>=20
> diff --git a/include/hw/vmapple/bdif.h b/include/hw/vmapple/bdif.h
> new file mode 100644
> index 0000000000..65ee43457b
> --- /dev/null
> +++ b/include/hw/vmapple/bdif.h
> @@ -0,0 +1,31 @@
> +/*
> + * VMApple Backdoor Interface
> + *
> + * Copyright =A9 2023 Amazon.com, Inc. or its affiliates. All Rights Res=
erved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
> + * Copyright =A9 2023 Amazon.com, Inc. or its affiliates. All Rights Res=
erved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
> +    uint64_t ret =3D -1;
> +    uint64_t devid =3D (offset & REG_DEVID_MASK);
> +
> +    switch (offset & ~REG_DEVID_MASK) {
> +    case REG_STATUS:
> +        ret =3D REG_STATUS_ACTIVE;
> +        break;
> +    case REG_CFG:
> +        ret =3D REG_CFG_ACTIVE;
> +        break;
> +    case REG_UNK1:
> +        ret =3D 0x420;
> +        break;
> +    case REG_BUSY:
> +        ret =3D REG_BUSY_READY;
> +        break;
> +    case REG_UNK2:
> +        ret =3D 0x1;
> +        break;
> +    case REG_UNK3:
> +        ret =3D 0x0;
> +        break;
> +    case REG_NEXT_DEVICE:
> +        switch (devid) {
> +        case DEVID_ROOT:
> +            ret =3D 0x8000000;
> +            break;
> +        case DEVID_AUX:
> +            ret =3D 0x10000;
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
> +    sector->sector =3D le32_to_cpu(sector->sector);
> +}
> +
> +static void le2cpu_reqcmd(VblkReqCmd *cmd)
> +{
> +    cmd->addr =3D le64_to_cpu(cmd->addr);
> +    cmd->len =3D le32_to_cpu(cmd->len);
> +    cmd->flags =3D le32_to_cpu(cmd->flags);
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
> +    uint64_t off =3D 0;
> +    char *buf =3D NULL;
> +    uint8_t ret =3D VBLK_RET_FAILED;
> +    int r;
> +
> +    cpu_physical_memory_read(value, &req, sizeof(req));

Please zero req first so that when value is bogus and
cpu_physical_memory_read() does not store to &req, we don't process
req's uninitialized stack memory:

  VblkReq req =3D {};

> +    le2cpu_req(&req);
> +
> +    if (req.sector.len !=3D sizeof(sector)) {
> +        ret =3D VBLK_RET_FAILED;
> +        goto out;
> +    }
> +
> +    /* Read the vblk command */
> +    cpu_physical_memory_read(req.sector.addr, &sector, sizeof(sector));

Same here:

  VblkSectors sector =3D {};

> +    le2cpu_sector(&sector);
> +
> +    off =3D sector.sector * 512ULL + static_off;
> +
> +    /* Sanity check that we're not allocating bogus sizes */
> +    if (req.data.len > (128 * 1024 * 1024)) {
> +        goto out;
> +    }
> +
> +    buf =3D g_malloc0(req.data.len);
> +    switch (req.data.flags) {
> +    case VBLK_DATA_FLAGS_READ:
> +        r =3D blk_pread(blk, off, req.data.len, buf, 0);
> +        trace_bdif_vblk_read(devid =3D=3D DEVID_AUX ? "aux" : "root",
> +                             req.data.addr, off, req.data.len, r);
> +        if (r < 0) {
> +            goto out;
> +        }
> +        cpu_physical_memory_write(req.data.addr, buf, req.data.len);
> +        ret =3D VBLK_RET_SUCCESS;
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
> +    VMAppleBdifState *s =3D opaque;
> +    uint64_t devid =3D (offset & REG_DEVID_MASK);
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
> +static const MemoryRegionOps bdif_ops =3D {
> +    .read =3D bdif_read,
> +    .write =3D bdif_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
> +static void bdif_init(Object *obj)
> +{
> +    VMAppleBdifState *s =3D VMAPPLE_BDIF(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &bdif_ops, obj,
> +                         "VMApple Backdoor Interface", VMAPPLE_BDIF_SIZE=
);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static Property bdif_properties[] =3D {
> +    DEFINE_PROP_DRIVE("aux", VMAppleBdifState, aux),
> +    DEFINE_PROP_DRIVE("root", VMAppleBdifState, root),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void bdif_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "VMApple Backdoor Interface";
> +    device_class_set_props(dc, bdif_properties);
> +}
> +
> +static const TypeInfo bdif_info =3D {
> +    .name          =3D TYPE_VMAPPLE_BDIF,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(VMAppleBdifState),
> +    .instance_init =3D bdif_init,
> +    .class_init    =3D bdif_class_init,
> +};
> +
> +static void bdif_register_types(void)
> +{
> +    type_register_static(&bdif_info);
> +}
> +
> +type_init(bdif_register_types)
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index a73504d599..388a2bc60c 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -1,3 +1,5 @@
>  config VMAPPLE_AES
>      bool
> =20
> +config VMAPPLE_BDIF
> +    bool
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index bcd4dcb28d..d4624713de 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -1 +1,2 @@
>  system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> +system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
> diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> index 03585cdf0f..45c69de2e0 100644
> --- a/hw/vmapple/trace-events
> +++ b/hw/vmapple/trace-events
> @@ -18,3 +18,8 @@ aes_2_read(uint64_t offset, uint64_t res) "offset=3D0x%=
"PRIx64" res=3D0x%"PRIx64
>  aes_2_write_unknown(uint64_t offset) "offset=3D0x%"PRIx64
>  aes_2_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64" val=3D0=
x%"PRIx64
>  aes_dump_data(const char *desc, const char *hex) "%s%s"
> +
> +# bdif.c
> +bdif_read(uint64_t offset, uint32_t size, uint64_t value) "offset=3D0x%"=
PRIx64" size=3D0x%x value=3D0x%"PRIx64
> +bdif_write(uint64_t offset, uint32_t size, uint64_t value) "offset=3D0x%=
"PRIx64" size=3D0x%x value=3D0x%"PRIx64
> +bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset, uint32_t=
 len, int r) "dev=3D%s addr=3D0x%"PRIx64" off=3D0x%"PRIx64" size=3D0x%x r=
=3D%d"
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

--BkagG4ZhWHPJdn3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTw7hAACgkQnKSrs4Gr
c8hZ8wf3Z5bYYGLruvrl1CC95tBWHX7s6Hzb+QPL3xbBAE2NfAh6N+uMUUe2oHzt
GHF+BwP2Kehoh+2C9CZ11848HwiEEBTDTIFYuymm7BduENFCQhJkPb6/0uFUeOkI
A3+kKe3xIinTedIuaI3KIhpXncn0Bus7JSu4ZDcNPusuIKuipFh06ZMB2Jv87qHx
pc+0mpOv4UWRZAk1PgigDEIaL2BwWZdtM430ZIegcDOxHo8skC6r5J5ZTm1DjVJL
chm0kZwzZvc7Dl6onPWR3xi5sUB1mqRVioeDqdxzLNv/W+Spj8Q2FF4djeeTh4rh
RsER49h6eKdio63mUxwTaMMpAUj5
=cJY7
-----END PGP SIGNATURE-----

--BkagG4ZhWHPJdn3E--


