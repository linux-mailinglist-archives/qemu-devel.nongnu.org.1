Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C727B0192
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRXI-00081r-95; Wed, 27 Sep 2023 06:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qlRXG-00080i-8b
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qlRXE-0006HE-Cs
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695809567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTKcVCgHt8hkJSDGD6zDO5BzDDTiPxMx4RdIIX2ptuQ=;
 b=PqjRHXs0pySIaTHxV9UnefKGcUxSniiYGvBvQVDZ/3RgacGwxMUwQ948KWNHKfdhJP1hWU
 J+Y+/XpTDAIsT979CZ63fllPOvB6eIyJ/0nZmgoGCvZ4J5cTXaI38aqtMd82yAYmnXs72m
 /cF/0NS784iYWho7EZ5Ike9vbdDwK8k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-m_beV9mZMBmove6wePlkiQ-1; Wed, 27 Sep 2023 06:12:45 -0400
X-MC-Unique: m_beV9mZMBmove6wePlkiQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b04f70f98so76457626d6.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695809565; x=1696414365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTKcVCgHt8hkJSDGD6zDO5BzDDTiPxMx4RdIIX2ptuQ=;
 b=QgRbDFsc174hExiC3Vz8uqwOARMcpi0JiqWtmMFLQ2hSARF4kuiL6/Z1jWkrKmv5rz
 Vr7VGa1HGziucNHShnMeIt9+b9rhoLe01lLdJKlqt3VDAzDs/tSqBMzu/s+dH7ewLn0k
 WOl5J9F6KV9MhbLywRnD+0ZcVyrsL8uemk9s2VnoCmpOxo7QAH9PvC/VGam9TqvN3bpi
 jvq3xY5K2T2YBqdtgbzPsRqu4iCUOdfw3aENp7sxarpoLYtyMb4ssuom5upEQyxJKFaZ
 JNG3XDLDNBlPGJTtK6RArSZxepzWtZAHwpnVwLBM9Wk8Eoe1LmWEhmYWXDhodhzQFeeZ
 gTLA==
X-Gm-Message-State: AOJu0YxlD4lkDO2J0kWGg8RYYZQBOaLxXRiyUkSASwF1KOSiHl8JJecg
 ooXu2PHHPn6luWim+1lYQR8aYzDjEyTK7C8TKbG0F5YHGaG5KXUqEuE5UXPEDpAXkSbroamO+nK
 Gb5iS/3D6xwZOhME=
X-Received: by 2002:a0c:f094:0:b0:65b:2738:9bb4 with SMTP id
 g20-20020a0cf094000000b0065b27389bb4mr1434859qvk.23.1695809564849; 
 Wed, 27 Sep 2023 03:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKqAhRUonWTDKZiTWBI9V6R5u1H3Ssgr15pWLPZ/CBXmkm6l2+FnsCB0CXGAujbqwnhzDacQ==
X-Received: by 2002:a0c:f094:0:b0:65b:2738:9bb4 with SMTP id
 g20-20020a0cf094000000b0065b27389bb4mr1434838qvk.23.1695809564542; 
 Wed, 27 Sep 2023 03:12:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a0cf3c2000000b006583cc236aasm5733688qvm.76.2023.09.27.03.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:12:44 -0700 (PDT)
Message-ID: <168d8a5a-c419-706b-43a8-c0d8f43262c6@redhat.com>
Date: Wed, 27 Sep 2023 12:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 04/12] vfio/common: Introduce
 vfio_container_add|del_section_window()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230926113255.1177834-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/26/23 13:32, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Introduce helper functions that isolate the code used for
> VFIO_SPAPR_TCE_v2_IOMMU.
> 
> Those helpers hide implementation details beneath the container object
> and make the vfio_listener_region_add/del() implementations more
> readable. No code change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
>   1 file changed, 89 insertions(+), 67 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4e122fc4e4..de6b4a86e2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -807,6 +807,92 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
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

please return errno;

Otherwise,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

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
> @@ -833,62 +919,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
>       }
>   
>       hostwin = vfio_find_hostwin(container, iova, end);
> @@ -1105,17 +1137,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
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


