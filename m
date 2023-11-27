Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E87FAB9C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:32:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCn-0004uh-Jo; Mon, 27 Nov 2023 15:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCk-0004dF-Us
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCi-0002vQ-Sw
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2FA81FB74;
 Mon, 27 Nov 2023 20:27:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A36A71379A;
 Mon, 27 Nov 2023 20:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIVpGrX7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 29/30] migration: Add support for fdset with multifd +
 file
Date: Mon, 27 Nov 2023 17:26:11 -0300
Message-Id: <20231127202612.23012-30-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [7.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_HAM_LONG(-0.99)[-0.987]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 7.80
X-Rspamd-Queue-Id: B2FA81FB74
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allow multifd to use an fdset when migrating to a file. This is useful
for the scenario where the management layer wants to have control over
the migration file.

By receiving the file descriptors directly, QEMU can delegate some
high level operating system operations to the management layer (such
as mandatory access control). The management layer might also want to
add its own headers before the migration stream.

Enable the "file:/dev/fdset/#" syntax for the multifd migration with
fixed-ram. The requirements for the fdset mechanism are:

On the migration source side:

- the fdset must contain two fds that are not duplicates between
  themselves;
- if direct-io is to be used, exactly one of the fds must have the
  O_DIRECT flag set;
- the file must be opened with WRONLY both times.

On the migration destination side:

- the fdset must contain one fd;
- the file must be opened with RDONLY.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration.rst |  18 +++++++
 migration/file.c         | 100 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 1488e5b2f9..096ef27ed7 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -46,6 +46,24 @@ over any transport.
   application to add its own metadata to the start of the file without
   QEMU interference.
 
+  The file migration also supports using a file that has already been
+  opened. A set of file descriptors is passed to QEMU via an "fdset"
+  (see add-fd QMP command documentation). This method allows a
+  management application to have control over the migration file
+  opening operation. There are, however, strict requirements to this
+  interface:
+
+  On the migration source side:
+    - the fdset must contain two file descriptors that are not
+      duplicates between themselves;
+    - if the direct-io capability is to be used, exactly one of the
+      file descriptors must have the O_DIRECT flag set;
+    - the file must be opened with WRONLY both times.
+
+  On the migration destination side:
+    - the fdset must contain one file descriptor;
+    - the file must be opened with RDONLY.
+
 In addition, support is included for migration using RDMA, which
 transports the page data using ``RDMA``, where the hardware takes care of
 transporting the pages, and the load on the CPU is much lower.  While the
diff --git a/migration/file.c b/migration/file.c
index fc5c1a45f4..4b06335a8c 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -9,11 +9,13 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "monitor/monitor.h"
 #include "options.h"
 #include "trace.h"
 
@@ -21,6 +23,7 @@
 
 static struct FileOutgoingArgs {
     char *fname;
+    int64_t fdset_id;
 } outgoing_args;
 
 /* Remove the offset option from @filespec and return it in @offsetp. */
@@ -42,6 +45,84 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+/*
+ * If the open flags and file status flags from the file descriptors
+ * in the fdset don't match what QEMU expects, errno gets set to
+ * EACCES. Let's provide a more user-friendly message.
+ */
+static void file_fdset_error(int flags, Error **errp)
+{
+    ERRP_GUARD();
+
+    if (errno == EACCES) {
+        /* ditch the previous error */
+        error_free(*errp);
+        *errp = NULL;
+
+        error_setg(errp, "Fdset is missing a file descriptor with flags: 0x%x",
+                   flags);
+    }
+}
+
+static void file_remove_fdset(void)
+{
+    if (outgoing_args.fdset_id != -1) {
+        qmp_remove_fd(outgoing_args.fdset_id, false, -1, NULL);
+        outgoing_args.fdset_id = -1;
+    }
+}
+
+/*
+ * Due to the behavior of the dup() system call, we need the fdset to
+ * have two non-duplicate fds so we can enable direct IO in the
+ * secondary channels without affecting the main channel.
+ */
+static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
+                             Error **errp)
+{
+    FdsetInfoList *fds_info;
+    FdsetFdInfoList *fd_info;
+    const char *fdset_id_str;
+    int nfds = 0;
+
+    *fdset_id = -1;
+
+    if (!strstart(filename, "/dev/fdset/", &fdset_id_str)) {
+        return true;
+    }
+
+    if (!migrate_multifd()) {
+        error_setg(errp, "fdset is only supported with multifd");
+        return false;
+    }
+
+    *fdset_id = qemu_parse_fd(fdset_id_str);
+
+    for (fds_info = qmp_query_fdsets(NULL); fds_info;
+         fds_info = fds_info->next) {
+
+        if (*fdset_id != fds_info->value->fdset_id) {
+            continue;
+        }
+
+        for (fd_info = fds_info->value->fds; fd_info; fd_info = fd_info->next) {
+            if (nfds++ > 2) {
+                break;
+            }
+        }
+    }
+
+    if (nfds != 2) {
+        error_setg(errp, "Outgoing migration needs two fds in the fdset, "
+                   "got %d", nfds);
+        qmp_remove_fd(*fdset_id, false, -1, NULL);
+        *fdset_id = -1;
+        return false;
+    }
+
+    return true;
+}
+
 static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
 {
     /* noop */
@@ -56,6 +137,7 @@ int file_send_channel_destroy(QIOChannel *ioc)
     g_free(outgoing_args.fname);
     outgoing_args.fname = NULL;
 
+    file_remove_fdset();
     return 0;
 }
 
@@ -88,6 +170,7 @@ void file_send_channel_create(QIOTaskFunc f, void *data)
 
     task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
     if (!ioc) {
+        file_fdset_error(flags, &err);
         qio_task_set_error(task, err);
         return;
     }
@@ -108,13 +191,18 @@ void file_start_outgoing_migration(MigrationState *s,
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
-    if (!fioc) {
+    if (!file_parse_fdset(filename, &outgoing_args.fdset_id, errp)) {
         return;
     }
 
     outgoing_args.fname = g_strdup(filename);
 
+    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
+    if (!fioc) {
+        file_fdset_error(flags, errp);
+        return;
+    }
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
@@ -138,13 +226,14 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
     int channels = 1;
-    int i = 0, fd;
+    int i = 0, fd, flags = O_RDONLY;
 
     trace_migration_file_incoming(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
+    fioc = qio_channel_file_new_path(filename, flags, 0, errp);
     if (!fioc) {
-        goto out;
+        file_fdset_error(flags, errp);
+        return;
     }
 
     if (offset &&
@@ -168,7 +257,6 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
                                    g_main_context_get_thread_default());
     } while (++i < channels && (fioc = qio_channel_file_new_fd(fd)));
 
-out:
     if (!fioc) {
         error_setg(errp, "Error creating migration incoming channel");
         return;
-- 
2.35.3


