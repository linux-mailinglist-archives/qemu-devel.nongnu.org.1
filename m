Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE477F6D5
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcTG-0008DI-7s; Thu, 17 Aug 2023 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcT3-0007w2-1R
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcSx-0002dB-0S
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtQKuO2ROUQUxq1WJDoUiPOFKa3sDvvxUxkszlXYLVA=;
 b=RzwzWsNBYjYHG2KjMZlPmxxtn3vn2dUaDtM8y/4dexLpLCe+HQTb+u8EA2LbIqJAX4rWqn
 jzLmIXyxZTak0MLMewV7Pmee795L0C15eb5yD1RIe7lc3sT/C/v6/Wmi/d5tdRLof+/7+C
 EsUMgYXVRy8re6xpe+wNps2Le10B1ng=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-eFQnhH3nMdKshZOxNRXLSA-1; Thu, 17 Aug 2023 08:51:01 -0400
X-MC-Unique: eFQnhH3nMdKshZOxNRXLSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EF8B381BE89;
 Thu, 17 Aug 2023 12:51:00 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73FA61121314;
 Thu, 17 Aug 2023 12:50:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 06/21] block-coroutine-wrapper: Add no_co_wrapper_bdrv_wrlock
 functions
Date: Thu, 17 Aug 2023 14:50:05 +0200
Message-ID: <20230817125020.208339-7-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new wrapper type for GRAPH_WRLOCK functions that should be called
from coroutine context.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h       |  4 ++++
 scripts/block-coroutine-wrapper.py | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index e15395f2cb..267ac6b583 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -66,10 +66,14 @@
  * function. The coroutine yields after scheduling the BH and is reentered when
  * the wrapped function returns.
  *
+ * A no_co_wrapper_bdrv_wrlock function is a no_co_wrapper function that
+ * automatically takes the graph wrlock when calling the wrapped function.
+ *
  * If the first parameter of the function is a BlockDriverState, BdrvChild or
  * BlockBackend pointer, the AioContext lock for it is taken in the wrapper.
  */
 #define no_co_wrapper
+#define no_co_wrapper_bdrv_wrlock
 
 #include "block/blockjob.h"
 
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index d4a183db61..fa01c06567 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -71,10 +71,13 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
         self.args = [ParamDecl(arg.strip()) for arg in args.split(',')]
         self.create_only_co = 'mixed' not in variant
         self.graph_rdlock = 'bdrv_rdlock' in variant
+        self.graph_wrlock = 'bdrv_wrlock' in variant
 
         self.wrapper_type = wrapper_type
 
         if wrapper_type == 'co':
+            if self.graph_wrlock:
+                raise ValueError(f"co function can't be wrlock: {self.name}")
             subsystem, subname = self.name.split('_', 1)
             self.target_name = f'{subsystem}_co_{subname}'
         else:
@@ -250,6 +253,12 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
     name = func.target_name
     struct_name = func.struct_name
 
+    graph_lock=''
+    graph_unlock=''
+    if func.graph_wrlock:
+        graph_lock='    bdrv_graph_wrlock(NULL);'
+        graph_unlock='    bdrv_graph_wrunlock();'
+
     return f"""\
 /*
  * Wrappers for {name}
@@ -266,9 +275,11 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
     {struct_name} *s = opaque;
     AioContext *ctx = {func.gen_ctx('s->')};
 
+{graph_lock}
     aio_context_acquire(ctx);
     {func.get_result}{name}({ func.gen_list('s->{name}') });
     aio_context_release(ctx);
+{graph_unlock}
 
     aio_co_wake(s->co);
 }}
-- 
2.41.0


