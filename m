Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0477CE41
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvBw-0008Op-Uv; Tue, 15 Aug 2023 10:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBv-0008OK-OT
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:39 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBt-0002uZ-H4
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6EC551F8B8;
 Tue, 15 Aug 2023 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692110315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss9HHRBxbtgwF7lE2GrcOoBMb9RS2y9xz29KikLYwck=;
 b=yt1rD0sJqvAad8NouKnz8MTVCasH4BijgPK2a+UU6DiavO6WHmqOoa2E4HjNBh/8MIEBGa
 8D+5AypM7zKd2iDAV6NaKNwfGEJrCXXRoUrSdVDM8shJf/f+UTfncP1LQZtlKaHMsrVjk8
 0eJq9/0S9dYbmwYUK9ft9/CtsKVY8sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692110315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss9HHRBxbtgwF7lE2GrcOoBMb9RS2y9xz29KikLYwck=;
 b=WjQCMuSZEMwPcw/rpeBlSzaMineXDtBAaqvtOzCGusuRU9kolv0UN3nBf0YbxtoESxIaP8
 fWom/gbXzpnstPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27A7213909;
 Tue, 15 Aug 2023 14:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uJqhOOmN22T0WQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 14:38:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/5] migration/ram: Stop passing QEMUFile around in
 save_zero_page
Date: Tue, 15 Aug 2023 11:38:25 -0300
Message-Id: <20230815143828.15436-3-farosas@suse.de>
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

We don't need the QEMUFile when we're already passing the
PageSearchStatus.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 87efab72e8..761f43dc34 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1138,10 +1138,11 @@ void ram_release_page(const char *rbname, uint64_t offset)
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
-                                  RAMBlock *block, ram_addr_t offset)
+static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
+                                  ram_addr_t offset)
 {
     uint8_t *p = block->host + offset;
+    QEMUFile *file = pss->pss_channel;
     int len = 0;
 
     if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
@@ -1162,10 +1163,10 @@ static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
+static int save_zero_page(PageSearchStatus *pss, RAMBlock *block,
                           ram_addr_t offset)
 {
-    int len = save_zero_page_to_file(pss, f, block, offset);
+    int len = save_zero_page_to_file(pss, block, offset);
 
     if (len) {
         stat64_add(&mig_stats.zero_pages, 1);
@@ -2140,7 +2141,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    res = save_zero_page(pss, pss->pss_channel, block, offset);
+    res = save_zero_page(pss, block, offset);
     if (res > 0) {
         /* Must let xbzrle know, otherwise a previous (now 0'd) cached
          * page would be stale
-- 
2.35.3


