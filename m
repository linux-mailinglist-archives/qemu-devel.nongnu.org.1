Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF47D9C7C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwOMu-0006a6-1L; Fri, 27 Oct 2023 11:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwOMm-0006Xy-DU
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwOMk-0006X9-F2
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698418993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nTcTa7Y3BqC2xugGtfHKCxxytnXG3nlheXTLJV5t2U=;
 b=D8MhI70ItRgU0nMrGLHLEnp2cSMDSguMFb09ShahaTjt1gPy20eFLqBIpSVRAGtL9d7z1g
 sdWX6TC4MLnQZHm1uW0+458AJa0QRAyOFe1Y1jqtO4sbTc2qkPFdZbm4y9pJKkB1GJUTO8
 uhKrJAE0VoJepbM/5wZEjJHVYAems8A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-5tFTBpJ2O7K4A8f585EGNA-1; Fri, 27 Oct 2023 11:03:11 -0400
X-MC-Unique: 5tFTBpJ2O7K4A8f585EGNA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cd638a4beso27641821cf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698418990; x=1699023790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9nTcTa7Y3BqC2xugGtfHKCxxytnXG3nlheXTLJV5t2U=;
 b=V5DL+1jc1xyt7q2yk5vp+lSRISLYY5uZSLAYrOCJpBYEXxNIzRSb7YyeYnvuj12K3f
 epXkMCwcMoWJ6b9p+ZvsTee1hUQUtcJeZjvy+3EtViB6z6RdCjkm9iZlSgRcTub7r4yJ
 Brb18r31ACt/Lc6YXg+MJ7YHx0pIzqJlmJ4+YigoRQNk9i15+tWUCMNLOEoTSKjn2qUY
 HWLvf8+iagDyjLIsNmrZ/QK4IvGgThOEydxTS7uN7HncIQBRTxO7WDCEElvgn3vn8oGL
 DM/86dfWnb+JsmwVUKkIj4rPPCfKeM7gKN/8ufZgqvXtYXN92dqHc1QAWVeo7uTVMGTE
 XILQ==
X-Gm-Message-State: AOJu0Yz3Ac0ukoqJBqEnDSha5+VQkWUEoriYy856Jza48SecISIW6IEA
 AB1VoCFQi0n3GOP6dHH7/M2l524D9dMGAQ9F5CbejdzsIMN8KvDPkOJ2BKUv/0fvqTHefjy3amo
 Cv/o39M2IFAJph00=
X-Received: by 2002:ac8:5a8f:0:b0:41e:37cf:8661 with SMTP id
 c15-20020ac85a8f000000b0041e37cf8661mr3289093qtc.12.1698418990252; 
 Fri, 27 Oct 2023 08:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWI8LD2MCDMB4EGzvXsuxh6i5JEBWfA6AbYVQPT61xbIM2NPSx9xef10G7JDDrjFs2F267IA==
X-Received: by 2002:ac8:5a8f:0:b0:41e:37cf:8661 with SMTP id
 c15-20020ac85a8f000000b0041e37cf8661mr3289049qtc.12.1698418989754; 
 Fri, 27 Oct 2023 08:03:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a05622a15ce00b00418189b689csm651915qty.10.2023.10.27.08.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 08:03:09 -0700 (PDT)
