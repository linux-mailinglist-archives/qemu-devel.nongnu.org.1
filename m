Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392D7E6B55
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:44:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15JY-0007Uq-9V; Thu, 09 Nov 2023 08:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15JN-00076M-AG; Thu, 09 Nov 2023 08:43:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15JK-0000iO-Fm; Thu, 09 Nov 2023 08:43:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C35DC31AF8;
 Thu,  9 Nov 2023 16:43:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C4D1B3449F;
 Thu,  9 Nov 2023 16:43:02 +0300 (MSK)
Received: (nullmailer pid 1461763 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Soul Chen <soulchen8650@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 01/55] hw/pvrdma: Protect against buggy or malicious
 guest driver
Date: Thu,  9 Nov 2023 16:42:05 +0300
Message-Id: <20231109134300.1461632-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yuval Shaia <yuval.shaia.ml@gmail.com>

Guest driver allocates and initialize page tables to be used as a ring
of descriptors for CQ and async events.
The page table that represents the ring, along with the number of pages
in the page table is passed to the device.
Currently our device supports only one page table for a ring.

Let's make sure that the number of page table entries the driver
reports, do not exceeds the one page table size.

Reported-by: Soul Chen <soulchen8650@gmail.com>
Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Fixes: CVE-2023-1544
Message-ID: <20230301142926.18686-1-yuval.shaia.ml@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 85fc35afa93c7320d1641d344d0c5dfbe341d087)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 4fc6712025..55b338046e 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -91,19 +91,33 @@ static int init_dev_ring(PvrdmaRing *ring, PvrdmaRingState **ring_state,
                          dma_addr_t dir_addr, uint32_t num_pages)
 {
     uint64_t *dir, *tbl;
-    int rc = 0;
+    int max_pages, rc = 0;
 
     if (!num_pages) {
         rdma_error_report("Ring pages count must be strictly positive");
         return -EINVAL;
     }
 
+    /*
+     * Make sure we can satisfy the requested number of pages in a single
+     * TARGET_PAGE_SIZE sized page table (taking into account that first entry
+     * is reserved for ring-state)
+     */
+    max_pages = TARGET_PAGE_SIZE / sizeof(dma_addr_t) - 1;
+    if (num_pages > max_pages) {
+        rdma_error_report("Maximum pages on a single directory must not exceed %d\n",
+                          max_pages);
+        return -EINVAL;
+    }
+
     dir = rdma_pci_dma_map(pci_dev, dir_addr, TARGET_PAGE_SIZE);
     if (!dir) {
         rdma_error_report("Failed to map to page directory (ring %s)", name);
         rc = -ENOMEM;
         goto out;
     }
+
+    /* We support only one page table for a ring */
     tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
         rdma_error_report("Failed to map to page table (ring %s)", name);
-- 
2.39.2


