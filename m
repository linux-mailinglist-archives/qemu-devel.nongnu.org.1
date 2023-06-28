Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC17416F7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 19:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYdn-0002J9-Vc; Wed, 28 Jun 2023 13:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEYdh-00028t-HV
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEYdf-00056P-1y
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687972048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMMI+N93nUusVzArkuATSkAxiSby9m0cXsKoxAgECXI=;
 b=ECdYzmeaDH5iy2JzJkdzan4SI5sW8b/+rOlqXHu5ucrknfithQL57b5QJVLHzJ4BfzC50N
 oo0lo/B4ZFyOSwnwVFakJmUIVSTISfmDn6Qsq9GuqEx7IqcoghV6Je/eY+nGU6tfNNJp4S
 muQwGemY9p57ese5+WJRjgzVGoLxhf8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-AzHFU8PpNKiPPwse6l_FwA-1; Wed, 28 Jun 2023 13:07:26 -0400
X-MC-Unique: AzHFU8PpNKiPPwse6l_FwA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62ffa1214edso10863026d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 10:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687972046; x=1690564046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMMI+N93nUusVzArkuATSkAxiSby9m0cXsKoxAgECXI=;
 b=QRRWzQJTOwLMDOVjuAl0URsLAthXu27Nr7n7BEfa95oc0XTU8Hau4PpKQ30nmBX6y2
 2jCufPC/kj7V6iVpMOKJ3KWoW4yskXzpOE9Rj5x4mBVAbUKqcF6Y2UQNSIXHB9Awjwdt
 XRKmslPOhyaw0IrGv7TwfLHM7ZELBbWhTdGrsakWPjsnJWhYfAQhShqN0231Nctr2pxs
 YOldxFBlm7SRBlb5yovW7oOd/KGQscxDv/aiipGpYWfzBZRQggLYFpdnOAwWKB4GCH8v
 d0HkmQyHPUk+XMt7JvRtXvTtiI6tcCXZaWTZpN/7Q+ySnApeIhdIg73Gx5xsEh18ZjFX
 d/wg==
X-Gm-Message-State: ABy/qLbpIDSMdaOKJmk/EZmOOtOtJazyHqfq9GKJHTX9kqqUfFkFqIwx
 0sROJDBwCdA4uhg9J8rVLZiwZ+oGYSBPfGX3devtygvUBP9wt7pZJZOYBHLU2OCOPhtJr65oKsV
 JCMwVK0gsY724FcE=
X-Received: by 2002:a05:6214:410d:b0:625:aa49:c182 with SMTP id
 kc13-20020a056214410d00b00625aa49c182mr268272qvb.6.1687972046127; 
 Wed, 28 Jun 2023 10:07:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkvZugTTMGmpIA3aMZ0shTzGkEvQOY+zTlQebDo4wJkOG9veBdWH5cvn0bhp9ZmccjejgK5A==
X-Received: by 2002:a05:6214:410d:b0:625:aa49:c182 with SMTP id
 kc13-20020a056214410d00b00625aa49c182mr268236qvb.6.1687972045655; 
 Wed, 28 Jun 2023 10:07:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n16-20020a0cfbd0000000b00635f3cf3b5dsm1862315qvp.29.2023.06.28.10.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 10:07:25 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:07:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 1/2] migration: file URI
Message-ID: <ZJxozLt2gfqmnjSa@x1n>
References: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
 <1687466251-310524-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1687466251-310524-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 01:37:30PM -0700, Steve Sistare wrote:
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be
> used as an alternative to 'exec:cat > file' in minimized containers that
> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
> It can be used in HMP commands, and as a qemu command-line parameter.
> 
> For best performance, guest ram should be shared and x-ignore-shared
> should be true, so guest pages are not written to the file, in which case
> the guest may remain running.  If ram is not so configured, then the user
> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
> the same page, causing it to be appended to the file multiple times,
> and the file may grow unboundedly.  That issue is being addressed in the
> "fixed-ram" patch series.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/file.h       | 14 ++++++++++++
>  migration/meson.build  |  1 +
>  migration/migration.c  |  5 ++++
>  migration/trace-events |  4 ++++
>  qemu-options.hx        |  6 ++++-
>  6 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 migration/file.c
>  create mode 100644 migration/file.h
> 
> diff --git a/migration/file.c b/migration/file.c
> new file mode 100644
> index 0000000..8e35827
> --- /dev/null
> +++ b/migration/file.c
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "channel.h"
> +#include "file.h"
> +#include "migration.h"
> +#include "io/channel-file.h"
> +#include "io/channel-util.h"
> +#include "trace.h"
> +
> +void file_start_outgoing_migration(MigrationState *s, const char *filename,
> +                                   Error **errp)
> +{
> +    g_autoptr(QIOChannelFile) fioc = NULL;
> +    QIOChannel *ioc;
> +
> +    trace_migration_file_outgoing(filename);
> +
> +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> +                                     0600, errp);
> +    if (!fioc) {
> +        return;
> +    }
> +
> +    ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, "migration-file-outgoing");
> +    migration_channel_connect(s, ioc, NULL, NULL);

