Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A61B9BB9A22
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 19:39:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5ShG-0000ac-It; Sun, 05 Oct 2025 13:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sge-0000TX-Gl; Sun, 05 Oct 2025 13:38:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sgb-0004fl-Sd; Sun, 05 Oct 2025 13:38:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4676C15AA91;
 Sun, 05 Oct 2025 20:37:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2EE4329973D;
 Sun,  5 Oct 2025 20:37:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 54/58] include/system/memory.h: Clarify
 address_space_destroy() behaviour
Date: Sun,  5 Oct 2025 20:37:03 +0300
Message-ID: <20251005173712.445160-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

address_space_destroy() doesn't actually immediately destroy the AS;
it queues it to be destroyed via RCU. This means you can't g_free()
the memory the AS struct is in until that has happened.

Clarify this in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-2-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 9e7bfda4909cc688dd0327e17985019f08a78d5d)
(Mjt: this is just a comment fix, but it makes subsequent changes to apply cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e1c196a0c2..2ad3f93344 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2627,9 +2627,14 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
 /**
  * address_space_destroy: destroy an address space
  *
- * Releases all resources associated with an address space.  After an address space
- * is destroyed, its root memory region (given by address_space_init()) may be destroyed
- * as well.
+ * Releases all resources associated with an address space.  After an
+ * address space is destroyed, the reference the AddressSpace had to
+ * its root memory region is dropped, which may result in the
+ * destruction of that memory region as well.
+ *
+ * Note that destruction of the AddressSpace is done via RCU;
+ * it is therefore not valid to free the memory the AddressSpace
+ * struct is in until after that RCU callback has completed.
  *
  * @as: address space to be destroyed
  */
-- 
2.47.3


