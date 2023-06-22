Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE1739E1C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHJ8-0005uG-Pw; Thu, 22 Jun 2023 06:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCHJ7-0005tr-8U
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCHJ5-00023h-6u
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687428769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zOrxnBQY2m2uV8IDYJmtbHH3tt0LHi27rfHj5y/YCZc=;
 b=LNeFUwEifChKUcY+Sl+vWW737DR5AdIS8l3SgWAApDHdWkJHjuojJpIfoxY4dHpOoSTehV
 q/nDu7+6uxucE7Za41XKnYhwjBJ67GOWYQHH7mzXjze6AB79BZ5j2UBf7uGox5cMOA0hxd
 iczMg55+v0jcch4oIAXAhq5sNc0yiRY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-UlxZjnVrNA2TLqtGoD-cZg-1; Thu, 22 Jun 2023 06:12:48 -0400
X-MC-Unique: UlxZjnVrNA2TLqtGoD-cZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A20BD280BC42;
 Thu, 22 Jun 2023 10:12:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8CA2112132C;
 Thu, 22 Jun 2023 10:12:46 +0000 (UTC)
Date: Thu, 22 Jun 2023 11:12:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZJQenKR1aMJzaLCu@redhat.com>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be used
> as an alternative to 'exec:cat > file' in minimized containers that do not
> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
> be used in HMP commands, and as a qemu command-line parameter.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

In the cases where libvirt wants to save/restore QEMU migration state
to a file, we also need to have libvirt header and XML document at the
front of the file.

IOW, if libvirt is to be able to use this new 'file:' protocol, then
it neeeds to have the ability to specify an offset too. eg so libvirt
can tell QEMU to start reading/writing at, for example, 4MB offset
from the start.

Should be fairly easy to add on top of this - just requires support
for a URI parameter, and then a seek once the file is opened.

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
> index b37eb96..b93449d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4610,6 +4610,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>      "                prepare for incoming migration, listen on\n" \
>      "                specified protocol and socket address\n" \
>      "-incoming fd:fd\n" \
> +    "-incoming file:filename\n" \
>      "-incoming exec:cmdline\n" \
>      "                accept incoming migration on given file descriptor\n" \
>      "                or from given external command\n" \
> @@ -4626,7 +4627,10 @@ SRST
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


