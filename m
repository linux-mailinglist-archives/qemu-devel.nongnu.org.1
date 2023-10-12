Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ADD7C737F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyuL-0004xI-R4; Thu, 12 Oct 2023 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuG-0004tw-8r
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqyuE-0005ck-O5
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697129485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwq/2CORPrdAQ2SvvLFOmmUsLpU4vkHWIMv0enhZlxM=;
 b=dKRjLBeq8vazGqJa8edKtd57CUa+6ALR1se6BGOr5vaW+HdjxSEZ7s0i+8NpryOXEcENB6
 MPDzxf+uEa78v1ZjIqElKQfXMN1BN3dAAOvhitR+JI7WojawsQouPPph8p3zybo32Yx0EX
 3MuLjimc/ER/XAqySrjGcfcUo4gyFkA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-9f2DCvvzMNenWySAw_PGkA-1; Thu, 12 Oct 2023 12:51:12 -0400
X-MC-Unique: 9f2DCvvzMNenWySAw_PGkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5C501029F40;
 Thu, 12 Oct 2023 16:51:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBF15903;
 Thu, 12 Oct 2023 16:51:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Soul Chen <soulchen8650@gmail.com>
Subject: [PULL 1/7] hw/pvrdma: Protect against buggy or malicious guest driver
Date: Thu, 12 Oct 2023 18:51:02 +0200
Message-ID: <20231012165108.913443-2-thuth@redhat.com>
In-Reply-To: <20231012165108.913443-1-thuth@redhat.com>
References: <20231012165108.913443-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/rdma/vmw/pvrdma_main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

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
2.41.0


