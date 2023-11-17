Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D757EF3E5
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 14:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zIN-0006Ld-1o; Fri, 17 Nov 2023 08:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3zIK-0006LR-Ps
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3zIH-0004pw-0E
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700229238;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqxopdpd/ArBnu474I3sYmZykxoMw559NjOsm+2Sx/g=;
 b=gBgl2EfS95zS61AzvfRuA7zLbO9deJEA3hUVxumDC8Gk5tsF+wtTTG026GoNcE/Gf1WXiE
 IbvZ+nFRt+KBqL7JAKMYztMN4aMCshbIo32Dz3D4V5oFOxUJvnqMzDJPh1Ol/ujNU2SMwq
 SX6h4GfJNtz0YrgKvZ7yyTpAkqpRICM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ABMvzufoM_iDC6e2tvNvVg-1; Fri, 17 Nov 2023 08:53:56 -0500
X-MC-Unique: ABMvzufoM_iDC6e2tvNvVg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66cffe51b07so23504846d6.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 05:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700229236; x=1700834036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqxopdpd/ArBnu474I3sYmZykxoMw559NjOsm+2Sx/g=;
 b=qUQE5YODpR7yRi3hNvTkjnCQsPqu9x6c1ZeDgqc9ZEcMTE/aWDfaZ/5ddi8Serv5th
 ua938C1a8BpGyzLn8z3gOuD6ow/lkQifKkuWjY5hxCmjvQ0KXS7Yj9crQuOb4Ol+XWCc
 tuFVxz11a4p88tVppJiujjCCq3pA2iVI/HIOSLbL562snZvntX6rM7K3xMzZmDb8yruw
 k9ce7GgtlTnk+RVUf8be0OegKqCGxpjLs4ULJiGuFX9cIMkUEtN1Lto7YUGUZkXeyl6n
 7kX7MF4PRS4NyFisCdNIPES/pzjE5qV6B2WHf9TzN5+WTX9LX927Vk453Kc6/111bZY+
 yoIA==
X-Gm-Message-State: AOJu0YzYkv7VpJJuVQIiJuwl5PSwBh63DqnD+D51rJSQjJBFjwOkxfMI
 8I6DqQDvUM8N5IvQvUF16WJ71cretyfI69kXtKavcH1RcHA+1SW/ehThOaZsOS/ZkBzQ1dsHKFz
 2M2NB7/D6uhiPjQQ=
X-Received: by 2002:a0c:fd8d:0:b0:671:a3db:c11d with SMTP id
 p13-20020a0cfd8d000000b00671a3dbc11dmr11517648qvr.24.1700229236055; 
 Fri, 17 Nov 2023 05:53:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPZ/3fBxvECP9RHkFxy46+DEmgBxfaTIn+gencrmjLDv3rIhw+j4vZKrmW4nr0mFyWFWAEgw==
X-Received: by 2002:a0c:fd8d:0:b0:671:a3db:c11d with SMTP id
 p13-20020a0cfd8d000000b00671a3dbc11dmr11517636qvr.24.1700229235706; 
 Fri, 17 Nov 2023 05:53:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ml18-20020a056214585200b00655e2005350sm643024qvb.9.2023.11.17.05.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 05:53:54 -0800 (PST)
Message-ID: <cbc7ab3f-bffb-4626-bc64-3c258dc610ec@redhat.com>
Date: Fri, 17 Nov 2023 14:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/21] vfio/iommufd: Enable pci hot reset through
 iommufd cdev interface
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/14/23 11:09, Zhenzhong Duan wrote:
> Add a new callback iommufd_cdev_pci_hot_reset to do iommufd specific
> check and reset operation.

nit: Implement the newly introduced pci_hot_reset callback?
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v6: pci_hot_reset return -errno if fails
>
>  hw/vfio/iommufd.c    | 145 +++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   1 +
>  2 files changed, 146 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e5bf528e89..3eec428162 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -24,6 +24,7 @@
>  #include "sysemu/reset.h"
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
> +#include "pci.h"
>  
>  static int iommufd_cdev_map(VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> @@ -473,9 +474,153 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>      close(vbasedev->fd);
>  }
>  
> +static VFIODevice *iommufd_cdev_pci_find_by_devid(__u32 devid)
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
> +static int iommufd_cdev_pci_hot_reset(VFIODevice *vbasedev, bool single)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
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
> +        trace_iommufd_cdev_pci_hot_reset_dep_devices(devices[i].segment,
> +                                                     devices[i].bus,
> +                                                     PCI_SLOT(devices[i].devfn),
> +                                                     PCI_FUNC(devices[i].devfn),
> +                                                     devices[i].devid);
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
> +        vbasedev_iter = iommufd_cdev_pci_find_by_devid(devices[i].devid);
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
> +    if (ret) {
> +        ret = -errno;
> +    }
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
> +        vbasedev_iter = iommufd_cdev_pci_find_by_devid(devices[i].devid);
> +        if (!vbasedev_iter || !vbasedev_iter->dev->realized ||
> +            vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +            continue;
> +        }
> +        tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
nit: I see this block of code also is used above for the pre_reset. May
be interesting to introduce an helper? Could be done later though
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
> +
>  const VFIOIOMMUOps vfio_iommufd_ops = {
>      .dma_map = iommufd_cdev_map,
>      .dma_unmap = iommufd_cdev_unmap,
>      .attach_device = iommufd_cdev_attach,
>      .detach_device = iommufd_cdev_detach,
> +    .pci_hot_reset = iommufd_cdev_pci_hot_reset,
>  };
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 5d3e9e8cee..d838232d5a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -174,3 +174,4 @@ iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name, const char *str, in
>  iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
>  iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
>  iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
> +iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
Otherwise looks good to me.

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric




