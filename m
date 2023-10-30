Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DB7DBB60
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxStM-0002wQ-5d; Mon, 30 Oct 2023 10:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxStC-0002u1-NR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSt8-0003Yg-D8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698674704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uT1BK3r2QeqGwi7QBObBkrFAiRhzWsWYvdaEev5D+gA=;
 b=QGrIEmcGCy/MmHdOJMdcPqwsywUmpBVLKpjwu9rAqEZZLstGuZyaMvhFGRXB/Zb94MpMQX
 +LB/iyv/EqMDN1u5DHcFVGy333sgoCQm0CVOuMotHHyC3lI9p7qIGlDyP9VTUVOtUT3omJ
 rKzoxfM95k6u28nw4/nhldtmRNHsB0E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-vw-vakzeOjajt5AA825pGw-1; Mon, 30 Oct 2023 10:05:03 -0400
X-MC-Unique: vw-vakzeOjajt5AA825pGw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7789577b4e0so582784885a.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698674702; x=1699279502;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uT1BK3r2QeqGwi7QBObBkrFAiRhzWsWYvdaEev5D+gA=;
 b=CZe2Z/oUjS8F1vsKq0+8sIrP1OgKzliFsXY00QXOX0gVNoha9Z5FU/Ymlwex59QqZk
 TvhDITeZmPrVA3PRC3iHJBEHrzNtLIsUTIj9HGwdtt9Jl+yezI+qZ9WSFy+t9ce/XjhS
 zXXf9Fj/GBSaMRPYmmCcJrSsOFu99kq3dI+6clzKzXEO7KVVm1UenlM4kYD09U3FUCow
 1VtzrHAEdq1FfnwXWfJsQuTImN9PdQxvodq95GVMoI7eghfaf6PPcpN1nAim3ZhclHLO
 4OjeIgiNUmBbwG/SLuJlkurVMO5m0UQjbqt4T5hBhx87h0BlSiX0A4ATai5axq62PY+r
 J0lQ==
X-Gm-Message-State: AOJu0YwRSKZOWVfQ6T3p73zlhhEDdM1gVRfPI+8R4ov+dJZwEBj9p1lW
 bCuslwp/ajfiNPZEMHwZViFSQ4DFhkmDnMno5Jml1s/s++RZ+JuQiqppPrsPZUHovQXuOR1Lphg
 dyUTH2TJPUHMVDA4=
X-Received: by 2002:a05:620a:6584:b0:778:9692:f20b with SMTP id
 qd4-20020a05620a658400b007789692f20bmr8853592qkn.72.1698674701778; 
 Mon, 30 Oct 2023 07:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBAPzVsCmmrSB+7rn2wnu+0kXHOP/wFYUS3ZYMdUgFvKHC5BOlQa99xpCsMUoOp7n/aM4KuA==
X-Received: by 2002:a05:620a:6584:b0:778:9692:f20b with SMTP id
 qd4-20020a05620a658400b007789692f20bmr8853565qkn.72.1698674701487; 
 Mon, 30 Oct 2023 07:05:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 m12-20020ae9e70c000000b007770673e757sm3338314qka.94.2023.10.30.07.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 07:05:01 -0700 (PDT)
Message-ID: <c249da92-ddb4-432c-b4db-66ed1de3f498@redhat.com>
Date: Mon, 30 Oct 2023 15:04:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/37] vfio/pci: Adapt vfio pci hot reset support with
 iommufd BE
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-32-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-32-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> As pci hot reset path need to reference pci specific functions
> and data structures, adding container level callback functions
> for legacy and iommufd BE and referencing those pci specific
> func/data is no better than implementing reset support with
> iommufd BE directly in pci.c

yes but it includes a large section of IOMMUFD code in pci.c
which is ugly. Please make this an VFIOIOMMUOps handler instead.

Thanks,

C.

