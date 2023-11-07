Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E97E4134
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:52:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MVd-0001mk-Sx; Tue, 07 Nov 2023 08:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MVb-0001fV-BG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:52:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MVW-0000T5-Ji
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699365161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cebAfUBA8YfCoYjq/SKwW/MxYm4hIzK0BlaLChYUEI=;
 b=NCIoWwLsuwxOCu9RZgLHUk4s2zUOopVBBC3CJ7Jpwhc6PEkx6Yzv8iHVa6fwYC/xXMk8m5
 yZLUl0O07x7Ie4zDGAvNSc8nqNth5lDcbLotbRj6ZPdtb4QZ5bsRucJDUQg8G6S58vhD6g
 sYcNiadgp2cIfdmWP3NUIfScg/iYJBw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-drC38zegOM-zh6-Nw1oAxw-1; Tue, 07 Nov 2023 08:52:40 -0500
X-MC-Unique: drC38zegOM-zh6-Nw1oAxw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41b83b3fd18so67268411cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699365160; x=1699969960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+cebAfUBA8YfCoYjq/SKwW/MxYm4hIzK0BlaLChYUEI=;
 b=fSz1ACKF8oAfTDPKti4ozOB+NwgLznQKQ44V1DO1DrxM6YlBaQj3J4o/h48HIhPYty
 fHhLMncfZgtjmJfgU/OAWnn90pPxkOsKD/xM7+1j7asc8ptXT6T6IKtf3Bgz6X5xbMUT
 WbGHKBFVhL32b/RoHfTM4xATvdK6PeaelMILAYTnR6aEZK0fAFTR0KlMKb0Rht/t7Gjz
 lslZBo7FBGVLi4tpJp9e/3QrnUJqRt3VlO9/Z8WslJxSlOsaeIyJOlih8wbc/eS+oGma
 vp1thpSO21RXGDBJ4hagoUeRuNEuc0VtEMEEaZQnNANJ3H3OtjfdMXJOw9bHdwYxY6tF
 hJDw==
X-Gm-Message-State: AOJu0YxZiP880aRQdh7XBLePUjr4oCL3W9VmL2cnVgFFqYc9S228fFW6
 f0JOuiHAP2XunmJ83NQSLQY0++4AuXD3lOC8up95t2Cm/PzKFNiQOMWv4A2dbRvi0/v2AG5sAqt
 wxYFlKapfkXj1VYE=
X-Received: by 2002:a05:622a:34f:b0:40f:db89:8616 with SMTP id
 r15-20020a05622a034f00b0040fdb898616mr39679879qtw.67.1699365160112; 
 Tue, 07 Nov 2023 05:52:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Q7wzQ7bbFyTHroDFWtacgiqFd/51clUhgN7gTLVr/rpY5iPrp7KVsORlHj3yiHXv56dxFQ==
X-Received: by 2002:a05:622a:34f:b0:40f:db89:8616 with SMTP id
 r15-20020a05622a034f00b0040fdb898616mr39679858qtw.67.1699365159897; 
 Tue, 07 Nov 2023 05:52:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 gx5-20020a05622a27c500b004198f67acbesm4302218qtb.63.2023.11.07.05.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:52:39 -0800 (PST)
Message-ID: <7cb2087f-dbd8-48fb-b0e2-9f59ce597084@redhat.com>
Date: Tue, 7 Nov 2023 14:52:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/41] vfio/pci: Introduce a vfio pci hot reset
 interface
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-33-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-33-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> Legacy vfio pci and iommufd cdev have different process to hot reset
> vfio device, expand current code to abstract out pci_hot_reset callback
> for legacy vfio, this same interface will also be used by iommufd
> cdev vfio device.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.h                         |  1 +
>   include/hw/vfio/vfio-container-base.h |  3 +++
>   hw/vfio/container.c                   |  2 ++
>   hw/vfio/pci.c                         | 11 ++++++++++-
>   4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 1006061afb..12cc765821 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -220,6 +220,7 @@ extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>   
>   int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>                                       struct vfio_pci_hot_reset_info **info_p);
> +int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single);
>   
>   int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>   
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 4b6f017c6f..45bb19c767 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -106,6 +106,9 @@ struct VFIOIOMMUOps {
>       int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
>       int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
>                                 hwaddr iova, hwaddr size);
> +    /* PCI specific */
> +    int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
> +
>       /* SPAPR specific */
>       int (*add_window)(VFIOContainerBase *bcontainer,
>                         MemoryRegionSection *section,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index ed2d721b2b..f27cc15d09 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -33,6 +33,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "migration/migration.h"
> +#include "pci.h"
>   
>   VFIOGroupList vfio_group_list =
>       QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -929,4 +930,5 @@ const VFIOIOMMUOps vfio_legacy_ops = {
>       .detach_device = vfio_legacy_detach_device,
>       .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
>       .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
> +    .pci_hot_reset = vfio_legacy_pci_hot_reset,
>   };
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index eb55e8ae88..a6194b7bfe 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2483,8 +2483,9 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>       return 0;
>   }
>   
> -static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)

Could we move this routine to container .c ?


Thanks,

C.


>   {
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>       VFIOGroup *group;
>       struct vfio_pci_hot_reset_info *info = NULL;
>       struct vfio_pci_dependent_device *devices;
> @@ -2647,6 +2648,14 @@ out_single:
>       return ret;
>   }
>   
> +static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
> +{
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +    const VFIOIOMMUOps *ops = vbasedev->bcontainer->ops;
> +
> +    return ops->pci_hot_reset(vbasedev, single);
> +}
> +
>   /*
>    * We want to differentiate hot reset of multiple in-use devices vs hot reset
>    * of a single in-use device.  VFIO_DEVICE_RESET will already handle the case


