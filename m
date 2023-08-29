Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782478C53D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayjA-0000es-Ag; Tue, 29 Aug 2023 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayj7-0000Zj-Nt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayj0-0004QO-2R
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693315500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGrsPkmw5xZTtaTIvogHuF9o2ld8ZmvGCM5yAxyCFpc=;
 b=fb68H03f/lNyXD1rpTHrRI/kAusH7mQvjaNytfY420pIdSFlKe/cM9CXF7pFFMWOhm+N0v
 m7un1SLcXX9a6Kvam1dLMEZJWcjBoLxxW/c0gxUG+Hb1DLdYdOmsmFP0oqFYsmvTQEWkez
 br9g79BlA8/m4BcgclJBdrXVrFEqs6o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FfJIg96DMaGlQrvFTjxRIg-1; Tue, 29 Aug 2023 09:24:58 -0400
X-MC-Unique: FfJIg96DMaGlQrvFTjxRIg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c7bfba03dso2853556f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315497; x=1693920297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGrsPkmw5xZTtaTIvogHuF9o2ld8ZmvGCM5yAxyCFpc=;
 b=UHQS5634R4H8KmLDfrCfOk0SJgZwBq1lF1aQEX1yyjWXQ1Iq369d10A3Jk2x9aDU1A
 aTB2jPp2v5kF4ReDXH2410TRFoFsN9lPvbSgeUF0BxV4AuR7gaYrmygCMEhFhNMGOzgp
 9hkOs9QVngY8RGunOohtd/3+rK4XvN8DPADw6l4CRKxBxCbqPIgc4P6Oa5Q/AvawsGiz
 NAiNemp8p/4DBYGmLnfo4KVE1MnR9lyO1WJF1iQmfkDVhdrYZaTkCyXa/k2azD5cCVDM
 QihNR4q376dZ92kyuN4TQnal8ip/eoamG6BqxB3MR+rw11xHx5/cS1d3+4WstVYO64yr
 eNtg==
X-Gm-Message-State: AOJu0Yy21vyxoUyaJP9yoL1Rmw6/EBWFqUfGsblNg265msYVR8pDtc8L
 CqrlpY89nLNKTYZqHtPz6/WXkQJ98Q1otVmQJdTFC7qNpK65oJdbPgWhKXGFbnH8eZ9acAviOxg
 fuuAOrwEIDoID34zLVpKKhAc=
X-Received: by 2002:adf:f18a:0:b0:319:6001:978c with SMTP id
 h10-20020adff18a000000b003196001978cmr24576168wro.53.1693315496758; 
 Tue, 29 Aug 2023 06:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0sKSJ9nXfMtycggCN7GZv29zH/4sdgWY4dkyoNmvS4L98p0DUsLm+2iOrh+yLMQabjRB8ng==
X-Received: by 2002:adf:f18a:0:b0:319:6001:978c with SMTP id
 h10-20020adff18a000000b003196001978cmr24576151wro.53.1693315496407; 
 Tue, 29 Aug 2023 06:24:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 y14-20020adfee0e000000b0031c56218984sm13704053wrn.104.2023.08.29.06.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:24:55 -0700 (PDT)
