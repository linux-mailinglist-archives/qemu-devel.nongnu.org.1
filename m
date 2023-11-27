Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F264C7FAB8F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCU-0003ZT-Ib; Mon, 27 Nov 2023 15:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCR-0003RN-6B
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCG-0002q7-Gb
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39CA821B4C;
 Mon, 27 Nov 2023 20:27:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 264061379A;
 Mon, 27 Nov 2023 20:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SDJ2N5z7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 20/30] migration/multifd: Support outgoing fixed-ram
 stream format
Date: Mon, 27 Nov 2023 17:26:02 -0300
Message-Id: <20231127202612.23012-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [7.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 R_SPF_SOFTFAIL(4.60)[~all:c]; NEURAL_HAM_LONG(-0.99)[-0.989];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 7.80
X-Rspamd-Queue-Id: 39CA821B4C
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The new fixed-ram stream format uses a file transport and puts ram
pages in the migration file at their respective offsets and can be
done in parallel by using the pwritev system call which takes iovecs
and an offset.

Add support to enabling the new format along with multifd to make use
of the threading and page handling already in place.

This requires multifd to stop sending headers and leaving the stream
format to the fixed-ram code. When it comes time to write the data, we
need to call a version of qio_channel_write that can take an offset.

Usage on HMP is:

(qemu) stop
(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability fixed-ram on
(qemu) migrate_set_parameter max-bandwidth 0
(qemu) migrate_set_parameter multifd-channels 8
(qemu) migrate file:migfile

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- altered to call a separate qio_channel function for fixed-ram
---
 include/qemu/bitops.h | 13 +++++++
 migration/migration.c | 19 ++++++----
 migration/multifd.c   | 81 ++++++++++++++++++++++++++++++++++++-------
 migration/options.c   |  6 ----
 migration/ram.c       | 17 +++++++--
 migration/ram.h       |  1 +
 6 files changed, 110 insertions(+), 27 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index cb3526d1f4..2c0a2fe751 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -67,6 +67,19 @@ static inline void clear_bit(long nr, unsigned long *addr)
     *p &= ~mask;
 }
 
+/**
+ * clear_bit_atomic - Clears a bit in memory atomically
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit_atomic(long nr, unsigned long *addr)
+{
+    unsigned long mask = BIT_MASK(nr);
+    unsigned long *p = addr + BIT_WORD(nr);
+
+    return qatomic_and(p, ~mask);
+}
+
 /**
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
diff --git a/migration/migration.c b/migration/migration.c
index 16689171ab..cc707b0223 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -128,11 +128,19 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool transport_supports_multi_channels(SocketAddress *saddr)
+static bool transport_supports_multi_channels(MigrationAddress *addr)
 {
-    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+
+        return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+                saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+                saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        return migrate_fixed_ram();
+    } else {
+        return false;
+    }
 }
 
 static bool migration_needs_seekable_channel(void)
@@ -156,8 +164,7 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
     }
 
     if (migration_needs_multiple_sockets() &&
-        (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
-        !transport_supports_multi_channels(&addr->u.socket)) {
+        !transport_supports_multi_channels(addr)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
diff --git a/migration/multifd.c b/migration/multifd.c
index 7dfab2367a..8eae7de4de 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -278,6 +278,17 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     g_free(pages);
 }
 
+static void multifd_set_file_bitmap(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    assert(pages->block);
+
+    for (int i = 0; i < p->normal_num; i++) {
+        ramblock_set_shadow_bmap_atomic(pages->block, pages->offset[i]);
+    }
+}
+
 static void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
@@ -624,6 +635,34 @@ int multifd_send_sync_main(QEMUFile *f)
         }
     }
 
+    if (!migrate_multifd_packets()) {
+        /*
+         * There's no sync packet to send. Just make sure the sending
+         * above has finished.
+         */
+        for (i = 0; i < migrate_multifd_channels(); i++) {
+            qemu_sem_wait(&multifd_send_state->channels_ready);
+        }
+
+        /* sanity check and release the channels */
+        for (i = 0; i < migrate_multifd_channels(); i++) {
+            MultiFDSendParams *p = &multifd_send_state->params[i];
+
+            qemu_mutex_lock(&p->mutex);
+            if (p->quit) {
+                error_report("%s: channel %d has already quit!", __func__, i);
+                qemu_mutex_unlock(&p->mutex);
+                return -1;
+            }
+            assert(!p->pending_job);
+            qemu_mutex_unlock(&p->mutex);
+
+            qemu_sem_post(&p->sem);
+        }
+
+        return 0;
+    }
+
     /*
      * When using zero-copy, it's necessary to flush the pages before any of
      * the pages can be sent again, so we'll make sure the new version of the
@@ -707,6 +746,8 @@ static void *multifd_send_thread(void *opaque)
 
         if (p->pending_job) {
             uint32_t flags;
+            uintptr_t write_base;
+
             p->normal_num = 0;
 
             if (!use_packets || use_zero_copy_send) {
@@ -731,6 +772,15 @@ static void *multifd_send_thread(void *opaque)
             if (use_packets) {
                 multifd_send_fill_packet(p);
                 p->num_packets++;
+            } else {
+                multifd_set_file_bitmap(p);
+
+                /*
+                 * If we subtract the host page now, we don't need to
+                 * pass it into qio_channel_pwritev_all() below.
+                 */
+                write_base = p->pages->block->pages_offset -
+                    (uintptr_t)p->pages->block->host;
             }
 
             flags = p->flags;
