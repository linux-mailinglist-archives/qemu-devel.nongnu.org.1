Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2A753656
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 11:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKF1n-00006J-1Y; Fri, 14 Jul 2023 05:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1qKF1Y-0008WO-Kr
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:23:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1qKF1S-0002LD-4V
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:23:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230714092326euoutp0216ebfd3e13e41edb03fab2fc9422e873~xsZkIFAfA3048830488euoutp02K;
 Fri, 14 Jul 2023 09:23:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230714092326euoutp0216ebfd3e13e41edb03fab2fc9422e873~xsZkIFAfA3048830488euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1689326606;
 bh=Ok9c1H8E4OqDkDJGE4zgCg6UhUzc1ye8PG+LBMS23SY=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=aGrm/HZYy5eM3OjoFVuNqCXQ8Y8gye4N9amFSyCCpAbCAsTg/F6lPwQUJctzby5+J
 pQVo0UrSZci9e5o5+v4xVSQoFZ/6B3lbc3GJWu1hdcfSdxeuKGzt9Rky0uoWs9yDmy
 HP4H2KdCcwaPvD+y1QttuD0pyNJjmqgviMgLRENE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230714092325eucas1p2a0fa732adf162f81d2b08d8805723b8f~xsZj5lBKM0261002610eucas1p2w;
 Fri, 14 Jul 2023 09:23:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.6A.42423.D0411B46; Fri, 14
 Jul 2023 10:23:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230714092325eucas1p105978aa928776b6e008e08e793d0ac60~xsZjSx0kt2937029370eucas1p1o;
 Fri, 14 Jul 2023 09:23:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230714092325eusmtrp210bc0ec92366551db46069f936aeb5f1~xsZjSHGfd1630116301eusmtrp2u;
 Fri, 14 Jul 2023 09:23:25 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-2b-64b1140d17e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.5C.10549.C0411B46; Fri, 14
 Jul 2023 10:23:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230714092324eusmtip2d0ff3013208d6c70b1ccafc8cd660854~xsZjBwzwZ2869228692eusmtip2C;
 Fri, 14 Jul 2023 09:23:24 +0000 (GMT)
