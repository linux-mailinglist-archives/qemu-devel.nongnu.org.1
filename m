Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420B7A9293
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjF3S-0002ZI-Pk; Thu, 21 Sep 2023 04:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjF3Q-0002St-Ge
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjF3H-00087A-HI
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695284925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9JYBbiQ8eLGV1JjB0XuW1jXghpOTFoS30O5AbizPJo=;
 b=PtdBSpclzrLAB7COjjnyiWjwugiciMK9aQs2CH3sWI9bv5wZafwgV6zWWDd0VZLID9xwRc
 yoeaJf+wccJtD95YWqHXJ5oudSCZXueEjoQUIQOJWe+69r+oToazJw2mc9xEJtG/9mkHln
 7RSr/gPtssyzr52vUdsocxkPptbUc3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-5bKI1Hl1MFWdkOQfHa7_Xg-1; Thu, 21 Sep 2023 04:28:44 -0400
X-MC-Unique: 5bKI1Hl1MFWdkOQfHa7_Xg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-320004980a2so455427f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695284923; x=1695889723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T9JYBbiQ8eLGV1JjB0XuW1jXghpOTFoS30O5AbizPJo=;
 b=aToZKWo4KGW8C/l+Wahb+GVYyjMDHQrblI2qLceMQdB+46u0rVUtDcqvppkcT0InI/
 Gj/i1lVgBQUz91m1NtR9tpyy5q+Bx9cxWQlghpahJ9qUsC4RjGGVO4MWwr3vgJmaA28C
 V2kxIT+trST6QkHIEWWW3xhL1TzmR/Fc2+8DdiOvCPCe0tz5Ovs0Wl2Lr7uiHCrodVx3
 Wd405xkGzeEstUI/PSfbXOdsdo0nv72jbya5ENdsZZmXqxuTa3llmWU6Xsn9HP8cDP7/
 VVEpm5OXmeLUGK+d9LO3uXA1Td7JmEUhvBiB6a/1y4piX3XInxy34fJKPd8hIImpJM/l
 Uwrw==
X-Gm-Message-State: AOJu0YzsrSvtvaZ0jtgs33qpQHOQeMw6uomhku3sTHPpNN6D/zEuNZED
 vxNevjk9PQ1rOKWMcIEJQ8HGDZ+ROStbN9p1s+vkNPUEHLCSIxXn5Jl1BWNaaY9/05O7NWfjr3r
 12puMTFkQzAytkfo=
X-Received: by 2002:a5d:5b1f:0:b0:321:f74d:ade6 with SMTP id
 bx31-20020a5d5b1f000000b00321f74dade6mr834523wrb.40.1695284923315; 
 Thu, 21 Sep 2023 01:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKkcDzW9GhlP+CyGhBMO0OJ7jmQsWSmyN6yx2W44joEc3RDPjiv7unTg2A59IGoWLBOvIAyA==
X-Received: by 2002:a5d:5b1f:0:b0:321:f74d:ade6 with SMTP id
 bx31-20020a5d5b1f000000b00321f74dade6mr834490wrb.40.1695284922901; 
 Thu, 21 Sep 2023 01:28:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b0031fc9402b47sm1103662wrq.4.2023.09.21.01.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:28:42 -0700 (PDT)
Message-ID: <facf584a-e8bf-5386-8660-ac7dd3e6dde8@redhat.com>
Date: Thu, 21 Sep 2023 10:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Zhenzhong,

On 8/30/23 12:37, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Introduce helper functions that isolate the code used for
> VFIO_SPAPR_TCE_v2_IOMMU. This code reliance is IOMMU backend
> specific whereas the rest of the code in the callers, ie.
> vfio_listener_region_add|del is not.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
>   1 file changed, 89 insertions(+), 67 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9ca695837f..67150e4575 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -796,6 +796,92 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
>       return true;
>   }
>   
> +static int vfio_container_add_section_window(VFIOContainer *container,
> +                                             MemoryRegionSection *section,
> +                                             Error **errp)
> +{
> +    VFIOHostDMAWindow *hostwin;
> +    hwaddr pgsize = 0;
> +    int ret;
> +
> +    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> +        return 0;
> +    }

