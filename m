Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F577A8F28
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj5Uh-00011s-Nz; Wed, 20 Sep 2023 18:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj5Uc-0000zb-33
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj5UZ-0007FE-Mg
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695248178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gw/LrQC4ZCr4F1xGADvnDLGNP6KW2nZdcc040Xc8xEQ=;
 b=EVt/29R/enM6aSzisYp/seV1vDtfSAXeg8ToW64UvQYeBB+slOVerlMW4TD3//aPVZOHjh
 Z1CzPxTlQh0OT1s9gPaOL94FlUkExcWQvi+hJS5fvvfoiNUAvxXrqI2WlD+gdAlcMO4O9b
 uubYdk0VQln3AGfrSVjs9zM38sdbosg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-cJW_5RKFPReUgFfpdxZJQA-1; Wed, 20 Sep 2023 18:16:17 -0400
X-MC-Unique: cJW_5RKFPReUgFfpdxZJQA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7868ec37aa7so24303939f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695248176; x=1695852976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gw/LrQC4ZCr4F1xGADvnDLGNP6KW2nZdcc040Xc8xEQ=;
 b=DY4Kkr4si4sGt4ST1WwyNrWU/Ks++ZTwfPqx1011gX3z32Uz+GpyVUkGOntgG4s1+2
 YyciQNAXLt4a87M13G1A1dMGKs+CS/xC1iY8YTOz7pAbM5htOozPDfHbjny61cqL2rCp
 V0fC6pkSOE5AuHDVPU8b2oBfGEeu8bceJP3SBDsohvoSkMNT5U/e0dhAVNi50cp6+Clg
 qM5kJwBpb0NHuzLjkehIcUlayWC22awiNBaqKyudastLm1hTy4om94oSRMPYQNWDCHxq
 obp/CQel7jJm5YTuSBPvScsQDxRpZbP+7NM+pqpAoq/O/b1zz3igJqSGxE+LT3z0mvnp
 Rzpw==
X-Gm-Message-State: AOJu0YywRNrncf+uGHXbBREJA05GS/bM4Xxg4Y9AlHml22JEqFHML95V
 oXdRbWLDxTVpOBT51YeWgA8H3nUZ6s+NPE6GfsE6JeXEnh3Q9IKc2OQ55NyZwa65yckjair0kgN
 PZ7Elgx4Fsm9Pl+o=
X-Received: by 2002:a05:6602:22c9:b0:792:72b8:b8a with SMTP id
 e9-20020a05660222c900b0079272b80b8amr3751369ioe.18.1695248176105; 
 Wed, 20 Sep 2023 15:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2HnFcKah1OXgVjQtSU8V+MfmVME5i1n3j3qxLmiWELfxVrjGZ5VRIIw4zhZkk4ddZZjebSg==
X-Received: by 2002:a05:6602:22c9:b0:792:72b8:b8a with SMTP id
 e9-20020a05660222c900b0079272b80b8amr3751351ioe.18.1695248175761; 
 Wed, 20 Sep 2023 15:16:15 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 d26-20020a02a49a000000b004290fd3a68dsm1289jam.1.2023.09.20.15.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 15:16:15 -0700 (PDT)
