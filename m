Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9961E77CE46
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvC0-0008Q3-H0; Tue, 15 Aug 2023 10:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBy-0008Pe-Ij
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVvBw-0002vi-DR
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:38:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7E7721989;
 Tue, 15 Aug 2023 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692110318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toJxKUA5Dl8oTpfiH0/VZtwKHX39icaVQhUvfWCyR50=;
 b=WGMMKKGg/NOfNHyp1kwVBPAUCEWIzsbmCwy9GK+DUQkfkJ0xUeSfywNqJimYU5AJeUlRWu
 yRwXrB9g2PzcDpUvs6yGeJFsioDErShWsChG6oXLwzXu+bsZx2eKyuhOcmu52pnv4/OhHw
 SxLEU853FJgkujUCpkSBk+O6gVK7wsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692110318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toJxKUA5Dl8oTpfiH0/VZtwKHX39icaVQhUvfWCyR50=;
 b=O8qLObd0UEd2xASvtftrPLz1qHRHV3L7xqQGLveXeE5EwccbedSJhPl0CKEIlrXADqZ+Z7
 LIlIUWmk7WZumECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E65613909;
 Tue, 15 Aug 2023 14:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0EEBGu2N22T0WQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 14:38:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 4/5] migration/ram: Return early from save_zero_page
Date: Tue, 15 Aug 2023 11:38:27 -0300
Message-Id: <20230815143828.15436-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815143828.15436-1-farosas@suse.de>
References: <20230815143828.15436-1-farosas@suse.de>
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

Invert the first conditional so we return early when len == 0. This is
merely to make the next patch easier to read.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a10410a1a5..8ec38f69e8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1169,23 +1169,24 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
 {
     int len = save_zero_page_to_file(pss, block, offset);
 
-    if (len) {
-        stat64_add(&mig_stats.zero_pages, 1);
-        ram_transferred_add(len);
+    if (!len) {
+        return -1;
+    }
 
-        /*
-         * Must let xbzrle know, otherwise a previous (now 0'd) cached
-         * page would be stale.
-         */
-        if (rs->xbzrle_started) {
-            XBZRLE_cache_lock();
-            xbzrle_cache_zero_page(block->offset + offset);
-            XBZRLE_cache_unlock();
-        }
+    stat64_add(&mig_stats.zero_pages, 1);
+    ram_transferred_add(len);
 
-        return 1;
+    /*
+     * Must let xbzrle know, otherwise a previous (now 0'd) cached
+     * page would be stale.
+     */
+    if (rs->xbzrle_started) {
+        XBZRLE_cache_lock();
+        xbzrle_cache_zero_page(block->offset + offset);
+        XBZRLE_cache_unlock();
     }
-    return -1;
+
+    return 1;
 }
 
 /*
-- 
2.35.3


