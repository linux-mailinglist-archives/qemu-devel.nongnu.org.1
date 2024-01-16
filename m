Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05FA82E866
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 05:07:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPaiQ-0002Uu-88; Mon, 15 Jan 2024 23:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPaiO-0002Uk-GM
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 23:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPaiJ-0003ys-IZ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 23:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705377969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JaO3DO2ea9P2sGudaMBrPwMb2opEKUEmwxanEpTPUdw=;
 b=enhLRR5ZV5TsGF2NsCs65W+su7DoLngArTHbuQ/5yRqvly45uZGqELPzrFSGRP3Vd3eI1c
 Zt8wvm0YT77JUPHcUYQs0ptOw8u7VfVXD3XXBmeAPV6bgfk9O0N/JEn5u0D5sCNq44t6C2
 FjKS7WitbFNTqxCCBu2N/66SNHV/i5c=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-suVhvc_HMLeB2v9yZxFeEw-1; Mon, 15 Jan 2024 23:06:07 -0500
X-MC-Unique: suVhvc_HMLeB2v9yZxFeEw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9b3a964a1so2402728b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 20:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705377966; x=1705982766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaO3DO2ea9P2sGudaMBrPwMb2opEKUEmwxanEpTPUdw=;
 b=aX+VFpXEnCugX3RlUSXJ8xQU20hLkDCXAciKcUt4gKSrAFsE6gPlOBwdEE2tPlvMrQ
 s70d8qGMV3arH1KXljZgShbxVaZSvLFu4yBfB/eCrjbB+bqfbmf5pQpOfvGqjPsKFOnn
 8+YWGFU0OEv/Ne8AhN6WcVrcBsZLy3hRlQ42/9VvJz0fTFnsRMjoKLwPwD8Jed3wXXsZ
 /jlqXwTCGRjtQl+n/1Zg87UQA8kHY2/jYRdIdJhADABsden5zm6FC01VecAU7RFJTB3N
 UJXLhqLiEwegFpgrD532Ap8zKCl4N/pB5O8d/EWq4ILnbv3yS4sJFkrwprzOsosFixkC
 FH5Q==
X-Gm-Message-State: AOJu0Ywt1hNm01rAA/Ky2MRpSjlCmmyjxpzmFDsEiyfpX46U9E6Kvjb7
 s2BpBVqifkkEGtTGdkUX375vYCDxF6dSjS+JHvqUTZ6bYWBTLBtV5O00adw8kBlNGS4cYMEtQH7
 YKqTcXWVFq9LfFydlEyrMgLs=
X-Received: by 2002:a05:6a00:4b45:b0:6da:736d:67c8 with SMTP id
 kr5-20020a056a004b4500b006da736d67c8mr15081105pfb.3.1705377966046; 
 Mon, 15 Jan 2024 20:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqVwtFS3OqAgVet/J2sDiBf1zZt4GfV33+qo7wMPPqUX5XAbKwDzgRmAiEWRk6/W7F2irSPA==
X-Received: by 2002:a05:6a00:4b45:b0:6da:736d:67c8 with SMTP id
 kr5-20020a056a004b4500b006da736d67c8mr15081089pfb.3.1705377965727; 
 Mon, 15 Jan 2024 20:06:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s17-20020a056a00195100b006d8610fcb63sm8339464pfk.87.2024.01.15.20.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 20:06:05 -0800 (PST)
Date: Tue, 16 Jan 2024 12:05:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 13/30] migration/multifd: Add outgoing
 QIOChannelFile support
Message-ID: <ZaYApbyD5iexbYYW@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 27, 2023 at 05:25:55PM -0300, Fabiano Rosas wrote:
> Allow multifd to open file-backed channels. This will be used when
> enabling the fixed-ram migration stream format which expects a
> seekable transport.
> 
> The QIOChannel read and write methods will use the preadv/pwritev
> versions which don't update the file offset at each call so we can
> reuse the fd without re-opening for every channel.
> 
> Note that this is just setup code and multifd cannot yet make use of
> the file channels.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - open multifd channels with O_WRONLY and no mode
> - stop cancelling migration and propagate error via qio_task
> ---
>  migration/file.c      | 47 +++++++++++++++++++++++++++++++++++++++++--
>  migration/file.h      |  5 +++++
>  migration/multifd.c   | 14 +++++++++++--
>  migration/options.c   |  7 +++++++
>  migration/options.h   |  1 +
>  migration/qemu-file.h |  1 -
>  6 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 5d4975f43e..67d6f42da7 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -17,6 +17,10 @@
>  
>  #define OFFSET_OPTION ",offset="
>  
> +static struct FileOutgoingArgs {
> +    char *fname;
> +} outgoing_args;
> +
>  /* Remove the offset option from @filespec and return it in @offsetp. */
>  
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> @@ -36,6 +40,42 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>      return 0;
>  }
>  
> +static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
> +{
> +    /* noop */
> +}
> +
> +int file_send_channel_destroy(QIOChannel *ioc)
> +{
> +    if (ioc) {
> +        qio_channel_close(ioc, NULL);
> +        object_unref(OBJECT(ioc));
> +    }
> +    g_free(outgoing_args.fname);
> +    outgoing_args.fname = NULL;
> +
> +    return 0;
> +}
> +
> +void file_send_channel_create(QIOTaskFunc f, void *data)
> +{
> +    QIOChannelFile *ioc;
> +    QIOTask *task;
> +    Error *err = NULL;
> +    int flags = O_WRONLY;
> +
> +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
> +
> +    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
> +    if (!ioc) {
> +        qio_task_set_error(task, err);
> +        return;
> +    }
> +
> +    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
> +                           (gpointer)data, NULL, NULL);

