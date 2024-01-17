Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B902830BED
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:32:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9kc-0000cm-QY; Wed, 17 Jan 2024 12:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ9kV-0000bi-2F
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ9kT-0003v7-1f
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705512643;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiSExfCZS7k4bdyVeXzuorPtEejO7pZQWi9ONfXzZTM=;
 b=R523g5MHdHvQbyKmIaIa3WdqiDA2OEAgU5nauj/ACMCjnzkfkOZ7YbZSWK8YmqHZa3F3nw
 ME8Z6eeMuk1St29+6q3eEJr6WTY0uovmx7np+AKm441A1EvvNQ9Su9YG3BvQUUO+WRXM58
 WWOSTzszxDpd4Po1UCIx/4s/SC2nJ18=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-CGesMhJYMFmrCfcWsFP7iQ-1; Wed, 17 Jan 2024 12:30:42 -0500
X-MC-Unique: CGesMhJYMFmrCfcWsFP7iQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78346521232so879752985a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705512642; x=1706117442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiSExfCZS7k4bdyVeXzuorPtEejO7pZQWi9ONfXzZTM=;
 b=ug81KMGF8UERaI7sR1nZLYivZ0eINPoYmfnl7gp+hGiTj75f2evgLwPf0YUuUPB2Fn
 VAAUFolbzzubU+tPbRNOKWiZjdSpLQf87FhRqagCnTBRwsH+Gi7Yl4lzWcErxZjN/5nk
 0sn/hcHirp8Ni2Opozk2n1uwsI1sJ6Qznjuz6/isxLgSokFWly4L+1WTNuTx/xzbDQ/l
 A6UEmalZxQsQaeUXBQ6nd40LQmylek7FkOkKZMeSv6AFEwdeAqUDt5+Tu4tuCFOMyFxs
 QVTiDBSIyK9TcY/Q4G5nA0f98vy1G7FJgkeFSfeQ1eHWfxLidpZul0iNcH02GPH0GuUC
 Hshw==
X-Gm-Message-State: AOJu0YyHxtecoqjkk187Z+9Tz67zCdGH/GWM39BRIhD464T1tdPdzQ5/
 hW84/2bK9yXip6yXBcfopnu6HJL9GySnwcr3EbXRM/biYLbvD6TMMLpOPzt7WUjghPMLhVSACxp
 IGbVV8tPGOxGqQVX7nXlED4E=
X-Received: by 2002:a05:622a:1a9d:b0:429:d954:b342 with SMTP id
 s29-20020a05622a1a9d00b00429d954b342mr8980853qtc.73.1705512642034; 
 Wed, 17 Jan 2024 09:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuxlunUmtKSAUyhFKFTPyU96qBHcaHUPoWo6XHMGo7AYTl9C7F+l6LOj4sTknzvKsQjlzIAg==
X-Received: by 2002:a05:622a:1a9d:b0:429:d954:b342 with SMTP id
 s29-20020a05622a1a9d00b00429d954b342mr8980840qtc.73.1705512641745; 
 Wed, 17 Jan 2024 09:30:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ki26-20020a05622a771a00b0042a0d39442bsm927660qtb.17.2024.01.17.09.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:30:40 -0800 (PST)
Message-ID: <d6585044-d743-47eb-ba66-7dc24673df30@redhat.com>
Date: Wed, 17 Jan 2024 18:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240115101313.131139-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Hi Zhenzhong,

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
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/iommufd.c             |  2 ++
>  hw/vfio/pci.c                 | 24 +++++++++++++++++++-----
>  3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9b7ef7d02b..fde0d0ca60 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -31,6 +31,7 @@
>  #endif
>  #include "sysemu/sysemu.h"
>  #include "hw/vfio/vfio-container-base.h"
> +#include "sysemu/iommufd_device.h"
>  
>  #define VFIO_MSG_PREFIX "vfio %s: "
>  
> @@ -126,6 +127,7 @@ typedef struct VFIODevice {
>      bool dirty_tracking;
>      int devid;
>      IOMMUFDBackend *iommufd;
> +    IOMMUFDDevice idev;
This looks duplicate of existing fields:
idev.dev_id is same as above devid. by the way let's try to use the same
devid everywhere.
idev.iommufd is same as above iommufd if != NULL.
So we should at least rationalize.
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9bfddc1360..cbd035f148 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      VFIOContainerBase *bcontainer;
>      VFIOIOMMUFDContainer *container;
>      VFIOAddressSpace *space;
> +    IOMMUFDDevice *idev = &vbasedev->idev;
>      struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>      int ret, devfd;
>      uint32_t ioas_id;
> @@ -428,6 +429,7 @@ found_container:
>      QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>      QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>  
> +    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid);
>      trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                     vbasedev->num_regions, vbasedev->flags);
>      return 0;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7fe06715c..2c3a5d267b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3107,11 +3107,21 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>      vfio_bars_register(vdev);
>  
> -    ret = vfio_add_capabilities(vdev, errp);
> +    if (vbasedev->iommufd) {
> +        ret = pci_device_set_iommu_device(pdev, &vbasedev->idev, errp);
> +    } else {
> +        ret = pci_device_set_iommu_device(pdev, 0, errp);
> +    }
>      if (ret) {
> +        error_prepend(errp, "Failed to set iommu_device: ");
at the moment it is rather an IOMMUFD device.
>          goto out_teardown;
>      }
>  
> +    ret = vfio_add_capabilities(vdev, errp);
> +    if (ret) {
> +        goto out_unset_idev;
> +    }
> +
>      if (vdev->vga) {
>          vfio_vga_quirk_setup(vdev);
>      }
> @@ -3128,7 +3138,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>              error_setg(errp,
>                         "cannot support IGD OpRegion feature on hotplugged "
>                         "device");
> -            goto out_teardown;
> +            goto out_unset_idev;
>          }
>  
>          ret = vfio_get_dev_region_info(vbasedev,
> @@ -3137,13 +3147,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          if (ret) {
>              error_setg_errno(errp, -ret,
>                               "does not support requested IGD OpRegion feature");
> -            goto out_teardown;
> +            goto out_unset_idev;
>          }
>  
>          ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
>          g_free(opregion);
>          if (ret) {
> -            goto out_teardown;
> +            goto out_unset_idev;
>          }
>      }
>  
> @@ -3229,6 +3239,8 @@ out_deregister:
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);
>      }
> +out_unset_idev:
> +    pci_device_unset_iommu_device(pdev);
>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
> @@ -3257,6 +3269,7 @@ static void vfio_instance_finalize(Object *obj)
>  static void vfio_exitfn(PCIDevice *pdev)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>  
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
> @@ -3271,7 +3284,8 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_teardown_msi(vdev);
>      vfio_pci_disable_rp_atomics(vdev);
>      vfio_bars_exit(vdev);
> -    vfio_migration_exit(&vdev->vbasedev);
> +    vfio_migration_exit(vbasedev);
> +    pci_device_unset_iommu_device(pdev);
>  }
>  
>  static void vfio_pci_reset(DeviceState *dev)
Thanks

Eric


