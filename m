Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B357572E692
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TY-0006F8-KC; Tue, 13 Jun 2023 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TV-0006EE-Md
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TU-0007af-7y
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5YGCGVQz6G3iR3YABDPJqBvknSAWfsEV8CrTrsPdWM=;
 b=HvZv+0kiv8jTIhfmzUjSemS+Az4SxB34zLrV0KxAoOX+8UmYvpRWZJevfrEfpz123p2KBz
 r2s4tlveR7ffDYpMzH9/LT0qQtTdQCbzc7p7LGwdAG78Zd8rqPdBgehj8Pom13x4dOqvyi
 D4vjf/ov8upeNIvrTKMMr5SCpLsnQdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-xluXWPzYPVWmN0fDp31E_w-1; Tue, 13 Jun 2023 10:58:21 -0400
X-MC-Unique: xluXWPzYPVWmN0fDp31E_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B837101A53B;
 Tue, 13 Jun 2023 14:58:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C69440C6F5C;
 Tue, 13 Jun 2023 14:58:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 17/18] migration: Remove not needed block parameter for
 save_zero_page*
Date: Tue, 13 Jun 2023 16:57:56 +0200
Message-Id: <20230613145757.10131-18-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 293ea87a70..0259c33da7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1067,20 +1067,20 @@ void ram_release_page(const char *rbname, uint64_t offset)
  * a zero page
  *
  * @pss: current PSS channel
- * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
 static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
-                                  RAMBlock *block, ram_addr_t offset)
+                                  ram_addr_t offset)
 {
-    uint8_t *p = block->host + offset;
+    uint8_t *p = pss->block->host + offset;
     int len = 0;
 
     if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
-        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
+        len += save_page_header(pss, file, pss->block,
+                                offset | RAM_SAVE_FLAG_ZERO);
         qemu_put_byte(file, 0);
         len += 1;
-        ram_release_page(block->idstr, offset);
+        ram_release_page(pss->block->idstr, offset);
     }
     return len;
 }
@@ -1091,13 +1091,11 @@ static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
  * Returns the number of pages written.
  *
  * @pss: current PSS channel
- * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
-                          ram_addr_t offset)
+static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, ram_addr_t offset)
 {
-    int len = save_zero_page_to_file(pss, f, block, offset);
+    int len = save_zero_page_to_file(pss, f, offset);
 
     if (len) {
         stat64_add(&mig_stats.zero_pages, 1);
@@ -2033,7 +2031,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    res = save_zero_page(pss, pss->pss_channel, block, offset);
+    res = save_zero_page(pss, pss->pss_channel, offset);
     if (res > 0) {
         /* Must let xbzrle know, otherwise a previous (now 0'd) cached
          * page would be stale
-- 
2.40.1


