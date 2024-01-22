Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5E836CC6
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:16:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxtb-00015p-BT; Mon, 22 Jan 2024 12:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRxtI-0000sN-Pj
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRxtG-0007xe-Dh
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705943717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTkouqRkDKfZgGDCn5ld0KQ+Ci4ne23WRqtapmhK+HY=;
 b=anxNaueCc8xzH7Ksec9ROw6j0b0AN63KzP4uYr6fYkLou5T69WPknhAe/DnjT2wMZhK2Ek
 N4vkK/bCtiuolvoofasvucSkxBAfdEtcNI/koo5c9TT4KN7rHbvicDfDkhhMfQwRfsHq2F
 nmHXTNPCtMprEMKv8AEh6mAq5Bb+eQA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-UcdmkxfgNQyuPj_bo2ORhw-1; Mon, 22 Jan 2024 12:15:15 -0500
X-MC-Unique: UcdmkxfgNQyuPj_bo2ORhw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6de58170ceeso4539645a34.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943714; x=1706548514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTkouqRkDKfZgGDCn5ld0KQ+Ci4ne23WRqtapmhK+HY=;
 b=wizH/pFh0AGTUVxnZmnzumM2wJJzyP+2tl6CkQ9unxOAEHT6rM/YD4O9gv5ShhufJe
 pjSa3GgRzsWX65Y2m4aOYKWLf9pQHqKTiPXIJJNJG944PMYhJSyTtm1rTUxtIQnYmE0m
 61qLpMJidiDfWbZ+/fdVYN8epjHo0aZoTxWOmkpA4R7A1Q6P0PDSTSAB980YPrYa9T34
 YXjPU8Q+avotbdRtkBqTVxCRvnwP7EuHEHFXEgprwfbeB/G/Gc4VfF9fyBsRqbkijXul
 Q/8dms8cxWAF5agVWluWPX3NwQSGhBP0E7Lzn82fEdgafinKy6zAwFL9fPyvLyDQEVln
 yC/A==
X-Gm-Message-State: AOJu0Yz3LVsSFfEQt/D2n2FthxSwk7cys5sEl/5ceI/ImxifmmfiZ5Me
 frwlWveZlMAPj4yhvGux/9rHH2ScGK4VZzaAc2AGWT/JwiSgHeIlVjdDF5NFLHFuQNbkTBns2Bz
 13GvkHz9WtZ6lv4fA1EErlY7QC2I5WEE1FrbN9D/pNBqNIzfDXhYj
X-Received: by 2002:a05:6358:3413:b0:175:c179:7515 with SMTP id
 h19-20020a056358341300b00175c1797515mr3650851rwd.46.1705943714733; 
 Mon, 22 Jan 2024 09:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrCczHhHlIH1Nu3XvjhDQ47tEI0VOxUneQOuhBHfY4nvs95/Xb2lUnoLoMgTfFQWgvepGiew==
X-Received: by 2002:a05:6358:3413:b0:175:c179:7515 with SMTP id
 h19-20020a056358341300b00175c1797515mr3650839rwd.46.1705943714443; 
 Mon, 22 Jan 2024 09:15:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a0cc247000000b006854ec9dbabsm2535506qvh.92.2024.01.22.09.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 09:15:13 -0800 (PST)
Message-ID: <852e8e08-1d82-49d4-a19c-36a6b256d662@redhat.com>
Date: Mon, 22 Jan 2024 18:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240115101313.131139-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/15/24 11:13, Zhenzhong Duan wrote:
> Initialize IOMMUFDDevice in vfio and pass to vIOMMU, so that vIOMMU
> could get hw IOMMU information.
> 
> In VFIO legacy backend mode, we still pass a NULL IOMMUFDDevice to vIOMMU,
> in case vIOMMU needs some processing for VFIO legacy backend mode.
> 
> Originally-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/iommufd.c             |  2 ++
>   hw/vfio/pci.c                 | 24 +++++++++++++++++++-----
>   3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9b7ef7d02b..fde0d0ca60 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -31,6 +31,7 @@
>   #endif
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
> +#include "sysemu/iommufd_device.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -126,6 +127,7 @@ typedef struct VFIODevice {
>       bool dirty_tracking;
>       int devid;
>       IOMMUFDBackend *iommufd;
> +    IOMMUFDDevice idev;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9bfddc1360..cbd035f148 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       VFIOContainerBase *bcontainer;
>       VFIOIOMMUFDContainer *container;
>       VFIOAddressSpace *space;
> +    IOMMUFDDevice *idev = &vbasedev->idev;
>       struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>       int ret, devfd;
>       uint32_t ioas_id;
> @@ -428,6 +429,7 @@ found_container:
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>   
> +    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid);
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
>       return 0;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7fe06715c..2c3a5d267b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3107,11 +3107,21 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       vfio_bars_register(vdev);
>   
> -    ret = vfio_add_capabilities(vdev, errp);
> +    if (vbasedev->iommufd) {
> +        ret = pci_device_set_iommu_device(pdev, &vbasedev->idev, errp);
> +    } else {
> +        ret = pci_device_set_iommu_device(pdev, 0, errp);


AFAICT, pci_device_set_iommu_device() with a NULL IOMMUFDDevice will do
nothing. Why call it ?


Thanks,

C.



> +    }
>       if (ret) {
> +        error_prepend(errp, "Failed to set iommu_device: ");
>           goto out_teardown;
>       }
>   
> +    ret = vfio_add_capabilities(vdev, errp);
> +    if (ret) {
> +        goto out_unset_idev;
> +    }
> +
>       if (vdev->vga) {
>           vfio_vga_quirk_setup(vdev);
>       }
> @@ -3128,7 +3138,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>               error_setg(errp,
>                          "cannot support IGD OpRegion feature on hotplugged "
>                          "device");
> -            goto out_teardown;
> +            goto out_unset_idev;
>           }
>   
>           ret = vfio_get_dev_region_info(vbasedev,
> @@ -3137,13 +3147,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           if (ret) {
>               error_setg_errno(errp, -ret,
>                                "does not support requested IGD OpRegion feature");
> -            goto out_teardown;
> +            goto out_unset_idev;
>           }
>   
>           ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
>           g_free(opregion);
>           if (ret) {
> -            goto out_teardown;
> +            goto out_unset_idev;
>           }
>       }
>   
> @@ -3229,6 +3239,8 @@ out_deregister:
>       if (vdev->intx.mmap_timer) {
>           timer_free(vdev->intx.mmap_timer);
>       }
> +out_unset_idev:
> +    pci_device_unset_iommu_device(pdev);
>   out_teardown:
>       vfio_teardown_msi(vdev);
>       vfio_bars_exit(vdev);
> @@ -3257,6 +3269,7 @@ static void vfio_instance_finalize(Object *obj)
>   static void vfio_exitfn(PCIDevice *pdev)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_unregister_req_notifier(vdev);
>       vfio_unregister_err_notifier(vdev);
> @@ -3271,7 +3284,8 @@ static void vfio_exitfn(PCIDevice *pdev)
>       vfio_teardown_msi(vdev);
>       vfio_pci_disable_rp_atomics(vdev);
>       vfio_bars_exit(vdev);
> -    vfio_migration_exit(&vdev->vbasedev);
> +    vfio_migration_exit(vbasedev);
> +    pci_device_unset_iommu_device(pdev);
>   }
>   
>   static void vfio_pci_reset(DeviceState *dev)


