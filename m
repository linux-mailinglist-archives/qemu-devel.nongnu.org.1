Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F3846DF4
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Feb 2024 11:31:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqp6-0001bF-2t; Fri, 02 Feb 2024 05:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoy-00018j-7r
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqov-00020m-Ni
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCMu/h0Uagcfb4ObsHyaNRe66JC3h0/VZ/U7Orz2xOU=;
 b=i+7kKx3ckhTOhNzCHix+P/Q8v2shZJKPNqhrif8/bGDFbM6iTz1iInWfZWGKYK21Uca0MU
 ySc29LaTFtim5jL65oGaRgGPT4aiyOL0AjX8xm4G2ieZWG8JM1QzSNsGFUVYiaYKw7Cm/m
 smIwLFYkyXSMwQZgNCyqui3okDt9IQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-hZP7jx5fNCCqUNBLQ28FHw-1; Fri,
 02 Feb 2024 05:30:49 -0500
X-MC-Unique: hZP7jx5fNCCqUNBLQ28FHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B973C0BE50;
 Fri,  2 Feb 2024 10:30:49 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5F740C9444;
 Fri,  2 Feb 2024 10:30:44 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 18/23] migration/multifd: Rewrite multifd_queue_page()
Date: Fri,  2 Feb 2024 18:28:52 +0800
Message-ID: <20240202102857.110210-19-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

The current multifd_queue_page() is not easy to read and follow.  It is not
good with a few reasons:

  - No helper at all to show what exactly does a condition mean; in short,
  readability is low.

  - Rely on pages->ramblock being cleared to detect an empty queue.  It's
  slightly an overload of the ramblock pointer, per Fabiano [1], which I
  also agree.

  - Contains a self recursion, even if not necessary..

Rewrite this function.  We add some comments to make it even clearer on
what it does.

[1] https://lore.kernel.org/r/87wmrpjzew.fsf@suse.de

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 56 ++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 35d4e8ad1f..4ab8e6eff2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -506,35 +506,53 @@ static bool multifd_send_pages(void)
     return true;
 }
 
+static inline bool multifd_queue_empty(MultiFDPages_t *pages)
+{
+    return pages->num == 0;
+}
+
+static inline bool multifd_queue_full(MultiFDPages_t *pages)
+{
+    return pages->num == pages->allocated;
+}
+
+static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
+{
+    pages->offset[pages->num++] = offset;
+}
+
 /* Returns true if enqueue successful, false otherwise */
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
 {
-    MultiFDPages_t *pages = multifd_send_state->pages;
-    bool changed = false;
+    MultiFDPages_t *pages;
+
+retry:
+    pages = multifd_send_state->pages;
 
-    if (!pages->block) {
+    /* If the queue is empty, we can already enqueue now */
+    if (multifd_queue_empty(pages)) {
         pages->block = block;
+        multifd_enqueue(pages, offset);
+        return true;
     }
 
-    if (pages->block == block) {
-        pages->offset[pages->num] = offset;
-        pages->num++;
-
-        if (pages->num < pages->allocated) {
-            return true;
+    /*
+     * Not empty, meanwhile we need a flush.  It can because of either:
+     *
+     * (1) The page is not on the same ramblock of previous ones, or,
+     * (2) The queue is full.
+     *
+     * After flush, always retry.
+     */
+    if (pages->block != block || multifd_queue_full(pages)) {
+        if (!multifd_send_pages()) {
+            return false;
         }
-    } else {
-        changed = true;
-    }
-
-    if (!multifd_send_pages()) {
-        return false;
-    }
-
-    if (changed) {
-        return multifd_queue_page(block, offset);
+        goto retry;
     }
 
+    /* Not empty, and we still have space, do it! */
+    multifd_enqueue(pages, offset);
     return true;
 }
 
-- 
2.43.0


