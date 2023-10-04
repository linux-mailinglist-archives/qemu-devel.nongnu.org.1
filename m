Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589A7B7F7C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Cb-0008WO-26; Wed, 04 Oct 2023 08:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Bp-00077Q-P3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Bi-0004Tn-Bo
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAxJd50P6fUA8+vcaXVb7ZW5r7k5eWbpY4YxTPg09O0=;
 b=CSKAxl0EdqGJ9MiZq7tgZvs15rTk716v/70lTptI+4rK3v5bgmZM24qIL0qQqhegijAcr9
 gTnaS2p+1xhMh4z7mmjaxBaqmCKPij7v8AEodh8At3YMnNvjtsM9qxu8SMmTVPwK/7s6Jw
 kcDlmjCMLwhTIPKEVO3K19POrc+TCW0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-WeTDxYEGPJahk-tKXkJTjA-1; Wed, 04 Oct 2023 08:40:59 -0400
X-MC-Unique: WeTDxYEGPJahk-tKXkJTjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF3803C23FC5;
 Wed,  4 Oct 2023 12:40:58 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8E52026D4B;
 Wed,  4 Oct 2023 12:40:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 Michael Galaxy <mgalaxy@akamai.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/11] migration: file URI
Date: Wed,  4 Oct 2023 14:40:36 +0200
Message-ID: <20231004124038.16002-10-quintela@redhat.com>
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Extend the migration URI to support file:<filename>.  This can be used for
any migration scenario that does not require a reverse path.  It can be
used as an alternative to 'exec:cat > file' in minimized containers that
do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
It can be used in HMP commands, and as a qemu command-line parameter.

For best performance, guest ram should be shared and x-ignore-shared
should be true, so guest pages are not written to the file, in which case
the guest may remain running.  If ram is not so configured, then the user
is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
the same page, causing it to be appended to the file multiple times,
and the file may grow unboundedly.  That issue is being addressed in the
"fixed-ram" patch series.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Tested-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <1694182931-61390-2-git-send-email-steven.sistare@oracle.com>
---
 migration/file.h       | 14 ++++++++++
 migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++
 migration/migration.c  |  5 ++++
 migration/meson.build  |  1 +
 migration/trace-events |  4 +++
 qemu-options.hx        |  6 +++-
 6 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 migration/file.h
 create mode 100644 migration/file.c

diff --git a/migration/file.h b/migration/file.h
new file mode 100644
index 0000000000..90fa4849e0
--- /dev/null
+++ b/migration/file.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_FILE_H
+#define QEMU_MIGRATION_FILE_H
+void file_start_incoming_migration(const char *filename, Error **errp);
+
+void file_start_outgoing_migration(MigrationState *s, const char *filename,
+                                   Error **errp);
+#endif
diff --git a/migration/file.c b/migration/file.c
new file mode 100644
index 0000000000..0a65c43fdd
--- /dev/null
+++ b/migration/file.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "channel.h"
+#include "file.h"
+#include "migration.h"
+#include "io/channel-file.h"
+#include "io/channel-util.h"
+#include "trace.h"
+
+void file_start_outgoing_migration(MigrationState *s, const char *filename,
+                                   Error **errp)
+{
+    g_autoptr(QIOChannelFile) fioc = NULL;
+    QIOChannel *ioc;
+
+    trace_migration_file_outgoing(filename);
+
+    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
+                                     0600, errp);
+    if (!fioc) {
+        return;
+    }
+
+    ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, "migration-file-outgoing");
+    migration_channel_connect(s, ioc, NULL, NULL);
+}
+
+static gboolean file_accept_incoming_migration(QIOChannel *ioc,
+                                               GIOCondition condition,
+                                               gpointer opaque)
+{
+    migration_channel_process_incoming(ioc);
+    object_unref(OBJECT(ioc));
+    return G_SOURCE_REMOVE;
+}
+
+void file_start_incoming_migration(const char *filename, Error **errp)
+{
+    QIOChannelFile *fioc = NULL;
+    QIOChannel *ioc;
+
+    trace_migration_file_incoming(filename);
+
+    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
+    if (!fioc) {
+        return;
+    }
+
+    ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
+    qio_channel_add_watch_full(ioc, G_IO_IN,
+                               file_accept_incoming_migration,
+                               NULL, NULL,
+                               g_main_context_get_thread_default());
+}
diff --git a/migration/migration.c b/migration/migration.c
index 6d3cf5d5cd..585d3c8f55 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -20,6 +20,7 @@
 #include "migration/blocker.h"
 #include "exec.h"
 #include "fd.h"
+#include "file.h"
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
@@ -449,6 +450,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
         exec_start_incoming_migration(p, errp);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
+    } else if (strstart(uri, "file:", &p)) {
+        file_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1702,6 +1705,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         exec_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
+    } else if (strstart(uri, "file:", &p)) {
+        file_start_outgoing_migration(s, p, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
diff --git a/migration/meson.build b/migration/meson.build
index 1ae28523a1..92b1cc4297 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -16,6 +16,7 @@ system_ss.add(files(
   'dirtyrate.c',
   'exec.c',
   'fd.c',
+  'file.c',
   'global_state.c',
   'migration-hmp-cmds.c',
   'migration.c',
diff --git a/migration/trace-events b/migration/trace-events
index 63483732ce..3e9649ab2a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -311,6 +311,10 @@ migration_exec_incoming(const char *cmd) "cmd=%s"
 migration_fd_outgoing(int fd) "fd=%d"
 migration_fd_incoming(int fd) "fd=%d"
 
+# file.c
+migration_file_outgoing(const char *filename) "filename=%s"
+migration_file_incoming(const char *filename) "filename=%s"
+
 # socket.c
 migration_socket_incoming_accepted(void) ""
 migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
diff --git a/qemu-options.hx b/qemu-options.hx
index 9ce8a5b957..93e638c097 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4706,6 +4706,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
     "                prepare for incoming migration, listen on\n" \
     "                specified protocol and socket address\n" \
     "-incoming fd:fd\n" \
+    "-incoming file:filename\n" \
     "-incoming exec:cmdline\n" \
     "                accept incoming migration on given file descriptor\n" \
     "                or from given external command\n" \
@@ -4722,7 +4723,10 @@ SRST
     Prepare for incoming migration, listen on a given unix socket.
 
 ``-incoming fd:fd``
-    Accept incoming migration from a given filedescriptor.
+    Accept incoming migration from a given file descriptor.
+
+``-incoming file:filename``
+    Accept incoming migration from a given file.
 
 ``-incoming exec:cmdline``
     Accept incoming migration as an output from specified external
-- 
2.41.0