Message-ID: <ae76d3dc-9027-f52d-a3d4-196624750c63@redhat.com>
Date: Tue, 29 Aug 2023 15:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230828151842.11303-6-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/28/23 17:18, Avihai Horon wrote:
> VFIO migration is not compatible with postcopy migration. A VFIO device
> in the destination can't handle page faults for pages that have not been
> sent yet.
> 
> Doing such migration will cause the VM to crash in the destination:
> 
> qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
> qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> To prevent this and to be explicit about supported features, block VFIO
> migration with postcopy migration: Fail setting postcopy capability if a
> VFIO device is present, and add a migration blocker if a VFIO device is
> added when postcopy capability is on.
> 
> Reported-by: Yanghang Liu <yanghliu@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   migration/migration.h         |  2 ++
>   hw/vfio/common.c              | 43 +++++++++++++++++++++++++++++++++++
>   hw/vfio/migration.c           |  6 +++++
>   migration/options.c           | 19 ++++++++++++++++
>   migration/target.c            | 19 ++++++++++++++++
>   6 files changed, 91 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e9b8954595..c0b58f2bb7 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -227,6 +227,8 @@ extern VFIOGroupList vfio_group_list;
>   bool vfio_mig_active(void);
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
> +int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp);
> +void vfio_unblock_postcopy_migration(void);
>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
>   void vfio_reset_bytes_transferred(void);
> diff --git a/migration/migration.h b/migration/migration.h
> index c5695de214..21a6423408 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -514,6 +514,8 @@ void migration_cancel(const Error *error);
>   
>   void migration_populate_vfio_info(MigrationInfo *info);
>   void migration_reset_vfio_bytes_transferred(void);
> +bool migration_vfio_mig_active(void);
> +void migration_vfio_unblock_postcopy_migration(void);
>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>   
>   #endif
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 373f6e5932..7461194b2b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -40,6 +40,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "migration/migration.h"
> +#include "migration/options.h"
>   #include "migration/misc.h"
>   #include "migration/blocker.h"
>   #include "migration/qemu-file.h"
> @@ -343,6 +344,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>                                    uint64_t size, ram_addr_t ram_addr);
>   
>   static Error *multiple_devices_migration_blocker;
> +static Error *postcopy_migration_blocker;
>   
>   static unsigned int vfio_migratable_devices_num(void)
>   {
> @@ -427,6 +429,47 @@ void vfio_unblock_multiple_devices_migration(void)
>       multiple_devices_migration_blocker = NULL;
>   }
>   
> +int vfio_block_postcopy_migration(VFIODevice *vbasedev, Error **errp)
> +{
> +    int ret;
> +
> +    if (!migrate_postcopy_ram()) {
> +        return 0;
> +    }
> +
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> +        error_setg(errp,
> +                   "VFIO migration is not compatible with postcopy migration");
> +        return -EINVAL;
> +    }
> +
> +    if (postcopy_migration_blocker) {
> +        return 0;
> +    }
> +
> +    error_setg(&postcopy_migration_blocker,
> +               "VFIO migration is not compatible with postcopy migration");
> +    ret = migrate_add_blocker(postcopy_migration_blocker, errp);
> +    if (ret < 0) {
> +        error_free(postcopy_migration_blocker);
> +        postcopy_migration_blocker = NULL;
> +    }
> +
> +    return ret;
> +}
> +
> +void vfio_unblock_postcopy_migration(void)
> +{
> +    if (!postcopy_migration_blocker ||
> +        (vfio_migratable_devices_num() && migrate_postcopy_ram())) {
> +        return;
> +    }
> +
> +    migrate_del_blocker(postcopy_migration_blocker);
> +    error_free(postcopy_migration_blocker);
> +    postcopy_migration_blocker = NULL;
> +}
> +
>   bool vfio_mig_active(void)
>   {
>       return vfio_migratable_devices_num();
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 71855468fe..76406e9ae9 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -856,6 +856,7 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
>       unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>       vfio_migration_free(vbasedev);
>       vfio_unblock_multiple_devices_migration();
> +    vfio_unblock_postcopy_migration();
>   }
>   
>   static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> @@ -939,6 +940,11 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           goto out_deinit;
>       }
>   
> +    ret = vfio_block_postcopy_migration(vbasedev, errp);
> +    if (ret) {
> +        goto out_deinit;
> +    }
> +
>       if (vfio_viommu_preset(vbasedev)) {
>           error_setg(&err, "%s: Migration is currently not supported "
>                      "with vIOMMU enabled", vbasedev->name);
> diff --git a/migration/options.c b/migration/options.c
> index 1d1e1321b0..e201053563 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>               error_setg(errp, "Postcopy is not yet compatible with multifd");
>               return false;
>           }
> +
> +        if (migration_vfio_mig_active()) {
> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
> +            return false;
> +        }
>       }
>   
>       if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> @@ -612,6 +617,16 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>       return true;
>   }
>   
> +/*
> + * Devices might have added migration blockers based on migration capabilities
> + * values when those devices were added. Remove such blockers according to new
> + * changes in migration capabilities.
> + */
> +static void migration_caps_remove_blockers(void)
> +{
> +    migration_vfio_unblock_postcopy_migration();
> +}
> +
>   bool migrate_cap_set(int cap, bool value, Error **errp)
>   {
>       MigrationState *s = migrate_get_current();
> @@ -629,6 +644,8 @@ bool migrate_cap_set(int cap, bool value, Error **errp)
>           return false;
>       }
>       s->capabilities[cap] = value;
> +    migration_caps_remove_blockers();
> +
>       return true;
>   }
>   
> @@ -678,6 +695,8 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>       for (cap = params; cap; cap = cap->next) {
>           s->capabilities[cap->value->capability] = cap->value->state;
>       }
> +
> +    migration_caps_remove_blockers();
>   }
>   
>   /* parameters */
> diff --git a/migration/target.c b/migration/target.c
> index a6ffa9a5ce..690ecb4dd5 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -27,6 +27,16 @@ void migration_reset_vfio_bytes_transferred(void)
>   {
>       vfio_reset_bytes_transferred();
>   }
> +
> +bool migration_vfio_mig_active(void)
> +{
> +    return vfio_mig_active();
> +}
> +
> +void migration_vfio_unblock_postcopy_migration(void)
> +{
> +    vfio_unblock_postcopy_migration();
> +}
>   #else
>   void migration_populate_vfio_info(MigrationInfo *info)
>   {
> @@ -35,4 +45,13 @@ void migration_populate_vfio_info(MigrationInfo *info)
>   void migration_reset_vfio_bytes_transferred(void)
>   {
>   }
> +
> +bool migration_vfio_mig_active(void)
> +{
> +    return false;
> +}
> +
> +void migration_vfio_unblock_postcopy_migration()


Missing 'void' above.

Thanks,

C.


> +{
> +}
>   #endif


