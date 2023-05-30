Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA937169C0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IA-0007Lk-SW; Tue, 30 May 2023 12:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HK-0006TO-Rn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HG-0008En-O0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mDLK7mC5NRaUC3H3mY9AU3fBUJ0pXzL7oiwyUyUC9w=;
 b=WkXhR4PgKB75xutyyQUN+7jZAAUxztU6cpF8or0tJ8KIr5M+jXmcjJNadhXuHEz0mAPnbL
 PmJsivgkAIDEkSh76MMUElKBZwIaXClAdTnehj38NRVl+dO69QYUg/XWofGanamE1HIr5l
 uUTIiuEk16JxhjddtzOefy5ID63OH4s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-mmou09xpPc6GQR4B2HKIbg-1; Tue, 30 May 2023 12:32:48 -0400
X-MC-Unique: mmou09xpPc6GQR4B2HKIbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04FBD1C01E98;
 Tue, 30 May 2023 16:32:48 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4F1C15612;
 Tue, 30 May 2023 16:32:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/32] block-coroutine-wrapper: Take AioContext lock in
 no_co_wrappers
Date: Tue, 30 May 2023 18:32:08 +0200
Message-Id: <20230530163239.576632-2-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

All of the functions that currently take a BlockDriverState, BdrvChild
or BlockBackend as their first parameter expect the associated
AioContext to be locked when they are called. In the case of
no_co_wrappers, they are called from bottom halves directly in the main
loop, so no other caller can be expected to take the lock for them. This
can result in assertion failures because a lock that isn't taken is
released in nested event loops.

Looking at the first parameter is already done by co_wrappers to decide
where the coroutine should run, so doing the same in no_co_wrappers is
only consistent. Take the lock in the generated bottom halves to fix the
problem.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-2-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h       |  3 +++
 block/block-backend.c              |  7 ++++++-
 scripts/block-coroutine-wrapper.py | 25 +++++++++++++++----------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 93196229ac..e15395f2cb 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -65,6 +65,9 @@
  * scheduling a BH in the bottom half that runs the respective non-coroutine
  * function. The coroutine yields after scheduling the BH and is reentered when
  * the wrapped function returns.
+ *
+ * If the first parameter of the function is a BlockDriverState, BdrvChild or
+ * BlockBackend pointer, the AioContext lock for it is taken in the wrapper.
  */
 #define no_co_wrapper
 
diff --git a/block/block-backend.c b/block/block-backend.c
index ca537cd0ad..26447664ab 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2394,9 +2394,14 @@ void blk_op_unblock_all(BlockBackend *blk, Error *reason)
 
 AioContext *blk_get_aio_context(BlockBackend *blk)
 {
-    BlockDriverState *bs = blk_bs(blk);
+    BlockDriverState *bs;
     IO_CODE();
 
+    if (!blk) {
+        return qemu_get_aio_context();
+    }
+
+    bs = blk_bs(blk);
     if (bs) {
         AioContext *ctx = bdrv_get_aio_context(blk_bs(blk));
         assert(ctx == blk->ctx);
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index 60e9b3107c..d4a183db61 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -88,16 +88,7 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
                 raise ValueError(f"no_co function can't be rdlock: {self.name}")
             self.target_name = f'{subsystem}_{subname}'
 
-        t = self.args[0].type
-        if t == 'BlockDriverState *':
-            ctx = 'bdrv_get_aio_context(bs)'
-        elif t == 'BdrvChild *':
-            ctx = 'bdrv_get_aio_context(child->bs)'
-        elif t == 'BlockBackend *':
-            ctx = 'blk_get_aio_context(blk)'
-        else:
-            ctx = 'qemu_get_aio_context()'
-        self.ctx = ctx
+        self.ctx = self.gen_ctx()
 
         self.get_result = 's->ret = '
         self.ret = 'return s.ret;'
@@ -109,6 +100,17 @@ def __init__(self, wrapper_type: str, return_type: str, name: str,
             self.co_ret = ''
             self.return_field = ''
 
+    def gen_ctx(self, prefix: str = '') -> str:
+        t = self.args[0].type
+        if t == 'BlockDriverState *':
+            return f'bdrv_get_aio_context({prefix}bs)'
+        elif t == 'BdrvChild *':
+            return f'bdrv_get_aio_context({prefix}child->bs)'
+        elif t == 'BlockBackend *':
+            return f'blk_get_aio_context({prefix}blk)'
+        else:
+            return 'qemu_get_aio_context()'
+
     def gen_list(self, format: str) -> str:
         return ', '.join(format.format_map(arg.__dict__) for arg in self.args)
 
@@ -262,8 +264,11 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
 static void {name}_bh(void *opaque)
 {{
     {struct_name} *s = opaque;
+    AioContext *ctx = {func.gen_ctx('s->')};
 
+    aio_context_acquire(ctx);
     {func.get_result}{name}({ func.gen_list('s->{name}') });
+    aio_context_release(ctx);
 
     aio_co_wake(s->co);
 }}
-- 
2.40.1


