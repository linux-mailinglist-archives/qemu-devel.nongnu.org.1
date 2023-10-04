Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8065D7B861D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5K4-0000X9-KO; Wed, 04 Oct 2023 13:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo5K3-0000Vp-4Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo5K1-0007VM-Ci
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2L9Dymgah2JN7fzKzCOj4HBQNSo3o1EZybmCd2e0Ys=;
 b=iBVKXt7KjW+5yxUd4Q3a1S7NlxI3lYW4JWJozwB+mt46PVpT5j93fbPnsITmfCY5qunhW1
 pFjOmbXfq9owJ+sDe44k8YlOxFB8RX0VT1FOSBlXa84GDFR7SF6kg/36CFpwLlUxiJ6jND
 TcRtLkNC+nki8gIeP5fL75xLhjI0Bd4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-pfmyhRwPMxOvQxU-blljLg-1; Wed, 04 Oct 2023 13:06:02 -0400
X-MC-Unique: pfmyhRwPMxOvQxU-blljLg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-668d9c1f741so57796d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439162; x=1697043962;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2L9Dymgah2JN7fzKzCOj4HBQNSo3o1EZybmCd2e0Ys=;
 b=OVgW2AFE5KxsJ6lawuybgncfol+1DnGLtevQgP8QisEL6mYbIjy17BVp8n1RwqCyj4
 9jyx2Hm1rKZhA4WqDruIahZflPFG0ooqFtBBWnOsw8nximrbppXOBLujHzjSMRiIXQVc
 /u3s0dY60d7QJcsgTa7tpHoNcq/qTySG+S6DhkWnjJl8VB1Gve55leXh9Ir6gNUfFoch
 WqwyS+mKLzAN4CUf8JHUervzCDHhjgH/JxO0pm7b4eVgb2I2SMjlApAsu91LUaxvTY5/
 oCZOB7Lg1/5RII78mK9RjuV+UKwD1Bhgm9KtWCZtyV7iDV+5n1WYAm2H/yY5lv3iITvs
 RP4g==
X-Gm-Message-State: AOJu0YzTdveQmKhbAdxNY4LsetRO/pKVwOJnUPv2CqA/RMNsu/VZSc/4
 vI7RjXbClaJDsZHP48uo+7vD9msFIXR78LkUp8jKjhNcAhsL+MOHhg94+YQ2+F6Z56EySze4mUf
 Abq3cbMvFG+or3Eic2viki+A=
X-Received: by 2002:a0c:a982:0:b0:658:26d7:72d8 with SMTP id
 a2-20020a0ca982000000b0065826d772d8mr2421233qvb.41.1696439162077; 
 Wed, 04 Oct 2023 10:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAoPLqTtgJ+bk0hvkVKl2dAONUKi5Qo87jfuoKbzvfvOQNKiNG/ORh4W7sBB6YuqPJuxPYpg==
X-Received: by 2002:a0c:a982:0:b0:658:26d7:72d8 with SMTP id
 a2-20020a0ca982000000b0065826d772d8mr2421203qvb.41.1696439161810; 
 Wed, 04 Oct 2023 10:06:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a0cf34e000000b0065cfb75fe81sm1439957qvm.67.2023.10.04.10.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:06:01 -0700 (PDT)
Message-ID: <98853d8b-2abe-55bb-83fe-89316e809c2d@redhat.com>
Date: Wed, 4 Oct 2023 19:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 14/15] vfio/common: Introduce a global VFIODevice list
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
References: <20231004154518.334760-1-eric.auger@redhat.com>
 <20231004154518.334760-15-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231004154518.334760-15-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/4/23 17:44, Eric Auger wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Some functions iterate over all the VFIODevices. This is currently
> achieved by iterating over all groups/devices. Let's
> introduce a global list of VFIODevices simplifying that scan.
> 
> This will also be useful while migrating to IOMMUFD by hiding the
> group specificity.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/common.c              | 45 +++++++++++++++--------------------
>   2 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index bf12e40667..54905b9dd4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -131,6 +131,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
>   typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) next;
>       QLIST_ENTRY(VFIODevice) container_next;
> +    QLIST_ENTRY(VFIODevice) global_next;
>       struct VFIOGroup *group;
>       VFIOContainer *container;
>       char *sysfsdev;
> @@ -232,6 +233,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
>   
>   extern const MemoryRegionOps vfio_region_ops;
>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> +typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIOGroupList vfio_group_list;
>   
>   bool vfio_mig_active(void);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b14f04c9b0..5dd03763d2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -48,6 +48,8 @@
>   
>   VFIOGroupList vfio_group_list =
>       QLIST_HEAD_INITIALIZER(vfio_group_list);
> +static VFIODeviceList vfio_device_list =
> +    QLIST_HEAD_INITIALIZER(vfio_device_list);
>   static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>       QLIST_HEAD_INITIALIZER(vfio_address_spaces);
>   
> @@ -94,18 +96,15 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>   
>   bool vfio_mig_active(void)
>   {
> -    VFIOGroup *group;
>       VFIODevice *vbasedev;
>   
> -    if (QLIST_EMPTY(&vfio_group_list)) {
> +    if (QLIST_EMPTY(&vfio_device_list)) {
>           return false;
>       }
>   
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->migration_blocker) {
> -                return false;
> -            }
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->migration_blocker) {
> +            return false;
>           }
>       }
>       return true;
> @@ -120,19 +119,16 @@ static Error *multiple_devices_migration_blocker;
>    */
>   static bool vfio_multiple_devices_migration_is_supported(void)
>   {
> -    VFIOGroup *group;
>       VFIODevice *vbasedev;
>       unsigned int device_num = 0;
>       bool all_support_p2p = true;
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
>               }
>           }
>       }
> @@ -1777,22 +1773,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>   
>   void vfio_reset_handler(void *opaque)
>   {
> -    VFIOGroup *group;
>       VFIODevice *vbasedev;
>   
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dev->realized) {
> -                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
> -            }
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->dev->realized) {
> +            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>           }
>       }
>   
> -    QLIST_FOREACH(group, &vfio_group_list, next) {
> -        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -            if (vbasedev->dev->realized && vbasedev->needs_reset) {
> -                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
> -            }
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +        if (vbasedev->dev->realized && vbasedev->needs_reset) {
> +            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>           }
>       }
>   }
> @@ -2657,6 +2648,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       container = group->container;
>       vbasedev->container = container;
>       QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
> +    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>   
>       return ret;
>   }
> @@ -2665,6 +2657,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
> +    QLIST_REMOVE(vbasedev, global_next);
>       QLIST_REMOVE(vbasedev, container_next);
>       vbasedev->container = NULL;
>       trace_vfio_detach_device(vbasedev->name, group->groupid);


