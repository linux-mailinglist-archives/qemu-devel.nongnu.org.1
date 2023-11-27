Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D868E7FAB95
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCU-0003Z1-BO; Mon, 27 Nov 2023 15:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCS-0003UM-Gv
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCQ-0002qc-Fl
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD6741FB54;
 Mon, 27 Nov 2023 20:27:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD36B1379A;
 Mon, 27 Nov 2023 20:27:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gLa7HJ/7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 21/30] migration/multifd: Support incoming fixed-ram
 stream format
Date: Mon, 27 Nov 2023 17:26:03 -0300
Message-Id: <20231127202612.23012-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [10.80 / 50.00]; ARC_NA(0.00)[];
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
 BAYES_HAM(-0.00)[41.93%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 10.80
X-Rspamd-Queue-Id: BD6741FB54
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

For the incoming fixed-ram migration we need to read the ramblock
headers, get the pages bitmap and send the host address of each
non-zero page to the multifd channel thread for writing.

To read from the migration file we need a preadv function that can
read into the iovs in segments of contiguous pages because (as in the
writing case) the file offset applies to the entire iovec.

Usage on HMP is:

(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability fixed-ram on
(qemu) migrate_set_parameter max-bandwidth 0
(qemu) migrate_set_parameter multifd-channels 8
(qemu) migrate_incoming file:migfile
(qemu) info status
(qemu) c

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 385fe431bf..f5173755f0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -111,6 +111,7 @@
  * pages region in the migration file at a time.
  */
 #define FIXED_RAM_LOAD_BUF_SIZE 0x100000
+#define FIXED_RAM_MULTIFD_LOAD_BUF_SIZE 0x100000
 
 XBZRLECacheStats xbzrle_counters;
 
@@ -3942,13 +3943,36 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static size_t ram_load_multifd_pages(RAMBlock *block, ram_addr_t start_offset,
+                                     size_t size)
+{
+    MultiFDRecvData *data = multifd_get_recv_data();
+
+    /*
+     * Pointing the opaque directly to the host buffer, no
+     * preprocessing needed.
+     */
+    data->opaque = block->host + start_offset;
+
+    data->file_offset = block->pages_offset + start_offset;
+    data->size = size;
+
+    if (multifd_recv() < 0) {
+        return -1;
+    }
+
+    return size;
+}
+
 static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
                                     long num_pages, unsigned long *bitmap)
 {
     unsigned long set_bit_idx, clear_bit_idx;
     ram_addr_t offset;
     void *host;
-    size_t read, unread, size, buf_size = FIXED_RAM_LOAD_BUF_SIZE;
+    size_t read, unread, size;
+    size_t buf_size = (migrate_multifd() ? FIXED_RAM_MULTIFD_LOAD_BUF_SIZE :
+                       FIXED_RAM_LOAD_BUF_SIZE);
 
     for (set_bit_idx = find_first_bit(bitmap, num_pages);
          set_bit_idx < num_pages;
@@ -3963,8 +3987,12 @@ static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
             host = host_from_ram_block_offset(block, offset);
             size = MIN(unread, buf_size);
 
-            read = qemu_get_buffer_at(f, host, size,
-                                      block->pages_offset + offset);
+            if (migrate_multifd()) {
+                read = ram_load_multifd_pages(block, offset, size);
+            } else {
+                read = qemu_get_buffer_at(f, host, size,
+                                          block->pages_offset + offset);
+            }
             offset += read;
             unread -= read;
         }
-- 
2.35.3


