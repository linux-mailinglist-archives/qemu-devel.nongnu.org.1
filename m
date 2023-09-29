Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5567B3626
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEr0-0005bo-4Q; Fri, 29 Sep 2023 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqw-0005aw-TT
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqk-0004ci-Ap
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0h8u/3hjCF3QKFDOLTYL3ZrOBPUILZk0ei4CPLVAjo=;
 b=atmvD1OCVse0ZXO25QDsbj1dZXgmXubHV4qwdxT0mhTN293I/gN28vORsBo3pvR7g5kRlq
 SrwrIRUwf2hZ+d/xNwPaEXlwdV2CtKlaQWM6fNJ+8vIUu75d8hfZwSaLnKGH+KjD+9Fp95
 asXmqwttpTJ3aHlFR/fSuMNo2dQaNH0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-tGMW8w8kNkq8LoNpG9ROsA-1; Fri, 29 Sep 2023 10:52:06 -0400
X-MC-Unique: tGMW8w8kNkq8LoNpG9ROsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 803B438041E4;
 Fri, 29 Sep 2023 14:52:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50AF32026D4B;
 Fri, 29 Sep 2023 14:52:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 02/22] block-coroutine-wrapper: Add no_co_wrapper_bdrv_rdlock
 functions
Date: Fri, 29 Sep 2023 16:51:37 +0200
Message-ID: <20230929145157.45443-3-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