@@ -743,21 +793,28 @@ static void *multifd_send_thread(void *opaque)
             trace_multifd_send(p->id, p->packet_num, p->normal_num, flags,
                                p->next_packet_size);
 
-            if (use_zero_copy_send) {
-                /* Send header first, without zerocopy */
-                ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                            p->packet_len, &local_err);
-                if (ret != 0) {
-                    break;
+            if (use_packets) {
+                if (use_zero_copy_send) {
+                    /* Send header first, without zerocopy */
+                    ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                                p->packet_len, &local_err);
+                    if (ret != 0) {
+                        break;
+                    }
+                } else {
+                    /* Send header using the same writev call */
+                    p->iov[0].iov_len = p->packet_len;
+                    p->iov[0].iov_base = p->packet;
                 }
-            } else if (use_packets) {
-                /* Send header using the same writev call */
-                p->iov[0].iov_len = p->packet_len;
-                p->iov[0].iov_base = p->packet;
+
+                ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
+                                                  NULL, 0, p->write_flags,
+                                                  &local_err);
+            } else {
+                ret = qio_channel_pwritev_all(p->c, p->iov, p->iovs_num,
+                                              write_base, &local_err);
             }
 
-            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
-                                              0, p->write_flags, &local_err);
             if (ret != 0) {
                 break;
             }
diff --git a/migration/options.c b/migration/options.c
index f671e24758..7f23881f51 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -666,12 +666,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_FIXED_RAM]) {
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp,
-                       "Fixed-ram migration is incompatible with multifd");
-            return false;
-        }
-
         if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
             error_setg(errp,
                        "Fixed-ram migration is incompatible with xbzrle");
diff --git a/migration/ram.c b/migration/ram.c
index ad6abd1761..385fe431bf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1149,7 +1149,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
 
     if (migrate_fixed_ram()) {
         /* zero pages are not transferred with fixed-ram */
-        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
+        clear_bit_atomic(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
         return 1;
     }
 
@@ -2443,8 +2443,6 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap = NULL;
         g_free(block->bmap);
         block->bmap = NULL;
-        g_free(block->shadow_bmap);
-        block->shadow_bmap = NULL;
     }
 
     xbzrle_cleanup();
@@ -3131,9 +3129,22 @@ static void ram_save_shadow_bmap(QEMUFile *f)
         qemu_put_buffer_at(f, (uint8_t *)block->shadow_bmap, bitmap_size,
                            block->bitmap_offset);
         ram_transferred_add(bitmap_size);
+
+        /*
+         * Free the bitmap here to catch any synchronization issues
+         * with multifd channels. No channels should be sending pages
+         * after we've written the bitmap to file.
+         */
+        g_free(block->shadow_bmap);
+        block->shadow_bmap = NULL;
     }
 }
 
+void ramblock_set_shadow_bmap_atomic(RAMBlock *block, ram_addr_t offset)
+{
+    set_bit_atomic(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
+}
+
 /**
  * ram_save_iterate: iterative stage for migration
  *
diff --git a/migration/ram.h b/migration/ram.h
index 9b937a446b..a65120de0d 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -75,6 +75,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
+void ramblock_set_shadow_bmap_atomic(RAMBlock *block, ram_addr_t offset);
 
 /* ram cache */
 int colo_init_ram_cache(void);
-- 
2.35.3