This test makes me think that we should register a specific backend
for the pseries machines, implementing the add/del_window handler,
since others do not need it. Correct ?

It would avoid this ugly test. Let's keep that in mind when the
backends are introduced.

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

the ifdef test doesn't seem useful because the compiler should compile
out the section below since, in that case, kvm_enabled() is defined as :

   #define kvm_enabled()           (0)

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
> +                    error_report("vfio: failed to setup fd %d "
> +                                 "for a group with fd %d: %s",
> +                                 param.tablefd, param.groupfd,
> +                                 strerror(errno));
> +                    return 0;

hmm, the code bails out directly without undoing previous actions. we should
return some error at least.

> +                }
> +                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> +            }
> +        }
> +    }
> +#endif
> +    return 0;
> +}
> +
> +static void vfio_container_del_section_window(VFIOContainer *container,
> +                                              MemoryRegionSection *section)
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
> +
>   static void vfio_listener_region_add(MemoryListener *listener,
>                                        MemoryRegionSection *section)
>   {
> @@ -822,62 +908,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           return;
>       }
>   
> -    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> -        hwaddr pgsize = 0;
> -
> -        /* For now intersections are not allowed, we may relax this later */
> -        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> -            if (ranges_overlap(hostwin->min_iova,
> -                               hostwin->max_iova - hostwin->min_iova + 1,
> -                               section->offset_within_address_space,
> -                               int128_get64(section->size))) {
> -                error_setg(&err,
> -                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
> -                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
> -                    section->offset_within_address_space,
> -                    section->offset_within_address_space +
> -                        int128_get64(section->size) - 1,
> -                    hostwin->min_iova, hostwin->max_iova);
> -                goto fail;
> -            }
> -        }
> -
> -        ret = vfio_spapr_create_window(container, section, &pgsize);
> -        if (ret) {
> -            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
> -            goto fail;
> -        }
> -
> -        vfio_host_win_add(container, section->offset_within_address_space,
> -                          section->offset_within_address_space +
> -                          int128_get64(section->size) - 1, pgsize);
> -#ifdef CONFIG_KVM
> -        if (kvm_enabled()) {
> -            VFIOGroup *group;
> -            IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -            struct kvm_vfio_spapr_tce param;
> -            struct kvm_device_attr attr = {
> -                .group = KVM_DEV_VFIO_GROUP,
> -                .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
> -                .addr = (uint64_t)(unsigned long)&param,
> -            };
> -
> -            if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
> -                                              &param.tablefd)) {
> -                QLIST_FOREACH(group, &container->group_list, container_next) {
> -                    param.groupfd = group->fd;
> -                    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -                        error_report("vfio: failed to setup fd %d "
> -                                     "for a group with fd %d: %s",
> -                                     param.tablefd, param.groupfd,
> -                                     strerror(errno));
> -                        return;
> -                    }
> -                    trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
> -                }
> -            }
> -        }
> -#endif
> +    if (vfio_container_add_section_window(container, section, &err)) {
> +        goto fail;

That's not exactly the same as the return above when the ioctl call
fails. there doesn't seem to be much consequences though. Let's keep
it that way.

>       }
>   
>       hostwin = vfio_find_hostwin(container, iova, end);
> @@ -1094,17 +1126,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>   
>       memory_region_unref(section->mr);
>   
> -    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> -        vfio_spapr_remove_window(container,
> -                                 section->offset_within_address_space);
> -        if (vfio_host_win_del(container,
> -                              section->offset_within_address_space,
> -                              section->offset_within_address_space +
> -                              int128_get64(section->size) - 1) < 0) {
> -            hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
> -                     __func__, section->offset_within_address_space);
> -        }
> -    }
> +    vfio_container_del_section_window(container, section);
>   }
>   
>   static int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)

PPC is in the way. May be we could move these two routines in pseries to
help a little. I will look into it.

Thanks,

C.


