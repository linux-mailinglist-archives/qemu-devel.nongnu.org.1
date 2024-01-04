Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4F8243AE
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:23:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOc7-0001NA-FH; Thu, 04 Jan 2024 09:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc4-0001MQ-2L
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc1-0008Um-Nf
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B728B21E1A;
 Thu,  4 Jan 2024 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQauhPNVhpDDdP3z2mKGEg4aNBnP7toPGXMNMNJetWg=;
 b=lpDPSZWQLcgp1A5fCc9tozhZ18pcfuX8lfmHx0pK8bcR6VbuAqogzNDSOLFbjLQMtL97x3
 qUiyA6VLkZXLKg8CGimYjut7E6zXfNWsuxxTcmzjB6JmYo6ZgW6Mv0WxxXL9dq/KBMmyBI
 2LA+0cawj8yPVeWyVwDg4nwPLIC3H/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQauhPNVhpDDdP3z2mKGEg4aNBnP7toPGXMNMNJetWg=;
 b=fHYcoIHiJfk1H+dYopeW2vPFGW4x2HY0d6EAYX/BMgbZemM4qHWsJ420Xfacb9belPU5Xo
 9SE9GI6hxNXfSaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQauhPNVhpDDdP3z2mKGEg4aNBnP7toPGXMNMNJetWg=;
 b=lpDPSZWQLcgp1A5fCc9tozhZ18pcfuX8lfmHx0pK8bcR6VbuAqogzNDSOLFbjLQMtL97x3
 qUiyA6VLkZXLKg8CGimYjut7E6zXfNWsuxxTcmzjB6JmYo6ZgW6Mv0WxxXL9dq/KBMmyBI
 2LA+0cawj8yPVeWyVwDg4nwPLIC3H/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQauhPNVhpDDdP3z2mKGEg4aNBnP7toPGXMNMNJetWg=;
 b=fHYcoIHiJfk1H+dYopeW2vPFGW4x2HY0d6EAYX/BMgbZemM4qHWsJ420Xfacb9belPU5Xo
 9SE9GI6hxNXfSaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E18137E8;
 Thu,  4 Jan 2024 14:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uMSnIRq/lmUfPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 14:22:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 2/7] migration/multifd: Remove QEMUFile from where it is
 not needed
Date: Thu,  4 Jan 2024 11:21:39 -0300
Message-Id: <20240104142144.9680-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240104142144.9680-1-farosas@suse.de>
References: <20240104142144.9680-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 8.80
X-Spamd-Result: default: False [8.80 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(5.10)[100.00%]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 12 ++++++------
 migration/multifd.h |  4 ++--
 migration/ram.c     | 15 +++++++--------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3e650f5da0..2dbc3ba836 100644
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


