Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3873DBDB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiuj-0004Hq-Jw; Mon, 26 Jun 2023 05:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDiuI-0004Bf-HV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qDiuG-0006Ka-5x
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687773187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddK+EGqs6WzSRwm43kvZj85i0FN9T2ufit4/DylrUik=;
 b=ZDFm1kZJoTLYkuoZFzQtixchXNzmfhyOW40028NM8LlLM6PdFZkuQR8yBGVCxN64pCLbJ1
 oIgTZmICux0OvOtvFUmWPCtlbM94Y7vub5kQTQBr3JuUkunX2F6ZTWgiZ49wxo/pypumWI
 WTzYJk/w+cfbsf9xE9YmBXtgya6IOOA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ihXXDGGLN8CISf2sDA-x6w-1; Mon, 26 Jun 2023 05:53:02 -0400
X-MC-Unique: ihXXDGGLN8CISf2sDA-x6w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7659d103147so127554985a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773182; x=1690365182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddK+EGqs6WzSRwm43kvZj85i0FN9T2ufit4/DylrUik=;
 b=Vp8ZhG+McxAhplpBtBVZvzcAZ20PQAZW1wB93NEA58I1vkQljw+mkpaq0PqgjKsIti
 csnh0OHkZvI0fToPwfGWZEW6NvpgHJ6sfCcObFtyPycQj5RuskDGjJgb33iT1pu2zfL8
 3NhsFLaHn268V4okmqZMqdz8N6a4Rh3WhvCEw7v7gcGstDNbKJgPmtG9EdbRA8ICx+VY
 tMUt7k7qZ2/tXrgOdWrr4xLectbiEIEu62vMhYKpReR7U9nMnWWeZsOrvzWav3l1RmD2
 XsgV/Q6RN5nPly9pD6Pr/CNMvawYd6CFqSw2SWHyXdCHe4gFBrArNuS8o6uFj2YdXeyR
 QsDw==
X-Gm-Message-State: AC+VfDw+NHyCXXMQO5CElSmZW4tD6lPcU6+Sf6NvH292Eu+XXWKtkoyS
 5AtCs9y/wzhmKpTgagf/4b1DHaV95R+qgwsKiKC0QbOCuevbwBrZjHAARmd6P1Ugx6Yz260swO1
 Pz/wmEKxsiJR+yCA=
X-Received: by 2002:ac8:7fce:0:b0:3ec:d85d:2afe with SMTP id
 b14-20020ac87fce000000b003ecd85d2afemr37940496qtk.2.1687773181683; 
 Mon, 26 Jun 2023 02:53:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lTpIjcOMYSF6bTqvSuxm6Wp4GoVCGL1xpvAr9RD/fjYl+ohXCNtEJX9Koub0f/uiJk4TULQ==
X-Received: by 2002:ac8:7fce:0:b0:3ec:d85d:2afe with SMTP id
 b14-20020ac87fce000000b003ecd85d2afemr37940485qtk.2.1687773181369; 
 Mon, 26 Jun 2023 02:53:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aed27d9000000b003f364778b2bsm2897582qtg.4.2023.06.26.02.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 02:53:01 -0700 (PDT)
Message-ID: <2d226d72-36b4-747c-3379-a253dc61cdf2@redhat.com>
Date: Mon, 26 Jun 2023 11:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] vfio/migration: Reset bytes_transferred properly
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-3-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230626082353.18535-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=216.145.221.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Avihai,

On 6/26/23 10:23, Avihai Horon wrote:
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

a Fixes: tag would be useful.

> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
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
> index a8bfbe4b89..79eb81dfd7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -704,7 +704,6 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       case MIGRATION_STATUS_CANCELLING:
>       case MIGRATION_STATUS_CANCELLED:
>       case MIGRATION_STATUS_FAILED:
> -        bytes_transferred = 0;
>           /*
>            * If setting the device in RUNNING state fails, the device should
>            * be reset. To do so, use ERROR state as a recover state.
> @@ -825,6 +824,11 @@ int64_t vfio_mig_bytes_transferred(void)
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

I would simply use static inline in migration.h if !CONFIG_VFIO.

Thanks,

C.


  