Date: Wed, 20 Sep 2023 16:16:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
Message-ID: <20230920161614.3d9e4e5b.alex.williamson@redhat.com>
In-Reply-To: <20230830103754.36461-7-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-7-zhenzhong.duan@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 30 Aug 2023 18:37:38 +0800
Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> With a vfio device iterator added, we can make some migration and reset
> related functions group agnostic.
> E.x:
> vfio_mig_active
> vfio_migratable_device_num
> vfio_devices_all_dirty_tracking
> vfio_devices_all_device_dirty_tracking
> vfio_devices_all_running_and_mig_active
> vfio_devices_dma_logging_stop
> vfio_devices_dma_logging_start
> vfio_devices_query_dirty_bitmap
> vfio_reset_handler
> 
> Or else we need to add container specific callback variants for above
> functions just because they iterate devices based on group.
> 
> Move the reset handler registration/unregistration to a place that is not
> group specific, saying first vfio address space created instead of the
> first group.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 224 ++++++++++++++++++++++++++---------------------
>  1 file changed, 122 insertions(+), 102 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 949ad6714a..51c6e7598e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -84,6 +84,26 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
>      }
>  }
>  
> +static VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
> +                                                VFIODevice *curr)
> +{
> +    VFIOGroup *group;
> +
> +    if (!curr) {
> +        group = QLIST_FIRST(&container->group_list);
> +    } else {
> +        if (curr->next.le_next) {
> +            return curr->next.le_next;
> +        }


VFIODevice *device = QLIST_NEXT(curr, next);

if (device) {
    return device;
}

> +        group = curr->group->container_next.le_next;


group = QLIST_NEXT(curr->group, container_next);

> +    }
> +
> +    if (!group) {
> +        return NULL;
> +    }
> +    return QLIST_FIRST(&group->device_list);
> +}
> +
>  /*
>   * Device state interfaces
>   */
> @@ -112,17 +132,22 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>  
>  bool vfio_mig_active(void)
>  {
> -    VFIOGroup *group;
> +    VFIOAddressSpace *space;
> +    VFIOContainer *container;
>      VFIODevice *vbasedev;
>  
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
>          return false;
>      }
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->migration_blocker) {
> -                return false;
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        QLIST_FOREACH(container, &space->containers, next) {
> +            vbasedev = NULL;
> +            while ((vbasedev = vfio_container_dev_iter_next(container,
> +                                                            vbasedev))) {
> +                if (vbasedev->migration_blocker) {
> +                    return false;
> +                }

Appears easy to avoid setting vbasedev in the loop iterator and
improving the scope of vbasedev:

VFIODevice *vbasedev = vfio_container_dev_iter_next(container, NULL);

while (vbasedev) {
    if (vbasedev->migration_blocker) {
        return false;
    }

    vbasedev = vfio_container_dev_iter_next(container, vbasedev);
}

>              }
>          }
>      }
> @@ -133,14 +158,19 @@ static Error *multiple_devices_migration_blocker;
>  
>  static unsigned int vfio_migratable_device_num(void)
>  {
> -    VFIOGroup *group;
> +    VFIOAddressSpace *space;
> +    VFIOContainer *container;
>      VFIODevice *vbasedev;
>      unsigned int device_num = 0;
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->migration) {
> -                device_num++;
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        QLIST_FOREACH(container, &space->containers, next) {
> +            vbasedev = NULL;
> +            while ((vbasedev = vfio_container_dev_iter_next(container,
> +                                                            vbasedev))) {
> +                if (vbasedev->migration) {
> +                    device_num++;
> +                }

Same as above.

>              }
>          }
>      }
> @@ -207,8 +237,7 @@ static void vfio_set_migration_error(int err)
>  
>  static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>  {
> -    VFIOGroup *group;
> -    VFIODevice *vbasedev;
> +    VFIODevice *vbasedev = NULL;
>      MigrationState *ms = migrate_get_current();
>  
>      if (ms->state != MIGRATION_STATUS_ACTIVE &&
> @@ -216,19 +245,17 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>          return false;
>      }
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            VFIOMigration *migration = vbasedev->migration;
> +    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
> +        VFIOMigration *migration = vbasedev->migration;

Similar, and all the other loops below.

>  
> -            if (!migration) {
> -                return false;
> -            }
> +        if (!migration) {
> +            return false;
> +        }
>  
> -            if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
> -                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> -                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
> -                return false;
> -            }
> +        if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
> +            (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> +             migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
> +            return false;
>          }
>      }
>      return true;
> @@ -236,14 +263,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>  
>  static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>  {
> -    VFIOGroup *group;
> -    VFIODevice *vbasedev;
> +    VFIODevice *vbasedev = NULL;
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (!vbasedev->dirty_pages_supported) {
> -                return false;
> -            }
> +    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
> +        if (!vbasedev->dirty_pages_supported) {
> +            return false;
>          }
>      }
>  
> @@ -256,27 +280,24 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>   */
>  static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>  {
> -    VFIOGroup *group;
> -    VFIODevice *vbasedev;
> +    VFIODevice *vbasedev = NULL;
>  
>      if (!migration_is_active(migrate_get_current())) {
>          return false;
>      }
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            VFIOMigration *migration = vbasedev->migration;
> +    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
> +        VFIOMigration *migration = vbasedev->migration;
>  
> -            if (!migration) {
> -                return false;
> -            }
> +        if (!migration) {
> +            return false;
> +        }
>  
> -            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> -                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
> -                continue;
> -            } else {
> -                return false;
> -            }
> +        if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
> +            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
> +            continue;
> +        } else {
> +            return false;
>          }
>      }
>      return true;
> @@ -1243,25 +1264,22 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>                                sizeof(uint64_t))] = {};
>      struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> -    VFIODevice *vbasedev;
> -    VFIOGroup *group;
> +    VFIODevice *vbasedev = NULL;
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
> +    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
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
> @@ -1336,8 +1354,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>  {
>      struct vfio_device_feature *feature;
>      VFIODirtyRanges ranges;
> -    VFIODevice *vbasedev;
> -    VFIOGroup *group;
> +    VFIODevice *vbasedev = NULL;
>      int ret = 0;
>  
>      vfio_dirty_tracking_init(container, &ranges);
> @@ -1347,21 +1364,19 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>          return -errno;
>      }
>  
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dirty_tracking) {
> -                continue;
> -            }
> +    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
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
> @@ -1440,22 +1455,19 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
>                                             VFIOBitmap *vbmap, hwaddr iova,
>                                             hwaddr size)
>  {
> -    VFIODevice *vbasedev;
> -    VFIOGroup *group;
> +    VFIODevice *vbasedev = NULL;
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
> +    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
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
> @@ -1739,21 +1751,30 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>  
>  void vfio_reset_handler(void *opaque)
>  {
> -    VFIOGroup *group;
> +    VFIOAddressSpace *space;
> +    VFIOContainer *container;
>      VFIODevice *vbasedev;
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dev->realized) {
> -                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        QLIST_FOREACH(container, &space->containers, next) {
> +            vbasedev = NULL;
> +            while ((vbasedev = vfio_container_dev_iter_next(container,
> +                                                            vbasedev))) {
> +                if (vbasedev->dev->realized) {
> +                    vbasedev->ops->vfio_compute_needs_reset(vbasedev);
> +                }
>              }
>          }
>      }
>  
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dev->realized && vbasedev->needs_reset) {
> -                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        QLIST_FOREACH(container, &space->containers, next) {
> +            vbasedev = NULL;
> +            while ((vbasedev = vfio_container_dev_iter_next(container,
> +                                                            vbasedev))) {
> +                if (vbasedev->dev->realized && vbasedev->needs_reset) {
> +                    vbasedev->ops->vfio_hot_reset_multi(vbasedev);
> +                    }
>              }
>          }
>      }
> @@ -1841,6 +1862,10 @@ static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>      space->as = as;
>      QLIST_INIT(&space->containers);
>  
> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
> +        qemu_register_reset(vfio_reset_handler, NULL);
> +    }
> +

We could just have a vfio_device_list to avoid iterating either
containers and group or address spaces.  Thanks,

Alex

>      QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
>  
>      return space;
> @@ -1852,6 +1877,9 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>          QLIST_REMOVE(space, list);
>          g_free(space);
>      }
> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
> +        qemu_unregister_reset(vfio_reset_handler, NULL);
> +    }
>  }
>  
>  /*
> @@ -2317,10 +2345,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>          goto close_fd_exit;
>      }
>  
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> -        qemu_register_reset(vfio_reset_handler, NULL);
> -    }
> -
>      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
>  
>      return group;
> @@ -2349,10 +2373,6 @@ void vfio_put_group(VFIOGroup *group)
>      trace_vfio_put_group(group->fd);
>      close(group->fd);
>      g_free(group);
> -
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> -        qemu_unregister_reset(vfio_reset_handler, NULL);
> -    }
>  }
>  
>  struct vfio_device_info *vfio_get_device_info(int fd)


