Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D578C51B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaygn-0005it-Om; Tue, 29 Aug 2023 09:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayge-0005hb-JQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayga-0003he-OE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693315389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gq17/kReYcQv1OcFuc3g6uOmtpnPgcArAgTALMxxZzY=;
 b=D/BfzEdW+j4cQb3hR6vMZLTmQ5pM6q21NZFC+EwY4wWYRKeyWSg2lR4Fl6aYs8sCsZJHAa
 LHJWaLnj0o7/ti8Wr2CJUx92aUAuxHv44J2bLycKVbqDSI9q60GDqQrpYyDnU9/lSrRAYX
 SGZTZRXY8XJb2ueXNbQR2FE5AilHyLM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-vQYADTAZM0G7Vs8Dtz4zNA-1; Tue, 29 Aug 2023 09:23:07 -0400
X-MC-Unique: vQYADTAZM0G7Vs8Dtz4zNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe4f953070so29748695e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315386; x=1693920186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gq17/kReYcQv1OcFuc3g6uOmtpnPgcArAgTALMxxZzY=;
 b=UveCRHFOPBJDfKCokclJ6zVqNjw6zZNQXeKhoFFwG5wjCUg5LwKdc8w20WIOUZm3Bj
 mvuCupHM7LshSan/LD3sYvbcZey5fM43KON4ZD6aSnmS3e27F41c+C3dzqzkiSC5l5hU
 dR7cq89qTmwPG+WT8Kz40NnwgMREm+pygrcfWMncmBKip4Z14+0vt8xTjgUE4Vc05mfV
 33bcxovd96h3J7szYUljlTyPw4Shn4qL4onOF/0Tk1loeDbr7D4URnAIj4yyumvHAxj7
 mZl+xdyGeS+GHXkH0IgqwWBrtxFiwbBSZVvIrBdnUb/QM9KCHtEXPND4nKK181qbKexn
 ZIZg==
X-Gm-Message-State: AOJu0YyqePAPzke1Q4mpRSxLLLhwdKvDjGL71qZ7jeqkT2p5+895YqcQ
 Ha603QJsimCXFyOYHlOpQDWAPXGEJqXuXCq1AwAT34eQ8WJ7kweTGnJRrt1Vj2xqkilJzKp9gt5
 GFI39qDg7Q1zLsvI=
X-Received: by 2002:a05:600c:2217:b0:401:b53e:6c3b with SMTP id
 z23-20020a05600c221700b00401b53e6c3bmr8707577wml.6.1693315386021; 
 Tue, 29 Aug 2023 06:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvIXkhrtuYmAOWS3H80xtzABDj6UlX6zrP3vDAQuyxB6w27MM8qdBjIu3gXHJZU6+JKK3hlA==
X-Received: by 2002:a05:600c:2217:b0:401:b53e:6c3b with SMTP id
 z23-20020a05600c221700b00401b53e6c3bmr8707557wml.6.1693315385626; 
 Tue, 29 Aug 2023 06:23:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c024d00b003fe2bea77ccsm14014920wmj.5.2023.08.29.06.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:23:04 -0700 (PDT)
Message-ID: <710b2d68-d31b-1612-d554-696025b09648@redhat.com>
Date: Tue, 29 Aug 2023 15:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] migration: Add migration prefix to functions in
 target.c
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-2-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230828151842.11303-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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
> The functions in target.c are not static, yet they don't have a proper
> migration prefix. Add such prefix.



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/migration.h | 4 ++--
>   migration/migration.c | 6 +++---
>   migration/savevm.c    | 2 +-
>   migration/target.c    | 8 ++++----
>   4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 6eea18db36..c5695de214 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -512,8 +512,8 @@ void migration_consume_urgent_request(void);
>   bool migration_rate_limit(void);
>   void migration_cancel(const Error *error);
>   
> -void populate_vfio_info(MigrationInfo *info);
> -void reset_vfio_bytes_transferred(void);
> +void migration_populate_vfio_info(MigrationInfo *info);
> +void migration_reset_vfio_bytes_transferred(void);
>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>   
>   #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 5528acb65e..92866a8f49 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1039,7 +1039,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>           populate_time_info(info, s);
>           populate_ram_info(info, s);
>           populate_disk_info(info);
> -        populate_vfio_info(info);
> +        migration_populate_vfio_info(info);
>           break;
>       case MIGRATION_STATUS_COLO:
>           info->has_status = true;
> @@ -1048,7 +1048,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>       case MIGRATION_STATUS_COMPLETED:
>           populate_time_info(info, s);
>           populate_ram_info(info, s);
> -        populate_vfio_info(info);
> +        migration_populate_vfio_info(info);
>           break;
>       case MIGRATION_STATUS_FAILED:
>           info->has_status = true;
> @@ -1641,7 +1641,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>        */
>       memset(&mig_stats, 0, sizeof(mig_stats));
>       memset(&compression_counters, 0, sizeof(compression_counters));
> -    reset_vfio_bytes_transferred();
> +    migration_reset_vfio_bytes_transferred();
>   
>       return true;
>   }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a2cb8855e2..5bf8b59a7d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1622,7 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>       migrate_init(ms);
>       memset(&mig_stats, 0, sizeof(mig_stats));
>       memset(&compression_counters, 0, sizeof(compression_counters));
> -    reset_vfio_bytes_transferred();
> +    migration_reset_vfio_bytes_transferred();
>       ms->to_dst_file = f;
>   
>       qemu_mutex_unlock_iothread();
> diff --git a/migration/target.c b/migration/target.c
> index f39c9a8d88..a6ffa9a5ce 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -15,7 +15,7 @@
>   #endif
>   
>   #ifdef CONFIG_VFIO
> -void populate_vfio_info(MigrationInfo *info)
> +void migration_populate_vfio_info(MigrationInfo *info)
>   {
>       if (vfio_mig_active()) {
>           info->vfio = g_malloc0(sizeof(*info->vfio));
> @@ -23,16 +23,16 @@ void populate_vfio_info(MigrationInfo *info)
>       }
>   }
>   
> -void reset_vfio_bytes_transferred(void)
> +void migration_reset_vfio_bytes_transferred(void)
>   {
>       vfio_reset_bytes_transferred();
>   }
>   #else
> -void populate_vfio_info(MigrationInfo *info)
> +void migration_populate_vfio_info(MigrationInfo *info)
>   {
>   }
>   
> -void reset_vfio_bytes_transferred(void)
> +void migration_reset_vfio_bytes_transferred(void)
>   {
>   }
>   #endif


