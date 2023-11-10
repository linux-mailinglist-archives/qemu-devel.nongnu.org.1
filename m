Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D547E7B83
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1P86-000211-85; Fri, 10 Nov 2023 05:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1P85-00020s-0Z
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:52:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1P83-0005zO-1o
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699613566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2zYpv4LGpG6QINOzlwjpDU/HzAPDlqtkX+Ow47oAC0=;
 b=Dew4JEuGtFktKoGtJe9eh217xGGxsYLr3aWmGK9jLLd6y/REcXH5GjAuY2PNIfEiX51faQ
 dSfybus7d+htmUziClL3iRvQym0esa4r892LVFXdlR4dhC92LJHqUxnvDunqfSi0BXNDDy
 zCEAXTXN9jAleF7qjhPnnmeA8zUehBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-ASAR-pKtPje9t4Id-m45iQ-1; Fri, 10 Nov 2023 05:52:45 -0500
X-MC-Unique: ASAR-pKtPje9t4Id-m45iQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67012b06439so20516766d6.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 02:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699613565; x=1700218365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S2zYpv4LGpG6QINOzlwjpDU/HzAPDlqtkX+Ow47oAC0=;
 b=HOa1Rub0A3r26C+HjYs/x7pkSJhfSZHlU6QWiBUt19j2/P0q8vYxNXGCAL+F2U9fi6
 fjzP0AQ2ljQg6YN+AZEfKmRui4q4xO0ukcm09qRj8GgZK24bIdFG6SP/q5Od+7OVD9e6
 rjcMAkEaV4d2hAEfnODdQfrQ1g3JvexniEe596/HYi/k4sDRlfrI+iKJG0uXqy1zOvbB
 fTtuI60o3WjVKHpudwYUu1FWf+K/bPyq2oqMT2yApbIs3Ey4AW4GcX2/nrp7UtFVpvcp
 dHDxXu1ogASvcpsaGwHo2CmBYuf8ffa+zkMsFA8OzBIgf7utGjvhdD6GteCZyEs+Uhuy
 CfNg==
X-Gm-Message-State: AOJu0Yy8BXrczHBB7Sl1/mzOeDQvi46DoL0R4wUMa57o40+0S1IBrNl7
 FTLHhkqC73Ib9rjHxL76yocYMWKv1DRRfV3nbbjMA/SZrM9xuhTyw/1hqoIwPfnUqS+1Sbb3Yk+
 +jFeV4kvVUQq3zrE=
X-Received: by 2002:a05:6214:f29:b0:658:49bb:f78f with SMTP id
 iw9-20020a0562140f2900b0065849bbf78fmr8639796qvb.39.1699613564819; 
 Fri, 10 Nov 2023 02:52:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZNZsPcfrTADoH9gqkqQIOfW5yPylKIX/2o8TeCEv99aCwfcoulgJmSnqy/ZQTEsCbzKbVpw==
X-Received: by 2002:a05:6214:f29:b0:658:49bb:f78f with SMTP id
 iw9-20020a0562140f2900b0065849bbf78fmr8639778qvb.39.1699613564504; 
 Fri, 10 Nov 2023 02:52:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05621401ea00b0065b11053445sm2848260qvu.54.2023.11.10.02.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 02:52:44 -0800 (PST)
Message-ID: <07539cb1-2262-4ae9-82ea-cfb7b9b8f2d5@redhat.com>
Date: Fri, 10 Nov 2023 11:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/20] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-11-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231109114529.1904193-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/9/23 12:45, Zhenzhong Duan wrote:
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Together with the earlier support of pre-opening /dev/iommu device,
> now we have full support of passing a vfio device to unprivileged
> qemu by management tool. This mode is no more considered for the
> legacy backend. So let's remove the "TODO" comment.
> 
> Add a helper function vfio_device_get_name() to check fd and get
> device name, it will also be used by other vfio devices.
> 
> There is no easy way to check if a device is mdev with FD passing,
> so fail the x-balloon-allowed check unconditionally in this case.
> 
> There is also no easy way to get BDF as name with FD passing, so
> we fake a name by VFIO_FD[fd].
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/helpers.c             | 34 +++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c             | 12 +++++++----
>   hw/vfio/pci.c                 | 40 ++++++++++++++++++++++++-----------
>   4 files changed, 71 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3dac5c167e..960a14e8d8 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -238,6 +238,7 @@ struct vfio_info_cap_header *
>   vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>   struct vfio_info_cap_header *
>   vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   #endif
>   
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 168847e7c5..d80aa58719 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <sys/ioctl.h>
>   
>   #include "hw/vfio/vfio-common.h"
> @@ -609,3 +610,36 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
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
> +    }
> +#ifdef CONFIG_IOMMUFD
> +    else {
> +        if (!vbasedev->iommufd) {


Can we handle with this case without CONFIG_IOMMUFD, simply by
testing vbasedev->iommufd ?

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
> +#endif
> +    return 0;
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 44dc6848bf..fd30477275 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -326,11 +326,15 @@ static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
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
>       ret = iommufd_connect_and_bind(vbasedev, errp);
>       if (ret) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e9a426200b..f95725ed16 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,6 +44,7 @@
>   #include "migration/blocker.h"
>   #include "migration/qemu-file.h"
>   #include "sysemu/iommufd.h"
> +#include "monitor/monitor.h"
>   
>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>   
> @@ -2934,18 +2935,23 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
> +#ifdef CONFIG_IOMMUFD
> +            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F, "
> +                              "-device vfio-pci,sysfsdev=PATH_TO_DEVICE "
> +                              "or -device vfio-pci,fd=DEVICE_FD\n");
> +#else
>               error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
>                                 "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
> +#endif

or simply :


                error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
  +#ifdef CONFIG_IOMMUFD
  +                              "or -device vfio-pci,fd=DEVICE_FD "
  +#endif
                                  "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");



>               return;
>           }
>           vbasedev->sysfsdev =
> @@ -2954,13 +2960,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
> @@ -3320,6 +3322,7 @@ static void vfio_instance_init(Object *obj)
>       vdev->host.bus = ~0U;
>       vdev->host.slot = ~0U;
>       vdev->host.function = ~0U;
> +    vdev->vbasedev.fd = -1;
We should probably move the all VFIODevice initializations :

     vbasedev->ops = &vfio_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);

under vfio_instance_init (should be called vfio_pci_instance_init).

This is true for all other VFIO devices. May be not for this series,
it can come later.


>   
>       vdev->nv_gpudirect_clique = 0xFF;
>   
> @@ -3373,11 +3376,6 @@ static Property vfio_pci_dev_properties[] = {
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
> @@ -3385,6 +3383,21 @@ static Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +#ifdef CONFIG_IOMMUFD
> +static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    int fd = -1;
> +
> +    fd = monitor_fd_param(monitor_cur(), str, errp);
> +    if (fd == -1) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;
> +    }
> +    vdev->vbasedev.fd = fd;

We could introduce a common helper in hw/vfio/common.c to remove code
duplication :

#ifdef CONFIG_IOMMUFD
static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
{
     vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
}
#endif
  

Thanks,

C.



> +}
> +#endif
> +
>   static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3392,6 +3405,9 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>   
>       dc->reset = vfio_pci_reset;
>       device_class_set_props(dc, vfio_pci_dev_properties);
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
> +#endif
>       dc->desc = "VFIO-based PCI device assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       pdc->realize = vfio_realize;


