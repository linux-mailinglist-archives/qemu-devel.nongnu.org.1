Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BBB08B5D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 12:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucMGR-0007PC-Tr; Thu, 17 Jul 2025 06:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGK-0007F4-Au; Thu, 17 Jul 2025 06:54:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucMGH-00037s-1B; Thu, 17 Jul 2025 06:54:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8B06137E1D;
 Thu, 17 Jul 2025 13:54:34 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CAFAF249267;
 Thu, 17 Jul 2025 13:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Chaney, Ben" <bchaney@akamai.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 17/26] migration: Don't sync volatile memory after
 migration completes
Date: Thu, 17 Jul 2025 13:54:31 +0300
Message-ID: <20250717105442.735202-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250717135416@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Chaney, Ben" <bchaney@akamai.com>

Syncing volatile memory provides no benefit, instead it can cause
performance issues in some cases.  Only sync memory that is marked as
non-volatile after migration completes on destination.

Signed-off-by: Ben Chaney <bchaney@akamai.com>
Fixes: bd108a44bc29 (migration: ram: Switch to ram block writeback)
Link: https://lore.kernel.org/r/1CC43F59-336F-4A12-84AD-DB89E0A17A95@akamai.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 983899eab4939dc4dff67fa4d822c5b4df7eae21)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/ram.c b/migration/ram.c
index f25ebd9620..e3ab67acd4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3930,7 +3930,9 @@ static int ram_load_cleanup(void *opaque)
     RAMBlock *rb;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        qemu_ram_block_writeback(rb);
+        if (memory_region_is_nonvolatile(rb->mr)) {
+            qemu_ram_block_writeback(rb);
+        }
     }
 
     xbzrle_load_cleanup();
-- 
2.47.2


