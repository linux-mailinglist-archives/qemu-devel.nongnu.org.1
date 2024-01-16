Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C45682E993
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 07:30:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPcx5-0008V7-Tm; Tue, 16 Jan 2024 01:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPcx2-0008Uj-Np
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPcx0-0002ch-Vk
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705386570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjW2hyd6/zfiqP3/x3EpGznWog0gSIMxuHDONd1CiyQ=;
 b=iYpQfnTszW0ZtfO0Q7K5UKY9Bp+/knU1h+AvNF6OhRBzJz6NkItidc7eytXlJ3q7EeNWiQ
 RvjtXW7Vx7kmT7FyYJzphSDzKNImLeC06NYYJI/tkxlRQVfMZT0DqjpA7mZQTOOG4fJo84
 uCZMQJIotcPwlkMLsKORb+8kPhmRj6I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-n2frAOeKNeqvlhIlx2cvJQ-1; Tue, 16 Jan 2024 01:29:28 -0500
X-MC-Unique: n2frAOeKNeqvlhIlx2cvJQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28e714c9a04so105336a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 22:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705386567; x=1705991367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjW2hyd6/zfiqP3/x3EpGznWog0gSIMxuHDONd1CiyQ=;
 b=BMSVBMY6JiYJLvGgnX/i+R7fjZDHS3NdRUITijhxnL0iypzl86F/8M9awbMqqfK4nw
 7QQh0veuLODT0kVPX3Q11BLwJPjr679nF2g4xbh3iqTdTCyCtdIILXbPA3YiVo/EtL1T
 tqAM/maqG8bJLQsK+JKso/PtRSrBVD8Gnu8Bl8I/fexoZlsDk7ciFUUoZ1SEy6KEHxCU
 TfPCpqvWUXrB8iEc9frQBpV0R/NQxcs5Wlom0x9qO3xEub4g1gndfV1K1bUwScloA4F9
 edy3soSCgWrLIfJhdIYbeKioSBWwXEDZxDNsVjYhcHbI1enPdUnHGX8YMeXxPzG1O8i3
 Cdbg==
X-Gm-Message-State: AOJu0YwwZDgwXCM3bGAWXGV8GDZGRnksY+kNEUo1c0C3dzYU/DYlMY7s
 ea8rksqGKCbEdKqcX4s8V5V4O3KkHfG+RoMkdpoMJ8vUTlx3URhWtGQ2V+Kob/txD5UdiU4MSYd
 1rJagQFa1OIlmSJMybP3Upm8RRGBa5eJ2rg==
X-Received: by 2002:a17:902:eccf:b0:1d5:13b0:cf14 with SMTP id
 a15-20020a170902eccf00b001d513b0cf14mr14470806plh.1.1705386567095; 
 Mon, 15 Jan 2024 22:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnpWRTMR52JDGWwBP6NE/rWiydBghHQ9GH3JWW5jUB1oLo3MbWVf64m49yHbSktZBmbqCnyw==
X-Received: by 2002:a17:902:eccf:b0:1d5:13b0:cf14 with SMTP id
 a15-20020a170902eccf00b001d513b0cf14mr14470799plh.1.1705386566786; 
 Mon, 15 Jan 2024 22:29:26 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902da8200b001d39ced922asm8558860plx.97.2024.01.15.22.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 22:29:26 -0800 (PST)
Date: Tue, 16 Jan 2024 14:29:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 14/30] migration/multifd: Add incoming
 QIOChannelFile support
Message-ID: <ZaYiP_RhneIWxW7n@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 27, 2023 at 05:25:56PM -0300, Fabiano Rosas wrote:
> On the receiving side we don't need to differentiate between main
> channel and threads, so whichever channel is defined first gets to be
> the main one. And since there are no packets, use the atomic channel
> count to index into the params array.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - stop setting offset in secondary channels
> - check for packets when peeking
> ---
>  migration/file.c      | 36 ++++++++++++++++++++++++++++--------
>  migration/migration.c |  3 ++-
>  migration/multifd.c   |  3 +--
>  migration/multifd.h   |  1 +
>  4 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 67d6f42da7..62ba994109 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -7,12 +7,14 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "channel.h"
>  #include "file.h"
>  #include "migration.h"
>  #include "io/channel-file.h"
>  #include "io/channel-util.h"
> +#include "options.h"
>  #include "trace.h"
>  
>  #define OFFSET_OPTION ",offset="
> @@ -117,22 +119,40 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>      g_autofree char *filename = g_strdup(file_args->filename);
>      QIOChannelFile *fioc = NULL;
>      uint64_t offset = file_args->offset;
> -    QIOChannel *ioc;
> +    int channels = 1;
> +    int i = 0, fd;
>  
>      trace_migration_file_incoming(filename);
>  
>      fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
>      if (!fioc) {
> +        goto out;

Shouldn't here be a "return"?  Won't "goto out" try to error_setg() again
and crash?

It looks like that label can be dropped.

> +    }
> +
> +    if (offset &&
> +        qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
>          return;
>      }
>  
> -    ioc = QIO_CHANNEL(fioc);
> -    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> +    if (migrate_multifd()) {
> +        channels += migrate_multifd_channels();
> +    }
> +
> +    fd = fioc->fd;
> +
> +    do {
> +        QIOChannel *ioc = QIO_CHANNEL(fioc);
> +
> +        qio_channel_set_name(ioc, "migration-file-incoming");
> +        qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                   file_accept_incoming_migration,
> +                                   NULL, NULL,
> +                                   g_main_context_get_thread_default());
> +    } while (++i < channels && (fioc = qio_channel_file_new_fd(fd)));
> +
> +out:
> +    if (!fioc) {
> +        error_setg(errp, "Error creating migration incoming channel");
>          return;
>      }
> -    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
> -    qio_channel_add_watch_full(ioc, G_IO_IN,
> -                               file_accept_incoming_migration,
> -                               NULL, NULL,
> -                               g_main_context_get_thread_default());
>  }
> diff --git a/migration/migration.c b/migration/migration.c
> index 897ed1db67..16689171ab 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -838,7 +838,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>      uint32_t channel_magic = 0;
>      int ret = 0;
>  
> -    if (migrate_multifd() && !migrate_postcopy_ram() &&
> +    if (migrate_multifd() && migrate_multifd_packets() &&
> +        !migrate_postcopy_ram() &&
>          qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>          /*
>           * With multiple channels, it is possible that we receive channels
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 427740aab6..3476fac49f 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1283,8 +1283,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>          /* initial packet */
>          num_packets = 1;
>      } else {
> -        /* next patch gives this a meaningful value */
> -        id = 0;
> +        id = qatomic_read(&multifd_recv_state->count);
>      }
>  
>      p = &multifd_recv_state->params[id];
> diff --git a/migration/multifd.h b/migration/multifd.h
> index a835643b48..a112ec7ac6 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -18,6 +18,7 @@ void multifd_save_cleanup(void);
>  int multifd_load_setup(Error **errp);
>  void multifd_load_cleanup(void);
>  void multifd_load_shutdown(void);
> +bool multifd_recv_first_channel(void);

This can be dropped?

>  bool multifd_recv_all_channels_created(void);
>  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
> -- 
> 2.35.3
> 

-- 
Peter Xu


