Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DF7D410C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:39:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1g1-0003po-NX; Mon, 23 Oct 2023 16:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fk-0003Yn-SV
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1ff-0001t1-OH
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57F411FE33;
 Mon, 23 Oct 2023 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxXCrbtkZnuGnuLEOFYoGSN8ud46u43gByhDryWps9k=;
 b=dHjUTrmrJDeH+d8Zf1KDQSMq7rySrZYGsUMD//vVhFny7mXNCS34PLDTRRwOUX2zd+aqM0
 M/scemS/j3orEXQ6PgTzIqjX4vXKmoz89tU9YAqxod1SanSkTwal/KZmSRAgvsprIhKJqY
 ZC6uLNDzkD7f8ctQDC+JeTHIVDPlN1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxXCrbtkZnuGnuLEOFYoGSN8ud46u43gByhDryWps9k=;
 b=OHL4cQy3V4zpKgcwf50PluyOxsQeXfoZpKnccXK3R+CH1xLdU3ZSAgCmjTa7ASn9vml9/G
 6EfFcNRqHIGBa5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B785132FD;
 Mon, 23 Oct 2023 20:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SCjNDXDZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 20/29] migration/multifd: Add incoming QIOChannelFile
 support
Date: Mon, 23 Oct 2023 17:35:59 -0300
Message-Id: <20231023203608.26370-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

On the receiving side we don't need to differentiate between main
channel and threads, so whichever channel is defined first gets to be
the main one. And since there are no packets, use the atomic channel
count to index into the params array.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 39 +++++++++++++++++++++++++++++----------
 migration/migration.c |  2 ++
 migration/multifd.c   |  7 ++++++-
 migration/multifd.h   |  1 +
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 93b9b7bf5d..ad75225f43 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -6,13 +6,15 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "options.h"
 #include "trace.h"
 
 #define OFFSET_OPTION ",offset="
@@ -136,7 +138,8 @@ void file_start_incoming_migration(const char *filespec, Error **errp)
     g_autofree char *filename = g_strdup(filespec);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = 0;
-    QIOChannel *ioc;
+    int channels = 1;
+    int i = 0, fd;
 
     trace_migration_file_incoming(filename);
 
@@ -146,16 +149,32 @@ void file_start_incoming_migration(const char *filespec, Error **errp)
 
     fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
     if (!fioc) {
-        return;
+        goto out;
+    }
+
+    if (migrate_multifd()) {
+        channels += migrate_multifd_channels();
     }
 
-    ioc = QIO_CHANNEL(fioc);
-    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+    fd = fioc->fd;
+
+    do {
+        QIOChannel *ioc = QIO_CHANNEL(fioc);
+
+        if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+            return;
+        }
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
+        error_report("Error creating migration incoming channel");
         return;
     }
-    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
-    qio_channel_add_watch_full(ioc, G_IO_IN,
-                               file_accept_incoming_migration,
-                               NULL, NULL,
-                               g_main_context_get_thread_default());
 }
diff --git a/migration/migration.c b/migration/migration.c
index ba806cea55..5fa726f6d4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -756,6 +756,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         }
 
         default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
+    } else if (migrate_multifd() && migrate_fixed_ram()) {
+        default_channel = multifd_recv_first_channel();
     } else {
         default_channel = !mis->from_src_file;
     }
diff --git a/migration/multifd.c b/migration/multifd.c
index 75a17ea8ab..ad51210f13 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1242,6 +1242,11 @@ int multifd_load_setup(Error **errp)
     return 0;
 }
 
+bool multifd_recv_first_channel(void)
+{
+    return !multifd_recv_state;
+}
+
 bool multifd_recv_all_channels_created(void)
 {
     int thread_count = migrate_multifd_channels();
@@ -1284,7 +1289,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
         /* initial packet */
         num_packets = 1;
     } else {
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


