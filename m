Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCEC7D40FF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:38:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1fd-0003PJ-OS; Mon, 23 Oct 2023 16:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fZ-0003Ik-E4
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:01 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fX-0001r9-NM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10E361FE3B;
 Mon, 23 Oct 2023 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zj1w64ezVZU0bavfntnDEAPLXAKVFP1yUxizTzb9PgE=;
 b=PPjmGxyRfPitH0sZ4iawF9yATbWrtqVLNeYh8JQi4K/iW6CIoSuTraghtlCYYXhN7DtLqT
 tjLvPWJtpRNKwWNvXMLhBx5sllzl1LPkYRk5DKrFxZyoZZ0Dw4B+pynA0so9Ci6pLilW/x
 wCpb+bMQY9Mu3Ez8rfIDBHT9ZV4OtGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zj1w64ezVZU0bavfntnDEAPLXAKVFP1yUxizTzb9PgE=;
 b=70PGgajtGYydJ3eUsakGkdNwVMlyrr/Il7LTz0yQFaQKkrnq7Xt0H3bcYiBaaMlLbkBxuU
 Bd49e+BDUTyzXAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4AA6132FD;
 Mon, 23 Oct 2023 20:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YFZkK2XZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram' migration
 restore
Date: Mon, 23 Oct 2023 17:35:55 -0300
Message-Id: <20231023203608.26370-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.57
X-Spamd-Result: default: False [-0.57 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.47)[91.47%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

From: Nikolay Borisov <nborisov@suse.com>

Add the necessary code to parse the format changes for the 'fixed-ram'
capability.

One of the more notable changes in behavior is that in the 'fixed-ram'
case ram pages are restored in one go rather than constantly looping
through the migration stream.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
(farosas) reused more of the common code by making the fixed-ram
function take only one ramblock and calling it from inside
parse_ramblock.
---
 migration/ram.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 152a03604f..cea6971ab2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3032,6 +3032,32 @@ static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
     qemu_put_buffer(file, (uint8_t *) header, header_size);
 }
 
+static int fixed_ram_read_header(QEMUFile *file, struct FixedRamHeader *header)
+{
+    size_t ret, header_size = sizeof(struct FixedRamHeader);
+
+    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
+    if (ret != header_size) {
+        return -1;
+    }
+
+    /* migration stream is big-endian */
+    be32_to_cpus(&header->version);
+
+    if (header->version > FIXED_RAM_HDR_VERSION) {
+        error_report("Migration fixed-ram capability version mismatch (expected %d, got %d)",
+                     FIXED_RAM_HDR_VERSION, header->version);
+        return -1;
+    }
+
+    be64_to_cpus(&header->page_size);
+    be64_to_cpus(&header->bitmap_offset);
+    be64_to_cpus(&header->pages_offset);
+
+
+    return 0;
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -3932,6 +3958,68 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
+                                    long num_pages, unsigned long *bitmap)
+{
+    unsigned long set_bit_idx, clear_bit_idx;
+    unsigned long len;
+    ram_addr_t offset;
+    void *host;
+    size_t read, completed, read_len;
+
+    for (set_bit_idx = find_first_bit(bitmap, num_pages);
+         set_bit_idx < num_pages;
+         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
+
+        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
+
+        len = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
+        offset = set_bit_idx << TARGET_PAGE_BITS;
+
+        for (read = 0, completed = 0; completed < len; offset += read) {
+            host = host_from_ram_block_offset(block, offset);
+            read_len = MIN(len, TARGET_PAGE_SIZE);
+
+            read = qemu_get_buffer_at(f, host, read_len,
+                                      block->pages_offset + offset);
+            completed += read;
+        }
+    }
+}
+
+static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
+{
+    g_autofree unsigned long *bitmap = NULL;
+    struct FixedRamHeader header;
+    size_t bitmap_size;
+    long num_pages;
+    int ret = 0;
+
+    ret = fixed_ram_read_header(f, &header);
+    if (ret < 0) {
+        error_report("Error reading fixed-ram header");
+        return -EINVAL;
+    }
+
+    block->pages_offset = header.pages_offset;
+    num_pages = length / header.page_size;
+    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+    bitmap = g_malloc0(bitmap_size);
+    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+                           header.bitmap_offset) != bitmap_size) {
+        error_report("Error parsing dirty bitmap");
+        return -EINVAL;
+    }
+
+    read_ramblock_fixed_ram(f, block, num_pages, bitmap);
+
+    /* Skip pages array */
+    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
+
+    return ret;
+}
+
 static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 {
     int ret = 0;
@@ -3940,6 +4028,10 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 
     assert(block);
 
+    if (migrate_fixed_ram()) {
+        return parse_ramblock_fixed_ram(f, block, length);
+    }
+
     if (!qemu_ram_is_migratable(block)) {
         error_report("block %s should not be migrated !", block->idstr);
         return -EINVAL;
@@ -4142,6 +4234,7 @@ static int ram_load_precopy(QEMUFile *f)
                 migrate_multifd_flush_after_each_section()) {
                 multifd_recv_sync_main();
             }
+
             break;
         case RAM_SAVE_FLAG_HOOK:
             ret = rdma_registration_handle(f);
-- 
2.35.3


