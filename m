Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2D7D4106
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1fw-0003eT-M7; Mon, 23 Oct 2023 16:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1ff-0003Ui-Uz
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fd-0001sm-8l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F336A218B8;
 Mon, 23 Oct 2023 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXco7ODBLFbdpBvI36wDc465nJCANDAxYLcH8E4hR+E=;
 b=M92azYZIrGKmV++COkNvBeogGyz9wUxfrzseteh2HtQBJSkfMA6fKt1Nx1tR8jeXqqplpz
 AEZCO+LHNZKXJpFoIPaC5JTnZkrJpq/bgcVv//+02Wbm1NWJ3NFUGTCzVzegDQ9cZzWUCE
 I2v2vYPLJV57A+rq5CtOnI49AYIYajQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXco7ODBLFbdpBvI36wDc465nJCANDAxYLcH8E4hR+E=;
 b=3ZV7pGJpwFf8MXHnQnbGhUDK8HmL2TM4370ljTRcoa96yW/B72yvD+HzLfvjT7rHB/uCci
 sfzzBfotyriErrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 141E4132FD;
 Mon, 23 Oct 2023 20:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aH41NG3ZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 19/29] migration/multifd: Add outgoing QIOChannelFile
 support
Date: Mon, 23 Oct 2023 17:35:58 -0300
Message-Id: <20231023203608.26370-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow multifd to open file-backed channels. This will be used when
enabling the fixed-ram migration stream format which expects a
seekable transport.

The QIOChannel read and write methods will use the preadv/pwritev
versions which don't update the file offset at each call so we can
reuse the fd without re-opening for every channel.

Note that this is just setup code and multifd cannot yet make use of
the file channels.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 64 +++++++++++++++++++++++++++++++++++++++++--
 migration/file.h      | 10 +++++--
 migration/migration.c |  2 +-
 migration/multifd.c   | 14 ++++++++--
 migration/options.c   |  7 +++++
 migration/options.h   |  1 +
 6 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index cf5b1bf365..93b9b7bf5d 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -17,6 +17,12 @@
 
 #define OFFSET_OPTION ",offset="
 
+static struct FileOutgoingArgs {
+    char *fname;
+    int flags;
+    int mode;
+} outgoing_args;
+
 /* Remove the offset option from @filespec and return it in @offsetp. */
 
 static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
@@ -36,13 +42,62 @@ static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
+{
+    /* noop */
+}
+
+static void file_migration_cancel(Error *errp)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_FAILED);
+    migration_cancel(errp);
+}
+
+int file_send_channel_destroy(QIOChannel *ioc)
+{
+    if (ioc) {
+        qio_channel_close(ioc, NULL);
+        object_unref(OBJECT(ioc));
+    }
+    g_free(outgoing_args.fname);
+    outgoing_args.fname = NULL;
+
+    return 0;
+}
+
+void file_send_channel_create(QIOTaskFunc f, void *data)
+{
+    QIOChannelFile *ioc;
+    QIOTask *task;
+    Error *errp = NULL;
+
+    ioc = qio_channel_file_new_path(outgoing_args.fname,
+                                    outgoing_args.flags,
+                                    outgoing_args.mode, &errp);
+    if (!ioc) {
+        file_migration_cancel(errp);
+        return;
+    }
+
+    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
+    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
+                           (gpointer)data, NULL, NULL);
+}
+
 void file_start_outgoing_migration(MigrationState *s, const char *filespec,
                                    Error **errp)
 {
-    g_autofree char *filename = g_strdup(filespec);
     g_autoptr(QIOChannelFile) fioc = NULL;
+    g_autofree char *filename = g_strdup(filespec);
     uint64_t offset = 0;
     QIOChannel *ioc;
+    int flags = O_CREAT | O_TRUNC | O_WRONLY;
+    mode_t mode = 0660;
 
     trace_migration_file_outgoing(filename);
 
@@ -50,12 +105,15 @@ void file_start_outgoing_migration(MigrationState *s, const char *filespec,
         return;
     }
 
-    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
-                                     0600, errp);
+    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
     if (!fioc) {
         return;
     }
 
+    outgoing_args.fname = g_strdup(filename);
+    outgoing_args.flags = flags;
+    outgoing_args.mode = mode;
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
diff --git a/migration/file.h b/migration/file.h
index 90fa4849e0..10148233c5 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -7,8 +7,14 @@
 
 #ifndef QEMU_MIGRATION_FILE_H
 #define QEMU_MIGRATION_FILE_H
-void file_start_incoming_migration(const char *filename, Error **errp);
 
-void file_start_outgoing_migration(MigrationState *s, const char *filename,
+#include "io/task.h"
+#include "channel.h"
+
+void file_start_incoming_migration(const char *filespec, Error **errp);
+
+void file_start_outgoing_migration(MigrationState *s, const char *filespec,
                                    Error **errp);
+void file_send_channel_create(QIOTaskFunc f, void *data);
+int file_send_channel_destroy(QIOChannel *ioc);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index cabb3ad3a5..ba806cea55 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -114,7 +114,7 @@ static bool migration_needs_seekable_channel(void)
 static bool uri_supports_multi_channels(const char *uri)
 {
     return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
-           strstart(uri, "vsock:", NULL);
+           strstart(uri, "vsock:", NULL) || strstart(uri, "file:", NULL);
 }
 
 static bool uri_supports_seeking(const char *uri)
diff --git a/migration/multifd.c b/migration/multifd.c
index b912060b32..75a17ea8ab 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -17,6 +17,7 @@
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "file.h"
 #include "ram.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -28,6 +29,7 @@
 #include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
+#include "io/channel-file.h"
 #include "io/channel-socket.h"
 #include "yank_functions.h"
 
@@ -512,7 +514,11 @@ static void multifd_send_terminate_threads(Error *err)
 
 static int multifd_send_channel_destroy(QIOChannel *send)
 {
-    return socket_send_channel_destroy(send);
+    if (migrate_to_file()) {
+        return file_send_channel_destroy(send);
+    } else {
+        return socket_send_channel_destroy(send);
+    }
 }
 
 void multifd_save_cleanup(void)
@@ -907,7 +913,11 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 
 static void multifd_new_send_channel_create(gpointer opaque)
 {
-    socket_send_channel_create(multifd_new_send_channel_async, opaque);
+    if (migrate_to_file()) {
+        file_send_channel_create(multifd_new_send_channel_async, opaque);
+    } else {
+        socket_send_channel_create(multifd_new_send_channel_async, opaque);
+    }
 }
 
 int multifd_save_setup(Error **errp)
diff --git a/migration/options.c b/migration/options.c
index bb7a2bbe06..469d5d4c50 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -414,6 +414,13 @@ bool migrate_tls(void)
     return s->parameters.tls_creds && *s->parameters.tls_creds;
 }
 
+bool migrate_to_file(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return qemu_file_is_seekable(s->to_dst_file);
+}
+
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
diff --git a/migration/options.h b/migration/options.h
index 4a3e7e36a8..01bba5b928 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -61,6 +61,7 @@ bool migrate_multifd_packets(void);
 bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
+bool migrate_to_file(void);
 
 /* capabilities helpers */
 
-- 
2.35.3


