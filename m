Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23390742ABC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 18:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEugq-0006c3-8q; Thu, 29 Jun 2023 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEugn-0006bt-4c
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEugj-0007uI-Bq
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688056808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkcrRyyVU753PCw88FfAVMqtBE36nxnageudGBVkoPk=;
 b=PQjyHrlGkMf0UV/ijEyqgvsrIdj1ib5ccOQ7d3C710PpZzHlTD0f5lYDm02nTTiXu2TG/s
 5iaSCKJqWon9Y7FlTtmPIZM1tW6phAFYG08aQj9Bf9yqheeRvemjq+lIJPiEVlKZMtvJ+i
 wRyH4AUKoTGAV9ZvkcFKf2/63MGl1H8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-KuFjKIfUNa6s_NB0KKxUEw-1; Thu, 29 Jun 2023 12:40:06 -0400
X-MC-Unique: KuFjKIfUNa6s_NB0KKxUEw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6349a78b1aaso5959366d6.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 09:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688056806; x=1690648806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WkcrRyyVU753PCw88FfAVMqtBE36nxnageudGBVkoPk=;
 b=S9KP77w8mfFMhnUYbaCM4SAUvyDyfWhAOdkLGhrpsGvaLrUeBrEFNEfMS7cM8swz8a
 vDPvau1Uzjj9rUZYOv8efjPigxBqJyd5GVcDydKNhrad/CgPmKqKlDFSsBHKJoS8JUTT
 9I0TnynFlplMuv86McxpK0GLcXHBX+mcB85pUBErHcMnEgCQkmMwEzrcGfCu0zYSRI43
 642V/X6w3Xu5NjdapkLpCp7GvPow0pTKfkwpyl9/SZfjSLcxX8qqthBnU2TVuaLTfnod
 wBY3bdaONibaVv3c17VM3HfzEX9isk1/i0ILgfq4NwOlLykQ8pvpAW0OvKDU3q3KuMFL
 ROYg==
X-Gm-Message-State: ABy/qLbGBYHe3qr2dR50MletzO9jUPdJHDXR/6qxC4RxXm5I6rTXAWW+
 7+pR3XZ16FhRmMan3HhMtVjAMFRpAgL3V+Hh+Oqq+JXvPQQ4AdFg9cAHzNae2GrDIEernzaqwmA
 B/D8KlEuvhoxSFjs=
X-Received: by 2002:ad4:5bae:0:b0:625:aa49:ea0d with SMTP id
 14-20020ad45bae000000b00625aa49ea0dmr450232qvq.32.1688056805932; 
 Thu, 29 Jun 2023 09:40:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHG69eQME41rmnrk73h3pJvPJ99QpO0T5BQEV/yuzp8HX3v83Mm4deVelQRFzxYCd7BzXQgHg==
X-Received: by 2002:ad4:5bae:0:b0:625:aa49:ea0d with SMTP id
 14-20020ad45bae000000b00625aa49ea0dmr450208qvq.32.1688056805590; 
 Thu, 29 Jun 2023 09:40:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a056214032e00b00635eee57eb0sm1452348qvu.34.2023.06.29.09.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 09:40:05 -0700 (PDT)
Message-ID: <fa97ab02-1b53-758d-9b2e-0d277b5e4e3f@redhat.com>
Date: Thu, 29 Jun 2023 18:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230629084042.86502-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

Hello Zhenzhong,

On 6/29/23 10:40, Zhenzhong Duan wrote:
> This patch refactors vfio_migration_realize() and its dependend code
> as follows:
> 
> 1. It's redundant in vfio_migration_realize() to registers multiple blockers,
>     e.g: vIOMMU blocker can be refactored as per device blocker.
> 2. Change vfio_viommu_preset() to be only a per device checker.
> 3. Remove global vIOMMU blocker related stuff, e.g:
>     giommu_migration_blocker, vfio_[block|unblock]_giommu_migration()
>     and vfio_migration_finalize()
> 4. Change vfio_migration_realize(), vfio_block_multiple_devices_migration()
>     vfio_block_migration() and vfio_viommu_preset() to return bool type.
> 5. Print "Migration disabled" depending on enable_migration property
>     and print it as warning instead of error which is overkill.


We are close to soft freeze and these combo patches adding various fixes
all at once are difficult to evaluate.

Please split this patch in multiple ones to ease the review.  May be
start with the  int -> bool conversion of the return values. It should
remove some noise.

Thanks,

C.

> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
> However, the caller of vfio_migration_realize() considers that migration was
> blocked when the latter returned an error. What matters for migration is that
> the blocker is added in core migration, so this cleans up usability such that
> user sees "Migrate disabled" when any of the vfio migration blockers are active
> and it's not intentionally forced by user with enable-migration=off.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/common.c              | 66 +++++++----------------------------
>   hw/vfio/migration.c           | 30 +++++++++-------
>   hw/vfio/pci.c                 |  4 +--
>   include/hw/vfio/vfio-common.h |  7 ++--
>   4 files changed, 36 insertions(+), 71 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 77e2ee0e5c6e..c80ecb1da53f 100644
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
> @@ -381,19 +380,19 @@ static unsigned int vfio_migratable_device_num(void)
>       return device_num;
>   }
>   
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>   
>       if (multiple_devices_migration_blocker ||
>           vfio_migratable_device_num() <= 1) {
> -        return 0;
> +        return true;
>       }
>   
>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>           error_setg(errp, "Migration is currently not supported with multiple "
>                            "VFIO devices");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       error_setg(&multiple_devices_migration_blocker,
> @@ -403,9 +402,15 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>       if (ret < 0) {
>           error_free(multiple_devices_migration_blocker);
>           multiple_devices_migration_blocker = NULL;
> +    } else {
> +        /*
> +         * Only ON_OFF_AUTO_AUTO case, ON_OFF_AUTO_OFF is checked
> +         * in vfio_migration_realize().
> +         */
> +        warn_report("Migration disabled, not support multiple VFIO devices");
>       }
>   
> -    return ret;
> +    return !ret;
>   }
>   
>   void vfio_unblock_multiple_devices_migration(void)
> @@ -420,55 +425,10 @@ void vfio_unblock_multiple_devices_migration(void)
>       multiple_devices_migration_blocker = NULL;
>   }
>   
> -static bool vfio_viommu_preset(void)
> +/* Block migration with a vIOMMU */
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
> index 1db7d52ab2c1..84036e5cfc01 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       return 0;
>   }
>   
> -static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> +static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>   {
>       int ret;
>   
>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>           error_propagate(errp, err);
> -        return -EINVAL;
> +        return false;
>       }
>   
>       vbasedev->migration_blocker = error_copy(err);
> @@ -818,9 +818,11 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>       if (ret < 0) {
>           error_free(vbasedev->migration_blocker);
>           vbasedev->migration_blocker = NULL;
> +    } else if (vbasedev->enable_migration != ON_OFF_AUTO_OFF) {
> +        warn_report("%s: Migration disabled", vbasedev->name);
>       }
>   
> -    return ret;
> +    return !ret;
>   }
>   
>   /* ---------------------------------------------------------------------- */
> @@ -835,7 +837,12 @@ void vfio_reset_bytes_transferred(void)
>       bytes_transferred = 0;
>   }
>   
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +/*
> + * Return true when either migration initialized or blocker registered.
> + * Currently only return false when adding blocker fails which will
> + * de-register vfio device.
> + */
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
>       Error *err = NULL;
>       int ret;
> @@ -873,18 +880,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>                       vbasedev->name);
>       }
>   
> -    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_block_multiple_devices_migration(vbasedev, errp)) {
> +        return false;
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
> -    trace_vfio_migration_realize(vbasedev->name);
> -    return 0;
> +    return true;
>   }
>   
>   void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dc69d3031b24..184d08568154 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (!pdev->failover_pair_id) {
>           ret = vfio_migration_realize(vbasedev, errp);
>           if (ret) {
> -            error_report("%s: Migration disabled", vbasedev->name);
> +            trace_vfio_migration_realize(vbasedev->name);
> +        } else {
>               goto out_vfio_migration;
>           }
>       }
> @@ -3257,7 +3258,6 @@ static void vfio_instance_finalize(Object *obj)
>        */
>       vfio_put_device(vdev);
>       vfio_put_group(group);
> -    vfio_migration_finalize();
>   }
>   
>   static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 93429b9abba0..3c18572322fc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   extern VFIOGroupList vfio_group_list;
>   
>   bool vfio_mig_active(void);
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
>   
> @@ -252,8 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>   int vfio_spapr_remove_window(VFIOContainer *container,
>                                hwaddr offset_within_address_space);
>   
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>   void vfio_migration_exit(VFIODevice *vbasedev);
> -void vfio_migration_finalize(void);
>   
>   #endif /* HW_VFIO_VFIO_COMMON_H */


