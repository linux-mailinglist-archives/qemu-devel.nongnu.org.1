Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718787CD8D8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SV-0007Ok-8t; Wed, 18 Oct 2023 06:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SL-0007Lx-GL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SJ-0007iQ-Lg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdPWHupyalxgAoMbT7Alu7oVWzzkw5Fu9OAgcLpjPvo=;
 b=XDlZLL2Rnyv81puOt/7VtAer17wy6pUV4KPuAphmnl7WOtVn0Pjs8GFnfQdH7m35SeA5Qg
 U0rxvTRGhQUTFfQWO3b2g9FLSr9oOQ2xPPHm4HTdbW682F4Y8nTDBmQzXJH02X2/JDW6bk
 bqMIba0+NkERb24VOJAA0TeC1ljbc8g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-vF9hmxvSObiQ8yQn1IF4ug-1; Wed, 18 Oct 2023 06:07:08 -0400
X-MC-Unique: vF9hmxvSObiQ8yQn1IF4ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9504A3C1CC37;
 Wed, 18 Oct 2023 10:07:07 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D7372026D4C;
 Wed, 18 Oct 2023 10:07:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 11/11] migration: save_zero_page() can take block through pss
Date: Wed, 18 Oct 2023 12:06:51 +0200
Message-ID: <20231018100651.32674-12-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7f18c1808d..16c30a9d7a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1144,13 +1144,12 @@ void ram_release_page(const char *rbname, uint64_t offset)
  *
  * @rs: current RAM state
  * @pss: current PSS channel
- * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
+static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
                           ram_addr_t offset)
 {
-    uint8_t *p = block->host + offset;
+    uint8_t *p = pss->block->host + offset;
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
@@ -1158,10 +1157,10 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
         return 0;
     }
 
-    len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
+    len += save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
     qemu_put_byte(file, 0);
     len += 1;
-    ram_release_page(block->idstr, offset);
+    ram_release_page(pss->block->idstr, offset);
 
     stat64_add(&mig_stats.zero_pages, 1);
     ram_transferred_add(len);
@@ -1172,7 +1171,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
      */
     if (rs->xbzrle_started) {
         XBZRLE_cache_lock();
-        xbzrle_cache_zero_page(block->offset + offset);
+        xbzrle_cache_zero_page(pss->block->offset + offset);
         XBZRLE_cache_unlock();
     }
 
@@ -2119,7 +2118,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    if (save_zero_page(rs, pss, block, offset)) {
+    if (save_zero_page(rs, pss, offset)) {
         return 1;
     }
 
-- 
2.41.0