Received: from localhost (106.210.248.167) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 14 Jul 2023 10:23:24 +0100
Date: Fri, 14 Jul 2023 11:23:23 +0200
From: Joel Granados <j.granados@samsung.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>, <jasonwang@redhat.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <yi.y.sun@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [RFC PATCH v4 20/24] vfio/iommufd: Implement the iommufd backend
Message-ID: <20230714092323.lc4puo4rbsmhxce6@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="4ts7acx5whm3mmti"
Content-Disposition: inline
In-Reply-To: <20230712072528.275577-21-zhenzhong.duan@intel.com>
X-Originating-IP: [106.210.248.167]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87q8IhtTDKa+1rb49r+HzaJxwT5m
 i3l/1rJa3LmkaNG7x8Xiyr89jBZL325lt9j79DGbxZb939gtjvfuYLGY+/Mai8XE6YvYLBbf
 Os/owOuxeM9LJo8n1zYzefQ2v2PzeL/vKlsASxSXTUpqTmZZapG+XQJXxrfeL2wFvacYK6Z+
 +sLSwLhuOmMXIzuHhICJRLdCFyMXh5DACkaJ061fmLoYOYGcL4wS179xQiQ+M0q8+fiKDSQB
 Uv9t2U4WiMRyRokf83oZ4apuzV3BBuFsZZT4un4eWAuLgKrE4sbzYDabgI7E+Td3mEFsEQFd
 iW+fp4F1MwvMZZKY++w0I0hCWMBfYsuriSwgNq+AucSkldfZIGxBiZMzn4DFmQUqJFqXdgEN
 4gCypSWW/+MACXMKOEhMWHMe6lRlidbjTSwQdq3EqS23mEB2SQjs5pRY+/MsG0ivhICLxIIJ
 QhA1whKvjm9hh7BlJP7vnA9VP5lRYv+/D+wQzmpGiWWNX5kgqqwlWq48gepwlPi4qpcJYiif
 xI23ghB38klM2jadGSLMK9HRBrVLTWL1vTcsExiVZyH5bBaSz2YhfAYR1pFYsPsTG4awtsSy
 ha+ZIWxbiXXr3rMsYGRfxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZj8Tv87/mkH49xX
 H/UOMTJxMB5iVAFqfrRh9QVGKZa8/LxUJRFelW3rUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz
 atueTBYSSE8sSc1OTS1ILYLJMnFwSjUwxcROuf5O8d1NH8EPkvPnNp+5vcpfZ/uqNxczdkl5
 SxR9F5EP6Ci1VFspdm3np/v8MWfvGTfLTnodlnO++MejXw/WB5wwkL+TpM7kaLeJr31/2f23
 53v/mzOvll2TLp91Lcbiw8V4/68XTrer3xOxvXzP8cBDq5/imopWNslGB9gad1/mS7YWvmB/
 Nl9aZdq8Z6nGjqvPvj/SFZV27lcw65z5CjyBuZKHXppfYQtkmHbzpN7srOhnLQ0+C6q+axsp
 hcwonbTrcmqgma+ObchB/w2HOgIirVo0pT+ufbv+5J1v6dl6ArdlHj9ZWZRea7z8EYvvjjUC
 Rx9Yz1uw0PT4o/3MDD68wcWLpDYKs5/ZqcRSnJFoqMVcVJwIAH2LMFr5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4PV1ekY0pBocLLL7972GzaFywj9li
 3p+1rBZ3Lila9O5xsbjybw+jxdK3W9kt9j59zGaxZf83dovjvTtYLOb+vMZiMXH6IjaLxbfO
 Mzrweize85LJ48m1zUwevc3v2Dze77vKFsASpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
 Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJex7+9JloLuU4wVL6+vYW1gXDOdsYuRk0NCwETi27Kd
 LF2MXBxCAksZJX48uAKVkJHY+OUqK4QtLPHnWhcbiC0k8JFR4tItOYiGrYwSt2YdZQFJsAio
 SixuPA9WxCagI3H+zR1mEFtEQFfi2+dpjCANzAJzmSTmPjsNtkFYwFfiWXc/O4jNK2AuMWnl
 dagNJRKbL01ihogLSpyc+QRsAbNAmcT+1w+Zuhg5gGxpieX/OEDCnAIOEhPWQOyVEFCWaD3e
 xAJh10p8/vuMcQKj8Cwkk2YhmTQLYRJEWEvixr+XmMLaEssWvmaGsG0l1q17z7KAkX0Vo0hq
 aXFuem6xoV5xYm5xaV66XnJ+7iZGYArYduzn5h2M81591DvEyMTBeIhRBajz0YbVFxilWPLy
 81KVRHhVtq1LEeJNSaysSi3Kjy8qzUktPsRoCgzFicxSosn5wOSUVxJvaGZgamhiZmlgamlm
 rCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAZC5rIff3i9nnLDPT1F0S22x8qppiF3m5Je9f
 971hl3cq47ZTfRuc5oRr93JsvPxlqvNxueju84eY/n69fcLhlnH7OsXPp8+Ubljtte148A1V
 7YWFcq+DJpn1z+JlWKBx7kuL8+0tXt9OOHt3CrE4Pv3grOPTkbT/mnnGFLspj++Lv1V/aGG2
 6LMfb1/XgqKnH85nJJz7PGH2m9C+wLe/pcLPM175yG+suGjb8ZTf5bK+0QfNl4q+e8uTq82q
 vnBq0bbljNu/hcVv38q2nzn9/jrhBT38t/K6F4vEizc68+YkTvy9KWnXxxY9trv+O6RWLshu
 29rPWZ+hzbLlwe1D27PN7FKebVZ4c9o4qGeDgRJLcUaioRZzUXEiAOTKuSKWAwAA
X-CMS-MailID: 20230714092325eucas1p105978aa928776b6e008e08e793d0ac60
X-Msg-Generator: CA
X-RootMTR: 20230714092325eucas1p105978aa928776b6e008e08e793d0ac60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230714092325eucas1p105978aa928776b6e008e08e793d0ac60
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-21-zhenzhong.duan@intel.com>
 <CGME20230714092325eucas1p105978aa928776b6e008e08e793d0ac60@eucas1p1.samsung.com>
