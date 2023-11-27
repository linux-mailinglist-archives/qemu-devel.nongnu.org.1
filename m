Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF587FAB88
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:30:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iC1-0002dZ-Jj; Mon, 27 Nov 2023 15:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBw-0002ag-Lt
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBr-0002lO-Ex
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C89D21B4C;
 Mon, 27 Nov 2023 20:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3Y3JvwparVu6jz/rrX6XYg3Vvu0prcpcfTxv1yblC0=;
 b=W/xsn22sKvYa/xiVM1HSkVg2Nkbf9cNwSyiuCdJwjs9M7e/YSKQaaWvF/em43fQYXd1EBn
 lx2JZazgdyuSX9elJZwksF2UKPptFJ6+sUfgRZ8cJBYurTIjdAGhhRWDYRtrvY8eJFfiB1
 1szZK3yXobe03XsSikYtKi10zjr7XGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3Y3JvwparVu6jz/rrX6XYg3Vvu0prcpcfTxv1yblC0=;
 b=HPd2KiQd3fShUEv0HXYM3lhE6gnTfAKIsI70VvJWnsA1pTmJAbNYKvhlkKRj1Reie7cnoY
 jPonGWU/5A2AzDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E4F1379A;
 Mon, 27 Nov 2023 20:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cFVfJn/7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH v3 09/30] migration/ram: Add incoming 'fixed-ram' migration
Date: Mon, 27 Nov 2023 17:25:51 -0300
Message-Id: <20231127202612.23012-10-farosas@suse.de>
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
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add the necessary code to parse the format changes for the 'fixed-ram'
capability.

One of the more notable changes in behavior is that in the 'fixed-ram'
case ram pages are restored in one go rather than constantly looping
through the migration stream.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- added sanity check for pages_offset alignment
- s/parsing/reading
- used Error
- fixed buffer size computation, now allowing an arbitrary limit
- fixed dereference of pointer to packed struct member in endianness
  conversion
---
 migration/ram.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4a0ab8105f..08604222f2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -106,6 +106,12 @@
  */
 #define FIXED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
 
+/*
+ * When doing fixed-ram migration, this is the amount we read from the
+ * pages region in the migration file at a time.
+ */
+#define FIXED_RAM_LOAD_BUF_SIZE 0x100000
+
 XBZRLECacheStats xbzrle_counters;
 
 /* used by the search for pages to send */
@@ -2996,6 +3002,35 @@ static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
     qemu_put_buffer(file, (uint8_t *) header, header_size);
 }
 
+static bool fixed_ram_read_header(QEMUFile *file, FixedRamHeader *header,
+                                  Error **errp)
+{
+    size_t ret, header_size = sizeof(FixedRamHeader);
+
+    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
+    if (ret != header_size) {
+        error_setg(errp, "Could not read whole fixed-ram migration header "
+                   "(expected %zd, got %zd bytes)", header_size, ret);
+        return false;
+    }
+
+    /* migration stream is big-endian */
+    header->version = be32_to_cpu(header->version);
+
+    if (header->version > FIXED_RAM_HDR_VERSION) {
+        error_setg(errp, "Migration fixed-ram capability version mismatch "
+                   "(expected %d, got %d)", FIXED_RAM_HDR_VERSION,
+                   header->version);
+        return false;
+    }
+
+    header->page_size = be64_to_cpu(header->page_size);
+    header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
+    header->pages_offset = be64_to_cpu(header->pages_offset);
+
+    return true;
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -3892,6 +3927,80 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
+                                    long num_pages, unsigned long *bitmap)
+{
+    unsigned long set_bit_idx, clear_bit_idx;
+    ram_addr_t offset;
+    void *host;
+    size_t read, unread, size, buf_size = FIXED_RAM_LOAD_BUF_SIZE;
+
+    for (set_bit_idx = find_first_bit(bitmap, num_pages);
+         set_bit_idx < num_pages;
+         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
+
+        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
+
+        unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
+        offset = set_bit_idx << TARGET_PAGE_BITS;
+
+        while (unread > 0) {
+            host = host_from_ram_block_offset(block, offset);
+            size = MIN(unread, buf_size);
+
+            read = qemu_get_buffer_at(f, host, size,
+                                      block->pages_offset + offset);
+            offset += read;
+            unread -= read;
+        }
+    }
+}
+
+static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
+                                    ram_addr_t length, Error **errp)
+{
+    g_autofree unsigned long *bitmap = NULL;
+    FixedRamHeader header;
+    size_t bitmap_size;
+    long num_pages;
+
+    if (!fixed_ram_read_header(f, &header, errp)) {
+        return -EINVAL;
+    }
+
+    block->pages_offset = header.pages_offset;
+
+    /*
+     * Check the alignment of the file region that contains pages. We
+     * don't enforce FIXED_RAM_FILE_OFFSET_ALIGNMENT to allow that
+     * value to change in the future. Do only a sanity check with page
+     * size alignment.
+     */
+    if (!QEMU_IS_ALIGNED(block->pages_offset, TARGET_PAGE_SIZE)) {
+        error_setg(errp,
+                   "Error reading ramblock %s pages, region has bad alignment",
+                   block->idstr);
+        return -EINVAL;
+    }
+
+    num_pages = length / header.page_size;
+    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+    bitmap = g_malloc0(bitmap_size);
+    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+                           header.bitmap_offset) != bitmap_size) {
+        error_setg(errp, "Error reading dirty bitmap");
+        return -EINVAL;
+    }
+
+    read_ramblock_fixed_ram(f, block, num_pages, bitmap);
+
+    /* Skip pages array */
+    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
+
+    return 0;
+}
+
 static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 {
     int ret = 0;
@@ -3900,6 +4009,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 
     assert(block);
 
+    if (migrate_fixed_ram()) {
+        Error *local_err = NULL;
+
+        ret = parse_ramblock_fixed_ram(f, block, length, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+        return ret;
+    }
+
     if (!qemu_ram_is_migratable(block)) {
         error_report("block %s should not be migrated !", block->idstr);
         return -EINVAL;
-- 
2.35.3


