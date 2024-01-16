Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48E82EA03
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:26:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdpO-0005L6-Vd; Tue, 16 Jan 2024 02:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdpL-0005Ka-8u
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdpJ-00030k-8G
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705389936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=50igfUSiDCF09d1FZSEN0LexSii09kG4A1iVBLlS7s0=;
 b=HkNuKJ6fXn9k+E9rFV6rn2tDGKnNN8aFvPSLGMxEFoC4KYP6D80r4FxmBL3WZ2vhazWx8k
 mL9wwi+ol4VtG+Jn+wo8halCdS+46eKkhk6Bqt9f6wlJ/W7GkUP54k2p8N8uqZBnScUz56
 U/JFJYII68x7A0ghRz5LNFAFteCf0UM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-2tAH-PohP5WB0mmCvjjlzA-1; Tue, 16 Jan 2024 02:25:34 -0500
X-MC-Unique: 2tAH-PohP5WB0mmCvjjlzA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28df183249bso1325939a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 23:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705389933; x=1705994733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50igfUSiDCF09d1FZSEN0LexSii09kG4A1iVBLlS7s0=;
 b=APLafQsi3EQQIubrhb+e4tKt5u+5KSRrJS+7RXO0oeFm1yty/nqs4naIFcOhw+P5id
 SJ8IRc67zrgLpp65SDrX2kWnbfP8A1K9++Cukk6l215E/W8mYDLY+nP2ZynRH0kdzYL1
 oLS6GL9Svg6gAtVJ81csfMDepSoLOdc4cHyRukBtsIUb9jsxUgA2TfNFJhQVow3uw52U
 jY4QtP6vKtv2Y0LAeTaP4e8LDBVQqfWrx0Nkv5+DDfYpEZ4YbAgzcNRgVvVSh3Rbc47R
 M20JcYe7paIU1tzYzeLyKtn5FPE2rBuWfiiDCNzeuCRryX/7LwYL9/DVsYzx+IeBWrP9
 kNsA==
X-Gm-Message-State: AOJu0YxJfS9XDnnhNZygQHfNqD3ZiCJgwHXI7j40MYBFiOdy9/xa/6hR
 UQf1KhIqxiZ4bKgElMTC+7LEBE68iowfM+bnvIZnTZcqp0NxwHAFMl4dL3BGivaYY2+d8TSa+Ak
 1swtGOtuOGBllg6EVUKCY444=
X-Received: by 2002:a17:90b:1bc5:b0:28e:2305:e378 with SMTP id
 oa5-20020a17090b1bc500b0028e2305e378mr8935542pjb.1.1705389933126; 
 Mon, 15 Jan 2024 23:25:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmPZL/67I7j1KRXC7XfdsrHZ8ab6EHMv3Fjq3b4MXZlu/RT/v0+/MwL3l1YwVDEaKHUqaiGQ==
X-Received: by 2002:a17:90b:1bc5:b0:28e:2305:e378 with SMTP id
 oa5-20020a17090b1bc500b0028e2305e378mr8935528pjb.1.1705389932831; 
 Mon, 15 Jan 2024 23:25:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z18-20020a17090ab11200b0028ddf2efa58sm10981286pjq.16.2024.01.15.23.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 23:25:32 -0800 (PST)
Date: Tue, 16 Jan 2024 15:25:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 13/30] migration/multifd: Add outgoing
 QIOChannelFile support
Message-ID: <ZaYvZGX4ZHKVs3Dw@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-14-farosas@suse.de> <ZaYApbyD5iexbYYW@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaYApbyD5iexbYYW@x1n>
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

