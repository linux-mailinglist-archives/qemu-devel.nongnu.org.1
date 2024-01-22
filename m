Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB983697A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:02:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwk8-0001WS-Dl; Mon, 22 Jan 2024 11:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRwk3-0001VL-Gh
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rRwjz-0004Be-Rq
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705939298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDh4WEZ0dC0KA7h7CB4VSOE3odtiVN+rZQUHsVMmrsw=;
 b=eKQqM5mM2gCVlr66KYflyHu2rJ8AROUy9Pa01l0RsdLIKLw9xbQHzgf2v7dUGZQjt5Fpfn
 17zCY/h5fjqz8ZKI6TZWHYm7iGaBi2ClBvUoJMrnJ9AsLc3n/CkM5C5dyO6SOcZo80Fwik
 9a/xF/yZx+lDOQ3PWhwvFoHcS7yukuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-uDOXSj8DPouX5_Owq2OJVg-1; Mon, 22 Jan 2024 11:01:35 -0500
X-MC-Unique: uDOXSj8DPouX5_Owq2OJVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A08978F9202;
 Mon, 22 Jan 2024 16:01:31 +0000 (UTC)
Received: from localhost (unknown [10.39.194.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3BD52026F95;
 Mon, 22 Jan 2024 16:01:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/2] coroutine-ucontext: Save fake stack for pooled coroutine
Date: Mon, 22 Jan 2024 11:01:25 -0500
Message-ID: <20240122160126.394141-2-stefanha@redhat.com>
In-Reply-To: <20240122160126.394141-1-stefanha@redhat.com>
References: <20240122160126.394141-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Coroutine may be pooled even after COROUTINE_TERMINATE if
CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
I'm seeing stack corruption without fake stack being saved.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240117-asan-v2-1-26f9e1ea6e72@daynix.com>
---
 util/coroutine-ucontext.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 7b304c79d9..8ef603d081 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -119,13 +119,11 @@ void finish_switch_fiber(void *fake_stack_save)
 
 /* always_inline is required to avoid TSan runtime fatal errors. */
 static inline __attribute__((always_inline))
-void start_switch_fiber_asan(CoroutineAction action, void **fake_stack_save,
+void start_switch_fiber_asan(void **fake_stack_save,
                              const void *bottom, size_t size)
 {
 #ifdef CONFIG_ASAN
-    __sanitizer_start_switch_fiber(
-            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
-            bottom, size);
+    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
 #endif
 }
 
@@ -165,7 +163,7 @@ static void coroutine_trampoline(int i0, int i1)
     if (!sigsetjmp(self->env, 0)) {
         CoroutineUContext *leaderp = get_ptr_leader();
 
-        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save,
+        start_switch_fiber_asan(&fake_stack_save,
                                 leaderp->stack, leaderp->stack_size);
         start_switch_fiber_tsan(&fake_stack_save, self, true); /* true=caller */
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
@@ -226,8 +224,7 @@ Coroutine *qemu_coroutine_new(void)
 
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
-        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save, co->stack,
-                                co->stack_size);
+        start_switch_fiber_asan(&fake_stack_save, co->stack, co->stack_size);
         start_switch_fiber_tsan(&fake_stack_save,
                                 co, false); /* false=not caller */
 
@@ -269,10 +266,28 @@ static inline void valgrind_stack_deregister(CoroutineUContext *co)
 #endif
 #endif
 
+#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
+static void coroutine_fn terminate_asan(void *opaque)
+{
+    CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, opaque);
+
+    set_current(opaque);
+    start_switch_fiber_asan(NULL, to->stack, to->stack_size);
+    G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN));
+    siglongjmp(to->env, COROUTINE_ENTER);
+}
+#endif
+
 void qemu_coroutine_delete(Coroutine *co_)
 {
     CoroutineUContext *co = DO_UPCAST(CoroutineUContext, base, co_);
 
+#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
+    co_->entry_arg = qemu_coroutine_self();
+    co_->entry = terminate_asan;
+    qemu_coroutine_switch(co_->entry_arg, co_, COROUTINE_ENTER);
+#endif
+
 #ifdef CONFIG_VALGRIND_H
     valgrind_stack_deregister(co);
 #endif
@@ -305,8 +320,10 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
-        start_switch_fiber_asan(action, &fake_stack_save, to->stack,
-                                to->stack_size);
+        start_switch_fiber_asan(IS_ENABLED(CONFIG_COROUTINE_POOL) ||
+                                action != COROUTINE_TERMINATE ?
+                                    &fake_stack_save : NULL,
+                                to->stack, to->stack_size);
         start_switch_fiber_tsan(&fake_stack_save,
                                 to, false); /* false=not caller */
         siglongjmp(to->env, action);
-- 
2.43.0


