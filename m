Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC127FAB82
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:29:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iC0-0002Xv-BD; Mon, 27 Nov 2023 15:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBm-0002Tp-JS
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:43 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBk-0002kz-GV
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61F1821B2A;
 Mon, 27 Nov 2023 20:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUjd+KKO1a0SIehqfLmmOxI1GH8hjBJlH4OWswskEH8=;
 b=Na42/nziHYOau5dLtU4U1YahrBBmjKbU6XbybaVU7soxco5amQkmOTgUPqpayNeNyEj8mW
 ixMfytWJFo6YXUrnBud8Yz5D9oVnuD9o27wvQSVuGKopBfl6QuTs295Adz6e3eBZQeVZc0
 TpHM/jWPesVceO1nFvAu8ksbFPRcDa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUjd+KKO1a0SIehqfLmmOxI1GH8hjBJlH4OWswskEH8=;
 b=fQBPVpkru1rRKuDGTuxmINvJeoAlWYLiWecXr9+9iuavxBPN1uK+HSc3LBn7cVHMvKf6sF
 9/18XuszpgQNr5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6388D1379A;
 Mon, 27 Nov 2023 20:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDW3Cnz7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v3 08/30] migration/ram: Add outgoing 'fixed-ram' migration
Date: Mon, 27 Nov 2023 17:25:50 -0300
Message-Id: <20231127202612.23012-9-farosas@suse.de>
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
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
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

From: Nikolay Borisov <nborisov@suse.com>

Implement the outgoing migration side for the 'fixed-ram' capability.

A bitmap is introduced to track which pages have been written in the
migration file. Pages are written at a fixed location for every
ramblock. Zero pages are ignored as they'd be zero in the destination
migration as well.

The migration stream is altered to put the dirty pages for a ramblock
after its header instead of having a sequential stream of pages that
follow the ramblock headers. Since all pages have a fixed location,
RAM_SAVE_FLAG_EOS is no longer generated on every migration iteration.

Without fixed-ram (current):        With fixed-ram (new):

 ---------------------               --------------------------------
 | ramblock 1 header |               | ramblock 1 header            |
 ---------------------               --------------------------------
 | ramblock 2 header |               | ramblock 1 fixed-ram header  |
 ---------------------               --------------------------------
 | ...               |               | padding to next 1MB boundary |
 ---------------------               | ...                          |
 | ramblock n header |               --------------------------------
 ---------------------               | ramblock 1 pages             |
 | RAM_SAVE_FLAG_EOS |               | ...                          |
 ---------------------               --------------------------------
 | stream of pages   |               | ramblock 2 header            |
 | (iter 1)          |               --------------------------------
 | ...               |               | ramblock 2 fixed-ram header  |
 ---------------------               --------------------------------
 | RAM_SAVE_FLAG_EOS |               | padding to next 1MB boundary |
 ---------------------               | ...                          |
 | stream of pages   |               --------------------------------
 | (iter 2)          |               | ramblock 2 pages             |
 | ...               |               | ...                          |
 ---------------------               --------------------------------
 | ...               |               | ...                          |
 ---------------------               --------------------------------
                                     | RAM_SAVE_FLAG_EOS            |
                                     --------------------------------
                                     | ...                          |
                                     --------------------------------

where:
 - ramblock header: the generic information for a ramblock, such as
   idstr, used_len, etc.

 - ramblock fixed-ram header: the new information added by this
   feature: bitmap of pages written, bitmap size and offset of pages
   in the migration file.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- used a macro for alignment value
- documented alignment assumptions
- moved shadow_bmap debug code to multifd patch
- did NOT use used_length for bmap, it breaks dirty page tracking somehow
- uncommented the capability enabling
- accounted for the bitmap size with ram_transferred_add()
---
 include/exec/ramblock.h |   8 +++
 migration/ram.c         | 121 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 120 insertions(+), 9 deletions(-)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 69c6a53902..e0e3f16852 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -44,6 +44,14 @@ struct RAMBlock {
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
+    /* shadow dirty bitmap used when migrating to a file */
+    unsigned long *shadow_bmap;
+    /*
+     * offset in the file pages belonging to this ramblock are saved,
+     * used only during migration to a file.
+     */
+    off_t bitmap_offset;
+    uint64_t pages_offset;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
 
diff --git a/migration/ram.c b/migration/ram.c
index 8c7886ab79..4a0ab8105f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -94,6 +94,18 @@
 #define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
 /* We can't use any flag that is bigger than 0x200 */
 
+/*
+ * fixed-ram migration supports O_DIRECT, so we need to make sure the
+ * userspace buffer, the IO operation size and the file offset are
+ * aligned according to the underlying device's block size. The first
+ * two are already aligned to page size, but we need to add padding to
+ * the file to align the offset.  We cannot read the block size
+ * dynamically because the migration file can be moved between
+ * different systems, so use 1M to cover most block sizes and to keep
+ * the file offset aligned at page size as well.
+ */
+#define FIXED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
+
 XBZRLECacheStats xbzrle_counters;
 
 /* used by the search for pages to send */
@@ -1127,12 +1139,18 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
         return 0;
     }
 
