Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370986B308
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 16:24:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLlJ-0006jJ-4N; Wed, 28 Feb 2024 10:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLlH-0006iu-6h
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:23 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLlB-0005Qn-RK
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D8801F79A;
 Wed, 28 Feb 2024 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19+qrsqe7/KXKqvZMOvcK4i7xuyjTkOSFZfsCf0tULk=;
 b=Tfv643gV8HkFLp+IoEQnUH1sUMkRtx71qmaJheXwo2iwBwC0DGQwvJ121d91j937Lt56yP
 3+9xprYIRFyN4r0IAOq48PrthFgK+9encTbhnkEKb4su3aL/zDMHT/a91sbUfLu7jC68XS
 W/wI3uaEBMwKZjKm8O4i5jtTX4MPE+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19+qrsqe7/KXKqvZMOvcK4i7xuyjTkOSFZfsCf0tULk=;
 b=3ALnIGwtDK//I7XYwThorb5Heq8nfKtHzbu8NMiqyhfec2WsPN7rX7euPE+U6S26QQ5nCw
 AcxK1fqIamEzhyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19+qrsqe7/KXKqvZMOvcK4i7xuyjTkOSFZfsCf0tULk=;
 b=Tfv643gV8HkFLp+IoEQnUH1sUMkRtx71qmaJheXwo2iwBwC0DGQwvJ121d91j937Lt56yP
 3+9xprYIRFyN4r0IAOq48PrthFgK+9encTbhnkEKb4su3aL/zDMHT/a91sbUfLu7jC68XS
 W/wI3uaEBMwKZjKm8O4i5jtTX4MPE+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19+qrsqe7/KXKqvZMOvcK4i7xuyjTkOSFZfsCf0tULk=;
 b=3ALnIGwtDK//I7XYwThorb5Heq8nfKtHzbu8NMiqyhfec2WsPN7rX7euPE+U6S26QQ5nCw
 AcxK1fqIamEzhyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D7213A5D;
 Wed, 28 Feb 2024 15:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qCzOL6ZP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:22:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 20/23] migration/multifd: Support outgoing mapped-ram
 stream format
Date: Wed, 28 Feb 2024 12:21:24 -0300
Message-Id: <20240228152127.18769-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tfv643gV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3ALnIGwt
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 9D8801F79A
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The new mapped-ram stream format uses a file transport and puts ram
pages in the migration file at their respective offsets and can be
done in parallel by using the pwritev system call which takes iovecs
and an offset.

Add support to enabling the new format along with multifd to make use
of the threading and page handling already in place.

This requires multifd to stop sending headers and leaving the stream
format to the mapped-ram code. When it comes time to write the data, we
need to call a version of qio_channel_write that can take an offset.

Usage on HMP is:

(qemu) stop
(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate_set_parameter max-bandwidth 0
(qemu) migrate_set_parameter multifd-channels 8
(qemu) migrate file:migfile

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- added used_length sanity check
- allowed returning negative value
---
 include/qemu/bitops.h | 13 +++++++++++
 migration/file.c      | 54 +++++++++++++++++++++++++++++++++++++++++++
 migration/file.h      |  2 ++
 migration/migration.c | 17 ++++++++++----
 migration/multifd.c   | 24 +++++++++++++++++--
 migration/options.c   | 13 ++++++-----
 migration/ram.c       | 17 +++++++++++---
 migration/ram.h       |  1 +
 8 files changed, 125 insertions(+), 16 deletions(-)

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
diff --git a/migration/file.c b/migration/file.c
index 5e1348fec0..2188774a9d 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -150,3 +150,57 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
         }
     } while (++i < channels);
 }
+
+int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
+                            int niov, RAMBlock *block, Error **errp)
+{
+    ssize_t ret = -1;
+    int i, slice_idx, slice_num;
+    uintptr_t base, next, offset;
+    size_t len;
+
+    slice_idx = 0;
+    slice_num = 1;
+
+    /*
+     * If the iov array doesn't have contiguous elements, we need to
+     * split it in slices because we only have one file offset for the
+     * whole iov. Do this here so callers don't need to break the iov
+     * array themselves.
+     */
+    for (i = 0; i < niov; i++, slice_num++) {
+        base = (uintptr_t) iov[i].iov_base;
+
+        if (i != niov - 1) {
+            len = iov[i].iov_len;
+            next = (uintptr_t) iov[i + 1].iov_base;
+
+            if (base + len == next) {
+                continue;
+            }
+        }
+
+        /*
+         * Use the offset of the first element of the segment that
+         * we're sending.
+         */
+        offset = (uintptr_t) iov[slice_idx].iov_base - (uintptr_t) block->host;
+        if (offset >= block->used_length) {
+            error_setg(errp, "offset " RAM_ADDR_FMT
+                       "outside of ramblock %s range", offset, block->idstr);
+            ret = -1;
+            break;
+        }
+
+        ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
+                                  block->pages_offset + offset, errp);
+        if (ret < 0) {
+            break;
+        }
+
+        slice_idx += slice_num;
+        slice_num = 0;
+    }
+
+    return (ret < 0) ? ret : 0;
+}
diff --git a/migration/file.h b/migration/file.h
index 4577f9efdd..01a338cac7 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -19,4 +19,6 @@ void file_start_outgoing_migration(MigrationState *s,
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
+int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
+                            int niov, RAMBlock *block, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index ff3872468f..957d2890b7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -139,12 +139,14 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
 
-        return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
+        return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+                saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+                saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        return migrate_mapped_ram();
+    } else {
+        return false;
     }
