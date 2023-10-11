Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 751647C5B8E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeDx-0001mL-Kj; Wed, 11 Oct 2023 14:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDu-0001cV-CF
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:22 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDs-0003i1-P8
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D9052184F;
 Wed, 11 Oct 2023 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697049979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hykwTlJ9Xm5o57C1/e0u3flzezbhfATgfKIKfLqGbGs=;
 b=dIf6WqFoj8+H6baKbfEtEWKfoVxY67HETrw4Kk1PCaKt2CaVTQ+d88+Gt6CbVspJdJGRDY
 zCtvWeaR+lWRDK1Zil7tMIzVwL2RSDOYDnGcv9Xoi4Zx+flpH6Ojx/0mlm+OxX91SV8E5B
 NpWsKWgkD1Y6vo84REqPytMUttzO42k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697049979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hykwTlJ9Xm5o57C1/e0u3flzezbhfATgfKIKfLqGbGs=;
 b=kMoX17XhJWph4XBSphht5gHS+5r9IusGhwplBdI6k3FI4LmBKDqwwjhMBaYhEVI/Ay9FIl
 BNmhI4YmlTwKMYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F62F134F5;
 Wed, 11 Oct 2023 18:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uC+qNnntJmU1bQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 18:46:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH RESEND 6/7] migration/ram: Merge save_zero_page functions
Date: Wed, 11 Oct 2023 15:46:03 -0300
Message-Id: <20231011184604.32364-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231011184604.32364-1-farosas@suse.de>
References: <20231011184604.32364-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[29.56%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

We don't need to do this in two pieces. One single function makes it
easier to grasp, specially since it removes the indirection on the
return value handling.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1177563523..24c249f944 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1136,32 +1136,6 @@ void ram_release_page(const char *rbname, uint64_t offset)
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
@@ -1175,12 +1149,19 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
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
 
@@ -1194,7 +1175,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
         XBZRLE_cache_unlock();
     }
 
-    return 1;
+    return len;
 }
 
 /*
@@ -2150,9 +2131,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    res = save_zero_page(rs, pss, block, offset);
-    if (res > 0) {
-        return res;
+    if (save_zero_page(rs, pss, block, offset)) {
+        return 1;
     }
 
     /*
-- 
2.35.3


