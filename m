Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D07411CD
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:55:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEUhU-0001EA-2m; Wed, 28 Jun 2023 08:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEUhR-0001DT-J7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEUhP-00021b-3x
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687956906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=autDdQyF4RQo6MrJLH1q2+Lm8H/QfZTxbz4b8uqRWPk=;
 b=Qs4QOa7OwvURQfljqbS7by3RBSQMfxnrrB9O8XDFAPXUV141baEw6NNkso+3L05V3Rw+mZ
 mRECCF5hMHxx/zk8NFrfbGcYZNlcdaI91QNGzLgCg6v8lPdIeyXS0JpDdBf+0dQA72Qd0j
 KR02xTnJdkm3zAndq8jmoB/22YRCWGY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-6WYKf9e4N0ea_F4-FiTbGg-1; Wed, 28 Jun 2023 08:55:04 -0400
X-MC-Unique: 6WYKf9e4N0ea_F4-FiTbGg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7659924cf20so361431185a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687956902; x=1690548902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=autDdQyF4RQo6MrJLH1q2+Lm8H/QfZTxbz4b8uqRWPk=;
 b=dfwZAeMeLh0ft36wPP+Jguaq8ekGhHbkXYGngvorFrL2XD9l9Rw1hVRoNHpWeiPtft
 b6aTDNPD4oHpxf8RMgRgyPAbSvh0vmeANGzRD0iLHDSyW3lzZ+4zL3qb73aLxENww1MP
 8g2V3aae+XBe1laC9abAL48poA9Q9e82jVD33rnbowqWT+p8YZsKyIcKdiEd3BfaP0RZ
 gPXpgWa8UUeHdq+bl27FXhkdgfOkXPqRnWqQ3a7u5t5mfZGF4qN9eV9Am6BNoZhjji22
 +NYLOQPzVuJK2BfooG9Zz9x1Getf4jk3OZgk3SH3Tf5MbPtHdNlXD/uGL92btyOkp+iK
 LJRg==
X-Gm-Message-State: AC+VfDxeggyh1Z6AUqf6wM3T7vpx9ORACdqAa4TXto8wt8FCWJJhCfFH
 2/yOGBFznJjBHNPDmKcumOqJWKDQcUoUk8kfajUaqSSxedJEA766rQpAI+JgJdFaL2f4HZaEMLz
 sXSAEzwkWVev79iA=
X-Received: by 2002:a05:620a:2987:b0:765:a927:df0c with SMTP id
 r7-20020a05620a298700b00765a927df0cmr9839676qkp.38.1687956902000; 
 Wed, 28 Jun 2023 05:55:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7po+XwppbxxD6A+7b6lKalPFcm/9X+kmEaA4FY6K4pgNqtGExWFIPmiqJjOoGABxUnaP9aZQ==
X-Received: by 2002:a05:620a:2987:b0:765:a927:df0c with SMTP id
 r7-20020a05620a298700b00765a927df0cmr9839656qkp.38.1687956901625; 
 Wed, 28 Jun 2023 05:55:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a05620a01f700b00765a9f53af0sm3295214qkn.128.2023.06.28.05.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:55:01 -0700 (PDT)
Message-ID: <0b6b4262-5782-bdc1-428e-2b106411afd3@redhat.com>
Date: Wed, 28 Jun 2023 14:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] vfio/migration: Make VFIO migration
 non-experimental
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
 <20230628073112.7958-3-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230628073112.7958-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/28/23 09:31, Avihai Horon wrote:
> The major parts of VFIO migration are supported today in QEMU. This
> includes basic VFIO migration, device dirty page tracking and precopy
> support.
> 
> Thus, at this point in time, it seems appropriate to make VFIO migration
> non-experimental: remove the x prefix from enable_migration property,
> change it to ON_OFF_AUTO and let the default value be AUTO.
> 
> In addition, make the following adjustments:
> 1. When enable_migration is ON and migration is not supported, fail VFIO
>     device realization.
> 2. When enable_migration is AUTO (i.e., not explicitly enabled), require
>     device dirty tracking support. This is because device dirty tracking
>     is currently the only method to do dirty page tracking, which is
>     essential for migrating in a reasonable downtime. Setting
>     enable_migration to ON will not require device dirty tracking.
> 3. Make migration error and blocker messages more elaborate.
> 4. Remove error prints in vfio_migration_query_flags().
> 5. Rename trace_vfio_migration_probe() to
>     trace_vfio_migration_realize().
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


We should rework the return value of most of the routines called by
vfio_migration_realize() and simply use a bool. I think Zhenzhong is
working it.

Zhenzhong,

When you resend v4 of the "VFIO migration related refactor and bug fix"
series, please rebase on this patch since it should be merged.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.
      

