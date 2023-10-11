Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C20647C5B96
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeDt-0001VL-Ep; Wed, 11 Oct 2023 14:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDr-0001Pq-Ve
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:20 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqeDn-0003gy-Ba
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:46:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E22A1F45A;
 Wed, 11 Oct 2023 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697049974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qy7h0B1d62LP0D1+0Lb0KPya9EwaJlrhQwRy4nxXQHQ=;
 b=D+9Ow1zwX+/+WTu77R8uA4G9Kro7mdeclug/YV0h3WFkPmgjY5ZJwcgvnr4JoR1nxy49OL
 bYp6LvXRJ4T8F8BDIpp3dLX6A4UEtTkgjW+3Up3e6lCS1lnOCNsd5xawc42trExA6UjOXZ
 WBRJtRiyIEASIvOFGBdS5ta0/kHPJrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697049974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qy7h0B1d62LP0D1+0Lb0KPya9EwaJlrhQwRy4nxXQHQ=;
 b=NvJV8DQLOrjSmdQAge6giMUMjbfDo4WUnVGcb7a70Y//DfCh9x6Vwku/LQRroiHhK6o3nX
 d0EMgvSnPq40Z4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E54D6134F5;
 Wed, 11 Oct 2023 18:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MPydK3TtJmU1bQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 18:46:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH RESEND 3/7] migration/ram: Remove RAMState from
 xbzrle_cache_zero_page
Date: Wed, 11 Oct 2023 15:46:00 -0300
Message-Id: <20231011184604.32364-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231011184604.32364-1-farosas@suse.de>
References: <20231011184604.32364-1-farosas@suse.de>
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

'rs' is not used in that function. It's a leftover from commit
9360447d34 ("ram: Use MigrationStats for statistics").

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1cc14e543e..cd765212af 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -569,7 +569,6 @@ void mig_throttle_counter_reset(void)
 /**
  * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
  *
- * @rs: current RAM state
  * @current_addr: address for the zero page
  *
  * Update the xbzrle cache to reflect a page that's been sent as all 0.
@@ -578,7 +577,7 @@ void mig_throttle_counter_reset(void)
  * As a bonus, if the page wasn't in the cache it gets added so that
  * when a small write is made into the 0'd page it gets XBZRLE sent.
  */
-static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
+static void xbzrle_cache_zero_page(ram_addr_t current_addr)
 {
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
@@ -2144,7 +2143,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
          */
         if (rs->xbzrle_started) {
             XBZRLE_cache_lock();
-            xbzrle_cache_zero_page(rs, block->offset + offset);
+            xbzrle_cache_zero_page(block->offset + offset);
             XBZRLE_cache_unlock();
         }
         return res;
-- 
2.35.3


