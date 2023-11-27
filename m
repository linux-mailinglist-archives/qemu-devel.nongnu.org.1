Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F97FAB72
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iC3-0002dm-4L; Mon, 27 Nov 2023 15:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC0-0002cP-FX
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:56 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBy-0002mu-Gp
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 516E121B32;
 Mon, 27 Nov 2023 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySHJGr28eNmdndGPA24e3H+ebuE7zi2Ok5x+3aj7lC8=;
 b=IudeiSeNKoKId1dotlW0Jfxj3ipFeSBMuEFVaWslPzNYnqkfN92YP3qpdOMpztpHvUmSuk
 FuMNVGYnxsEs89E4FcQFl67fSsowqqphWce3UnS0WxSTUMpybHqOUXCa7lUabSPuiRXydt
 yDFkSeLeFoVaWcyWjqXZCC747o0fVwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySHJGr28eNmdndGPA24e3H+ebuE7zi2Ok5x+3aj7lC8=;
 b=dukanSq4HybK3/tQeSiRFeEbYD9yLRPtx8PzPTeRm3QNdb67qTo5uuUA4u8QLeAq0BNcJ+
 5/LqhY7zplJET2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EDCE1379A;
 Mon, 27 Nov 2023 20:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YGPMAYv7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 13/30] migration/multifd: Add outgoing QIOChannelFile
 support
Date: Mon, 27 Nov 2023 17:25:55 -0300
Message-Id: <20231127202612.23012-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
- open multifd channels with O_WRONLY and no mode
- stop cancelling migration and propagate error via qio_task
---
 migration/file.c      | 47 +++++++++++++++++++++++++++++++++++++++++--
 migration/file.h      |  5 +++++
 migration/multifd.c   | 14 +++++++++++--
 migration/options.c   |  7 +++++++
 migration/options.h   |  1 +
 migration/qemu-file.h |  1 -
 6 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 5d4975f43e..67d6f42da7 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -17,6 +17,10 @@
 
 #define OFFSET_OPTION ",offset="
 
+static struct FileOutgoingArgs {
+    char *fname;
+} outgoing_args;
+
 /* Remove the offset option from @filespec and return it in @offsetp. */
 
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
@@ -36,6 +40,42 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
+{
+    /* noop */
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
+    Error *err = NULL;
+    int flags = O_WRONLY;
+
+    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
+
+    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
+    if (!ioc) {
+        qio_task_set_error(task, err);
+        return;
+    }
+
+    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
+                           (gpointer)data, NULL, NULL);
+}
+
 void file_start_outgoing_migration(MigrationState *s,
                                    FileMigrationArgs *file_args, Error **errp)
 {
@@ -43,15 +83,18 @@ void file_start_outgoing_migration(MigrationState *s,
     g_autofree char *filename = g_strdup(file_args->filename);
     uint64_t offset = file_args->offset;
     QIOChannel *ioc;
+    int flags = O_CREAT | O_TRUNC | O_WRONLY;
+    mode_t mode = 0660;
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
-                                     0600, errp);
+    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
     if (!fioc) {
         return;
     }
 
+    outgoing_args.fname = g_strdup(filename);
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
diff --git a/migration/file.h b/migration/file.h
index 37d6a08bfc..511019b319 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -9,10 +9,15 @@
 #define QEMU_MIGRATION_FILE_H
 
 #include "qapi/qapi-types-migration.h"
+#include "io/task.h"
+#include "channel.h"
 
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
 
 void file_start_outgoing_migration(MigrationState *s,
                                    FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
+
+void file_send_channel_create(QIOTaskFunc f, void *data);
+int file_send_channel_destroy(QIOChannel *ioc);
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index 123ff0dec0..427740aab6 100644
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
 
@@ -511,7 +513,11 @@ static void multifd_send_terminate_threads(Error *err)
 
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
@@ -904,7 +910,11 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 
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
index 10730b13ba..f671e24758 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -409,6 +409,13 @@ bool migrate_tls(void)
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
index 8a19d6939c..84628a76e8 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -60,6 +60,7 @@ bool migrate_multifd_packets(void);
 bool migrate_postcopy(void);
 bool migrate_rdma(void);
 bool migrate_tls(void);
+bool migrate_to_file(void);
 
 /* capabilities helpers */
 
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 32fd4a34fd..78ea21ab98 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -83,5 +83,4 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
-
 #endif
-- 
2.35.3


