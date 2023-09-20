Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF87A7F7E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwHZ-0001KF-8f; Wed, 20 Sep 2023 08:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qiwHG-0001Ji-DM
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qiwHD-0007oM-KB
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695212753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq0WWWiBVGhiCWYlrSHUzvAUDpt7LlcvKXGGR30LL3U=;
 b=im89CcBxM8NW3IganCXK74blkdeTGtxCt3o7tIIVyhCAoiHa394kFDnhnR2OflrDEGwfzD
 ID8E8CZ8MVuKe22v+zpKbGd8uFniyG6PufVxGLwjovIIA4yHTrBbr8C3qkeGfO18qsXSRi
 mYUlll/QNZBaWrtUKguimzTyrgczETM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-sbDlFQJ9MS-i4KHxusBCIg-1; Wed, 20 Sep 2023 08:25:52 -0400
X-MC-Unique: sbDlFQJ9MS-i4KHxusBCIg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f3eaa5c5eso4334843f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 05:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695212751; x=1695817551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wq0WWWiBVGhiCWYlrSHUzvAUDpt7LlcvKXGGR30LL3U=;
 b=tfMEDsKuwdm6o1K3ZTU4XWt1peh/H3F+IFk8uIVP9ztfqZOA2brRZfMMLrckled/ru
 vMmwXPx8ThWmA1QzO64TcyXyRHPDwPBKZHzwieiEET/2tWLjwVUNt5IXAwq1VqtrVQXY
 scaQav0bR097+0jBzHteAD/b4dotCOig0vXxI20b7TUhwP0AmnW8C089m1H8xxciIfOv
 3J5g0bboNVIdz1L120CKnVTTF+dXxKigGBBuhBUYNrKte9YJh497UvzwtQ5flE3/jGeG
 LC3E/w7W1BN2jKrmjp6icpIG4+TwYLKiplN5WSRec5XacpME08uphTFcNuzxpc72A7Kq
 41nQ==
X-Gm-Message-State: AOJu0YyU9zxGCPoGvZg+Z3/6YZ4jRGdF6L8z0OMK2yAY5BohrgXeZcuD
 3OEnCeO+VyYi0wd0Y3cyb3xtGrAb/xrPnk61ODKDG6XqkI+YOSkBetcaR9Ff//vy4MQ8ryu3+Uu
 Yur8pnQVeYgnA2YI=
X-Received: by 2002:a5d:4d4d:0:b0:320:bb1:5a73 with SMTP id
 a13-20020a5d4d4d000000b003200bb15a73mr2092037wru.22.1695212750924; 
 Wed, 20 Sep 2023 05:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Jd010ioGRWqtZo8GPwIIXWgHu2KRScusR8u8o5VJzLrMZvdUcPhxiKIZEbKHK9tif5ze4Q==
X-Received: by 2002:a5d:4d4d:0:b0:320:bb1:5a73 with SMTP id
 a13-20020a5d4d4d000000b003200bb15a73mr2092013wru.22.1695212750437; 
 Wed, 20 Sep 2023 05:25:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 f4-20020adfdb44000000b00318147fd2d3sm18534105wrj.41.2023.09.20.05.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 05:25:49 -0700 (PDT)
Message-ID: <7a8611de-eef9-9e11-766e-77c20d6973b7@redhat.com>
Date: Wed, 20 Sep 2023 14:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 06/22] vfio/common: Add a vfio device iterator
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-7-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230830103754.36461-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
I would move the reset handler registration/unregistration changes in a
separate patch.
besides,  I don't catch what you mean by
"saying first vfio address space created instead of the first group."
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
I would add a comment:
iterate on all devices from all groups attached to a container
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
> +        group = curr->group->container_next.le_next;
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

Couldn't you use an extra define such as:
#define CONTAINER_FOREACH_DEV(container, vbasedev) \
vbasedev = NULL
while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev)))

> +                if (vbasedev->migration_blocker) {
> +                    return false;
> +                }
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
Thanks

Eric