Miss one object_unref(ioc)?

> +}
> +
> +static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> +                                               GIOCondition condition,
> +                                               gpointer opaque)
> +{
> +    migration_channel_process_incoming(ioc);
> +    object_unref(OBJECT(ioc));
> +    return G_SOURCE_REMOVE;
> +}
> +
> +void file_start_incoming_migration(const char *filename, Error **errp)
> +{
> +    QIOChannelFile *fioc = NULL;
> +    QIOChannel *ioc;
> +
> +    trace_migration_file_incoming(filename);
> +
> +    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
> +    if (!fioc) {
> +        return;
> +    }
> +
> +    ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
> +    qio_channel_add_watch_full(ioc, G_IO_IN,
> +                               file_accept_incoming_migration,
> +                               NULL, NULL,
> +                               g_main_context_get_thread_default());
> +}
> diff --git a/migration/file.h b/migration/file.h
> new file mode 100644
> index 0000000..841b94a
> --- /dev/null
> +++ b/migration/file.h
> @@ -0,0 +1,14 @@
> +/*
> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_FILE_H
> +#define QEMU_MIGRATION_FILE_H
> +void file_start_incoming_migration(const char *filename, Error **errp);
> +
> +void file_start_outgoing_migration(MigrationState *s, const char *filename,
> +                                   Error **errp);
> +#endif
> diff --git a/migration/meson.build b/migration/meson.build
> index 8ba6e42..3af817e 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -16,6 +16,7 @@ softmmu_ss.add(files(
>    'dirtyrate.c',
>    'exec.c',
>    'fd.c',
> +  'file.c',
>    'global_state.c',
>    'migration-hmp-cmds.c',
>    'migration.c',
> diff --git a/migration/migration.c b/migration/migration.c
> index dc05c6f..cfbde86 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -20,6 +20,7 @@
>  #include "migration/blocker.h"
>  #include "exec.h"
>  #include "fd.h"
> +#include "file.h"
>  #include "socket.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> @@ -442,6 +443,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
>          exec_start_incoming_migration(p, errp);
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_incoming_migration(p, errp);
> +    } else if (strstart(uri, "file:", &p)) {
> +        file_start_incoming_migration(p, errp);
>      } else {
>          error_setg(errp, "unknown migration protocol: %s", uri);
>      }
> @@ -1662,6 +1665,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          exec_start_outgoing_migration(s, p, &local_err);
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_outgoing_migration(s, p, &local_err);
> +    } else if (strstart(uri, "file:", &p)) {
> +        file_start_outgoing_migration(s, p, &local_err);
>      } else {
>          if (!(has_resume && resume)) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> diff --git a/migration/trace-events b/migration/trace-events
> index cdaef7a..c8c1771 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -307,6 +307,10 @@ migration_exec_incoming(const char *cmd) "cmd=%s"
>  migration_fd_outgoing(int fd) "fd=%d"
>  migration_fd_incoming(int fd) "fd=%d"
>  
> +# file.c
> +migration_file_outgoing(const char *filename) "filename=%s"
> +migration_file_incoming(const char *filename) "filename=%s"
> +
>  # socket.c
>  migration_socket_incoming_accepted(void) ""
>  migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b57489d..5aab8fb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4622,6 +4622,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>      "                prepare for incoming migration, listen on\n" \
>      "                specified protocol and socket address\n" \
>      "-incoming fd:fd\n" \
> +    "-incoming file:filename\n" \
>      "-incoming exec:cmdline\n" \
>      "                accept incoming migration on given file descriptor\n" \
>      "                or from given external command\n" \
> @@ -4638,7 +4639,10 @@ SRST
>      Prepare for incoming migration, listen on a given unix socket.
>  
>  ``-incoming fd:fd``
> -    Accept incoming migration from a given filedescriptor.
> +    Accept incoming migration from a given file descriptor.
> +
> +``-incoming file:filename``
> +    Accept incoming migration from a given file.
>  
>  ``-incoming exec:cmdline``
>      Accept incoming migration as an output from specified external
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


