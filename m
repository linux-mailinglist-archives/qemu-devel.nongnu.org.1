Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929027CBDD4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUp-00083T-Am; Tue, 17 Oct 2023 04:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUe-0007iX-Tj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUd-0005Xq-9i
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pz6NvAlGZ381RFyPcRI1ZC88cLxxXxRlnofiW9awMeo=;
 b=BibrZQt0x8FArf55rFgIn3ZejKVQ8XtchjzCpKMTvVxLHAOom9hF2w0ns+CGN3PnuHTfNr
 7f5vAv55VSAnwawW9VzfpQyoViLHi82k1M8atsvX45kYYVxD7NvPkBWgGNqxuZv8hKbpz4
 xV426ZkhaUZFNIC29N0d6UA9whfgtws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-kjdoacXJMyaTP30oECdW_Q-1; Tue, 17 Oct 2023 04:31:49 -0400
X-MC-Unique: kjdoacXJMyaTP30oECdW_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B79C805B31;
 Tue, 17 Oct 2023 08:31:49 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5531C060AE;
 Tue, 17 Oct 2023 08:31:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 34/38] migration/ram: Move xbzrle zero page handling into
 save_zero_page
Date: Tue, 17 Oct 2023 10:29:59 +0200
Message-ID: <20231017083003.15951-35-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

From: Fabiano Rosas <farosas@suse.de>

It makes a bit more sense to have the zero page handling of xbzrle
right where we save the zero page.

Also invert the exit condition to remove one level of indentation
which makes the next patch easier to grasp.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011184604.32364-6-farosas@suse.de>
---
 migration/ram.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2ec28c4507..229cad5c74 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1168,21 +1168,34 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
  *
  * Returns the number of pages written.
  *
+ * @rs: current RAM state
  * @pss: current PSS channel
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page(PageSearchStatus *pss, RAMBlock *block,
+static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
                           ram_addr_t offset)
 {
     int len = save_zero_page_to_file(pss, block, offset);
 
-    if (len) {
-        stat64_add(&mig_stats.zero_pages, 1);
-        ram_transferred_add(len);
-        return 1;
+    if (!len) {
+        return -1;
     }
-    return -1;
+
+    stat64_add(&mig_stats.zero_pages, 1);
+    ram_transferred_add(len);
+
+    /*
+     * Must let xbzrle know, otherwise a previous (now 0'd) cached
+     * page would be stale.
+     */
+    if (rs->xbzrle_started) {
+        XBZRLE_cache_lock();
+        xbzrle_cache_zero_page(block->offset + offset);
+        XBZRLE_cache_unlock();
+    }
+
+    return 1;
 }
 
 /*
@@ -2139,16 +2152,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    res = save_zero_page(pss, block, offset);
+    res = save_zero_page(rs, pss, block, offset);
     if (res > 0) {
-        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
-         * page would be stale
-         */
-        if (rs->xbzrle_started) {
-            XBZRLE_cache_lock();
-            xbzrle_cache_zero_page(block->offset + offset);
-            XBZRLE_cache_unlock();
-        }
         return res;
     }
 
-- 
2.41.0


