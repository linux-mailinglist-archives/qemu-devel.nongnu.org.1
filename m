Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD97D9DBC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPHX-000570-VT; Fri, 27 Oct 2023 12:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPHU-00054c-4S
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwPHO-0004qq-Nl
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CRC0lYjp3KqxxfiOyYhH4NMg8lNU39BLkvQ8cxskuM=;
 b=PohWcR2f5GPjMdgZjstXo5mGgRYknNkx3ICVJO2VQRHdk9uwBRH+lVFkvKmgO+U0/9R2+b
 CWqX0Dt1td2y50Zo0tbySN25b8Wak6WMf8uKgrfyvQoIsfSIlL6Qw0N9QB4Ck3aD5W9Ctb
 rfR3FIzGri5LHYW5M3lX1SrqlVEWLgI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Qf7WA5tCMoKI5wV9LK7NKw-1; Fri, 27 Oct 2023 12:01:43 -0400
X-MC-Unique: Qf7WA5tCMoKI5wV9LK7NKw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77a12fbe7eeso87366285a.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698422503; x=1699027303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4CRC0lYjp3KqxxfiOyYhH4NMg8lNU39BLkvQ8cxskuM=;
 b=ADVjUVxJelws7h5nFq4TBwP4gmWTrjQurv3C04J4ENu0fJDCNy/WJlQWQ+S60yVW4g
 D03Y/NbPS3kjDBk8edya5pBo6xe5vHwpjoayiwRAOBljzYj42qodDnQHD/f29PE06b/R
 iVa0skT/3Hn+OXBKTMHpxg3mLaDvJY3QLtkbgzmsOD8h2VS4drZDNRdEYjco9tx/yLHG
 StMECXFqstZKsiHYkXsTnOfVE9Tr3TEp4e00M75ILy58/85hvM3Zf2UbpLs2BXP5/8pD
 CshdoGbkmoulyEkgRK9i+k1lpwFd+wJUdKOhijSIIHGllnhMhgHIsnFKVPrNg2uKMVkb
 ksMQ==
X-Gm-Message-State: AOJu0YyT6v18ds1e/notz1IC+FTBJEsShREv0gEtF7sf36L8jdS8Mzuy
 BdnsAC95uR0z9MdTbu/vzl1fqQQxOoK0y4vAc4iS8x8lQdfGz2TnGfjYDJzOK8IGfgcTgrgYx4S
 44s5xNtrIpzCVOa8=
X-Received: by 2002:a05:620a:a0f:b0:76f:8c6:a537 with SMTP id
 i15-20020a05620a0a0f00b0076f08c6a537mr2415998qka.77.1698422502938; 
 Fri, 27 Oct 2023 09:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbUjLZmGroFMbCRZ2zqLYmJ3OLq/vfXDgg1HT4IAqrvsjxe8BimlAkYDscVawM0eKh2vOWZQ==
X-Received: by 2002:a05:620a:a0f:b0:76f:8c6:a537 with SMTP id
 i15-20020a05620a0a0f00b0076f08c6a537mr2415979qka.77.1698422502654; 
 Fri, 27 Oct 2023 09:01:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a05620a140e00b00767dc4c539bsm657746qkj.44.2023.10.27.09.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 09:01:42 -0700 (PDT)
Message-ID: <8f729c1b-6d58-4d6a-baa8-5ce774c7a916@redhat.com>
Date: Fri, 27 Oct 2023 18:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/37] vfio/container: Move dirty_pgsizes and
 max_dirty_bitmap_size to base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-17-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-17-zhenzhong.duan@intel.com>
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
> From: Eric Auger <eric.auger@redhat.com>
> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Drop the Sob please,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h         |  2 --
>   include/hw/vfio/vfio-container-base.h |  2 ++
>   hw/vfio/container.c                   | 11 ++++++-----
>   3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 56452018a9..423ab2436c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -80,8 +80,6 @@ typedef struct VFIOContainer {
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       MemoryListener prereg_listener;
>       unsigned iommu_type;
> -    uint64_t dirty_pgsizes;
> -    uint64_t max_dirty_bitmap_size;
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>       GList *iova_ranges;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 89642e6b45..526d23acfd 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -53,6 +53,8 @@ typedef struct VFIOContainerBase {
>       MemoryListener listener;
>       Error *error;
>       bool initialized;
> +    uint64_t dirty_pgsizes;
> +    uint64_t max_dirty_bitmap_size;
>       unsigned long pgsizes;
>       unsigned int dma_max_mappings;
>       bool dirty_pages_supported;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index b8f36f56d2..68dc6d240f 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -64,6 +64,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       struct vfio_iommu_type1_dma_unmap *unmap;
>       struct vfio_bitmap *bitmap;
>       VFIOBitmap vbmap;
> @@ -91,7 +92,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
>       bitmap->size = vbmap.size;
>       bitmap->data = (__u64 *)vbmap.bitmap;
>   
> -    if (vbmap.size > container->max_dirty_bitmap_size) {
> +    if (vbmap.size > bcontainer->max_dirty_bitmap_size) {
>           error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
>           ret = -E2BIG;
>           goto unmap_exit;
> @@ -131,7 +132,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
>   
>       if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> -            container->bcontainer.dirty_pages_supported) {
> +            bcontainer->dirty_pages_supported) {
>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>           }
>   
> @@ -154,7 +155,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
>           if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
>               container->iommu_type == VFIO_TYPE1v2_IOMMU) {
>               trace_vfio_legacy_dma_unmap_overflow_workaround();
> -            unmap.size -= 1ULL << ctz64(container->bcontainer.pgsizes);
> +            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
>               continue;
>           }
>           error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
> @@ -469,8 +470,8 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>        */
>       if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
>           bcontainer->dirty_pages_supported = true;
> -        container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
> -        container->dirty_pgsizes = cap_mig->pgsize_bitmap;
> +        bcontainer->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
> +        bcontainer->dirty_pgsizes = cap_mig->pgsize_bitmap;
>       }
>   }
>   


