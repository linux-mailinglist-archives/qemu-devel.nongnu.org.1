Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBBB79A6EC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVI-0005om-0H; Mon, 11 Sep 2023 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVF-0005nQ-MM
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVD-0004fM-Af
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BoQknEwn9ecSi4i/cwW0yXzUzs5yMqBXtZKUV3kqNso=;
 b=hsX3615Q+Yikjj/dG3Hj2qxj5yNsYilNQSiDpQjTe7Ww1nI9s5eLLKZkBO3d3muNnW2Bp5
 PoYQej1W7YEnQK54Pn8mViDoebC9RnMtXc2jPD/yFcEuD0k7IxKlyybHbRuoxNRz3QPcqM
 PnO7Q1c+iGqJLcYbQdH+GXt0xpNHW9Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-sMVvcYHXPNm1Zcs2LUddTg-1; Mon, 11 Sep 2023 05:46:41 -0400
X-MC-Unique: sMVvcYHXPNm1Zcs2LUddTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 973D029ABA11;
 Mon, 11 Sep 2023 09:46:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68A2440C6EBF;
 Mon, 11 Sep 2023 09:46:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 06/21] block-coroutine-wrapper: Add
 no_co_wrapper_bdrv_wrlock functions
Date: Mon, 11 Sep 2023 11:46:05 +0200
Message-ID: <20230911094620.45040-7-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Add a new wrapper type for GRAPH_WRLOCK functions that should be called
from coroutine context.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block-common.h       |  4 ++++
 scripts/block-coroutine-wrapper.py | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index df5ffc8d09..3bbc5d9294 100644
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


