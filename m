Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7278D613
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:17:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbL42-0004w9-Rv; Wed, 30 Aug 2023 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbL3y-0004m7-BI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbL3u-0001gd-Cx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693401405;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dGzzn5aeAe4g35JzM7wXaEv5yZKXM9eTX7uB91qPyac=;
 b=bm6Pl9iUbEU5ue0G7biMSqcAtFNML9SKoltATAt9qc02RDakMlgLS0EABfRYE8PyvgKd5O
 82EOG/0B05JMwXXD0kVVrk3TjSjX5XTdUP7LRiX6WJvLFeVPKoGa2G3AaVM8pmxKUXSA+i
 TIBLtHzB6BheGZVr5Ku0nBTE4boWhtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-e8p6lNYfOdapCQ7t4ebfzA-1; Wed, 30 Aug 2023 09:16:42 -0400
X-MC-Unique: e8p6lNYfOdapCQ7t4ebfzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4330185A792;
 Wed, 30 Aug 2023 13:16:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBA4E1121315;
 Wed, 30 Aug 2023 13:16:40 +0000 (UTC)
Date: Wed, 30 Aug 2023 14:16:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V4 1/2] migration: file URI
Message-ID: <ZO9BNnnOnLjH3bcD@redhat.com>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <1688135108-316997-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1688135108-316997-2-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 30, 2023 at 07:25:07AM -0700, Steve Sistare wrote:
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
> Reviewed-by: Peter Xu <peterx@redhat.com>
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

Was it an intentional decision to assign this under the version 2 *only* ?

QEMU's LICENSE file states

[quote]
As of July 2013, contributions under version 2 of the GNU General Public
License (and no later version) are only accepted for the following files
or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
[/quote]

Thus we'd expect this new file to be version 2, or later.

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
> index 1ae2852..92b1cc4 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -16,6 +16,7 @@ system_ss.add(files(
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

This section will clash with the other pending reviewed series
that introduces a formall QAPI schema for migration addresses.

Either this or that series will need an update depending on
which Juan decides to merge first.  The changes should be
fairly simple to resolve so not a big deal.

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

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


