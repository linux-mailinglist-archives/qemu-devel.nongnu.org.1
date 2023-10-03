Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF07B6D6C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhhH-0001Dq-FH; Tue, 03 Oct 2023 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhhE-0001Dh-U5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhhA-0005Pl-NW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696348343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w81jSuw/m2mkqxvfwZtKl2qRax7JM/ceuJoqeD0koVY=;
 b=AcWAd9RdT/QxPZZefXDhAU23RkOuOcXxzvmOa3NxEwkHP3z9HN5xTLPAdTSbHS3W0ImGLH
 SWKnXUpdHD9nInCaORnZwD3851MhaMS+RABP+pdDmdCPDA4Uf9ms3XbawaH/UgdEu8jd9W
 exEk6q8xuyGd8hB3kw9RYb0aJ5bsFq8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-3Fu8BWBoMUmRfj27f_YfOA-1; Tue, 03 Oct 2023 11:52:21 -0400
X-MC-Unique: 3Fu8BWBoMUmRfj27f_YfOA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65b23c40cefso10955956d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696348341; x=1696953141;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w81jSuw/m2mkqxvfwZtKl2qRax7JM/ceuJoqeD0koVY=;
 b=InrUjLlkU29aPItTeTI+2zdsUmkW2MN0AKWBMCuSglX8Ac0A4Kn2MI5cRXQpn6dodc
 BEbEjJ0swZQcJn60ipyBJGXa58m/JkQEZPeVHAXIeOD/98CJJ/4JB0JfI8c1wc3elUjX
 xbjGdo5Nb3b/aaNjDPy1Se898TWhcTaiJHI5C7ZysKRNfFR/zIO62eDMq9ApUc62gbgK
 kw0l5JXjTelXByJwBvGvhc28A9jqBJbDR0u7zsGUWfwkmc1Icplxy8Yo/18gLQm+BggT
 dZEb+E/DP90mn75ntqkCpKE/3RbW2CxAeO3GLNNHi9xzxwNmzKtUlFoZ4DIePUDFI9uv
 MJzg==
X-Gm-Message-State: AOJu0Ywd+m2gfV2xziSBTY8ORt3ot13NrjKdiH/RTIxdEUUGXLTG2tKg
 Ax13w1DMebMzsNnB8aAsvTLZhGvfgZ3yJ6qH1x+qLgLrhP5uZ4W0XrTleQIOKX/LLyx5fr6Dm4K
 9yhl+65axFFr5UOM=
X-Received: by 2002:a0c:a792:0:b0:63f:bf70:6796 with SMTP id
 v18-20020a0ca792000000b0063fbf706796mr10939831qva.58.1696348341287; 
 Tue, 03 Oct 2023 08:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETzY7XkZ24Je19jccRakpKIvwmtQZiR/wpu7dn7dUgdDIWpyi4Eqcff4fSVNZtM9c1FVqe1A==
X-Received: by 2002:a0c:a792:0:b0:63f:bf70:6796 with SMTP id
 v18-20020a0ca792000000b0063fbf706796mr10939818qva.58.1696348340949; 
 Tue, 03 Oct 2023 08:52:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a0cf10a000000b006624e9d51d9sm572954qvl.76.2023.10.03.08.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:52:20 -0700 (PDT)
Message-ID: <cd70f534-2b08-3e56-547f-acd182c8e684@redhat.com>
Date: Tue, 3 Oct 2023 17:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 12/15] vfio/common: Introduce a per container device
 list
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-13-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-13-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/3/23 12:14, Eric Auger wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Several functions need to iterate over the VFIO devices attached to
> a given container.  This is currently achieved by iterating over the
> groups attached to the container and then over the devices in the group.
> Let's introduce a per container device list that simplifies this
> search.
> 
> Per container list is used in below functions:
> vfio_devices_all_dirty_tracking
> vfio_devices_all_device_dirty_tracking
> vfio_devices_all_running_and_mig_active
> vfio_devices_dma_logging_stop
> vfio_devices_dma_logging_start
> vfio_devices_query_dirty_bitmap
> 
> This will also ease the migration of IOMMUFD by hiding the group
> specificity.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

