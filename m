Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3397D936B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJ06-0000Qe-Ve; Fri, 27 Oct 2023 05:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwIzz-0000Q6-0U
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwIzv-0005Hz-CA
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698398358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YViFHnijlbGeqtHPZl1ik8yJqH5+mts9HGKyLariNi8=;
 b=ZYrppX5tGAp3ygUVsre4AlD6zTS0uv0Uv2E++t+tP+48/P+Sfk7ANq5diZ92EUW6U61iIq
 pvIjW1yWGdQKdCtdjvgpamfqy+Rx82aUWNaiscMD0DvlkUPU+z5DzPKSzK5kYEptKYLPiP
 VzsZUDYFPH+uFWgIJiyuhs7VQGRVyhE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-OQmYmFhENGqy8t6KuO_i9A-1; Fri, 27 Oct 2023 05:19:17 -0400
X-MC-Unique: OQmYmFhENGqy8t6KuO_i9A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7740517a478so264440185a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 02:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698398356; x=1699003156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YViFHnijlbGeqtHPZl1ik8yJqH5+mts9HGKyLariNi8=;
 b=olBffN+51wJhftt15epFpgW4L24ijjstEjDT5EjItbEFZjqhYWULyez8KfDPZIvbU5
 8+QR/sfDmAY7Wo4xK42EnpKCD0QZ5N9cAw6VADU00LZGelK+A5tNn+QCXiQzmYx5ZYny
 8nn8wjDyVGZqiJmQwBUdOrSgCfx0kd1KFt2bs0T5LkvoYf74gr3EpwgtOJtHjsZHg5Te
 OrpJXi+Azn9/DqRre6FaZx9pZkg4WzCBAJda7RbcyQ8pbj/hKHEdUcwPTh16pEF8FkDm
 SQsmfts8zMp3K0x6OM7lGg7HKgF038GkLA/fbkHb1usDmxRyRgjfMwUNXmXq4ehsKqKG
 GL0A==
X-Gm-Message-State: AOJu0YzF2o+rtS8agK/5yInm8yLNOKISxekMe4baxct3KMOoZoLxZG/J
 cEWWIsKQ/xXVz0yb6wmfqKZMkNoP8Y3eATLHV8Y02JHW+QTqpZ3Qm8cbO9v0iGoHCQFPBS+FLVH
 DCztRfqyLH5hs3eQ=
X-Received: by 2002:a05:620a:2d95:b0:778:98b9:d3a9 with SMTP id
 tr21-20020a05620a2d9500b0077898b9d3a9mr1811476qkn.13.1698398356327; 
 Fri, 27 Oct 2023 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPi0xiDfQh64Xhj6Bkw6tocn1dSbi5DdBAl2grK/sVDpi5juzqFv6/2mZ8ExDDumt9nDqCQ==
X-Received: by 2002:a05:620a:2d95:b0:778:98b9:d3a9 with SMTP id
 tr21-20020a05620a2d9500b0077898b9d3a9mr1811459qkn.13.1698398356010; 
 Fri, 27 Oct 2023 02:19:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 c5-20020ae9e205000000b0076f35d17d06sm392309qkc.69.2023.10.27.02.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:19:12 -0700 (PDT)