> 
> This way we can also share the common bus reset and system reset
> path for both BEs.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c        | 156 ++++++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/trace-events |   1 +
>   2 files changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c17e1f4376..d7a41c8def 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -42,6 +42,7 @@
>   #include "qapi/error.h"
>   #include "migration/blocker.h"
>   #include "migration/qemu-file.h"
> +#include "linux/iommufd.h"
>   
>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>   
> @@ -2497,7 +2498,7 @@ static int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>       return 0;
>   }
>   
> -static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +static int vfio_pci_hot_reset_legacy(VFIOPCIDevice *vdev, bool single)
>   {
>       VFIOGroup *group;
>       struct vfio_pci_hot_reset_info *info = NULL;
> @@ -2661,6 +2662,159 @@ out_single:
>       return ret;
>   }
>   
> +#ifdef CONFIG_IOMMUFD
> +static VFIODevice *vfio_pci_find_by_iommufd_devid(__u32 devid)
> +{
> +    VFIODevice *vbasedev_iter;
> +
> +    QLIST_FOREACH(vbasedev_iter, &vfio_device_list, global_next) {
> +        if (vbasedev_iter->bcontainer->ops != &vfio_iommufd_ops) {
> +            continue;
> +        }
> +        if (devid == vbasedev_iter->devid) {
> +            return vbasedev_iter;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static int vfio_pci_hot_reset_iommufd(VFIOPCIDevice *vdev, bool single)
> +{
> +    struct vfio_pci_hot_reset_info *info = NULL;
> +    struct vfio_pci_dependent_device *devices;
> +    struct vfio_pci_hot_reset *reset;
> +    int ret, i;
> +    bool multi = false;
> +
> +    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
> +
> +    if (!single) {
> +        vfio_pci_pre_reset(vdev);
> +    }
> +    vdev->vbasedev.needs_reset = false;
> +
> +    ret = vfio_pci_get_pci_hot_reset_info(vdev, &info);
> +
> +    if (ret) {
> +        goto out_single;
> +    }
> +
> +    assert(info->flags & VFIO_PCI_HOT_RESET_FLAG_DEV_ID);
> +
> +    devices = &info->devices[0];
> +
> +    if (!(info->flags & VFIO_PCI_HOT_RESET_FLAG_DEV_ID_OWNED)) {
> +        if (!vdev->has_pm_reset) {
> +            for (i = 0; i < info->count; i++) {
> +                if (devices[i].devid == VFIO_PCI_DEVID_NOT_OWNED) {
> +                    error_report("vfio: Cannot reset device %s, "
> +                                 "depends on device %04x:%02x:%02x.%x "
> +                                 "which is not owned.",
> +                                 vdev->vbasedev.name, devices[i].segment,
> +                                 devices[i].bus, PCI_SLOT(devices[i].devfn),
> +                                 PCI_FUNC(devices[i].devfn));
> +                }
> +            }
> +        }
> +        ret = -EPERM;
> +        goto out_single;
> +    }
> +
> +    trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
> +
> +    for (i = 0; i < info->count; i++) {
> +        VFIOPCIDevice *tmp;
> +        VFIODevice *vbasedev_iter;
> +
> +        trace_vfio_pci_hot_reset_dep_devices_iommufd(devices[i].segment,
> +                                             devices[i].bus,
> +                                             PCI_SLOT(devices[i].devfn),
> +                                             PCI_FUNC(devices[i].devfn),
> +                                             devices[i].devid);
> +
> +        /*
> +         * If a VFIO cdev device is resettable, all the dependent devices
> +         * are either bound to same iommufd or within same iommu_groups as
> +         * one of the iommufd bound devices.
> +         */
> +        assert(devices[i].devid != VFIO_PCI_DEVID_NOT_OWNED);
> +
> +        if (devices[i].devid == vdev->vbasedev.devid ||
> +            devices[i].devid == VFIO_PCI_DEVID_OWNED) {
> +            continue;
> +        }
> +
> +        vbasedev_iter = vfio_pci_find_by_iommufd_devid(devices[i].devid);
> +        if (!vbasedev_iter || !vbasedev_iter->dev->realized ||
> +            vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +            continue;
> +        }
> +        tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> +        if (single) {
> +            ret = -EINVAL;
> +            goto out_single;
> +        }
> +        vfio_pci_pre_reset(tmp);
> +        tmp->vbasedev.needs_reset = false;
> +        multi = true;
> +    }
> +
> +    if (!single && !multi) {
> +        ret = -EINVAL;
> +        goto out_single;
> +    }
> +
> +    /* Use zero length array for hot reset with iommufd backend */
> +    reset = g_malloc0(sizeof(*reset));
> +    reset->argsz = sizeof(*reset);
> +
> +     /* Bus reset! */
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_HOT_RESET, reset);
> +    g_free(reset);
> +
> +    trace_vfio_pci_hot_reset_result(vdev->vbasedev.name,
> +                                    ret ? strerror(errno) : "Success");
> +
> +    /* Re-enable INTx on affected devices */
> +    for (i = 0; i < info->count; i++) {
> +        VFIOPCIDevice *tmp;
> +        VFIODevice *vbasedev_iter;
> +
> +        if (devices[i].devid == vdev->vbasedev.devid ||
> +            devices[i].devid == VFIO_PCI_DEVID_OWNED) {
> +            continue;
> +        }
> +
> +        vbasedev_iter = vfio_pci_find_by_iommufd_devid(devices[i].devid);
> +        if (!vbasedev_iter || !vbasedev_iter->dev->realized ||
> +            vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +            continue;
> +        }
> +        tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> +        vfio_pci_post_reset(tmp);
> +    }
> +out_single:
> +    if (!single) {
> +        vfio_pci_post_reset(vdev);
> +    }
> +    g_free(info);
> +
> +    return ret;
> +}
> +#endif
> +
> +static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +{
> +#ifdef CONFIG_IOMMUFD
> +    if (vdev->vbasedev.iommufd) {
> +        return vfio_pci_hot_reset_iommufd(vdev, single);
> +    } else
> +#endif
> +    {
> +        return vfio_pci_hot_reset_legacy(vdev, single);
> +    }
> +}> +
>   /*
>    * We want to differentiate hot reset of multiple in-use devices vs hot reset
>    * of a single in-use device.  VFIO_DEVICE_RESET will already handle the case
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 9b180cf77c..71c5840636 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -34,6 +34,7 @@ vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
>   vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
>   vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
>   vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
> +vfio_pci_hot_reset_dep_devices_iommufd(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
>   vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
>   vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
>   vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"


