Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2D7EB1A0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:09:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2u5Z-0007a4-Vf; Tue, 14 Nov 2023 09:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u5X-0007ZH-Js
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2u5V-0001ek-LT
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699970900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3V4wtnJyeFNk1PCXQbiI3NYvxm036kHcYqm4lGEkyDU=;
 b=MxnTHrq9mjlOG8fmUcsyKi3K5Lee9UtueHbGO+S2RCNVL0Z70vFkldxIxcR6GcwaU0Yl8F
 2Goe3j9x4mLwb/bKUxLllcYQEtJ09IXAjis1mS+5W5N+0onSy2scCJFyIJxu9frThMDhSV
 oH3rSnm//KiKXmTBDzBWnRdvJyyX/Fg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-ZxDGiSd9NxWnE3LNJ9FAvg-1; Tue, 14 Nov 2023 09:08:19 -0500
X-MC-Unique: ZxDGiSd9NxWnE3LNJ9FAvg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77a12fbe7eeso698782285a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699970899; x=1700575699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3V4wtnJyeFNk1PCXQbiI3NYvxm036kHcYqm4lGEkyDU=;
 b=PLt91cc60EMqHKRzQ1U4Br/W6TsaXCr2Y1NwygC5ICKUMEt4b1uHixDCxjIU+4wCdi
 55lyyhW23ADGaBOlxH+Q614NP/bQy1ZcVZJUvxc5sZ7dbf9OJ4MQYmfCTE8Dc8zfxK0n
 fItvLW0ujFMEZqi7CWK9MGINUALXboUrJkR1Lx1J71dojTjUPpZ8kM/KsInsyIO2Nv6M
 AD7YjWsZVeWiDNT62wOAr8bsC0rErlp7Z4oNja/kZ3Aw/jfkRNc4QGNL63WmEoQiaFGV
 +I9uWJMeN73rjvDb/hn54iNDyqPzPeW5U6eI3dWhRfbq4TQN1e49irM0L7pwtiUbp/bM
 1zpw==
X-Gm-Message-State: AOJu0Yw33oTlC9WRxt1jdPsWVQMM4ygKBd0LVNZKN8xMTtoVUI5f2/6P
 Hi+aRizHYu+9gNvlK8tkA2Rp8qJUXoitXPfbsie4uHLonA+bHNyJVMyahwctyWtdBvr9zaAcuM9
 IAm0aBznc0XH5/Gw=
X-Received: by 2002:a05:620a:27d4:b0:76f:8c6:a537 with SMTP id
 i20-20020a05620a27d400b0076f08c6a537mr2495192qkp.77.1699970898961; 
 Tue, 14 Nov 2023 06:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiIYOyJAHTvbYEwLSLUP8T6CwkxkHjOa1eDxGBtz49DX7APZHBz+hyWUEW+2zyoFw1ocFZQw==
X-Received: by 2002:a05:620a:27d4:b0:76f:8c6:a537 with SMTP id
 i20-20020a05620a27d400b0076f08c6a537mr2495171qkp.77.1699970898673; 
 Tue, 14 Nov 2023 06:08:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q26-20020ae9e41a000000b0076f12fcb0easm2671941qkc.2.2023.11.14.06.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:08:18 -0800 (PST)
Message-ID: <dbbf0f56-c296-43fa-ace7-4a500a683f47@redhat.com>
Date: Tue, 14 Nov 2023 15:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-12-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/14/23 11:09, Zhenzhong Duan wrote:
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Together with the earlier support of pre-opening /dev/iommu device,
> now we have full support of passing a vfio device to unprivileged
> qemu by management tool. This mode is no more considered for the
> legacy backend. So let's remove the "TODO" comment.
> 
> Add helper functions vfio_device_set_fd() and vfio_device_get_name()
> to set fd and get device name, they will also be used by other vfio
> devices.
> 
> There is no easy way to check if a device is mdev with FD passing,
> so fail the x-balloon-allowed check unconditionally in this case.
> 
> There is also no easy way to get BDF as name with FD passing, so
> we fake a name by VFIO_FD[fd].
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v6: simplify CONFIG_IOMMUFD checking code
>      introduce a helper vfio_device_set_fd
> 
>   include/hw/vfio/vfio-common.h |  3 +++
>   hw/vfio/helpers.c             | 44 +++++++++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c             | 12 ++++++----
>   hw/vfio/pci.c                 | 28 ++++++++++++----------
>   4 files changed, 71 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3dac5c167e..567e5f7bea 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -251,4 +251,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
>                                       hwaddr size);
>   int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
>                                    uint64_t size, ram_addr_t ram_addr);
> +
> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> +void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   #endif /* HW_VFIO_VFIO_COMMON_H */
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 168847e7c5..986ef1095a 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */

