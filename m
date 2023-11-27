Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE86F7FAB98
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iC6-0002hm-2O; Mon, 27 Nov 2023 15:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC2-0002dv-V9
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:58 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC1-0002ng-1Z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:58 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9EBB1FB54;
 Mon, 27 Nov 2023 20:26:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C885B1379A;
 Mon, 27 Nov 2023 20:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YHZlI437ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 14/30] migration/multifd: Add incoming QIOChannelFile
 support
Date: Mon, 27 Nov 2023 17:25:56 -0300
Message-Id: <20231127202612.23012-15-farosas@suse.de>
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
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 R_SPF_SOFTFAIL(4.60)[~all:c]; NEURAL_HAM_LONG(-0.99)[-0.987];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 7.80
X-Rspamd-Queue-Id: D9EBB1FB54
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

On the receiving side we don't need to differentiate between main
channel and threads, so whichever channel is defined first gets to be
the main one. And since there are no packets, use the atomic channel
count to index into the params array.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- stop setting offset in secondary channels
- check for packets when peeking
---
 migration/file.c      | 36 ++++++++++++++++++++++++++++--------
 migration/migration.c |  3 ++-
 migration/multifd.c   |  3 +--
 migration/multifd.h   |  1 +
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 67d6f42da7..62ba994109 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -7,12 +7,14 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "options.h"
 #include "trace.h"
 
 #define OFFSET_OPTION ",offset="
@@ -117,22 +119,40 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
-    QIOChannel *ioc;
+    int channels = 1;
+    int i = 0, fd;
 
     trace_migration_file_incoming(filename);
 
     fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
     if (!fioc) {
+        goto out;
+    }
+
+    if (offset &&
+        qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
         return;
     }
 
-    ioc = QIO_CHANNEL(fioc);
-    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+    if (migrate_multifd()) {
+        channels += migrate_multifd_channels();
+    }
+
+    fd = fioc->fd;
+
+    do {
+        QIOChannel *ioc = QIO_CHANNEL(fioc);
+
+        qio_channel_set_name(ioc, "migration-file-incoming");
+        qio_channel_add_watch_full(ioc, G_IO_IN,
+                                   file_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
+    } while (++i < channels && (fioc = qio_channel_file_new_fd(fd)));
+
+out:
+    if (!fioc) {
+        error_setg(errp, "Error creating migration incoming channel");
         return;
     }
-    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
-    qio_channel_add_watch_full(ioc, G_IO_IN,
-                               file_accept_incoming_migration,
-                               NULL, NULL,
-                               g_main_context_get_thread_default());
 }
diff --git a/migration/migration.c b/migration/migration.c
index 897ed1db67..16689171ab 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -838,7 +838,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_postcopy_ram() &&
+    if (migrate_multifd() && migrate_multifd_packets() &&
+        !migrate_postcopy_ram() &&
         qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
         /*
          * With multiple channels, it is possible that we receive channels
diff --git a/migration/multifd.c b/migration/multifd.c
index 427740aab6..3476fac49f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1283,8 +1283,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
         /* initial packet */
         num_packets = 1;
     } else {
-        /* next patch gives this a meaningful value */
-        id = 0;
+        id = qatomic_read(&multifd_recv_state->count);
     }
 
     p = &multifd_recv_state->params[id];
diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..a112ec7ac6 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -18,6 +18,7 @@ void multifd_save_cleanup(void);
 int multifd_load_setup(Error **errp);
 void multifd_load_cleanup(void);
 void multifd_load_shutdown(void);
+bool multifd_recv_first_channel(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-- 
2.35.3


