Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF486B30F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 16:24:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLlQ-0006kK-Eg; Wed, 28 Feb 2024 10:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLlJ-0006jl-TS
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:25 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLlE-0005UG-5H
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B88A9225B3;
 Wed, 28 Feb 2024 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAXmLUDkt1kZKfef3eOiSWbbq7NudWfPCCZUSdEiA4U=;
 b=VFkpv/KDtushB9uCgw/N9eAC2Bi17v6+oprSzQxbJZZWtfkqjRW/XSJjymu0rK0i3v7fHp
 RNK82fojGuV5IBRmXw2zCpB0OFWcUs/RVyXk5Jh5g4KinVqSDvcHiCOiGVGFc9OJxrwE2V
 WythLc2ZNgsdsBXz2t/cxJmaU2ersl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAXmLUDkt1kZKfef3eOiSWbbq7NudWfPCCZUSdEiA4U=;
 b=pDPYx7041T3/Ekh2+auvXUsJASoXv9CtXbnPXmtr5fp40JD08MNMkqFyw7uEvpQjDwHriN
 ymSsPAOa1Z1nTXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAXmLUDkt1kZKfef3eOiSWbbq7NudWfPCCZUSdEiA4U=;
 b=VFkpv/KDtushB9uCgw/N9eAC2Bi17v6+oprSzQxbJZZWtfkqjRW/XSJjymu0rK0i3v7fHp
 RNK82fojGuV5IBRmXw2zCpB0OFWcUs/RVyXk5Jh5g4KinVqSDvcHiCOiGVGFc9OJxrwE2V
 WythLc2ZNgsdsBXz2t/cxJmaU2ersl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAXmLUDkt1kZKfef3eOiSWbbq7NudWfPCCZUSdEiA4U=;
 b=pDPYx7041T3/Ekh2+auvXUsJASoXv9CtXbnPXmtr5fp40JD08MNMkqFyw7uEvpQjDwHriN
 ymSsPAOa1Z1nTXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20AE613A5D;
 Wed, 28 Feb 2024 15:22:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GN8iNqhP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:22:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 21/23] migration/multifd: Support incoming mapped-ram
 stream format
Date: Wed, 28 Feb 2024 12:21:25 -0300
Message-Id: <20240228152127.18769-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="VFkpv/KD";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pDPYx704
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: B88A9225B3
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For the incoming mapped-ram migration we need to read the ramblock
headers, get the pages bitmap and send the host address of each
non-zero page to the multifd channel thread for writing.

Usage on HMP is:

(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate_incoming file:migfile

(the ram.h include needs to move because we've been previously relying
on it being included from migration.c. Now file.h will start including
multifd.h before migration.o is processed)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- dropped NOCOMP flag handling
- dropped comment and newline
- dropped duplicate LOAD_BUF_SIZE
---
 migration/file.c    | 18 +++++++++++++++++-
 migration/file.h    |  2 ++
 migration/multifd.c | 31 ++++++++++++++++++++++++++++---
 migration/multifd.h |  2 ++
 migration/ram.c     | 26 ++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 2188774a9d..44b73bf9e5 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -13,7 +13,6 @@
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
-#include "multifd.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
 #include "options.h"
@@ -204,3 +203,20 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
     return (ret < 0) ? ret : 0;
 }
+
+int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDRecvData *data = p->data;
+    size_t ret;
+
+    ret = qio_channel_pread(p->c, (char *) data->opaque,
+                            data->size, data->file_offset, errp);
+    if (ret != data->size) {
+        error_prepend(errp,
+                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
+                      p->id, ret, data->size);
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/migration/file.h b/migration/file.h
index 01a338cac7..9f71e87f74 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -11,6 +11,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "io/task.h"
 #include "channel.h"
+#include "multifd.h"
 
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
 
@@ -21,4 +22,5 @@ void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
+int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index e31d2934cc..7a3977fc34 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -18,7 +18,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "file.h"
-#include "ram.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "socket.h"
@@ -251,7 +250,7 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
     uint32_t flags;
 
     if (!multifd_use_packets()) {
-        return 0;
+        return multifd_file_recv_data(p, errp);
     }
 
     flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
@@ -1331,22 +1330,48 @@ void multifd_recv_cleanup(void)
 void multifd_recv_sync_main(void)
 {
     int thread_count = migrate_multifd_channels();
+    bool file_based = !multifd_use_packets();
     int i;
 
-    if (!migrate_multifd() || !multifd_use_packets()) {
+    if (!migrate_multifd()) {
         return;
     }
 
+    /*
+     * File-based channels don't use packets and therefore need to
+     * wait for more work. Release them to start the sync.
+     */
+    if (file_based) {
+        for (i = 0; i < thread_count; i++) {
+            MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+            trace_multifd_recv_sync_main_signal(p->id);
+            qemu_sem_post(&p->sem);
+        }
+    }
+
     /*
      * Initiate the synchronization by waiting for all channels.
+     *
      * For socket-based migration this means each channel has received
      * the SYNC packet on the stream.
+     *
+     * For file-based migration this means each channel is done with
+     * the work (pending_job=false).
      */
     for (i = 0; i < thread_count; i++) {
         trace_multifd_recv_sync_main_wait(i);
         qemu_sem_wait(&multifd_recv_state->sem_sync);
     }
 
+    if (file_based) {
+        /*
+         * For file-based loading is done in one iteration. We're
+         * done.
+         */
+        return;
+    }
+
     /*
      * Sync done. Release the channels for the next iteration.
      */
diff --git a/migration/multifd.h b/migration/multifd.h
index db8887f088..7447c2bea3 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
+#include "ram.h"
+
 typedef struct MultiFDRecvData MultiFDRecvData;
 
 bool multifd_send_setup(void);
diff --git a/migration/ram.c b/migration/ram.c
index 53643d2046..c8e2372f06 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3950,6 +3950,22 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static size_t ram_load_multifd_pages(void *host_addr, size_t size,
+                                     uint64_t offset)
+{
+    MultiFDRecvData *data = multifd_get_recv_data();
+
+    data->opaque = host_addr;
+    data->file_offset = offset;
+    data->size = size;
+
+    if (!multifd_recv()) {
+        return 0;
+    }
+
+    return size;
+}
+
 static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                      long num_pages, unsigned long *bitmap,
                                      Error **errp)
@@ -3979,8 +3995,14 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
 
             size = MIN(unread, MAPPED_RAM_LOAD_BUF_SIZE);
 
-            read = qemu_get_buffer_at(f, host, size,
-                                      block->pages_offset + offset);
+            if (migrate_multifd()) {
+                read = ram_load_multifd_pages(host, size,
+                                              block->pages_offset + offset);
+            } else {
+                read = qemu_get_buffer_at(f, host, size,
+                                          block->pages_offset + offset);
+            }
+
             if (!read) {
                 goto err;
             }
-- 
2.35.3