Unused now. I removed it.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

>   #include <sys/ioctl.h>
>   
>   #include "hw/vfio/vfio-common.h"
> @@ -27,6 +28,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "monitor/monitor.h"
>   
>   /*
>    * Common VFIO interrupt disable
> @@ -609,3 +611,45 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   
>       return ret;
>   }
> +
> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct stat st;
> +
> +    if (vbasedev->fd < 0) {
> +        if (stat(vbasedev->sysfsdev, &st) < 0) {
> +            error_setg_errno(errp, errno, "no such host device");
> +            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
> +            return -errno;
> +        }
> +        /* User may specify a name, e.g: VFIO platform device */
> +        if (!vbasedev->name) {
> +            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
> +        }
> +    } else {
> +        if (!vbasedev->iommufd) {
> +            error_setg(errp, "Use FD passing only with iommufd backend");
> +            return -EINVAL;
> +        }
> +        /*
> +         * Give a name with fd so any function printing out vbasedev->name
> +         * will not break.
> +         */
> +        if (!vbasedev->name) {
> +            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
> +{
> +    int fd = monitor_fd_param(monitor_cur(), str, errp);
> +
> +    if (fd < 0) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;
> +    }
> +    vbasedev->fd = fd;
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3eec428162..e08a217057 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -326,11 +326,15 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       uint32_t ioas_id;
>       Error *err = NULL;
>   
> -    devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
> -    if (devfd < 0) {
> -        return devfd;
> +    if (vbasedev->fd < 0) {
> +        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
> +        if (devfd < 0) {
> +            return devfd;
> +        }
> +        vbasedev->fd = devfd;
> +    } else {
> +        devfd = vbasedev->fd;
>       }
> -    vbasedev->fd = devfd;
>   
>       ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
>       if (ret) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c5984b0598..b23b492cce 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2944,17 +2944,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       char *tmp, *subsys;
>       Error *err = NULL;
> -    struct stat st;
>       int i, ret;
>       bool is_mdev;
>       char uuid[UUID_STR_LEN];
>       char *name;
>   
> -    if (!vbasedev->sysfsdev) {
> +    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
>                 ~vdev->host.slot || ~vdev->host.function)) {
>               error_setg(errp, "No provided host device");
>               error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
> +#ifdef CONFIG_IOMMUFD
> +                              "or -device vfio-pci,fd=DEVICE_FD "
> +#endif
>                                 "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>               return;
>           }
> @@ -2964,13 +2966,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                               vdev->host.slot, vdev->host.function);
>       }
>   
> -    if (stat(vbasedev->sysfsdev, &st) < 0) {
> -        error_setg_errno(errp, errno, "no such host device");
> -        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
> +    if (vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
> -
> -    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>       vbasedev->ops = &vfio_pci_ops;
>       vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>       vbasedev->dev = DEVICE(vdev);
> @@ -3330,6 +3328,7 @@ static void vfio_instance_init(Object *obj)
>       vdev->host.bus = ~0U;
>       vdev->host.slot = ~0U;
>       vdev->host.function = ~0U;
> +    vdev->vbasedev.fd = -1;
>   
>       vdev->nv_gpudirect_clique = 0xFF;
>   
> @@ -3383,11 +3382,6 @@ static Property vfio_pci_dev_properties[] = {
>                                      qdev_prop_nv_gpudirect_clique, uint8_t),
>       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
>                                   OFF_AUTOPCIBAR_OFF),
> -    /*
> -     * TODO - support passed fds... is this necessary?
> -     * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
> -     * DEFINE_PROP_STRING("vfiogroupfd, VFIOPCIDevice, vfiogroupfd_name),
> -     */
>   #ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> @@ -3395,6 +3389,13 @@ static Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +#ifdef CONFIG_IOMMUFD
> +static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
> +}
> +#endif
> +
>   static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3402,6 +3403,9 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>   
>       dc->reset = vfio_pci_reset;
>       device_class_set_props(dc, vfio_pci_dev_properties);
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
> +#endif
>       dc->desc = "VFIO-based PCI device assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       pdc->realize = vfio_realize;