> ---
>   include/hw/vfio/vfio-common.h |  6 +--
>   hw/vfio/common.c              | 16 ++++++-
>   hw/vfio/migration.c           | 79 +++++++++++++++++++++++------------
>   hw/vfio/pci.c                 |  4 +-
>   hw/vfio/trace-events          |  2 +-
>   5 files changed, 73 insertions(+), 34 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b4c28f318f..0ded0e73e2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
>       bool needs_reset;
>       bool no_mmap;
>       bool ram_block_discard_allowed;
> -    bool enable_migration;
> +    OnOffAuto enable_migration;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
> @@ -224,9 +224,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   extern VFIOGroupList vfio_group_list;
>   
>   bool vfio_mig_active(void);
> -int vfio_block_multiple_devices_migration(Error **errp);
> +int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(Error **errp);
> +int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
>   
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 25801de173..8c73f84581 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -381,7 +381,7 @@ static unsigned int vfio_migratable_device_num(void)
>       return device_num;
>   }
>   
> -int vfio_block_multiple_devices_migration(Error **errp)
> +int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>   
> @@ -390,6 +390,12 @@ int vfio_block_multiple_devices_migration(Error **errp)
>           return 0;
>       }
>   
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> +        error_setg(errp, "Migration is currently not supported with multiple "
> +                         "VFIO devices");
> +        return -EINVAL;
> +    }
> +
>       error_setg(&multiple_devices_migration_blocker,
>                  "Migration is currently not supported with multiple "
>                  "VFIO devices");
> @@ -427,7 +433,7 @@ static bool vfio_viommu_preset(void)
>       return false;
>   }
>   
> -int vfio_block_giommu_migration(Error **errp)
> +int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>   
> @@ -436,6 +442,12 @@ int vfio_block_giommu_migration(Error **errp)
>           return 0;
>       }
>   
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> +        error_setg(errp,
> +                   "Migration is currently not supported with vIOMMU enabled");
> +        return -EINVAL;
> +    }
> +
>       error_setg(&giommu_migration_blocker,
>                  "Migration is currently not supported with vIOMMU enabled");
>       ret = migrate_add_blocker(giommu_migration_blocker, errp);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 7cf143926c..1db7d52ab2 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -724,14 +724,6 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
>       feature->argsz = sizeof(buf);
>       feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_MIGRATION;
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        if (errno == ENOTTY) {
> -            error_report("%s: VFIO migration is not supported in kernel",
> -                         vbasedev->name);
> -        } else {
> -            error_report("%s: Failed to query VFIO migration support, err: %s",
> -                         vbasedev->name, strerror(errno));
> -        }
> -
>           return -errno;
>       }
>   
> @@ -810,6 +802,27 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       return 0;
>   }
>   
> +static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> +{
> +    int ret;
> +
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> +        error_propagate(errp, err);
> +        return -EINVAL;
> +    }
> +
> +    vbasedev->migration_blocker = error_copy(err);
> +    error_free(err);
> +
> +    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
> +    if (ret < 0) {
> +        error_free(vbasedev->migration_blocker);
> +        vbasedev->migration_blocker = NULL;
> +    }
> +
> +    return ret;
> +}
> +
>   /* ---------------------------------------------------------------------- */
>   
>   int64_t vfio_mig_bytes_transferred(void)
> @@ -824,40 +837,54 @@ void vfio_reset_bytes_transferred(void)
>   
>   int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret = -ENOTSUP;
> +    Error *err = NULL;
> +    int ret;
>   
> -    if (!vbasedev->enable_migration) {
> -        goto add_blocker;
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
> +        error_setg(&err, "%s: Migration is disabled for VFIO device",
> +                   vbasedev->name);
> +        return vfio_block_migration(vbasedev, err, errp);
>       }
>   
>       ret = vfio_migration_init(vbasedev);
>       if (ret) {
> -        goto add_blocker;
> +        if (ret == -ENOTTY) {
> +            error_setg(&err, "%s: VFIO migration is not supported in kernel",
> +                       vbasedev->name);
> +        } else {
> +            error_setg(&err,
> +                       "%s: Migration couldn't be initialized for VFIO device, "
> +                       "err: %d (%s)",
> +                       vbasedev->name, ret, strerror(-ret));
> +        }
> +
> +        return vfio_block_migration(vbasedev, err, errp);
> +    }
> +
> +    if (!vbasedev->dirty_pages_supported) {
> +        if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
> +            error_setg(&err,
> +                       "%s: VFIO device doesn't support device dirty tracking",
> +                       vbasedev->name);
> +            return vfio_block_migration(vbasedev, err, errp);
> +        }
> +
> +        warn_report("%s: VFIO device doesn't support device dirty tracking",
> +                    vbasedev->name);
>       }
>   
> -    ret = vfio_block_multiple_devices_migration(errp);
> +    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = vfio_block_giommu_migration(errp);
> +    ret = vfio_block_giommu_migration(vbasedev, errp);
>       if (ret) {
>           return ret;
>       }
>   
> -    trace_vfio_migration_probe(vbasedev->name);
> +    trace_vfio_migration_realize(vbasedev->name);
>       return 0;
> -
> -add_blocker:
> -    error_setg(&vbasedev->migration_blocker,
> -               "VFIO device doesn't support migration");
> -
> -    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(vbasedev->migration_blocker);
> -        vbasedev->migration_blocker = NULL;
> -    }
> -    return ret;
>   }
>   
>   void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de..48584e3b01 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_REQ_BIT, true),
>       DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> -    DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDevice,
> -                     vbasedev.enable_migration, false),
> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
> +                            vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                        vbasedev.ram_block_discard_allowed, false),
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e328d644d2..ee7509e68e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -155,7 +155,7 @@ vfio_load_cleanup(const char *name) " (%s)"
>   vfio_load_device_config_state(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
> -vfio_migration_probe(const char *name) " (%s)"
> +vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"