Message-ID: <7f78ed58-e7bd-4d34-9cb0-4aa22702ada6@redhat.com>
Date: Fri, 27 Oct 2023 11:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/37] vfio/container: Move
 vfio_container_add/del_section_window into spapr.c
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> vfio_container_add/del_section_window are spapr specific functions,
> so move them into spapr.c to make container.c cleaner.
> 
> No functional changes intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 90 ---------------------------------------------
>   hw/vfio/spapr.c     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+), 90 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 83c0f05bba..7a3f005d1b 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -20,9 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
> -#ifdef CONFIG_KVM
> -#include <linux/kvm.h>
> -#endif
>   #include <linux/vfio.h>
>   
>   #include "hw/vfio/vfio-common.h"
> @@ -32,7 +29,6 @@
>   #include "hw/hw.h"
>   #include "qemu/error-report.h"
>   #include "qemu/range.h"
> -#include "sysemu/kvm.h"
>   #include "sysemu/reset.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> @@ -204,92 +200,6 @@ int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       return -errno;
>   }
>   
> -int vfio_container_add_section_window(VFIOContainer *container,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp)
> -{
> -    VFIOHostDMAWindow *hostwin;
> -    hwaddr pgsize = 0;
> -    int ret;
> -
> -    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> -        return 0;
> -    }
> -
> -    /* For now intersections are not allowed, we may relax this later */
> -    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> -        if (ranges_overlap(hostwin->min_iova,
> -                           hostwin->max_iova - hostwin->min_iova + 1,
> -                           section->offset_within_address_space,
> -                           int128_get64(section->size))) {
> -            error_setg(errp,
> -                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
> -                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
> -                section->offset_within_address_space,
> -                section->offset_within_address_space +
> -                    int128_get64(section->size) - 1,
> -                hostwin->min_iova, hostwin->max_iova);
> -            return -EINVAL;
> -        }
> -    }
> -
> -    ret = vfio_spapr_create_window(container, section, &pgsize);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> -        return ret;
> -    }
> -
> -    vfio_host_win_add(container, section->offset_within_address_space,
> -                      section->offset_within_address_space +
> -                      int128_get64(section->size) - 1, pgsize);
> -#ifdef CONFIG_KVM
> -    if (kvm_enabled()) {
> -        VFIOGroup *group;
> -        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -        struct kvm_vfio_spapr_tce param;
> -        struct kvm_device_attr attr = {
> -            .group = KVM_DEV_VFIO_GROUP,
> -            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> -            .addr = (uint64_t)(unsigned long)&param,
> -        };
> -
> -        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> -                                          &param.tablefd)) {
> -            QLIST_FOREACH(group, &container->group_list, container_next) {
> -                param.groupfd = group->fd;
> -                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -                    error_setg_errno(errp, errno,
> -                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
> -                                     "KVM VFIO device %d and group fd %d",
> -                                     param.tablefd, param.groupfd);
> -                    return -errno;
> -                }
> -                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> -            }
> -        }
> -    }
> -#endif
> -    return 0;
> -}
> -
> -void vfio_container_del_section_window(VFIOContainer *container,
> -                                       MemoryRegionSection *section)
> -{
> -    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> -        return;
> -    }
> -
> -    vfio_spapr_remove_window(container,
> -                             section->offset_within_address_space);
> -    if (vfio_host_win_del(container,
> -                          section->offset_within_address_space,
> -                          section->offset_within_address_space +
> -                          int128_get64(section->size) - 1) < 0) {
> -        hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
> -                 __func__, section->offset_within_address_space);
> -    }
> -}
> -
>   int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
>   {
>       int ret;
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 9ec1e95f6d..9a7517c042 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -11,6 +11,10 @@
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
> +#ifdef CONFIG_KVM
> +#include <linux/kvm.h>
> +#endif
> +#include "sysemu/kvm.h"
>   
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/hw.h"
> @@ -253,3 +257,89 @@ int vfio_spapr_remove_window(VFIOContainer *container,
>   
>       return 0;
>   }
> +
> +int vfio_container_add_section_window(VFIOContainer *container,
> +                                      MemoryRegionSection *section,
> +                                      Error **errp)
> +{
> +    VFIOHostDMAWindow *hostwin;
> +    hwaddr pgsize = 0;
> +    int ret;
> +
> +    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> +        return 0;
> +    }
> +
> +    /* For now intersections are not allowed, we may relax this later */
> +    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +        if (ranges_overlap(hostwin->min_iova,
> +                           hostwin->max_iova - hostwin->min_iova + 1,
> +                           section->offset_within_address_space,
> +                           int128_get64(section->size))) {
> +            error_setg(errp,
> +                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
> +                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
> +                section->offset_within_address_space,
> +                section->offset_within_address_space +
> +                    int128_get64(section->size) - 1,
> +                hostwin->min_iova, hostwin->max_iova);
> +            return -EINVAL;
> +        }
> +    }
> +
> +    ret = vfio_spapr_create_window(container, section, &pgsize);
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> +        return ret;
> +    }
> +
> +    vfio_host_win_add(container, section->offset_within_address_space,
> +                      section->offset_within_address_space +
> +                      int128_get64(section->size) - 1, pgsize);
> +#ifdef CONFIG_KVM
> +    if (kvm_enabled()) {
> +        VFIOGroup *group;
> +        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> +        struct kvm_vfio_spapr_tce param;
> +        struct kvm_device_attr attr = {
> +            .group = KVM_DEV_VFIO_GROUP,
> +            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> +            .addr = (uint64_t)(unsigned long)&param,
> +        };
> +
> +        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> +                                          &param.tablefd)) {
> +            QLIST_FOREACH(group, &container->group_list, container_next) {
> +                param.groupfd = group->fd;
> +                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +                    error_setg_errno(errp, errno,
> +                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
> +                                     "KVM VFIO device %d and group fd %d",
> +                                     param.tablefd, param.groupfd);
> +                    return -errno;
> +                }
> +                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> +            }
> +        }
> +    }
> +#endif
> +    return 0;
> +}
> +
> +void vfio_container_del_section_window(VFIOContainer *container,
> +                                       MemoryRegionSection *section)
> +{
> +    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> +        return;
> +    }
> +
> +    vfio_spapr_remove_window(container,
> +                             section->offset_within_address_space);
> +    if (vfio_host_win_del(container,
> +                          section->offset_within_address_space,
> +                          section->offset_within_address_space +
> +                          int128_get64(section->size) - 1) < 0) {
> +        hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
> +                 __func__, section->offset_within_address_space);
> +    }
> +}


