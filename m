Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CE7C7292
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySw-0003fN-AK; Thu, 12 Oct 2023 12:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySr-0003bo-Vf
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000Za-Ka
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdZQvoU71BxqN/jXUFvJWcOtH/L3ZpOToPERbcZ/qbQ=;
 b=U4qrotXkfIsb18PALuvzNSAXx8knmnwvXOi3SydwjXFEmxE2mHgKdJGv1Sp5Q4mNjxhUkn
 uSmynjvFfcijTNg5fMC6V205vOOvhNg6weuXAU+NFVH1SsWtZmiNrBjuNy5T9vfcVBQ0Ia
 7HjSSTrOSpegAIjM2muB1Z4PymkqPPM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-rfgsyL6GM8W5rXBLnTNTpA-1; Thu, 12 Oct 2023 12:22:40 -0400
X-MC-Unique: rfgsyL6GM8W5rXBLnTNTpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 823CE28AC1C9;
 Thu, 12 Oct 2023 16:22:40 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6B0A20296DB;
 Thu, 12 Oct 2023 16:22:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/26] block-coroutine-wrapper: Add no_co_wrapper_bdrv_rdlock
 functions
Date: Thu, 12 Oct 2023 18:22:04 +0200
Message-ID: <20231012162224.240535-7-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a new wrapper type for GRAPH_RDLOCK functions that should be called
from coroutine context.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-3-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h       |  7 +++++--
 scripts/block-coroutine-wrapper.py | 10 +++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 2d2af7230d..d7599564db 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -66,13 +66,16 @@
  * function. The coroutine yields after scheduling the BH and is reentered when
  * the wrapped function returns.
  *
- * A no_co_wrapper_bdrv_wrlock function is a no_co_wrapper function that
- * automatically takes the graph wrlock when calling the wrapped function.
+ * A no_co_wrapper_bdrv_rdlock function is a no_co_wrapper function that
+ * automatically takes the graph rdlock when calling the wrapped function. In
+ * the same way, no_co_wrapper_bdrv_wrlock functions automatically take the
+ * graph wrlock.
  *
  * If the first parameter of the function is a BlockDriverState, BdrvChild or
  * BlockBackend pointer, the AioContext lock for it is taken in the wrapper.
  */
 #define no_co_wrapper
+#define no_co_wrapper_bdrv_rdlock
 #define no_co_wrapper_bdrv_wrlock
 
 #include "block/blockjob.h"
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index 685d0b4ed4..a601c3c672 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -87,8 +87,9 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
                 raise ValueError(f"Invalid no_co function name: {self.name}")
             if not self.create_only_co:
                 raise ValueError(f"no_co function can't be mixed: {self.name}")
-            if self.graph_rdlock:
-                raise ValueError(f"no_co function can't be rdlock: {self.name}")
+            if self.graph_rdlock and self.graph_wrlock:
+                raise ValueError("function can't be both rdlock and wrlock: "
+                                 f"{self.name}")
             self.target_name = f'{subsystem}_{subname}'
 
         self.ctx = self.gen_ctx()
@@ -256,7 +257,10 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
 
     graph_lock=''
     graph_unlock=''
-    if func.graph_wrlock:
+    if func.graph_rdlock:
+        graph_lock='    bdrv_graph_rdlock_main_loop();'
+        graph_unlock='    bdrv_graph_rdunlock_main_loop();'
+    elif func.graph_wrlock:
         graph_lock='    bdrv_graph_wrlock(NULL);'
         graph_unlock='    bdrv_graph_wrunlock();'
 
-- 
2.41.0


