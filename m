Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C977E8B7
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWLFy-0003pS-HL; Wed, 16 Aug 2023 14:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWLFu-0003oa-MO
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:28:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWLFs-0006p4-EB
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:28:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8512321881;
 Wed, 16 Aug 2023 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692210506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsG/34ZSYIoS6eKANfLhgLDzptxFgaHF6zKNR/mzDrQ=;
 b=VnP0C3tUHcohV6lXL7AUcgVx3jAwOQlsnJFKIisjArXiq4iY7/feiYiH8zcpHXQMi6aZfO
 RQrCKOZ8SAsjTQpPiETJEStIoI3eCTGXS7oIb4i9uTBqdWefQzVDDdH97fTnh4BMh2sUS6
 wesepf58S4iRLS0JvNraWIfkQ0qZJJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692210506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsG/34ZSYIoS6eKANfLhgLDzptxFgaHF6zKNR/mzDrQ=;
 b=rux8gNpUSD0QIrC74vOGQu7Wshgium2xTuSuaBOABr71NYbLq0vH9oxA3rDcFR8PTdvsBW
 0oLkTChDa2u4HaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 388D3133F2;
 Wed, 16 Aug 2023 18:28:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SLwsAUkV3WTxbQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 18:28:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 3/4] migration/ram: Move xbzrle zero page handling into
 save_zero_page
Date: Wed, 16 Aug 2023 15:28:16 -0300
Message-Id: <20230816182817.17590-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816182817.17590-1-farosas@suse.de>
References: <20230816182817.17590-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

It makes a bit more sense to have the zero page handling of xbzrle
right where we save the zero page.

Also invert the exit condition to remove one level of indentation
which makes the next patch easier to grasp.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 761f43dc34..82ff53beec 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1159,21 +1159,34 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
  *
  * Returns the number of pages written.
  *
+ * @rs: current RAM state
  * @pss: current PSS channel
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page(PageSearchStatus *pss, RAMBlock *block,
+static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
                           ram_addr_t offset)
 {
     int len = save_zero_page_to_file(pss, block, offset);
 
-    if (len) {
-        stat64_add(&mig_stats.zero_pages, 1);
-        ram_transferred_add(len);
-        return 1;
+    if (!len) {
+        return -1;
     }
-    return -1;
+
+    stat64_add(&mig_stats.zero_pages, 1);
+    ram_transferred_add(len);
+
+    /*
+     * Must let xbzrle know, otherwise a previous (now 0'd) cached
+     * page would be stale.
+     */
+    if (rs->xbzrle_started) {
+        XBZRLE_cache_lock();
+        xbzrle_cache_zero_page(block->offset + offset);
+        XBZRLE_cache_unlock();
+    }
+
+    return 1;
 }
 
 /*
@@ -2141,16 +2154,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    res = save_zero_page(pss, block, offset);
+    res = save_zero_page(rs, pss, block, offset);
     if (res > 0) {
-        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
-         * page would be stale
-         */
-        if (rs->xbzrle_started) {
-            XBZRLE_cache_lock();
-            xbzrle_cache_zero_page(block->offset + offset);
-            XBZRLE_cache_unlock();
-        }
         return res;
     }
 
-- 
2.35.3