+    stat64_add(&mig_stats.zero_pages, 1);
+
+    if (migrate_fixed_ram()) {
+        /* zero pages are not transferred with fixed-ram */
+        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
+        return 1;
+    }
+
     len += save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
     qemu_put_byte(file, 0);
     len += 1;
     ram_release_page(pss->block->idstr, offset);
-
-    stat64_add(&mig_stats.zero_pages, 1);
     ram_transferred_add(len);
 
     /*
@@ -1190,14 +1208,20 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
 {
     QEMUFile *file = pss->pss_channel;
 
-    ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
-                                         offset | RAM_SAVE_FLAG_PAGE));
-    if (async) {
-        qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
-                              migrate_release_ram() &&
-                              migration_in_postcopy());
+    if (migrate_fixed_ram()) {
+        qemu_put_buffer_at(file, buf, TARGET_PAGE_SIZE,
+                           block->pages_offset + offset);
+        set_bit(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
     } else {
-        qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
+        ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
+                                             offset | RAM_SAVE_FLAG_PAGE));
+        if (async) {
+            qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
+                                  migrate_release_ram() &&
+                                  migration_in_postcopy());
+        } else {
+            qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
+        }
     }
     ram_transferred_add(TARGET_PAGE_SIZE);
     stat64_add(&mig_stats.normal_pages, 1);
@@ -2413,6 +2437,8 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap = NULL;
         g_free(block->bmap);
         block->bmap = NULL;
+        g_free(block->shadow_bmap);
+        block->shadow_bmap = NULL;
     }
 
     xbzrle_cleanup();
@@ -2780,6 +2806,7 @@ static void ram_list_init_bitmaps(void)
              */
             block->bmap = bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
+            block->shadow_bmap = bitmap_new(pages);
             block->clear_bmap_shift = shift;
             block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
         }
@@ -2917,6 +2944,58 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
     }
 }
 
+#define FIXED_RAM_HDR_VERSION 1
+struct FixedRamHeader {
+    uint32_t version;
+    /*
+     * The target's page size, so we know how many pages are in the
+     * bitmap.
+     */
+    uint64_t page_size;
+    /*
+     * The offset in the migration file where the pages bitmap is
+     * found.
+     */
+    uint64_t bitmap_offset;
+    /*
+     * The offset in the migration file where the actual pages (data)
+     * are found.
+     */
+    uint64_t pages_offset;
+    /* end of v1 */
+} QEMU_PACKED;
+typedef struct FixedRamHeader FixedRamHeader;
+
+static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
+{
+    g_autofree FixedRamHeader *header;
+    size_t header_size, bitmap_size;
+    long num_pages;
+
+    header = g_new0(FixedRamHeader, 1);
+    header_size = sizeof(FixedRamHeader);
+
+    num_pages = block->used_length >> TARGET_PAGE_BITS;
+    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+    /*
+     * Save the file offsets of where the bitmap and the pages should
+     * go as they are written at the end of migration and during the
+     * iterative phase, respectively.
+     */
+    block->bitmap_offset = qemu_get_offset(file) + header_size;
+    block->pages_offset = ROUND_UP(block->bitmap_offset +
+                                   bitmap_size,
+                                   FIXED_RAM_FILE_OFFSET_ALIGNMENT);
+
+    header->version = cpu_to_be32(FIXED_RAM_HDR_VERSION);
+    header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
+    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
+    header->pages_offset = cpu_to_be64(block->pages_offset);
+
+    qemu_put_buffer(file, (uint8_t *) header, header_size);
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -2966,6 +3045,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
             if (migrate_ignore_shared()) {
                 qemu_put_be64(f, block->mr->addr);
             }
+
+            if (migrate_fixed_ram()) {
+                fixed_ram_insert_header(f, block);
+                /* prepare offset for next ramblock */
+                qemu_set_offset(f, block->pages_offset + block->used_length,
+                                SEEK_SET);
+            }
         }
     }
 
@@ -2999,6 +3085,19 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     return qemu_fflush(f);
 }
 
+static void ram_save_shadow_bmap(QEMUFile *f)
+{
+    RAMBlock *block;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        long num_pages = block->used_length >> TARGET_PAGE_BITS;
+        long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+        qemu_put_buffer_at(f, (uint8_t *)block->shadow_bmap, bitmap_size,
+                           block->bitmap_offset);
+        ram_transferred_add(bitmap_size);
+    }
+}
+
 /**
  * ram_save_iterate: iterative stage for migration
  *
@@ -3188,6 +3287,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    if (migrate_fixed_ram()) {
+        ram_save_shadow_bmap(f);
+    }
+
     if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
-- 
2.35.3


