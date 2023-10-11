Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315E7C5B93
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:47:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeDw-0001iu-Ts; Wed, 11 Oct 2023 14:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDt-0001XP-H7
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDr-0003ha-0D
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B51B221833;
 Wed, 11 Oct 2023 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697049977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwngeoIto3OiopZbtgN/FTwEBG7umoRGFAG9xkrazTg=;
 b=QUmtPZALgN3J0JUmZWsGJCci/gkZtdeGDtmVLm3buZaFecGYPlNT4V9LTKW125smfGtEST
 5fz5O1/UMtIhCuruKV/4/uVc8QEABKYTdR2TpcDkv6Yi4DccXPxch1oCb4Bk9AyNO2K7ox
 jGznPc5iE+TH3Z7rtkGSXMEfaxcEbIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697049977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwngeoIto3OiopZbtgN/FTwEBG7umoRGFAG9xkrazTg=;
 b=Ckfpii956dwzkyVF3HvV6oIFi04HPG8DJYFDrnE6iPLly7fMbrauaIzgu/iUdXM3Es7a62
 HYb3uH2z4tYk8wCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CD82134F5;
 Wed, 11 Oct 2023 18:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SBdQCnjtJmU1bQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 18:46:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH RESEND 5/7] migration/ram: Move xbzrle zero page handling into
 save_zero_page
Date: Wed, 11 Oct 2023 15:46:02 -0300
Message-Id: <20231011184604.32364-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231011184604.32364-1-farosas@suse.de>
References: <20231011184604.32364-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.89
X-Spamd-Result: default: False [3.89 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[48.46%]
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
index c8474f6fd8..1177563523 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1167,21 +1167,34 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
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
@@ -2137,16 +2150,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
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