LGTM,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   include/hw/vfio/vfio-common.h |   2 +
>   hw/vfio/common.c              | 145 +++++++++++++++-------------------
>   2 files changed, 67 insertions(+), 80 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c486bdef2a..8ca70dd821 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -98,6 +98,7 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>       QLIST_ENTRY(VFIOContainer) next;
> +    QLIST_HEAD(, VFIODevice) device_list;
>   } VFIOContainer;
>   
>   typedef struct VFIOGuestIOMMU {
> @@ -129,6 +130,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
>   
>   typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) next;
> +    QLIST_ENTRY(VFIODevice) container_next;
>       struct VFIOGroup *group;
>       char *sysfsdev;
>       char *name;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 019da387d2..ef9dc7c747 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -218,7 +218,6 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>   
>   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>   {
> -    VFIOGroup *group;
>       VFIODevice *vbasedev;
>       MigrationState *ms = migrate_get_current();
>   
> @@ -227,19 +226,17 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>           return false;
>       }
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            VFIOMigration *migration = vbasedev->migration;
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        VFIOMigration *migration = vbasedev->migration;
>   
> -            if (!migration) {
> -                return false;
> -            }
> +        if (!migration) {
> +            return false;
> +        }
>   
> -            if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
> -                (vfio_device_state_is_running(vbasedev) ||
> -                 vfio_device_state_is_precopy(vbasedev))) {
> -                return false;
> -            }
> +        if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
> +            (vfio_device_state_is_running(vbasedev) ||
> +             vfio_device_state_is_precopy(vbasedev))) {
> +            return false;
>           }
>       }
>       return true;
> @@ -247,14 +244,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>   
>   static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>   {
> -    VFIOGroup *group;
>       VFIODevice *vbasedev;
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (!vbasedev->dirty_pages_supported) {
> -                return false;
> -            }
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (!vbasedev->dirty_pages_supported) {
> +            return false;
>           }
>       }
>   
> @@ -267,27 +261,24 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>    */
>   static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>   {
> -    VFIOGroup *group;
>       VFIODevice *vbasedev;
>   
>       if (!migration_is_active(migrate_get_current())) {
>           return false;
>       }
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            VFIOMigration *migration = vbasedev->migration;
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        VFIOMigration *migration = vbasedev->migration;
>   
> -            if (!migration) {
> -                return false;
> -            }
> +        if (!migration) {
> +            return false;
> +        }
>   
> -            if (vfio_device_state_is_running(vbasedev) ||
> -                vfio_device_state_is_precopy(vbasedev)) {
> -                continue;
> -            } else {
> -                return false;
> -            }
> +        if (vfio_device_state_is_running(vbasedev) ||
> +            vfio_device_state_is_precopy(vbasedev)) {
> +            continue;
> +        } else {
> +            return false;
>           }
>       }
>       return true;
> @@ -1187,20 +1178,17 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>   {
>       VFIOPCIDevice *pcidev;
>       VFIODevice *vbasedev;
> -    VFIOGroup *group;
>       Object *owner;
>   
>       owner = memory_region_owner(section->mr);
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> -                continue;
> -            }
> -            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> -            if (OBJECT(pcidev) == owner) {
> -                return true;
> -            }
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +            continue;
> +        }
> +        pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +        if (OBJECT(pcidev) == owner) {
> +            return true;
>           }
>       }
>   
> @@ -1296,24 +1284,21 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>                                 sizeof(uint64_t))] = {};
>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>       VFIODevice *vbasedev;
> -    VFIOGroup *group;
>   
>       feature->argsz = sizeof(buf);
>       feature->flags = VFIO_DEVICE_FEATURE_SET |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (!vbasedev->dirty_tracking) {
> -                continue;
> -            }
> -
> -            if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -                warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> -                             vbasedev->name, -errno, strerror(errno));
> -            }
> -            vbasedev->dirty_tracking = false;
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (!vbasedev->dirty_tracking) {
> +            continue;
>           }
> +
> +        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> +                        vbasedev->name, -errno, strerror(errno));
> +        }
> +        vbasedev->dirty_tracking = false;
>       }
>   }
>   
> @@ -1396,7 +1381,6 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>       struct vfio_device_feature *feature;
>       VFIODirtyRanges ranges;
>       VFIODevice *vbasedev;
> -    VFIOGroup *group;
>       int ret = 0;
>   
>       vfio_dirty_tracking_init(container, &ranges);
> @@ -1406,21 +1390,19 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>           return -errno;
>       }
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dirty_tracking) {
> -                continue;
> -            }
> -
> -            ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> -            if (ret) {
> -                ret = -errno;
> -                error_report("%s: Failed to start DMA logging, err %d (%s)",
> -                             vbasedev->name, ret, strerror(errno));
> -                goto out;
> -            }
> -            vbasedev->dirty_tracking = true;
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (vbasedev->dirty_tracking) {
> +            continue;
>           }
> +
> +        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +        if (ret) {
> +            ret = -errno;
> +            error_report("%s: Failed to start DMA logging, err %d (%s)",
> +                         vbasedev->name, ret, strerror(errno));
> +            goto out;
> +        }
> +        vbasedev->dirty_tracking = true;
>       }
>   
>   out:
> @@ -1500,21 +1482,18 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
>                                              hwaddr size)
>   {
>       VFIODevice *vbasedev;
> -    VFIOGroup *group;
>       int ret;
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            ret = vfio_device_dma_logging_report(vbasedev, iova, size,
> -                                                 vbmap->bitmap);
> -            if (ret) {
> -                error_report("%s: Failed to get DMA logging report, iova: "
> -                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> -                             ", err: %d (%s)",
> -                             vbasedev->name, iova, size, ret, strerror(-ret));
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
> +                                             vbmap->bitmap);
> +        if (ret) {
> +            error_report("%s: Failed to get DMA logging report, iova: "
> +                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> +                         ", err: %d (%s)",
> +                         vbasedev->name, iova, size, ret, strerror(-ret));
>   
> -                return ret;
> -            }
> +            return ret;
>           }
>       }
>   
> @@ -2648,6 +2627,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
> +    VFIOContainer *container;
>       int ret;
>   
>       if (groupid < 0) {
> @@ -2671,8 +2651,12 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       ret = vfio_get_device(group, name, vbasedev, errp);
>       if (ret) {
>           vfio_put_group(group);
> +        return ret;
>       }
>   
> +    container = group->container;
> +    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
> +
>       return ret;
>   }
>   
> @@ -2680,6 +2664,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
> +    QLIST_REMOVE(vbasedev, container_next);
>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);


