Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6E7C5B8F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeE0-0002Ay-JD; Wed, 11 Oct 2023 14:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDy-0001zp-KN
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:26 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDl-0003gS-L6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 842561F74A;
 Wed, 11 Oct 2023 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697049972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geIx7jVDHWsUbpe/R93qEjTF2bYMxWBsk7l7eUQOZ58=;
 b=1UTHDVNtbZLMHXyS9dCxpZtcT4W36eaUvuhFFKPiTnk84s1pAsMzGkE8qGQ+FoOPJvk/vv
 07+hx3bBv8g/iSdMOBx1tDSgHyJEjTkSY9JrhVkV1fStQ5zAbD0m0dfyor0DCyZqohIs0h
 p06Tly8XWzUjRC6mcPE1AVFXS3RuJsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697049972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geIx7jVDHWsUbpe/R93qEjTF2bYMxWBsk7l7eUQOZ58=;
 b=XJdv+TqMWyNmfMARbGF2d9QQaDIH5V5wV/foiP9iJY43ZgYVoibwCulf2+IPig71dtxFQE
 FKhDvaE/6ecRNrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1B20134F5;
 Wed, 11 Oct 2023 18:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QBHXInLtJmU1bQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 18:46:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Nikolay Borisov <nborisov@suse.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH RESEND 2/7] migration/ram: Refactor precopy ram loading code
Date: Wed, 11 Oct 2023 15:45:59 -0300
Message-Id: <20231011184604.32364-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231011184604.32364-1-farosas@suse.de>
References: <20231011184604.32364-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Extract the ramblock parsing code into a routine that operates on the
sequence of headers from the stream and another the parses the
individual ramblock. This makes ram_load_precopy() easier to
comprehend.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 141 +++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 62 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2f5ce4d60b..1cc14e543e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3861,6 +3861,82 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
+{
+    int ret = 0;
+    /* ADVISE is earlier, it shows the source has the postcopy capability on */
+    bool postcopy_advised = migration_incoming_postcopy_advised();
+
+    assert(block);
+
+    if (!qemu_ram_is_migratable(block)) {
+        error_report("block %s should not be migrated !", block->idstr);
+        return -EINVAL;
+    }
+
+    if (length != block->used_length) {
+        Error *local_err = NULL;
+
+        ret = qemu_ram_resize(block, length, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
+    /* For postcopy we need to check hugepage sizes match */
+    if (postcopy_advised && migrate_postcopy_ram() &&
+        block->page_size != qemu_host_page_size) {
+        uint64_t remote_page_size = qemu_get_be64(f);
+        if (remote_page_size != block->page_size) {
+            error_report("Mismatched RAM page size %s "
+                         "(local) %zd != %" PRId64, block->idstr,
+                         block->page_size, remote_page_size);
+            ret = -EINVAL;
+        }
+    }
+    if (migrate_ignore_shared()) {
+        hwaddr addr = qemu_get_be64(f);
+        if (migrate_ram_is_ignored(block) &&
+            block->mr->addr != addr) {
+            error_report("Mismatched GPAs for block %s "
+                         "%" PRId64 "!= %" PRId64, block->idstr,
+                         (uint64_t)addr, (uint64_t)block->mr->addr);
+            ret = -EINVAL;
+        }
+    }
+    ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG, block->idstr);
+
+    return ret;
+}
+
+static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
+{
+    int ret = 0;
+
+    /* Synchronize RAM block list */
+    while (!ret && total_ram_bytes) {
+        RAMBlock *block;
+        char id[256];
+        ram_addr_t length;
+        int len = qemu_get_byte(f);
+
+        qemu_get_buffer(f, (uint8_t *)id, len);
+        id[len] = 0;
+        length = qemu_get_be64(f);
+
+        block = qemu_ram_block_by_name(id);
+        if (block) {
+            ret = parse_ramblock(f, block, length);
+        } else {
+            error_report("Unknown ramblock \"%s\", cannot accept "
+                         "migration", id);
+            ret = -EINVAL;
+        }
+        total_ram_bytes -= length;
+    }
+
+    return ret;
+}
+
 /**
  * ram_load_precopy: load pages in precopy case
  *
@@ -3875,14 +3951,13 @@ static int ram_load_precopy(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
-    /* ADVISE is earlier, it shows the source has the postcopy capability on */
-    bool postcopy_advised = migration_incoming_postcopy_advised();
+
     if (!migrate_compress()) {
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
 
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
-        ram_addr_t addr, total_ram_bytes;
+        ram_addr_t addr;
         void *host = NULL, *host_bak = NULL;
         uint8_t ch;
 
@@ -3953,65 +4028,7 @@ static int ram_load_precopy(QEMUFile *f)
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_MEM_SIZE:
-            /* Synchronize RAM block list */
-            total_ram_bytes = addr;
-            while (!ret && total_ram_bytes) {
-                RAMBlock *block;
-                char id[256];
-                ram_addr_t length;
-
-                len = qemu_get_byte(f);
-                qemu_get_buffer(f, (uint8_t *)id, len);
-                id[len] = 0;
-                length = qemu_get_be64(f);
-
-                block = qemu_ram_block_by_name(id);
-                if (block && !qemu_ram_is_migratable(block)) {
-                    error_report("block %s should not be migrated !", id);
-                    ret = -EINVAL;
-                } else if (block) {
-                    if (length != block->used_length) {
-                        Error *local_err = NULL;
-
-                        ret = qemu_ram_resize(block, length,
-                                              &local_err);
-                        if (local_err) {
-                            error_report_err(local_err);
-                        }
-                    }
-                    /* For postcopy we need to check hugepage sizes match */
-                    if (postcopy_advised && migrate_postcopy_ram() &&
-                        block->page_size != qemu_host_page_size) {
-                        uint64_t remote_page_size = qemu_get_be64(f);
-                        if (remote_page_size != block->page_size) {
-                            error_report("Mismatched RAM page size %s "
-                                         "(local) %zd != %" PRId64,
-                                         id, block->page_size,
-                                         remote_page_size);
-                            ret = -EINVAL;
-                        }
-                    }
-                    if (migrate_ignore_shared()) {
-                        hwaddr addr2 = qemu_get_be64(f);
-                        if (migrate_ram_is_ignored(block) &&
-                            block->mr->addr != addr2) {
-                            error_report("Mismatched GPAs for block %s "
-                                         "%" PRId64 "!= %" PRId64,
-                                         id, (uint64_t)addr2,
-                                         (uint64_t)block->mr->addr);
-                            ret = -EINVAL;
-                        }
-                    }
-                    ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
-                                          block->idstr);
-                } else {
-                    error_report("Unknown ramblock \"%s\", cannot "
-                                 "accept migration", id);
-                    ret = -EINVAL;
-                }
-
-                total_ram_bytes -= length;
-            }
+            ret = parse_ramblocks(f, addr);
             break;
 
         case RAM_SAVE_FLAG_ZERO:
-- 
2.35.3


