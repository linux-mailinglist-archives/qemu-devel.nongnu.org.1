Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38878C6D2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazL4-0008BI-CI; Tue, 29 Aug 2023 10:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qazL2-000883-VC
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qazKx-0004Tl-I9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693317892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d657rjV2Vq28eI0hdstj+Io7VFvBRdWBPSOewn+R/RY=;
 b=WbdIeiK6yiDl6MkaAAHQ4hysPX/U3QQ63o+M6z0weUHf8k+L6eJD93hm+IGDjZMai9EZ7Y
 XZfuoGYnwbVE0tZlzgXqLv6rGBe4WHC0EDOcSQHpdMS1JjO+3I3QsiZUdlNKvL3Nj5XErB
 OMy4/g3pbdMb9YTBBpzu+lhzPvHyNKI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-n0kbrr9xOhuUEEbFWwTa3w-1; Tue, 29 Aug 2023 10:04:45 -0400
X-MC-Unique: n0kbrr9xOhuUEEbFWwTa3w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63c9463c116so8569226d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693317885; x=1693922685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d657rjV2Vq28eI0hdstj+Io7VFvBRdWBPSOewn+R/RY=;
 b=Sc5Ohd89gUJs6t6n3zM9MfzLE0Dza+t2TW0/S+RZh9ZAViixT7zIHBvh3V+3XZSrBI
 fnMLL8qYr3o/ijDzWiIOhL+PlWep/i08my6nxkib380WHS4Q1K3TRR2vPbndpEzkPrMS
 gOB/1MOJWZpyFUcBRWWCDaQuIY2HXDrDk6xuwkvmO/ZYArOy/NXebXhULHAjpp/EDl0g
 /98gksGYjnxMz8yQ+1YORHWCRNT1w8zUjUcHlnkLwwB6I4GAvmqtWl/anQFWY+lm+EQC
 5K6gfqSHgEUelnGMSNwnbkfcWksc0nfi48rzuAmMWQT+y143YbaW6l1x+aZ6EC98z2Gl
 LubQ==
X-Gm-Message-State: AOJu0YzqumynydewxOjISuLbd5IDhtbA8Zb40FwQJzOh6Qoy2BSeCsKN
 YeCKMZy+irgEam1oOePUAfe+7Ub1Kqf5Ck7J41VkTIzdGmS4uVv1rRBadItXZk3xbP7GHRI9PoG
 10XdgEC+7UJ9CAIo=
X-Received: by 2002:a05:6214:d87:b0:62b:6c6f:b3e3 with SMTP id
 e7-20020a0562140d8700b0062b6c6fb3e3mr33589875qve.3.1693317884893; 
 Tue, 29 Aug 2023 07:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIFOqegIjr7uErA2n54/rc4W14ZwQ+jzAXW5kXaicYhGaFZdbRph+ZMCV5TVPvcfOx7NOqHQ==
X-Received: by 2002:a05:6214:d87:b0:62b:6c6f:b3e3 with SMTP id
 e7-20020a0562140d8700b0062b6c6fb3e3mr33589846qve.3.1693317884616; 
 Tue, 29 Aug 2023 07:04:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g18-20020a0ce4d2000000b0064f5d312babsm3385306qvm.46.2023.08.29.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:04:44 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:04:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH 1/6] migration: Add migration prefix to functions in
 target.c
Message-ID: <ZO36+h2p/X/LCG5B@x1n>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-2-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828151842.11303-2-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

On Mon, Aug 28, 2023 at 06:18:37PM +0300, Avihai Horon wrote:
> The functions in target.c are not static, yet they don't have a proper
> migration prefix. Add such prefix.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

No issue on the patch itself, but just noticed that we have hard-coded vfio
calls in migration paths.. that's slightly unfortunate. :(

> ---
>  migration/migration.h | 4 ++--
>  migration/migration.c | 6 +++---
>  migration/savevm.c    | 2 +-
>  migration/target.c    | 8 ++++----
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 6eea18db36..c5695de214 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -512,8 +512,8 @@ void migration_consume_urgent_request(void);
>  bool migration_rate_limit(void);
>  void migration_cancel(const Error *error);
>  
> -void populate_vfio_info(MigrationInfo *info);
> -void reset_vfio_bytes_transferred(void);
> +void migration_populate_vfio_info(MigrationInfo *info);
> +void migration_reset_vfio_bytes_transferred(void);
>  void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>  
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 5528acb65e..92866a8f49 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1039,7 +1039,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
>          populate_disk_info(info);
> -        populate_vfio_info(info);
> +        migration_populate_vfio_info(info);

(maybe in the future we should have SaveVMHandlers hooks for populating
 data for ram/disk/vfio/..., or some other way to not hard-code these)

>          break;
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> @@ -1048,7 +1048,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_COMPLETED:
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
> -        populate_vfio_info(info);
> +        migration_populate_vfio_info(info);
>          break;
>      case MIGRATION_STATUS_FAILED:
>          info->has_status = true;
> @@ -1641,7 +1641,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>       */
>      memset(&mig_stats, 0, sizeof(mig_stats));
>      memset(&compression_counters, 0, sizeof(compression_counters));
> -    reset_vfio_bytes_transferred();
> +    migration_reset_vfio_bytes_transferred();

Could this already be done during vfio_save_setup(), to avoid calling an
vfio function directly in migration.c?

Again, not a request for this patchset, but more to see whether it'll work
to be moved there.

Thanks,

>  
>      return true;
>  }

-- 
Peter Xu


