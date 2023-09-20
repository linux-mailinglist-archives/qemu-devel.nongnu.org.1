Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33197A7A57
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivIi-0002pc-3x; Wed, 20 Sep 2023 07:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qivIf-0002eF-Ai
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qivId-0002YZ-Cn
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695208998;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hm4PKuUnZFuFOsXHgLlZrH2Zcv657Fo1thmLv17/2+k=;
 b=dcvzsnGm5T5M4Mt/4vLcvFa9QEugM3r0BWvhItk6FHA8YtM6u+qCf6ls/g72SYQruyGUD5
 +lw/lRYPDzXkVIU2MmMkqY01x8uYOJW5dn6y00lzv7xBdt+Q+rzzB2bkjK5Mg4vsoEKyir
 Fbd3ASPOYpQX3QMmh3JfS+3HTFKuC7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-pSu4XKXAOHKtJYf425GOuA-1; Wed, 20 Sep 2023 07:23:17 -0400
X-MC-Unique: pSu4XKXAOHKtJYf425GOuA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso51463335e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208996; x=1695813796;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hm4PKuUnZFuFOsXHgLlZrH2Zcv657Fo1thmLv17/2+k=;
 b=MGUUGxv78HjVDnUnotTQS71VJh0HcGS6x4S1xFTbTguKcPvu/DtOWpyv+5F8kfvHZk
 1BcPPZ3LI3edg8TQFINtidVM3SCzC3UDZBDBU9cGD3zddcTzFoJiSIbjHkfTrMaOmYza
 FB6zFCbsVPFI4pS2eiQxqYYvbzT0B04ceqhj/CaFay2w4FHkYCZrVbmSv5DXYMvo9ZbI
 it+Cs8xG33ootgjsAmLBkNSyXd1lXtjWHMFIVXlz553tl3eP/HIxSRqnRj9VBw3X+tBu
 0VpxxL1xDpFjfkfS2DOAiuJj8WKIiI67vUIKGG1K6Po+qHQoOCx3AdaqrKPX27BIMltF
 BnYw==
X-Gm-Message-State: AOJu0YzuVcM3aAgFRAjZIm8g9vmcUDwMytbyZzdSzg4KQLesgzcFmAmw
 jzN50cV1fBKrI6y0U32c7Y/D0vHUQJWTCWoKlh8cRTXYiGTtYAmDyky9WKWi0yakrwmR0TA/KiB
 mM8ABDc4VMJYSS9w=
X-Received: by 2002:a05:600c:2613:b0:400:57d1:4913 with SMTP id
 h19-20020a05600c261300b0040057d14913mr2348688wma.9.1695208995951; 
 Wed, 20 Sep 2023 04:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDdl5FHC+lQOd0sUUvFlCuNqh8HdjFlnWQlV9ldDAYbJV1T0jmDEuqJHZMFiwEIkA6afcIfA==
X-Received: by 2002:a05:600c:2613:b0:400:57d1:4913 with SMTP id
 h19-20020a05600c261300b0040057d14913mr2348671wma.9.1695208995521; 
 Wed, 20 Sep 2023 04:23:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a05600c251200b003fed7fa6c00sm1699579wma.7.2023.09.20.04.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 04:23:14 -0700 (PDT)
Message-ID: <9c12db4c-439f-463c-76d6-fddc131e1f5a@redhat.com>
Date: Wed, 20 Sep 2023 13:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230830103754.36461-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
On 8/30/23 12:37, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> Introduce helper functions that isolate the code used for
> VFIO_SPAPR_TCE_v2_IOMMU. This code reliance is IOMMU backend
> specific whereas the rest of the code in the callers, ie.
this last sentence should be rephrased into something like
Those helpers hide implementation details beneath the container object
and make the vfio_listener_region_add/del() implementations more
readable ( I think). No code change intended.

Thanks

Eric
> vfio_listener_region_add|del is not.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
>  1 file changed, 89 insertions(+), 67 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9ca695837f..67150e4575 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -796,6 +796,92 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
>      return true;
>  }
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
> +                    error_report("vfio: failed to setup fd %d "
> +                                 "for a group with fd %d: %s",
> +                                 param.tablefd, param.groupfd,
> +                                 strerror(errno));
> +                    return 0;
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
>  static void vfio_listener_region_add(MemoryListener *listener,
>                                       MemoryRegionSection *section)
>  {
> @@ -822,62 +908,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          return;
>      }
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
>      }
>  
>      hostwin = vfio_find_hostwin(container, iova, end);
> @@ -1094,17 +1126,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>  
>      memory_region_unref(section->mr);
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
>  }
>  
>  static int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)