On Tue, Jan 16, 2024 at 12:05:57PM +0800, Peter Xu wrote:
> On Mon, Nov 27, 2023 at 05:25:55PM -0300, Fabiano Rosas wrote:
> > Allow multifd to open file-backed channels. This will be used when
> > enabling the fixed-ram migration stream format which expects a
> > seekable transport.
> > 
> > The QIOChannel read and write methods will use the preadv/pwritev
> > versions which don't update the file offset at each call so we can
> > reuse the fd without re-opening for every channel.
> > 
> > Note that this is just setup code and multifd cannot yet make use of
> > the file channels.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> > - open multifd channels with O_WRONLY and no mode
> > - stop cancelling migration and propagate error via qio_task
> > ---
> >  migration/file.c      | 47 +++++++++++++++++++++++++++++++++++++++++--
> >  migration/file.h      |  5 +++++
> >  migration/multifd.c   | 14 +++++++++++--
> >  migration/options.c   |  7 +++++++
> >  migration/options.h   |  1 +
> >  migration/qemu-file.h |  1 -
> >  6 files changed, 70 insertions(+), 5 deletions(-)
> > 
> > diff --git a/migration/file.c b/migration/file.c
> > index 5d4975f43e..67d6f42da7 100644
> > --- a/migration/file.c
> > +++ b/migration/file.c
> > @@ -17,6 +17,10 @@
> >  
> >  #define OFFSET_OPTION ",offset="
> >  
> > +static struct FileOutgoingArgs {
> > +    char *fname;
> > +} outgoing_args;
> > +
> >  /* Remove the offset option from @filespec and return it in @offsetp. */
> >  
> >  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> > @@ -36,6 +40,42 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> >      return 0;
> >  }
> >  
> > +static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
> > +{
> > +    /* noop */
> > +}
> > +
> > +int file_send_channel_destroy(QIOChannel *ioc)
> > +{
> > +    if (ioc) {
> > +        qio_channel_close(ioc, NULL);
> > +        object_unref(OBJECT(ioc));
> > +    }
> > +    g_free(outgoing_args.fname);
> > +    outgoing_args.fname = NULL;
> > +
> > +    return 0;
> > +}
> > +
> > +void file_send_channel_create(QIOTaskFunc f, void *data)
> > +{
> > +    QIOChannelFile *ioc;
> > +    QIOTask *task;
> > +    Error *err = NULL;
> > +    int flags = O_WRONLY;
> > +
> > +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
> > +
> > +    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
> > +    if (!ioc) {
> > +        qio_task_set_error(task, err);
> > +        return;
> > +    }
> > +
> > +    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
> > +                           (gpointer)data, NULL, NULL);
> 
> This is pretty weird.  This invokes a thread, but it'll run a noop.  It
> seems meaningless to me.
> 
> I assume you wanted to keep using the same async model as the socket typed
> multifd, but I don't think that works anyway, because file open blocks at
> qio_channel_file_new_path() so it's sync anyway.
> 
> AFAICT we still share the code, as long as the file path properly invokes
> multifd_channel_connect() after the iochannel is setup.
> 
> > +}
> > +
> >  void file_start_outgoing_migration(MigrationState *s,
> >                                     FileMigrationArgs *file_args, Error **errp)
> >  {
> > @@ -43,15 +83,18 @@ void file_start_outgoing_migration(MigrationState *s,
> >      g_autofree char *filename = g_strdup(file_args->filename);
> >      uint64_t offset = file_args->offset;
> >      QIOChannel *ioc;
> > +    int flags = O_CREAT | O_TRUNC | O_WRONLY;
> > +    mode_t mode = 0660;
> >  
> >      trace_migration_file_outgoing(filename);
> >  
> > -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> > -                                     0600, errp);
> > +    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
> >      if (!fioc) {
> >          return;
> >      }
> >  
> > +    outgoing_args.fname = g_strdup(filename);
> > +
> >      ioc = QIO_CHANNEL(fioc);
> >      if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> >          return;
> > diff --git a/migration/file.h b/migration/file.h
> > index 37d6a08bfc..511019b319 100644
> > --- a/migration/file.h
> > +++ b/migration/file.h
> > @@ -9,10 +9,15 @@
> >  #define QEMU_MIGRATION_FILE_H
> >  
> >  #include "qapi/qapi-types-migration.h"
> > +#include "io/task.h"
> > +#include "channel.h"
> >  
> >  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
> >  
> >  void file_start_outgoing_migration(MigrationState *s,
> >                                     FileMigrationArgs *file_args, Error **errp);
> >  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
> > +
> > +void file_send_channel_create(QIOTaskFunc f, void *data);
> > +int file_send_channel_destroy(QIOChannel *ioc);
> >  #endif
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 123ff0dec0..427740aab6 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -17,6 +17,7 @@
> >  #include "exec/ramblock.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > +#include "file.h"
> >  #include "ram.h"
> >  #include "migration.h"
> >  #include "migration-stats.h"
> > @@ -28,6 +29,7 @@
> >  #include "threadinfo.h"
> >  #include "options.h"
> >  #include "qemu/yank.h"
> > +#include "io/channel-file.h"
> >  #include "io/channel-socket.h"
> >  #include "yank_functions.h"
> >  
> > @@ -511,7 +513,11 @@ static void multifd_send_terminate_threads(Error *err)
> >  
> >  static int multifd_send_channel_destroy(QIOChannel *send)
> >  {
> > -    return socket_send_channel_destroy(send);
> > +    if (migrate_to_file()) {
> > +        return file_send_channel_destroy(send);
> > +    } else {
> > +        return socket_send_channel_destroy(send);
> > +    }
> >  }
> >  
> >  void multifd_save_cleanup(void)
> > @@ -904,7 +910,11 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
> >  
> >  static void multifd_new_send_channel_create(gpointer opaque)
> >  {
> > -    socket_send_channel_create(multifd_new_send_channel_async, opaque);
> > +    if (migrate_to_file()) {
> > +        file_send_channel_create(multifd_new_send_channel_async, opaque);
> > +    } else {
> > +        socket_send_channel_create(multifd_new_send_channel_async, opaque);
> > +    }
> >  }
> >  
> >  int multifd_save_setup(Error **errp)
> > diff --git a/migration/options.c b/migration/options.c
> > index 10730b13ba..f671e24758 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -409,6 +409,13 @@ bool migrate_tls(void)
> >      return s->parameters.tls_creds && *s->parameters.tls_creds;
> >  }
> >  
> > +bool migrate_to_file(void)
> > +{
> > +    MigrationState *s = migrate_get_current();
> > +
> > +    return qemu_file_is_seekable(s->to_dst_file);
> > +}
> 
> Would this migrate_to_file() == migrate_multifd_packets()?
> 
> Maybe we can keep using the other one and drop migrate_to_file?

Or perhaps the other way round; as migrate_to_file() is a migration global
helper, so applicable without multifd.

> 
> > +
> >  typedef enum WriteTrackingSupport {
> >      WT_SUPPORT_UNKNOWN = 0,
> >      WT_SUPPORT_ABSENT,
> > diff --git a/migration/options.h b/migration/options.h
> > index 8a19d6939c..84628a76e8 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -60,6 +60,7 @@ bool migrate_multifd_packets(void);
> >  bool migrate_postcopy(void);
> >  bool migrate_rdma(void);
> >  bool migrate_tls(void);
> > +bool migrate_to_file(void);
> >  
> >  /* capabilities helpers */
> >  
> > diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> > index 32fd4a34fd..78ea21ab98 100644
> > --- a/migration/qemu-file.h
> > +++ b/migration/qemu-file.h
> > @@ -83,5 +83,4 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
> >                            off_t pos);
> >  
> >  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
> > -
> >  #endif
> > -- 
> > 2.35.3
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