-
-    return false;
 }
 
 static bool migration_needs_seekable_channel(void)
@@ -1988,6 +1990,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
             error_setg(errp, "Cannot use TLS with mapped-ram");
             return false;
         }
+
+        if (migrate_multifd_compression()) {
+            error_setg(errp, "Cannot use compression with mapped-ram");
+            return false;
+        }
     }
 
     if (migrate_mode_is_cpr(s)) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 7c3994b3ba..e31d2934cc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -108,6 +108,17 @@ void multifd_send_channel_created(void)
     qemu_sem_post(&multifd_send_state->channels_created);
 }
 
+static void multifd_set_file_bitmap(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    assert(pages->block);
+
+    for (int i = 0; i < p->pages->num; i++) {
+        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i]);
+    }
+}
+
 /* Multifd without compression */
 
 /**
@@ -169,6 +180,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 
     if (!multifd_use_packets()) {
         multifd_send_prepare_iovs(p);
+        multifd_set_file_bitmap(p);
+
         return 0;
     }
 
@@ -867,8 +880,15 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
-                                              0, p->write_flags, &local_err);
+            if (migrate_mapped_ram()) {
+                ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
+                                              p->pages->block, &local_err);
+            } else {
+                ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
+                                                  NULL, 0, p->write_flags,
+                                                  &local_err);
+            }
+
             if (ret != 0) {
                 break;
             }
diff --git a/migration/options.c b/migration/options.c
index c6edbe4f3e..b6f39c57d8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -654,12 +654,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM]) {
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp,
-                       "Mapped-ram migration is incompatible with multifd");
-            return false;
-        }
-
         if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
             error_setg(errp,
                        "Mapped-ram migration is incompatible with xbzrle");
@@ -1252,6 +1246,13 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
     }
 #endif
 
+    if (migrate_mapped_ram() &&
+        (migrate_multifd_compression() || migrate_tls())) {
+        error_setg(errp,
+                   "Mapped-ram only available for non-compressed non-TLS multifd migration");
+        return false;
+    }
+
     if (params->has_x_vcpu_dirty_limit_period &&
         (params->x_vcpu_dirty_limit_period < 1 ||
          params->x_vcpu_dirty_limit_period > 1000)) {
diff --git a/migration/ram.c b/migration/ram.c
index 250dcd110c..53643d2046 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1148,7 +1148,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
 
     if (migrate_mapped_ram()) {
         /* zero pages are not transferred with mapped-ram */
-        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->file_bmap);
+        clear_bit_atomic(offset >> TARGET_PAGE_BITS, pss->block->file_bmap);
         return 1;
     }
 
@@ -2444,8 +2444,6 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap = NULL;
         g_free(block->bmap);
         block->bmap = NULL;
-        g_free(block->file_bmap);
-        block->file_bmap = NULL;
     }
 
     xbzrle_cleanup();
@@ -3134,9 +3132,22 @@ static void ram_save_file_bmap(QEMUFile *f)
         qemu_put_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
                            block->bitmap_offset);
         ram_transferred_add(bitmap_size);
+
+        /*
+         * Free the bitmap here to catch any synchronization issues
+         * with multifd channels. No channels should be sending pages
+         * after we've written the bitmap to file.
+         */
+        g_free(block->file_bmap);
+        block->file_bmap = NULL;
     }
 }
 
+void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset)
+{
+    set_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+}
+
 /**
  * ram_save_iterate: iterative stage for migration
  *
diff --git a/migration/ram.h b/migration/ram.h
index 9b937a446b..b9ac0da587 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -75,6 +75,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
+void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset);
 
 /* ram cache */
 int colo_init_ram_cache(void);
-- 
2.35.3


