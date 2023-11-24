Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAED7F78BB
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:16:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6YpL-0008Tt-87; Fri, 24 Nov 2023 11:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpJ-0008OA-2I
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:45 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpH-0001V9-1W
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D38E1FF6C;
 Fri, 24 Nov 2023 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700842480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YKQYD9gdZVbQptYh6IYsBkPHMVZI7txPRz2ic4q6h4=;
 b=Pj5gkjiEdifXebXIj6ieyTjGB9rhJ4nY0vYARGctQedsNdpYSBy1WUZWAg8bAK5pbVnCVJ
 XDWVZmfm6Rhb2/Ma4HluAkruYzpowJVvflCIQdGkL4OOXklSsHgKLu4Vyb2W3Zjw63X4mk
 3VTDxh6srSIN+O/xHgwGwaW0S5XWmAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700842480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YKQYD9gdZVbQptYh6IYsBkPHMVZI7txPRz2ic4q6h4=;
 b=buOLi0x7eblM5pAJwkvXMIAiITp56MbsKJucQCNFWWkBBe8hRmFDjNqiVdTJMHo/uIBGnj
 E0n/uJMn80IOUrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DD8A13A98;
 Fri, 24 Nov 2023 16:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EOUrOe7LYGXdagAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Nov 2023 16:14:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v1 2/7] migration/multifd: Remove QEMUFile from where it is
 not needed
Date: Fri, 24 Nov 2023 13:14:27 -0300
Message-Id: <20231124161432.3515-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231124161432.3515-1-farosas@suse.de>
References: <20231124161432.3515-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 8.40
X-Spamd-Result: default: False [8.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.50)[1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 12 ++++++------
 migration/multifd.h |  4 ++--
 migration/ram.c     | 15 +++++++--------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index e7dd9c6317..7e7fe59fcb 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -390,7 +390,7 @@ struct {
  * false.
  */
 
-static int multifd_send_pages(QEMUFile *f)
+static int multifd_send_pages(void)
 {
     int i;
     static int next_channel;
@@ -436,7 +436,7 @@ static int multifd_send_pages(QEMUFile *f)
     return 1;
 }
 
-int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
+int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages = multifd_send_state->pages;
     bool changed = false;
@@ -456,12 +456,12 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
         changed = true;
     }
 
-    if (multifd_send_pages(f) < 0) {
+    if (multifd_send_pages() < 0) {
         return -1;
     }
 
     if (changed) {
-        return multifd_queue_page(f, block, offset);
+        return multifd_queue_page(block, offset);
     }
 
     return 1;
@@ -583,7 +583,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(QEMUFile *f)
+int multifd_send_sync_main(void)
 {
     int i;
     bool flush_zero_copy;
@@ -592,7 +592,7 @@ int multifd_send_sync_main(QEMUFile *f)
         return 0;
     }
     if (multifd_send_state->pages->num) {
-        if (multifd_send_pages(f) < 0) {
+        if (multifd_send_pages() < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
         }
diff --git a/migration/multifd.h b/migration/multifd.h
index b0ff610c37..35d11f103c 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -21,8 +21,8 @@ void multifd_load_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-int multifd_send_sync_main(QEMUFile *f);
-int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
+int multifd_send_sync_main(void);
+int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
diff --git a/migration/ram.c b/migration/ram.c
index 8c7886ab79..b4f2f5108f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1250,10 +1250,9 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
     return pages;
 }
 
-static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
-                                 ram_addr_t offset)
+static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
 {
-    if (multifd_queue_page(file, block, offset) < 0) {
+    if (multifd_queue_page(block, offset) < 0) {
         return -1;
     }
     stat64_add(&mig_stats.normal_pages, 1);
@@ -1336,7 +1335,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
             if (migrate_multifd() &&
                 !migrate_multifd_flush_after_each_section()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_send_sync_main(f);
+                int ret = multifd_send_sync_main();
                 if (ret < 0) {
                     return ret;
                 }
@@ -2067,7 +2066,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
      * still see partially copied pages which is data corruption.
      */
     if (migrate_multifd() && !migration_in_postcopy()) {
-        return ram_save_multifd_page(pss->pss_channel, block, offset);
+        return ram_save_multifd_page(block, offset);
     }
 
     return ram_save_page(rs, pss);
@@ -2985,7 +2984,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     migration_ops->ram_save_target_page = ram_save_target_page_legacy;
 
     qemu_mutex_unlock_iothread();
-    ret = multifd_send_sync_main(f);
+    ret = multifd_send_sync_main();
     qemu_mutex_lock_iothread();
     if (ret < 0) {
         return ret;
@@ -3109,7 +3108,7 @@ out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
-            ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
+            ret = multifd_send_sync_main();
             if (ret < 0) {
                 return ret;
             }
@@ -3183,7 +3182,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
+    ret = multifd_send_sync_main();
     if (ret < 0) {
         return ret;
     }
-- 
2.35.3


