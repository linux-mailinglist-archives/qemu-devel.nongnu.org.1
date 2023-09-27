Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 877567B050A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:15:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlUMT-0004TC-6D; Wed, 27 Sep 2023 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlUMR-0004Sh-IU
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlUMO-0005Hi-Ur
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695820427;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiWhT/e7bYgCQ16y7hjenxvSN4WDdNtvCG4KaZCPMqY=;
 b=AA6nloVAIpLx3bdf7o7FOu41A7CYzLDThy/sFE5aNkwe7O2+FTh2HZYvGwNpMWlYRYhQEp
 +FZ+1J+JPSuKcF8oUXSaQVSnLWXFVrFRc7lqf/mZjie3rAy9DA0bhwF5BuvpgD8DScR+p/
 qs0sf5wcJEl7dzMRaohkDoO+3RVz2zw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-yIH_HGYdPrWEQLZqq1oyxw-1; Wed, 27 Sep 2023 09:13:43 -0400
X-MC-Unique: yIH_HGYdPrWEQLZqq1oyxw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77578227e4bso123622685a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 06:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695820423; x=1696425223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiWhT/e7bYgCQ16y7hjenxvSN4WDdNtvCG4KaZCPMqY=;
 b=ph6CJdwVDZJ1AjBHcJ1Yk3RiF5DhYRNxORYcmwz2TOxF3pbdvXiAu5Lm97+G8Yojht
 I6lvP00YGIkxgeNLD0D7SQTbXXtE4g8/T1xgqvMyImy02BOBSeloyyiX7nBTgcErLdXs
 59AkVNBGV5Okxd9KZmloi50UAn8plSPNUyybJZjTza3hQuDHOHI/b3K2EStgkrcmQIDB
 TqblIWPtVQ8XHrKkr1VEY2k3MJzmX8AgTBb3R6S4OPQXA28azocA8Q3PtV+H4G+NeXi6
 88n+xWM/yMlJTsFSf527yXkMhFiq0dI07gtSJ6iMAMOvQ/CFS1vlwUUxE7eEaf0Z/LJe
 bt9A==
X-Gm-Message-State: AOJu0YyXE4+l+bX1lkwpbu/tJ8PFEsJsrOP6ZreCZkoIAUZiKelMbY1V
 wOQ7bH6vMvnGT7a2TbFm/yCSkGYNWS0+/fXnJsz09Y8AAj0pPu/1jUCIt+JqzY5X0+TdYbNvxHF
 CzVKXrMmkpR4l7E4=
X-Received: by 2002:a0c:dd07:0:b0:658:3148:aac0 with SMTP id
 u7-20020a0cdd07000000b006583148aac0mr2109015qvk.0.1695820423087; 
 Wed, 27 Sep 2023 06:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEndrUxayQIqgAsm/k3GlG9bSfOzkJA3Q0CvsCAv04Kfr5IyY1i7WMxcVhYq6FA/Wub56uYOQ==
X-Received: by 2002:a0c:dd07:0:b0:658:3148:aac0 with SMTP id
 u7-20020a0cdd07000000b006583148aac0mr2108996qvk.0.1695820422733; 
 Wed, 27 Sep 2023 06:13:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a0ce38a000000b0063f88855ef2sm1811196qvl.101.2023.09.27.06.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 06:13:41 -0700 (PDT)
Message-ID: <dba250f5-4d75-b4d4-953b-6495f7ddbaf1@redhat.com>
Date: Wed, 27 Sep 2023 15:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 11/12] vfio/common: Introduce two kinds of VFIO device
 lists
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230926113255.1177834-12-zhenzhong.duan@intel.com>
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
On 9/26/23 13:32, Zhenzhong Duan wrote:
> In VFIO subsystem, there are different VFIO device iteration requirements.
> One requirement is to iterate all VFIO devices, the other is to iterate
> VFIO device in same container.
>
> Currently VFIO device is iterated through VFIO group list which is group
> perceivable and less efficient.
>
> Introduce two kinds of VFIO device lists, one is a global list, the other
> is per container list. With the two lists added, we can make some migration
> and reset related functions group agnostic.
>
> For example, vfio_device_list is used in below functions:
> vfio_mig_active
> vfio_reset_handler
> vfio_multiple_devices_migration_is_supported
>
> Per container list is used in below functions:
> vfio_devices_all_dirty_tracking
> vfio_devices_all_device_dirty_tracking
> vfio_devices_all_running_and_mig_active
> vfio_devices_dma_logging_stop
> vfio_devices_dma_logging_start
> vfio_devices_query_dirty_bitmap
>
> This is a prerequisite for future IOMMUFD backend support which
> has same kind of iteration requirement.
>
> vfio_group_list is preserved for some functions which honor group
> iteration, those functions are all related to legacy backend.
>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

