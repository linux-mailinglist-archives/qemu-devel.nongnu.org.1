Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B872E66D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 16:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TY-0006Fi-Px; Tue, 13 Jun 2023 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TU-0006Cm-37
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TS-0007aW-Ok
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pvo7dw/k63TnR6NweiqCcskG3T/Fy7l5tP+kzkTWyjw=;
 b=C+rRINaWNICF+3sDcIM7Tq/cZift0XOyrJBxc6cJeiIckTm5mlqHti7yyHdh4GTVU5E7B8
 Gi7frcRJjSbwrH96kvI7t7TtKFNxFX+60addhAWwHab6nQoBdVOYzque65IOJpewFwN91b
 Xi81uaFM6+zX+vZ4+fkXtqiABIZmgJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-58XYXCRMPHiuOtjwE-yc1Q-1; Tue, 13 Jun 2023 10:58:18 -0400
X-MC-Unique: 58XYXCRMPHiuOtjwE-yc1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25C29185A795;
 Tue, 13 Jun 2023 14:58:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38DCD40C6F5C;
 Tue, 13 Jun 2023 14:58:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 15/18] migration: save_compress_page() can take block through
 pss
Date: Tue, 13 Jun 2023 16:57:54 +0200
Message-Id: <20230613145757.10131-16-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1bd586c23a..e3ff98a6ce 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1986,7 +1986,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
  * paths to handle it
  */
 static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
-                               RAMBlock *block, ram_addr_t offset)
+                               ram_addr_t offset)
 {
     if (!migrate_compress()) {
         return false;
@@ -2002,12 +2002,13 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
      * We post the fist page as normal page as compression will take
      * much CPU resource.
      */
-    if (block != pss->last_sent_block) {
+    if (pss->block != pss->last_sent_block) {
         ram_flush_compressed_data();
         return false;
     }
 
-    return compress_page_with_multi_thread(block, offset, send_queued_data);
+    return compress_page_with_multi_thread(pss->block, offset,
+                                           send_queued_data);
 }
 
 /**
@@ -2028,7 +2029,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return res;
     }
 
-    if (save_compress_page(rs, pss, block, offset)) {
+    if (save_compress_page(rs, pss, offset)) {
         return 1;
     }
 
-- 
2.40.1


