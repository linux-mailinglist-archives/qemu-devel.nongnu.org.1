Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1397411AC
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEUcw-0005hH-0D; Wed, 28 Jun 2023 08:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEUcu-0005h5-9h
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEUcs-0006YH-HS
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687956625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Wftjnl89IWjBoWxS/+arcZ2PkHM6bX91Erlq62rufs=;
 b=H5h3rUSEI+uNhQbpqFWEfG5iABiGaQU1henUx6IlJt/eoGPfR28ue86yaZmhYi3X9kgoVR
 fFPwxEmloTRmnyMLE0ClkIxHe2Sxc+A/FBvAupROsep9OYxXQtU1fQzThh/Y2kTjeCsmb5
 SyEaG5Z63/ngUtRY4qDRnldP3BYOy+8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-5Vf8_iiMMU2nL0B8iMvx5w-1; Wed, 28 Jun 2023 08:50:24 -0400
X-MC-Unique: 5Vf8_iiMMU2nL0B8iMvx5w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76548fab0b2so645251485a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687956623; x=1690548623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Wftjnl89IWjBoWxS/+arcZ2PkHM6bX91Erlq62rufs=;
 b=bTqcfdEpyi/QQ5ZY+AC2nwpGDrshzdY1giTb4LrHJEoSfZLVS7LqhSm+E0Wc8ecV9D
 c5zzF0ExF+ZE0aOwcUsgeqzo7uFEHjJHTX87D45z4Nj2ufd5NvslgsQB5p30KGxuklQE
 +Jt7WuQeN0YKq9BGFDISmAcouuCU2JmJRyz65eza4iz56C2f/H/Fovs6U9Ek+KJh4sEE
 71mewsTrdv346s4OZIGMAtOL5+bMLmzN/b5KdOzfEM/iO9312hxcILUSdkieaZrz6KMW
 cGrzXWM1ZRnVhQ2gnx540IdpfRyPketILHDCe2R6Tzz/NWjDbSpLWAh4m6qxZRMImqIa
 n/1A==
X-Gm-Message-State: AC+VfDyHVV6dcd68bqFb3v441g0D70NR9QNO1NCTL+OuRofA0+PSFr7Z
 ZnAhl8Yeasyb7jzOtTZ4kHtju6E6ADuTXUOcSfrVxPdW/wXZhZF/cDhs27Vi2lMGGPzKjkFNf/N
 emg1wqnhqUjGo0GA=
X-Received: by 2002:a05:6214:c88:b0:626:1be5:177b with SMTP id
 r8-20020a0562140c8800b006261be5177bmr35344043qvr.65.1687956623475; 
 Wed, 28 Jun 2023 05:50:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IK2ndnUOnte9tx/ml7W7xSw/c8M/M3ajaotovXt6BaCFfWWE8yLDKeGJq7T86wNeYzEI5Rw==
X-Received: by 2002:a05:6214:c88:b0:626:1be5:177b with SMTP id
 r8-20020a0562140c8800b006261be5177bmr35344023qvr.65.1687956623210; 
 Wed, 28 Jun 2023 05:50:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 dp8-20020a05621409c800b0062ff179a538sm4807382qvb.123.2023.06.28.05.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:50:22 -0700 (PDT)
Message-ID: <531c8839-09e4-38f3-9e0b-54db550938e9@redhat.com>
Date: Wed, 28 Jun 2023 14:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] vfio/migration: Reset bytes_transferred properly
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
 <20230628073112.7958-2-avihaih@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230628073112.7958-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> Currently, VFIO bytes_transferred is not reset properly:
> 1. bytes_transferred is not reset after a VM snapshot (so a migration
>     following a snapshot will report incorrect value).
> 2. bytes_transferred is a single counter for all VFIO devices, however
>     upon migration failure it is reset multiple times, by each VFIO
>     device.
> 
> Fix it by introducing a new function vfio_reset_bytes_transferred() and
> calling it during migration and snapshot start.
> 
> Remove existing bytes_transferred reset in VFIO migration state
> notifier, which is not needed anymore.
> 
> Fixes: 3710586caa5d ("qapi: Add VFIO devices migration stats in Migration stats")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   migration/migration.h         |  1 +
>   hw/vfio/migration.c           |  6 +++++-
>   migration/migration.c         |  1 +
>   migration/savevm.c            |  1 +
>   migration/target.c            | 17 +++++++++++++++--
>   6 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3dc5f2104c..b4c28f318f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -228,6 +228,7 @@ int vfio_block_multiple_devices_migration(Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
>   int vfio_block_giommu_migration(Error **errp);
>   int64_t vfio_mig_bytes_transferred(void);
> +void vfio_reset_bytes_transferred(void);
>   
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
> diff --git a/migration/migration.h b/migration/migration.h
> index c859a0d35e..a80b22b703 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -514,6 +514,7 @@ bool migration_rate_limit(void);
>   void migration_cancel(const Error *error);
>   
>   void populate_vfio_info(MigrationInfo *info);
> +void reset_vfio_bytes_transferred(void);
>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>   
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index acbf0bb7ab..7cf143926c 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -697,7 +697,6 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       case MIGRATION_STATUS_CANCELLING:
>       case MIGRATION_STATUS_CANCELLED:
>       case MIGRATION_STATUS_FAILED:
> -        bytes_transferred = 0;
>           /*
>            * If setting the device in RUNNING state fails, the device should
>            * be reset. To do so, use ERROR state as a recover state.
> @@ -818,6 +817,11 @@ int64_t vfio_mig_bytes_transferred(void)
>       return bytes_transferred;
>   }
>   
> +void vfio_reset_bytes_transferred(void)
> +{
> +    bytes_transferred = 0;
> +}
> +
>   int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret = -ENOTSUP;
> diff --git a/migration/migration.c b/migration/migration.c
> index 7653787f74..096e8191d1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1628,6 +1628,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>        */
>       memset(&mig_stats, 0, sizeof(mig_stats));
>       memset(&compression_counters, 0, sizeof(compression_counters));
> +    reset_vfio_bytes_transferred();
>   
>       return true;
>   }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index cdf4793924..95c2abf47c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1622,6 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>       migrate_init(ms);
>       memset(&mig_stats, 0, sizeof(mig_stats));
>       memset(&compression_counters, 0, sizeof(compression_counters));
> +    reset_vfio_bytes_transferred();
>       ms->to_dst_file = f;
>   
>       qemu_mutex_unlock_iothread();
> diff --git a/migration/target.c b/migration/target.c
> index 00ca007f97..f39c9a8d88 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -14,12 +14,25 @@
>   #include "hw/vfio/vfio-common.h"
>   #endif
>   
> +#ifdef CONFIG_VFIO
>   void populate_vfio_info(MigrationInfo *info)
>   {
> -#ifdef CONFIG_VFIO
>       if (vfio_mig_active()) {
>           info->vfio = g_malloc0(sizeof(*info->vfio));
>           info->vfio->transferred = vfio_mig_bytes_transferred();
>       }
> -#endif
>   }
> +
> +void reset_vfio_bytes_transferred(void)
> +{
> +    vfio_reset_bytes_transferred();
> +}
> +#else
> +void populate_vfio_info(MigrationInfo *info)
> +{
> +}
> +
> +void reset_vfio_bytes_transferred(void)
> +{
> +}
> +#endif