Message-ID: <d4b331ba-593a-454a-bb34-1d30ae603eb8@redhat.com>
Date: Fri, 27 Oct 2023 17:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/37] vfio/container: Move per container device list
 in base container
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-13-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-13-zhenzhong.duan@intel.com>
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
> VFIO Device is also changed to point to base container instead of
> legacy container.
> 
> No fucntional change intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> [ clg: context changes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Please drop my SoB.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h         |  3 +--
>   include/hw/vfio/vfio-container-base.h |  1 +
>   hw/vfio/common.c                      | 23 +++++++++++++++--------
>   hw/vfio/container.c                   | 12 ++++++------
>   4 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d053c61872..f7a84dc8d0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -90,7 +90,6 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> -    QLIST_HEAD(, VFIODevice) device_list;
>       GList *iova_ranges;
>   } VFIOContainer;
>   
> @@ -118,7 +117,7 @@ typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) container_next;
>       QLIST_ENTRY(VFIODevice) global_next;
>       struct VFIOGroup *group;
> -    VFIOContainer *container;
> +    VFIOContainerBase *bcontainer;
>       char *sysfsdev;
>       char *name;
>       DeviceState *dev;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index ea8436a064..f1de1ef120 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -53,6 +53,7 @@ typedef struct VFIOContainerBase {
>       bool dirty_pages_supported;
>       QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>       QLIST_ENTRY(VFIOContainerBase) next;
> +    QLIST_HEAD(, VFIODevice) device_list;
>   } VFIOContainerBase;
>   
>   typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7d9b87fc67..f8475348ad 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -145,7 +145,7 @@ void vfio_unblock_multiple_devices_migration(void)
>   
>   bool vfio_viommu_preset(VFIODevice *vbasedev)
>   {
> -    return vbasedev->container->bcontainer.space->as != &address_space_memory;
> +    return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>   
>   static void vfio_set_migration_error(int err)
> @@ -179,6 +179,7 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>   
>   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>       MigrationState *ms = migrate_get_current();
>   
> @@ -187,7 +188,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>           return false;
>       }
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           VFIOMigration *migration = vbasedev->migration;
>   
>           if (!migration) {
> @@ -205,9 +206,10 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>   
>   bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           if (!vbasedev->dirty_pages_supported) {
>               return false;
>           }
> @@ -222,13 +224,14 @@ bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
>    */
>   bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>   
>       if (!migration_is_active(migrate_get_current())) {
>           return false;
>       }
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           VFIOMigration *migration = vbasedev->migration;
>   
>           if (!migration) {
> @@ -835,12 +838,13 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>                                        VFIOContainer *container)
>   {
>       VFIOPCIDevice *pcidev;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>       Object *owner;
>   
>       owner = memory_region_owner(section->mr);
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>               continue;
>           }
> @@ -941,13 +945,14 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>                                 sizeof(uint64_t))] = {};
>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>   
>       feature->argsz = sizeof(buf);
>       feature->flags = VFIO_DEVICE_FEATURE_SET |
>                        VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           if (!vbasedev->dirty_tracking) {
>               continue;
>           }
> @@ -1038,6 +1043,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>   {
>       struct vfio_device_feature *feature;
>       VFIODirtyRanges ranges;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>       int ret = 0;
>   
> @@ -1048,7 +1054,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
>           return -errno;
>       }
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           if (vbasedev->dirty_tracking) {
>               continue;
>           }
> @@ -1141,10 +1147,11 @@ int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
>                                       VFIOBitmap *vbmap, hwaddr iova,
>                                       hwaddr size)
>   {
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
>       int ret;
>   
> -    QLIST_FOREACH(vbasedev, &container->device_list, container_next) {
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           ret = vfio_device_dma_logging_report(vbasedev, iova, size,
>                                                vbmap->bitmap);
>           if (ret) {
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 6f02ca133e..3228dd2109 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -889,7 +889,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
> -    VFIOContainer *container;
> +    VFIOContainerBase *bcontainer;
>       int ret;
>   
>       if (groupid < 0) {
> @@ -916,9 +916,9 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>           return ret;
>       }
>   
> -    container = group->container;
> -    vbasedev->container = container;
> -    QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
> +    bcontainer = &group->container->bcontainer;
> +    vbasedev->bcontainer = bcontainer;
> +    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>   
>       return ret;
> @@ -928,13 +928,13 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
> -    if (!vbasedev->container) {
> +    if (!vbasedev->bcontainer) {
>           return;
>       }
>   
>       QLIST_REMOVE(vbasedev, global_next);
>       QLIST_REMOVE(vbasedev, container_next);
> -    vbasedev->container = NULL;
> +    vbasedev->bcontainer = NULL;
>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);


