Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B607CBDA9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUg-0007mM-Av; Tue, 17 Oct 2023 04:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUb-0007IR-VF
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUa-0005XD-79
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4rI2YBbNoLDRETHA/IHNLDNm237o+PQkfZNTOumI8Q=;
 b=XW+8ui1f/bEKukXlfALVkxo6aAFL+mjvUrHhMRTx7FeSUtXkG9qZyGeJfVT+Cfn105+CKg
 Qb7OwZBipp0IfUk+y/MZOdMfX7h6XkM+PeGaC2v3Q9bAVlUjLSchOyBzgvT9IR01cnyK0V
 ydiFZoUX84Ji+TIZW2OYvk9JpbpxyDw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ooixA1WaNZSBD-0gdKx5Xw-1; Tue, 17 Oct 2023 04:31:52 -0400
X-MC-Unique: ooixA1WaNZSBD-0gdKx5Xw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6C1B3C1E9DE;
 Tue, 17 Oct 2023 08:31:51 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7581C060AE;
 Tue, 17 Oct 2023 08:31:49 +0000 (UTC)
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
Subject: [PULL 35/38] migration/ram: Merge save_zero_page functions
Date: Tue, 17 Oct 2023 10:30:00 +0200
Message-ID: <20231017083003.15951-36-quintela@redhat.com>
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

We don't need to do this in two pieces. One single function makes it
easier to grasp, specially since it removes the indirection on the
return value handling.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011184604.32364-7-farosas@suse.de>
---
 migration/ram.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 229cad5c74..c844151ee9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1137,32 +1137,6 @@ void ram_release_page(const char *rbname, uint64_t offset)
     ram_discard_range(rbname, offset, TARGET_PAGE_SIZE);
 }
 
-/**
- * save_zero_page_to_file: send the zero page to the file
- *
- * Returns the size of data written to the file, 0 means the page is not
- * a zero page
- *
- * @pss: current PSS channel
- * @block: block that contains the page we want to send
- * @offset: offset inside the block for the page
- */
-static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
-                                  ram_addr_t offset)
-{
-    uint8_t *p = block->host + offset;
-    QEMUFile *file = pss->pss_channel;
-    int len = 0;
-
-    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
-        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
-        qemu_put_byte(file, 0);
-        len += 1;
-        ram_release_page(block->idstr, offset);
-    }
-    return len;
-}
-
 /**
  * save_zero_page: send the zero page to the stream
  *
@@ -1176,12 +1150,19 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
 static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
                           ram_addr_t offset)
 {
-    int len = save_zero_page_to_file(pss, block, offset);
+    uint8_t *p = block->host + offset;
+    QEMUFile *file = pss->pss_channel;
+    int len = 0;
 
-    if (!len) {
-        return -1;
+    if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
+        return 0;
     }
 
+    len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
+    qemu_put_byte(file, 0);
+    len += 1;
+    ram_release_page(block->idstr, offset);
+
     stat64_add(&mig_stats.zero_pages, 1);
     ram_transferred_add(len);
 
@@ -1195,7 +1176,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
         XBZRLE_cache_unlock();
     }
 
-    return 1;
+    return len;
 }
 
 /*
@@ -2152,9 +2133,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
-    res = save_zero_page(rs, pss, block, offset);
-    if (res > 0) {
-        return res;
+    if (save_zero_page(rs, pss, block, offset)) {
+        return 1;
     }
 
     /*
-- 
2.41.0