This may be split into 3 patches
1. creation of container->device_list
2. creation of global device list
3. addition of container field in vbasedev (which is not described in
the commit msg by the way) and looks somehow unrelated to me?

Eric
> ---
>  include/hw/vfio/vfio-common.h |   5 +
>  hw/vfio/common.c              | 194 ++++++++++++++++------------------
>  2 files changed, 94 insertions(+), 105 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c486bdef2a..54905b9dd4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -98,6 +98,7 @@ typedef struct VFIOContainer {
>      QLIST_HEAD(, VFIOGroup) group_list;
>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>      QLIST_ENTRY(VFIOContainer) next;
> +    QLIST_HEAD(, VFIODevice) device_list;
>  } VFIOContainer;
>  
>  typedef struct VFIOGuestIOMMU {
> @@ -129,7 +130,10 @@ typedef struct VFIODeviceOps VFIODeviceOps;
>  
>  typedef struct VFIODevice {
>      QLIST_ENTRY(VFIODevice) next;
> +    QLIST_ENTRY(VFIODevice) container_next;
> +    QLIST_ENTRY(VFIODevice) global_next;
>      struct VFIOGroup *group;
> +    VFIOContainer *container;
>      char *sysfsdev;
>      char *name;
>      DeviceState *dev;
> @@ -229,6 +233,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
>  
>  extern const MemoryRegionOps vfio_region_ops;
>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> +typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>  extern VFIOGroupList vfio_group_list;
>  
>  bool vfio_mig_active(void);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 12ebf2f11d..645e2dc39a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -48,6 +48,8 @@
>  
>  VFIOGroupList vfio_group_list =
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> +static VFIODeviceList vfio_device_list =
> +    QLIST_HEAD_INITIALIZER(vfio_device_list);
>  static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>      QLIST_HEAD_INITIALIZER(vfio_address_spaces);
>  
> @@ -94,18 +96,15 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>  
>  bool vfio_mig_active(void)
>  {
> -    VFIOGroup *group;
>      VFIODevice *vbasedev;
>  
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> +    if (QLIST_EMPTY(&vfio_device_list)) {
>          return false;
>      }
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->migration_blocker) {
> -                return false;
> -            }
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->migration_blocker) {
> +            return false;
>          }
>      }
>      return true;
> @@ -120,19 +119,16 @@ static Error *multiple_devices_migration_blocker;
>   */
>  static bool vfio_multiple_devices_migration_is_supported(void)
>  {
> -    VFIOGroup *group;
>      VFIODevice *vbasedev;
>      unsigned int device_num = 0;
>      bool all_support_p2p = true;
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->migration) {
> -                device_num++;
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->migration) {
> +            device_num++;
>  
> -                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
> -                    all_support_p2p = false;
> -                }
> +            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
> +                all_support_p2p = false;
>              }
>          }
>      }
> @@ -184,7 +180,7 @@ void vfio_unblock_multiple_devices_migration(void)
>  
>  bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
> -    return vbasedev->group->container->space->as != &address_space_memory;
> +    return vbasedev->container->space->as != &address_space_memory;
>  }
>  
>  static void vfio_set_migration_error(int err)
> @@ -218,7 +214,6 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>  
>  static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>  {
> -    VFIOGroup *group;
>      VFIODevice *vbasedev;
>      MigrationState *ms = migrate_get_current();
>  
> @@ -227,19 +222,17 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>          return false;
>      }
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
>          }
>      }
>      return true;
> @@ -247,14 +240,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>  
>  static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>  {
> -    VFIOGroup *group;
>      VFIODevice *vbasedev;
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (!vbasedev->dirty_pages_supported) {
> -                return false;
> -            }
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (!vbasedev->dirty_pages_supported) {
> +            return false;
>          }
>      }
>  
> @@ -267,27 +257,24 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>   */
>  static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>  {
> -    VFIOGroup *group;
>      VFIODevice *vbasedev;
>  
>      if (!migration_is_active(migrate_get_current())) {
>          return false;
>      }
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
>          }
>      }
>      return true;
> @@ -1187,20 +1174,17 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>  {
>      VFIOPCIDevice *pcidev;
>      VFIODevice *vbasedev;
> -    VFIOGroup *group;
>      Object *owner;
>  
>      owner = memory_region_owner(section->mr);
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
>          }
>      }
>  
> @@ -1296,24 +1280,21 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>                                sizeof(uint64_t))] = {};
>      struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>      VFIODevice *vbasedev;
> -    VFIOGroup *group;
>  
>      feature->argsz = sizeof(buf);
>      feature->flags = VFIO_DEVICE_FEATURE_SET |
>                       VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (!vbasedev->dirty_tracking) {
> -                continue;
> -            }
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (!vbasedev->dirty_tracking) {
> +            continue;
> +        }
>  
> -            if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -                warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> -                             vbasedev->name, -errno, strerror(errno));
> -            }
> -            vbasedev->dirty_tracking = false;
> +        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> +                        vbasedev->name, -errno, strerror(errno));
>          }
> +        vbasedev->dirty_tracking = false;
>      }
>  }
>  
> @@ -1396,7 +1377,6 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>      struct vfio_device_feature *feature;
>      VFIODirtyRanges ranges;
>      VFIODevice *vbasedev;
> -    VFIOGroup *group;
>      int ret = 0;
>  
>      vfio_dirty_tracking_init(container, &ranges);
> @@ -1406,21 +1386,19 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>          return -errno;
>      }
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dirty_tracking) {
> -                continue;
> -            }
> +    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +        if (vbasedev->dirty_tracking) {
> +            continue;
> +        }
>  
> -            ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> -            if (ret) {
> -                ret = -errno;
> -                error_report("%s: Failed to start DMA logging, err %d (%s)",
> -                             vbasedev->name, ret, strerror(errno));
> -                goto out;
> -            }
> -            vbasedev->dirty_tracking = true;
> +        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
> +        if (ret) {
> +            ret = -errno;
> +            error_report("%s: Failed to start DMA logging, err %d (%s)",
> +                         vbasedev->name, ret, strerror(errno));
> +            goto out;
>          }
> +        vbasedev->dirty_tracking = true;
>      }
>  
>  out:
> @@ -1500,21 +1478,18 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
>                                             hwaddr size)
>  {
>      VFIODevice *vbasedev;
> -    VFIOGroup *group;
>      int ret;
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
>          }
>      }
>  
> @@ -1798,22 +1773,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>  
>  void vfio_reset_handler(void *opaque)
>  {
> -    VFIOGroup *group;
>      VFIODevice *vbasedev;
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dev->realized) {
> -                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
> -            }
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->dev->realized) {
> +            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>          }
>      }
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dev->realized && vbasedev->needs_reset) {
> -                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
> -            }
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->dev->realized && vbasedev->needs_reset) {
> +            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>          }
>      }
>  }
> @@ -2643,6 +2613,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>      int groupid = vfio_device_groupid(vbasedev, errp);
>      VFIODevice *vbasedev_iter;
>      VFIOGroup *group;
> +    VFIOContainer *container;
>      int ret;
>  
>      if (groupid < 0) {
> @@ -2666,8 +2637,14 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>      ret = vfio_get_device(group, name, vbasedev, errp);
>      if (ret) {
>          vfio_put_group(group);
> +        return ret;
>      }
>  
> +    container = group->container;
> +    vbasedev->container = container;
> +    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
> +    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +
>      return ret;
>  }
>  
> @@ -2675,6 +2652,13 @@ void vfio_detach_device(VFIODevice *vbasedev)
>  {
>      VFIOGroup *group = vbasedev->group;
>  
> +    if (!vbasedev->container) {
> +        return;
> +    }
> +
> +    QLIST_REMOVE(vbasedev, global_next);
> +    QLIST_REMOVE(vbasedev, container_next);
> +    vbasedev->container = NULL;
>      vfio_put_base_device(vbasedev);
>      vfio_put_group(group);
>  }