Received-SPF: pass client-ip=210.118.77.12;
 envelope-from=j.granados@samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--4ts7acx5whm3mmti
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 03:25:24PM +0800, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>=20
> Add the iommufd backend. The IOMMUFD container class is implemented
> based on the new /dev/iommu user API. This backend obviously depends
> on CONFIG_IOMMUFD.
>=20
> So far, the iommufd backend doesn't support live migration yet due
> to missing support in the host kernel.
>=20
> Co-authored-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/as.c                          |  12 +-
>  hw/vfio/iommufd.c                     | 511 ++++++++++++++++++++++++++
>  hw/vfio/meson.build                   |   3 +
>  hw/vfio/trace-events                  |  11 +
>  include/hw/vfio/vfio-common.h         |  24 ++
>  include/hw/vfio/vfio-container-base.h |   3 +
>  6 files changed, 562 insertions(+), 2 deletions(-)
>  create mode 100644 hw/vfio/iommufd.c
>=20
> diff --git a/hw/vfio/as.c b/hw/vfio/as.c
> index a7179403b7..2e7ecd4e96 100644
> --- a/hw/vfio/as.c
> +++ b/hw/vfio/as.c
> @@ -45,7 +45,7 @@
>  #include "migration/qemu-file.h"
>  #include "sysemu/tpm.h"
> =20
> -static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =3D
> +VFIOAddressSpaceList vfio_address_spaces =3D
>      QLIST_HEAD_INITIALIZER(vfio_address_spaces);
> =20
>  #ifdef CONFIG_KVM
> @@ -1516,8 +1516,16 @@ int vfio_attach_device(char *name, VFIODevice *vba=
sedev,
>  {
>      const VFIOIOMMUBackendOpsClass *ops;
> =20
> -    ops =3D VFIO_IOMMU_BACKEND_OPS_CLASS(
> +#ifdef CONFIG_IOMMUFD
> +    if (vbasedev->iommufd) {
> +        ops =3D VFIO_IOMMU_BACKEND_OPS_CLASS(
> +                  object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_O=
PS));
> +    } else
> +#endif
> +    {
> +        ops =3D VFIO_IOMMU_BACKEND_OPS_CLASS(
>                    object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OP=
S));
> +    }
>      if (!ops) {
>          error_setg(errp, "VFIO IOMMU Backend not found!");
>          return -ENODEV;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> new file mode 100644
> index 0000000000..286ad0b766
> --- /dev/null
> +++ b/hw/vfio/iommufd.c
> @@ -0,0 +1,511 @@
> +/*
> + * iommufd container backend
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include <linux/iommufd.h>
> +
> +#include "hw/vfio/vfio-common.h"
> +#include "qemu/error-report.h"
> +#include "trace.h"
> +#include "qapi/error.h"
> +#include "sysemu/iommufd.h"
> +#include "hw/qdev-core.h"
> +#include "sysemu/reset.h"
> +#include "qemu/cutils.h"
> +#include "qemu/char_dev.h"
> +
> +static int iommufd_map(VFIOContainer *bcontainer, hwaddr iova,
> +                       ram_addr_t size, void *vaddr, bool readonly)
> +{
> +    VFIOIOMMUFDContainer *container =3D
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +
> +    return iommufd_backend_map_dma(container->be,
> +                                   container->ioas_id,
> +                                   iova, size, vaddr, readonly);
> +}
> +
> +static int iommufd_unmap(VFIOContainer *bcontainer,
> +                         hwaddr iova, ram_addr_t size,
> +                         IOMMUTLBEntry *iotlb)
> +{
> +    VFIOIOMMUFDContainer *container =3D
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +
> +    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
> +    return iommufd_backend_unmap_dma(container->be,
> +                                     container->ioas_id, iova, size);
> +}
> +
> +static int vfio_get_devicefd(const char *sysfs_path, Error **errp)
> +{
> +    long int ret =3D -ENOTTY;
> +    char *path, *vfio_dev_path =3D NULL, *vfio_path =3D NULL;
> +    DIR *dir =3D NULL;
> +    struct dirent *dent;
> +    gchar *contents;
> +    struct stat st;
> +    gsize length;
> +    int major, minor;
> +    dev_t vfio_devt;
> +
> +    path =3D g_strdup_printf("%s/vfio-dev", sysfs_path);
> +    if (stat(path, &st) < 0) {
> +        error_setg_errno(errp, errno, "no such host device");
> +        goto out_free_path;
> +    }
> +
> +    dir =3D opendir(path);
> +    if (!dir) {
> +        error_setg_errno(errp, errno, "couldn't open dirrectory %s", pat=
h);
> +        goto out_free_path;
> +    }
> +
> +    while ((dent =3D readdir(dir))) {
> +        if (!strncmp(dent->d_name, "vfio", 4)) {
> +            vfio_dev_path =3D g_strdup_printf("%s/%s/dev", path, dent->d=
_name);
> +            break;
> +        }
> +    }
> +
> +    if (!vfio_dev_path) {
> +        error_setg(errp, "failed to find vfio-dev/vfioX/dev");
> +        goto out_free_path;
> +    }
> +
> +    if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
> +        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
> +        goto out_free_dev_path;
> +    }
> +
> +    if (sscanf(contents, "%d:%d", &major, &minor) !=3D 2) {
> +        error_setg(errp, "failed to get major:mino for \"%s\"", vfio_dev=
_path);
Very small nit: Should be "minor" here.

> +        goto out_free_dev_path;
> +    }
> +    g_free(contents);
> +    vfio_devt =3D makedev(major, minor);
> +
> +    vfio_path =3D g_strdup_printf("/dev/vfio/devices/%s", dent->d_name);
> +    ret =3D open_cdev(vfio_path, vfio_devt);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to open %s", vfio_path);
> +    }
> +
> +    trace_vfio_iommufd_get_devicefd(vfio_path, ret);
> +    g_free(vfio_path);
> +
> +out_free_dev_path:
> +    g_free(vfio_dev_path);
> +    closedir(dir);
> +out_free_path:
> +    if (*errp) {
> +        error_prepend(errp, VFIO_MSG_PREFIX, path);
> +    }
> +    g_free(path);
> +
> +    return ret;
> +}
> +
> +static VFIOIOASHwpt *vfio_container_get_hwpt(VFIOIOMMUFDContainer *conta=
iner,
> +                                             uint32_t hwpt_id)
> +{
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (hwpt->hwpt_id =3D=3D hwpt_id) {
> +            return hwpt;
> +        }
> +    }
> +
> +    hwpt =3D g_malloc0(sizeof(*hwpt));
> +
> +    hwpt->hwpt_id =3D hwpt_id;
> +    QLIST_INIT(&hwpt->device_list);
> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +
> +    return hwpt;
> +}
> +
> +static void vfio_container_put_hwpt(VFIOIOASHwpt *hwpt)
> +{
> +    if (!QLIST_EMPTY(&hwpt->device_list)) {
> +        g_assert_not_reached();
> +    }
> +    QLIST_REMOVE(hwpt, next);
> +    g_free(hwpt);
> +}
> +
> +static VFIOIOASHwpt *vfio_find_hwpt_for_dev(VFIOIOMMUFDContainer *contai=
ner,
> +                                            VFIODevice *vbasedev)
> +{
> +    VFIOIOASHwpt *hwpt;
> +    VFIODevice *vbasedev_iter;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        QLIST_FOREACH(vbasedev_iter, &hwpt->device_list, next) {
> +            if (vbasedev_iter =3D=3D vbasedev) {
> +                return hwpt;
> +            }
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void vfio_kvm_device_add_device(VFIODevice *vbasedev)
> +{
> +    if (vfio_kvm_device_add_fd(vbasedev->fd)) {
> +        error_report("Failed to add device %s to KVM VFIO device",
> +                     vbasedev->name);
> +    }
> +}
> +
> +static void vfio_kvm_device_del_device(VFIODevice *vbasedev)
> +{
> +    if (vfio_kvm_device_del_fd(vbasedev->fd)) {
> +        error_report("Failed to del device %s from KVM VFIO device",
> +                     vbasedev->name);
> +    }
> +}
> +
> +static void
> +__vfio_device_detach_container(VFIODevice *vbasedev,
> +                               VFIOIOMMUFDContainer *container, Error **=
errp)
> +{
> +    struct vfio_device_attach_iommufd_pt detach_data =3D {
> +        .argsz =3D sizeof(detach_data),
> +        .flags =3D 0,
> +    };
> +
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)=
) {
> +        error_setg_errno(errp, errno, "detach %s from ioas id=3D%d faile=
d",
> +                         vbasedev->name, container->ioas_id);
> +    }
> +    trace_vfio_iommufd_detach_device(container->be->fd, vbasedev->name,
> +                                     container->ioas_id);
> +    vfio_kvm_device_del_device(vbasedev);
> +
> +    /* iommufd unbind is done per device fd close */
> +}
> +
> +static void vfio_device_detach_container(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    VFIOIOASHwpt *hwpt;
> +
> +    hwpt =3D vfio_find_hwpt_for_dev(container, vbasedev);
> +    if (hwpt) {
> +        QLIST_REMOVE(vbasedev, next);
> +        if (QLIST_EMPTY(&hwpt->device_list)) {
> +            vfio_container_put_hwpt(hwpt);
> +        }
> +    }
> +
> +    __vfio_device_detach_container(vbasedev, container, errp);
> +}
> +
> +static int vfio_device_attach_container(VFIODevice *vbasedev,
> +                                        VFIOIOMMUFDContainer *container,
> +                                        Error **errp)
> +{
> +    struct vfio_device_bind_iommufd bind =3D {
> +        .argsz =3D sizeof(bind),
> +        .flags =3D 0,
> +        .iommufd =3D container->be->fd,
> +    };
> +    struct vfio_device_attach_iommufd_pt attach_data =3D {
> +        .argsz =3D sizeof(attach_data),
> +        .flags =3D 0,
> +        .pt_id =3D container->ioas_id,
> +    };
> +    VFIOIOASHwpt *hwpt;
> +    int ret;
> +
> +    /*
> +     * Add device to kvm-vfio to be prepared for the tracking
> +     * in KVM. Especially for some emulated devices, it requires
> +     * to have kvm information in the device open.
> +     */
> +    vfio_kvm_device_add_device(vbasedev);
> +
> +    /* Bind device to iommufd */
> +    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> +    if (ret) {
> +        vfio_kvm_device_del_device(vbasedev);
> +        error_setg_errno(errp, errno, "error bind device fd=3D%d to iomm=
ufd=3D%d",
> +                         vbasedev->fd, bind.iommufd);
> +        return ret;
> +    }
> +
> +    vbasedev->devid =3D bind.out_devid;
> +    trace_vfio_iommufd_bind_device(bind.iommufd, vbasedev->name,
> +                                   vbasedev->fd, vbasedev->devid);
> +
> +    /* Attach device to an ioas within iommufd */
> +    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_d=
ata);
> +    if (ret) {
> +        vfio_kvm_device_del_device(vbasedev);
> +        error_setg_errno(errp, errno,
> +                         "[iommufd=3D%d] error attach %s (%d) to ioasid=
=3D%d",
> +                         container->be->fd, vbasedev->name, vbasedev->fd,
> +                         attach_data.pt_id);
> +        return ret;
> +
> +    }
> +    trace_vfio_iommufd_attach_device(bind.iommufd, vbasedev->name,
> +                                     vbasedev->fd, container->ioas_id,
> +                                     attach_data.pt_id);
> +
> +    hwpt =3D vfio_container_get_hwpt(container, attach_data.pt_id);
> +
> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, next);
> +    return 0;
> +}
> +
> +static void vfio_iommufd_container_destroy(VFIOIOMMUFDContainer *contain=
er)
> +{
> +    vfio_container_destroy(&container->bcontainer);
> +    g_free(container);
> +}
> +
> +static int vfio_ram_block_discard_disable(bool state)
> +{
> +    /*
> +     * We support coordinated discarding of RAM via the RamDiscardManage=
r.
> +     */
> +    return ram_block_uncoordinated_discard_disable(state);
> +}
> +
> +static void iommufd_detach_device(VFIODevice *vbasedev);
> +
> +static int iommufd_attach_device(char *name, VFIODevice *vbasedev,
> +                                 AddressSpace *as, Error **errp)
> +{
> +    VFIOIOMMUBackendOpsClass *ops =3D VFIO_IOMMU_BACKEND_OPS_CLASS(
> +        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
> +    VFIOContainer *bcontainer;
> +    VFIOIOMMUFDContainer *container;
> +    VFIOAddressSpace *space;
> +    struct vfio_device_info dev_info =3D { .argsz =3D sizeof(dev_info) };
> +    int ret, devfd;
> +    uint32_t ioas_id;
> +    Error *err =3D NULL;
> +
> +    devfd =3D vfio_get_devicefd(vbasedev->sysfsdev, errp);
> +    if (devfd < 0) {
> +        return devfd;
> +    }
> +    vbasedev->fd =3D devfd;
> +
> +    space =3D vfio_get_address_space(as);
> +
> +    /* try to attach to an existing container in this space */
> +    QLIST_FOREACH(bcontainer, &space->containers, next) {
> +        if (bcontainer->ops !=3D ops) {
> +            continue;
> +        }
> +        container =3D container_of(bcontainer, VFIOIOMMUFDContainer, bco=
ntainer);
> +        if (vfio_device_attach_container(vbasedev, container, &err)) {
> +            const char *msg =3D error_get_pretty(err);
> +
> +            trace_vfio_iommufd_fail_attach_existing_container(msg);
> +            error_free(err);
> +            err =3D NULL;
> +        } else {
> +            ret =3D vfio_ram_block_discard_disable(true);
> +            if (ret) {
> +                vfio_device_detach_container(vbasedev, container, &err);
> +                error_propagate(errp, err);
> +                vfio_put_address_space(space);
> +                close(vbasedev->fd);
> +                error_prepend(errp,
> +                              "Cannot set discarding of RAM broken (%d)"=
, ret);
> +                return ret;
> +            }
> +            goto out;
> +        }
> +    }
> +
> +    /* Need to allocate a new dedicated container */
> +    ret =3D iommufd_backend_get_ioas(vbasedev->iommufd, &ioas_id);
> +    if (ret < 0) {
> +        vfio_put_address_space(space);
> +        close(vbasedev->fd);
> +        error_report("Failed to alloc ioas (%s)", strerror(errno));
> +        return ret;
> +    }
> +
> +    trace_vfio_iommufd_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
> +
> +    container =3D g_malloc0(sizeof(*container));
> +    container->be =3D vbasedev->iommufd;
> +    container->ioas_id =3D ioas_id;
> +    QLIST_INIT(&container->hwpt_list);
> +
> +    bcontainer =3D &container->bcontainer;
> +    vfio_container_init(bcontainer, space, ops);
> +
> +    ret =3D vfio_device_attach_container(vbasedev, container, &err);
> +    if (ret) {
> +        /* todo check if any other thing to do */
> +        error_propagate(errp, err);
> +        vfio_iommufd_container_destroy(container);
> +        iommufd_backend_put_ioas(vbasedev->iommufd, ioas_id);
> +        vfio_put_address_space(space);
> +        close(vbasedev->fd);
> +        return ret;
> +    }
> +
> +    ret =3D vfio_ram_block_discard_disable(true);
> +    if (ret) {
> +        goto error;
> +    }
> +
> +    /*
> +     * TODO: for now iommufd BE is on par with vfio iommu type1, so it's
> +     * fine to add the whole range as window. For SPAPR, below code
> +     * should be updated.
> +     */
> +    vfio_host_win_add(bcontainer, 0, (hwaddr)-1, 4096);
> +    bcontainer->pgsizes =3D 4096;
> +
> +    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
> +
> +    bcontainer->listener =3D vfio_memory_listener;
> +
> +    memory_listener_register(&bcontainer->listener, bcontainer->space->a=
s);
> +
> +    bcontainer->initialized =3D true;
> +
> +out:
> +    vbasedev->container =3D bcontainer;
> +
> +    /*
> +     * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
> +     * for discarding incompatibility check as well?
> +     */
> +    if (vbasedev->ram_block_discard_allowed) {
> +        vfio_ram_block_discard_disable(false);
> +    }
> +
> +    ret =3D ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "error getting device info");
> +        memory_listener_unregister(&bcontainer->listener);
> +        QLIST_SAFE_REMOVE(bcontainer, next);
> +        goto error;
> +    }
> +
> +    vbasedev->group =3D 0;
> +    vbasedev->num_irqs =3D dev_info.num_irqs;
> +    vbasedev->num_regions =3D dev_info.num_regions;
> +    vbasedev->flags =3D dev_info.flags;
> +    vbasedev->reset_works =3D !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESE=
T);
> +
> +    trace_vfio_iommufd_device_info(vbasedev->name, devfd, vbasedev->num_=
irqs,
> +                                   vbasedev->num_regions, vbasedev->flag=
s);
> +    return 0;
> +error:
> +    vfio_device_detach_container(vbasedev, container, &err);
> +    error_propagate(errp, err);
> +    vfio_iommufd_container_destroy(container);
> +    iommufd_backend_put_ioas(vbasedev->iommufd, ioas_id);
> +    vfio_put_address_space(space);
> +    close(vbasedev->fd);
> +    return ret;
> +}
> +
> +static void iommufd_detach_device(VFIODevice *vbasedev)
> +{
> +    VFIOContainer *bcontainer =3D vbasedev->container;
> +    VFIOIOMMUFDContainer *container;
> +    VFIODevice *vbasedev_iter;
> +    VFIOIOASHwpt *hwpt;
> +    Error *err =3D NULL;
> +
> +    if (!bcontainer) {
> +        goto out;
> +    }
> +
> +    if (!vbasedev->ram_block_discard_allowed) {
> +        vfio_ram_block_discard_disable(false);
> +    }
> +
> +    container =3D container_of(bcontainer, VFIOIOMMUFDContainer, bcontai=
ner);
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        QLIST_FOREACH(vbasedev_iter, &hwpt->device_list, next) {
> +            if (vbasedev_iter =3D=3D vbasedev) {
> +                goto found;
> +            }
> +        }
> +    }
> +    g_assert_not_reached();
> +found:
> +    QLIST_REMOVE(vbasedev, next);
> +    if (QLIST_EMPTY(&hwpt->device_list)) {
> +        vfio_container_put_hwpt(hwpt);
> +    }
> +
> +    __vfio_device_detach_container(vbasedev, container, &err);
> +    if (err) {
> +        error_report_err(err);
> +    }
> +    if (QLIST_EMPTY(&container->hwpt_list)) {
> +        VFIOAddressSpace *space =3D bcontainer->space;
> +
> +        memory_listener_unregister(&bcontainer->listener);
> +        iommufd_backend_put_ioas(container->be, container->ioas_id);
> +        vfio_iommufd_container_destroy(container);
> +        vfio_put_address_space(space);
> +    }
> +    vbasedev->container =3D NULL;
> +out:
> +    close(vbasedev->fd);
> +    g_free(vbasedev->name);
> +}
> +
> +static void vfio_iommu_backend_iommufd_ops_class_init(ObjectClass *oc,
> +                                                     void *data) {
> +    VFIOIOMMUBackendOpsClass *ops =3D VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
> +
> +    ops->dma_map =3D iommufd_map;
> +    ops->dma_unmap =3D iommufd_unmap;
> +    ops->attach_device =3D iommufd_attach_device;
> +    ops->detach_device =3D iommufd_detach_device;
> +}
> +
> +static const TypeInfo vfio_iommu_backend_iommufd_ops_type =3D {
> +    .name =3D TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS,
> +
> +    .parent =3D TYPE_VFIO_IOMMU_BACKEND_OPS,
> +    .class_init =3D vfio_iommu_backend_iommufd_ops_class_init,
> +    .abstract =3D true,
> +};
> +static void vfio_iommu_backend_iommufd_ops_register_types(void)
> +{
> +    type_register_static(&vfio_iommu_backend_iommufd_ops_type);
> +}
> +type_init(vfio_iommu_backend_iommufd_ops_register_types);
> +
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index fd0dfd198a..326ff35749 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -7,6 +7,9 @@ vfio_ss.add(files(
>    'spapr.c',
>    'migration.c',
>  ))
> +if have_iommufd
> +  vfio_ss.add(files('iommufd.c'))
> +endif
>  vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>    'display.c',
>    'pci-quirks.c',
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 3f1a7e1c3e..4412c510e4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -167,3 +167,14 @@ vfio_save_setup(const char *name, uint64_t data_buff=
er_size) " (%s) data buffer
>  vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t=
 postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) =
precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" p=
recopy dirty size 0x%"PRIx64
>  vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t po=
stcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precop=
y_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size=
 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>  vfio_vmstate_change(const char *name, int running, const char *reason, c=
onst char *dev_state) " (%s) running %d reason %s device state %s"
> +
> +#iommufd.c
> +
> +vfio_iommufd_get_devicefd(const char *dev, int devfd) " %s (fd=3D%d)"
> +vfio_iommufd_bind_device(int iommufd, const char *name, int devfd, int d=
evid) " [iommufd=3D%d] Succesfully bound device %s (fd=3D%d): output devid=
=3D%d"
> +vfio_iommufd_attach_device(int iommufd, const char *name, int devfd, int=
 ioasid, int hwptid) " [iommufd=3D%d] Succesfully attached device %s (%d) t=
o ioasid=3D%d: output hwptd=3D%d"
> +vfio_iommufd_detach_device(int iommufd, const char *name, int ioasid) " =
[iommufd=3D%d] Detached %s from ioasid=3D%d"
> +vfio_iommufd_alloc_ioas(int iommufd, int ioas_id) " [iommufd=3D%d] new I=
OMMUFD container with ioasid=3D%d"
> +vfio_iommufd_device_info(char *name, int devfd, int num_irqs, int num_re=
gions, int flags) " %s (%d) num_irqs=3D%d num_regions=3D%d flags=3D%d"
> +vfio_iommufd_fail_attach_existing_container(const char *msg) " %s"
> +vfio_iommufd_container_reset(char *name) " Successfully reset %s"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 81a87d88b6..6434a442fd 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -85,6 +85,26 @@ typedef struct VFIOLegacyContainer {
>      QLIST_HEAD(, VFIOGroup) group_list;
>  } VFIOLegacyContainer;
> =20
> +#ifdef CONFIG_IOMMUFD
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
> +typedef struct IOMMUFDBackend IOMMUFDBackend;
> +
> +typedef struct VFIOIOMMUFDContainer {
> +    VFIOContainer bcontainer;
> +    IOMMUFDBackend *be;
> +    uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> +} VFIOIOMMUFDContainer;
> +#endif
> +
> +typedef QLIST_HEAD(VFIOAddressSpaceList, VFIOAddressSpace) VFIOAddressSp=
aceList;
> +extern VFIOAddressSpaceList vfio_address_spaces;
> +
>  typedef struct VFIODeviceOps VFIODeviceOps;
> =20
>  typedef struct VFIODevice {
> @@ -110,6 +130,10 @@ typedef struct VFIODevice {
>      OnOffAuto pre_copy_dirty_page_tracking;
>      bool dirty_pages_supported;
>      bool dirty_tracking;
> +#ifdef CONFIG_IOMMUFD
> +    int devid;
> +    IOMMUFDBackend *iommufd;
> +#endif
>  } VFIODevice;
> =20
>  struct VFIODeviceOps {
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio=
-container-base.h
> index b18fa92146..51aff4af05 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -117,6 +117,9 @@ void vfio_container_init(VFIOContainer *container,
>  void vfio_container_destroy(VFIOContainer *container);
> =20
>  #define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-op=
s"
> +#ifdef CONFIG_IOMMUFD
> +#define TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS "vfio-iommu-backend-iommufd-=
ops"
> +#endif
>  #define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
> =20
>  DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
> --=20
> 2.34.1
>=20
>=20

--=20

Joel Granados

--4ts7acx5whm3mmti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSxFAkACgkQupfNUreW
QU9YZQwAlFKf3u7G3qBBUqTfxNNRvXfV0tCz+9ZjjxGznFgRbTGD79mUiMKFrooV
pmuAIsChA/fxIaJlPR4uaYHSNy5/WnWjVdee9nVOCu3tLYCzvPU7nJsILeKSGvHG
OUN6HsYRUrdkRtj6iIQuGpFMn3nEHXCOwWd6YHyHQtUuEI+aFQyuExP/LshfAV32
6fP4ofraKRzLXdwvkTbd+fJhlYS6uQsNzW508bTtEme45CTulA6NFc1RE3w0PUw1
mM3FlhgctmmLTw39AtA/K0iRVGFNULC3F5DnumtPjIOCXj+BlFKZU14mUUuWRc4V
uLHwmdxn9+6swKVtGVnnaGoOmiCbIIs31U+CPtptjI6TlWDGNRv/jTinBpFDrpnE
Iw8oEPRWo2RfiSo7oYX+Qh9aPLuIvt6mDGJGeUrTaR4CTXPDJ9vqbFKJrhRgQ/n3
QNPWsUoaDtJJK8KIH9vkuouofL65CwYJ21TbftIywCINWn1QlSKbxTF6c/KgIdUb
FGuDpC0f
=deJF
-----END PGP SIGNATURE-----

--4ts7acx5whm3mmti--

