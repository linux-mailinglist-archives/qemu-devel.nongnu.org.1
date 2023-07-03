Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F2745F3C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGL04-0000QR-M3; Mon, 03 Jul 2023 10:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGKzv-0000LB-8P
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGKzt-0001l3-2p
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688396267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntewIDICB/HwPBr5opF5WCK6UOtCvWT5hmG8bKOzS3g=;
 b=XUrwWpu0UTvaJjtJq/IhMqFU3s6F9alzokUKRSTEEUHtG6DHt4kzStbKwGYfWsCNLufyBC
 rJI7BPijmYIIaVBlqAXS5I5k98nlPjheGueXSgf0L44RNSyM+uxtk8kLRsTBbgUlYD+LHG
 ycaRi4nxwAZPfa4TC0+oVAGAkcvivb0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-dG5h7yYROaGUT2psPtHYog-1; Mon, 03 Jul 2023 10:57:46 -0400
X-MC-Unique: dG5h7yYROaGUT2psPtHYog-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-765ab532883so551094485a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688396265; x=1690988265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntewIDICB/HwPBr5opF5WCK6UOtCvWT5hmG8bKOzS3g=;
 b=NRjHdWOFLN0jvpBUcQu3/FNW17IbZLeb7agqPPCbPU+m7nz7Xl26J4BbYmXqv/YX4u
 gtbdgCsfyvSYEEMboRYUXcn3+j9nYTcmkqVOBBFXU/VpWKD2S/Ou4BsxP+Xo4zzxF+ok
 zqAFPUjQmX+U68k/xGcCHxP/takmN7ReadtZgom+zSAPXw3n0PBep1Q71Pv7oKAv5PXB
 xbpfc4pXN3b3v971IpcDyombVaZsEbAwQtr4V1MvjMn3svTusgqpovTQaB3u2NAjDXgU
 oGb75uCwoz16CLo/AZ33yFSkMkmb7qSy4sQsMaE5ggbHw733dfMbLEqxivo62GJZJ/td
 kGWg==
X-Gm-Message-State: AC+VfDygqQRSfg8/yEUCtsHqSCnN1M2EG88L2aWspdX1xO5tx3oQeNhJ
 pf9tfZXiNq/Zy8AsOXd7UDi6NQicq6EXjN8GfbhdeB9rnWzXD8+LqaJK4lX6c930SO8mpefk/wS
 w0hEKQ+oTYHrPJss=
X-Received: by 2002:a05:620a:2a02:b0:765:4d13:dbd3 with SMTP id
 o2-20020a05620a2a0200b007654d13dbd3mr13029522qkp.43.1688396265793; 
 Mon, 03 Jul 2023 07:57:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pjHNjfwHcL2YcxOyiijkuCbdJWlvWwn2HQSHu049nvOEmBY/rbuo90ZAr+Ckcj5G7cqMjtg==
X-Received: by 2002:a05:620a:2a02:b0:765:4d13:dbd3 with SMTP id
 o2-20020a05620a2a0200b007654d13dbd3mr13029506qkp.43.1688396265549; 
 Mon, 03 Jul 2023 07:57:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 da34-20020a05620a362200b0075b2af4a076sm647840qkb.16.2023.07.03.07.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 07:57:45 -0700 (PDT)
Message-ID: <2fe67037-e6ae-7cea-d1ab-462e7789bc2e@redhat.com>
Date: Mon, 3 Jul 2023 16:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 4/7] vfio/migration: Change vIOMMU blocker from global
 to per device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
 <20230703071510.160712-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230703071510.160712-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/23 09:15, Zhenzhong Duan wrote:
> Contrary to multiple device blocker which needs to consider already-attached
> devices to unblock/block dynamically, the vIOMMU migration blocker is a device
> specific config. Meaning it only needs to know whether the device is bypassing
> or not the vIOMMU (via machine property, or per pxb-pcie::bypass_iommu), and
> does not need the state of currently present devices. For this reason, the
> vIOMMU global migration blocker can be consolidated into the per-device
> migration blocker, allowing us to remove some unnecessary code.
> 
> This change also makes vfio_mig_active() more accurate as it doesn't check for
> global blocker.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c              | 51 ++---------------------------------
>   hw/vfio/migration.c           |  7 ++---
>   hw/vfio/pci.c                 |  1 -
>   include/hw/vfio/vfio-common.h |  3 +--
>   4 files changed, 7 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 77e2ee0e5c6e..9aac21abb76e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -362,7 +362,6 @@ bool vfio_mig_active(void)
>   }
>   
>   static Error *multiple_devices_migration_blocker;
> -static Error *giommu_migration_blocker;
>   
>   static unsigned int vfio_migratable_device_num(void)
>   {
> @@ -420,55 +419,9 @@ void vfio_unblock_multiple_devices_migration(void)
>       multiple_devices_migration_blocker = NULL;
>   }
>   
> -static bool vfio_viommu_preset(void)
> +bool vfio_viommu_preset(VFIODevice *vbasedev)
>   {
> -    VFIOAddressSpace *space;
> -
> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> -        if (space->as != &address_space_memory) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
> -{
> -    int ret;
> -
> -    if (giommu_migration_blocker ||
> -        !vfio_viommu_preset()) {
> -        return 0;
> -    }
> -
> -    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> -        error_setg(errp,
> -                   "Migration is currently not supported with vIOMMU enabled");
> -        return -EINVAL;
> -    }
> -
> -    error_setg(&giommu_migration_blocker,
> -               "Migration is currently not supported with vIOMMU enabled");
> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(giommu_migration_blocker);
> -        giommu_migration_blocker = NULL;
> -    }
> -
> -    return ret;
> -}
> -
> -void vfio_migration_finalize(void)
> -{
> -    if (!giommu_migration_blocker ||
> -        vfio_viommu_preset()) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(giommu_migration_blocker);
> -    error_free(giommu_migration_blocker);
> -    giommu_migration_blocker = NULL;
> +    return vbasedev->group->container->space->as != &address_space_memory;
>   }
>   
>   static void vfio_set_migration_error(int err)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 1db7d52ab2c1..e6e5e85f7580 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -878,9 +878,10 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return ret;
>       }
>   
> -    ret = vfio_block_giommu_migration(vbasedev, errp);
> -    if (ret) {
> -        return ret;
> +    if (vfio_viommu_preset(vbasedev)) {
> +        error_setg(&err, "%s: Migration is currently not supported "
> +                   "with vIOMMU enabled", vbasedev->name);
> +        return vfio_block_migration(vbasedev, err, errp);
>       }
>   
>       trace_vfio_migration_realize(vbasedev->name);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31c4ab250fbe..c2cf7454ece6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3255,7 +3255,6 @@ static void vfio_instance_finalize(Object *obj)
>        */
>       vfio_put_device(vdev);
>       vfio_put_group(group);
> -    vfio_migration_finalize();
>   }
>   
>   static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 93429b9abba0..45167c8a8a54 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -227,7 +227,7 @@ extern VFIOGroupList vfio_group_list;
>   bool vfio_mig_active(void);
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
>   
> @@ -254,6 +254,5 @@ int vfio_spapr_remove_window(VFIOContainer *container,
>   
>   int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
> -void vfio_migration_finalize(void);
>   
>   #endif /* HW_VFIO_VFIO_COMMON_H */


