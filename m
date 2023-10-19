Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344F7CF643
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQse-0001t2-8y; Thu, 19 Oct 2023 07:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsV-0001Z7-HM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQsQ-0000ey-DW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697713659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLlIdJkdIqQe1aXcLmosz1ae+dtpSUozbxpric+R6yo=;
 b=JHeLOKf2UEYP4XkXUq+E3C2pXifowsrH4ynAYWrZDFrdB8uPLiA7lYvTyDw0dvSNcNVheq
 ABOIn2n9/7LUaN+lEYP5b5VJBC2WR44+D3YjzcRRLKajroqtbf79ysLFpA0SdqZBzpKM0g
 dZ6fxvJClG0+ux9ycLn9TReZpvrw9GE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-67rZLPJFOmKKhW9lli-KNQ-1; Thu, 19 Oct 2023 07:07:35 -0400
X-MC-Unique: 67rZLPJFOmKKhW9lli-KNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C71A4857A91;
 Thu, 19 Oct 2023 11:07:34 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45AD25C8;
 Thu, 19 Oct 2023 11:07:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v2 06/11] migration: Move busy++ to migrate_with_multithread
Date: Thu, 19 Oct 2023 13:07:19 +0200
Message-ID: <20231019110724.15324-7-quintela@redhat.com>
In-Reply-To: <20231019110724.15324-1-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

And now we can simplify save_compress_page().

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.c | 1 +
 migration/ram.c          | 8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index a991b15b7a..f56e1f8e69 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -291,6 +291,7 @@ bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
         }
         if (!wait) {
             qemu_mutex_unlock(&comp_done_lock);
+            compression_counters.busy++;
             return false;
         }
         /*
diff --git a/migration/ram.c b/migration/ram.c
index de7878c46e..a3c5fcc549 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2067,12 +2067,8 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
         return false;
     }
 
-    if (compress_page_with_multi_thread(pss->block, offset, send_queued_data)) {
-        return true;
-    }
-
-    compression_counters.busy++;
-    return false;
+    return compress_page_with_multi_thread(pss->block, offset,
+                                           send_queued_data);
 }
 
 /**
-- 
2.41.0


