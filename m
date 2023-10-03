Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B077B6D85
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhla-0004KQ-My; Tue, 03 Oct 2023 11:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhlY-0004JW-0K
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhlW-0006Pf-DJ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696348613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izzk9BsrU+TaRkVE9KUr4NHA+dfK0bdoLL60nb1Gp9A=;
 b=Z+Wnx8A0VA0pfQ73NATJd55yqSHoBh1sia8W5vP3FxU6Xx/u3knyjCqcXfhWuTrr9rFoaU
 jWJUtxwlIPDH6jHZZ7bpP0eEuPlk5GvUSjsjiNLfkp6YGfCvl68tyVRIwK0FEzsPIkPBpB
 2fIfuDfaYOMpYYhn5bHAuBaRng5j3B8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-2BlbQ2w6MlOXYRUwr5bzpA-1; Tue, 03 Oct 2023 11:56:52 -0400
X-MC-Unique: 2BlbQ2w6MlOXYRUwr5bzpA-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-48fdc9282ffso390011e0c.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696348612; x=1696953412;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=izzk9BsrU+TaRkVE9KUr4NHA+dfK0bdoLL60nb1Gp9A=;
 b=Aov7x7eD9NoCfkH5dXe/+K723egDeF+joWLFCs/adwmqMN9R1m2uixgqcs2jC5vdA/
 4wcbGYLGBdD1dRQSbQCLkRfu2364TmiKn1BKErd/7kKXO980bI7a7pa2CRMzfLtM/MdI
 POSaRQmOSFL5s+Ng2TxzdDKgILDhzlgvwuMz2JgF0qOqTkqDBSTzapKsUHYtmKo+BAqb
 IE7xCF9A6qkFSzqBdHAI5z6BnaVJc+nJ7uNb+khuny+1eMPInMwTVH5ODykQgKw7Rgp5
 OYTYXJEkh3OsMcV7bGZAaPerwS9r5/lDKEkA0K8tGS+LcvFatZKIYazSdK/kp20tixn7
 d4Aw==
X-Gm-Message-State: AOJu0YxRG2qrpsl+FLEZxwTGnkESBkbvSiyKLwcGtXgvBLSQ95okyqey
 FuN46uOW8s5RbD6Be2j4H6MTdcyVeHIccHuVrGcjHjZERglwyQmnrOSKLk21m46vpMamAlFw+s6
 4PKhQBKC0MNwO8dE=
X-Received: by 2002:a1f:e3c6:0:b0:496:a6cc:7ffe with SMTP id
 a189-20020a1fe3c6000000b00496a6cc7ffemr9901526vkh.13.1696348611861; 
 Tue, 03 Oct 2023 08:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs73yHnD8bRAkWHmmQlAvrg7mL4nO/HQBgGNZVLBqsGdbiJXm+LF8UlQ/CaU5GwSKcxY3Dqg==
X-Received: by 2002:a1f:e3c6:0:b0:496:a6cc:7ffe with SMTP id
 a189-20020a1fe3c6000000b00496a6cc7ffemr9901497vkh.13.1696348611376; 
 Tue, 03 Oct 2023 08:56:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c15-20020ac84e0f000000b004197d6d97c4sm537022qtw.24.2023.10.03.08.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:56:51 -0700 (PDT)
Message-ID: <2bcff7f9-b4d0-4942-953c-1b25533217d1@redhat.com>
Date: Tue, 3 Oct 2023 17:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 14/15] vfio/common: Introduce a global VFIODevice list
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-15-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-15-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
> Some functions iterate over all the VFIODevices. This is currently
> achieved by iterating over all groups/devices. Let's
> introduce a global list of VFIODevices simplifying that scan.

Maybe we should move the qemu_register_reset() when the first device
is added to the list, in vfio_attach_device() ?

Thanks,

C.

> 
> This will also be useful while migrating to IOMMUFD by hiding the
> group specificity.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
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
> index 55f8a113ea..95bc50bcda 100644
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
> @@ -2669,6 +2661,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
>           return;
>       }
>   
> +    QLIST_REMOVE(vbasedev, global_next);
>       QLIST_REMOVE(vbasedev, container_next);
>       vbasedev->container = NULL;
>       trace_vfio_detach_device(vbasedev->name, group->groupid);


