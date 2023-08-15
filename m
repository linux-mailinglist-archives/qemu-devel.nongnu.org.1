Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B36BA77CE48
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:39:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvC1-0008R7-OJ; Tue, 15 Aug 2023 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvC0-0008Pz-0O
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:44 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBx-0002wO-Ns
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A75701F749;
 Tue, 15 Aug 2023 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692110320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDHF1F1Gm9CKMTWMnNAi///z2f1xyUqQ3HKLwljCm00=;
 b=dqBEDlvdW1j9CeKbqHrCUe1Mx2Tc2eM8/RvqdXzPTw3IJ8kwN9uVh7a55NbmMXbLnfRrFQ
 fWBYMlT1vY83/yAPM6Phjtx8BCSV07TmyZnUHtPIphEGw/7M3DwdZ7c7D9WIfN9qYesGgq
 eRQ7MQdLxgCp2kTsqYopUIUCq0cjLyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692110320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDHF1F1Gm9CKMTWMnNAi///z2f1xyUqQ3HKLwljCm00=;
 b=5Y9cnO4dZyOM7VoBmhJn3T2ihxxpnuB/TxG4GS/zb9Ms1ofbWQRq6+5SmWV/FWqMBFHmFc
 Vd0PV/XWGXwMUZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DC6213909;
 Tue, 15 Aug 2023 14:38:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UBc0Cu+N22T0WQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 14:38:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 5/5] migration/ram: Merge save_zero_page functions
Date: Tue, 15 Aug 2023 11:38:28 -0300
Message-Id: <20230815143828.15436-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815143828.15436-1-farosas@suse.de>
References: <20230815143828.15436-1-farosas@suse.de>
MIME-Version: 1.0
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

We don't need to do this in two pieces. One single function makes it
easier to grasp, specially since it removes the indirection on the
return value handling.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8ec38f69e8..13935ead1c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1128,32 +1128,6 @@ void ram_release_page(const char *rbname, uint64_t offset)
     ram_discard_range(rbname, offset, TARGET_PAGE_SIZE);
 }
 
-/**
- * save_zero_page_to_file: send the zero page to the file
- *
- * Returns the size of data written to the file, 0 means the page is not
- * a zero page
- *
- * @pss: current PSS channel
- * @block: block that contains the page we want to send
- * @offset: offset inside the block for the page
- */
-static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
-                                  ram_addr_t offset)
-{
-    uint8_t *p = block->host + offset;
-    QEMUFile *file = pss->pss_channel;
-    int len = 0;
-
-    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
-        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
-        qemu_put_byte(file, 0);
-        len += 1;
-        ram_release_page(block->idstr, offset);
-    }
-    return len;
-}
-
 /**
  * save_zero_page: send the zero page to the stream
  *
@@ -1167,12 +1141,19 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
 static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
                           ram_addr_t offset)
 {
-    int len = save_zero_page_to_file(pss, block, offset);
+    uint8_t *p = block->host + offset;
+    QEMUFile *file = pss->pss_channel;
+    int len = 0;
 
-    if (!len) {
-        return -1;
+    if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
+        return 0;
     }
 
+    len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
+    qemu_put_byte(file, 0);
+    len += 1;
+    ram_release_page(block->idstr, offset);
+
     stat64_add(&mig_stats.zero_pages, 1);
     ram_transferred_add(len);
 
@@ -1186,7 +1167,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
         XBZRLE_cache_unlock();
     }
 
-    return 1;
+    return len;
 }
 
 /*
-- 
2.35.3