This is pretty weird.  This invokes a thread, but it'll run a noop.  It
seems meaningless to me.

I assume you wanted to keep using the same async model as the socket typed
multifd, but I don't think that works anyway, because file open blocks at
qio_channel_file_new_path() so it's sync anyway.

AFAICT we still share the code, as long as the file path properly invokes
multifd_channel_connect() after the iochannel is setup.

> +}
> +
>  void file_start_outgoing_migration(MigrationState *s,
>                                     FileMigrationArgs *file_args, Error **errp)
>  {
> @@ -43,15 +83,18 @@ void file_start_outgoing_migration(MigrationState *s,
>      g_autofree char *filename = g_strdup(file_args->filename);
>      uint64_t offset = file_args->offset;
>      QIOChannel *ioc;
> +    int flags = O_CREAT | O_TRUNC | O_WRONLY;
> +    mode_t mode = 0660;
>  
>      trace_migration_file_outgoing(filename);
>  
> -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> -                                     0600, errp);
> +    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
>      if (!fioc) {
>          return;
>      }
>  
> +    outgoing_args.fname = g_strdup(filename);
> +
>      ioc = QIO_CHANNEL(fioc);
>      if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
>          return;
> diff --git a/migration/file.h b/migration/file.h
> index 37d6a08bfc..511019b319 100644
> --- a/migration/file.h
> +++ b/migration/file.h
> @@ -9,10 +9,15 @@
>  #define QEMU_MIGRATION_FILE_H
>  
>  #include "qapi/qapi-types-migration.h"
> +#include "io/task.h"
> +#include "channel.h"
>  
>  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
>  
>  void file_start_outgoing_migration(MigrationState *s,
>                                     FileMigrationArgs *file_args, Error **errp);
>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
> +
> +void file_send_channel_create(QIOTaskFunc f, void *data);
> +int file_send_channel_destroy(QIOChannel *ioc);
>  #endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 123ff0dec0..427740aab6 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -17,6 +17,7 @@
>  #include "exec/ramblock.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "file.h"
>  #include "ram.h"
>  #include "migration.h"
>  #include "migration-stats.h"
> @@ -28,6 +29,7 @@
>  #include "threadinfo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
> +#include "io/channel-file.h"
>  #include "io/channel-socket.h"
>  #include "yank_functions.h"
>  
> @@ -511,7 +513,11 @@ static void multifd_send_terminate_threads(Error *err)
>  
>  static int multifd_send_channel_destroy(QIOChannel *send)
>  {
> -    return socket_send_channel_destroy(send);
> +    if (migrate_to_file()) {
> +        return file_send_channel_destroy(send);
> +    } else {
> +        return socket_send_channel_destroy(send);
> +    }
>  }
>  
>  void multifd_save_cleanup(void)
> @@ -904,7 +910,11 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>  
>  static void multifd_new_send_channel_create(gpointer opaque)
>  {
> -    socket_send_channel_create(multifd_new_send_channel_async, opaque);
> +    if (migrate_to_file()) {
> +        file_send_channel_create(multifd_new_send_channel_async, opaque);
> +    } else {
> +        socket_send_channel_create(multifd_new_send_channel_async, opaque);
> +    }
>  }
>  
>  int multifd_save_setup(Error **errp)
> diff --git a/migration/options.c b/migration/options.c
> index 10730b13ba..f671e24758 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -409,6 +409,13 @@ bool migrate_tls(void)
>      return s->parameters.tls_creds && *s->parameters.tls_creds;
>  }
>  
> +bool migrate_to_file(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return qemu_file_is_seekable(s->to_dst_file);
> +}

Would this migrate_to_file() == migrate_multifd_packets()?

Maybe we can keep using the other one and drop migrate_to_file?

> +
>  typedef enum WriteTrackingSupport {
>      WT_SUPPORT_UNKNOWN = 0,
>      WT_SUPPORT_ABSENT,
> diff --git a/migration/options.h b/migration/options.h
> index 8a19d6939c..84628a76e8 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -60,6 +60,7 @@ bool migrate_multifd_packets(void);
>  bool migrate_postcopy(void);
>  bool migrate_rdma(void);
>  bool migrate_tls(void);
> +bool migrate_to_file(void);
>  
>  /* capabilities helpers */
>  
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 32fd4a34fd..78ea21ab98 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -83,5 +83,4 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>                            off_t pos);
>  
>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
> -
>  #endif
> -- 
> 2.35.3
> 

-- 
Peter Xu


