Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E2830058
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:07:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ00C-0003Dc-1r; Wed, 17 Jan 2024 02:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ004-00039x-Na
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:06:14 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ002-0002US-B6
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:06:12 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bd6581bca0so2453866b6e.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705475168; x=1706079968;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4+R5N8u1e+xuE3UyJyVp4GWaI8hO4+G4jy5o+9g1cXk=;
 b=jR/Hxqk9IxRkoHYltp9J37b9FJvWh4UYRXk7LySwOCdvdeQgE5RDbnsf3ABTaUg666
 meEqFz70j6OMLItYi3mm+oqdkfI0RlFcpDFjNKnmUL/hBkETsttis/dsiCNQEzInxV6B
 1MPqvSzJc/tUHny65J8a+/noCg2STEXK5T6cv+v5bnzu32O79U0YsPy8YcP+xuQH/Zd+
 KqMpWwAJNo6N4NyQRnqWk3yNM9NpMx4a2n5TowqwkbuhU2pjINA1UpiI8jkpghhM5pWk
 PzWntJhDnNihj4GZMUys5p/nEWMYkps+hkxk8DWiRt9pQDB06/O8AYJoVSroZfjRz0Z7
 yifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705475168; x=1706079968;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+R5N8u1e+xuE3UyJyVp4GWaI8hO4+G4jy5o+9g1cXk=;
 b=J1sQ8MPaRZOm7yMPCyymUk9iwKBy84Q61zkRHZEkxTGEgbqzRD9Fxd9r9rgxcItrrn
 RmJGKrBV7Hbad8ofQzEe+hUbiDOPaZBYItMrqDqGDXxsFF7Ee/9jjy8B+X6daOvZD0ED
 Fj1bdPuTnqJlO5mmKQhf5N/TAIb4igL6fXbWWxoMGYsidgzq6KtiOkLK+h925v4eArsO
 VT2yY92KHUeNtAWAXJ0YfOL4kle+AEs/uLJcFhlT/vkIL72bLXIqpgMfy7wdb5D+nlFk
 dQTPzFEO1QZx5L0NEEoU1odLQfn0SSqGOeGrKQScQWGaJHl9Kt16pdLcNvQPgBWOxjX0
 xWDg==
X-Gm-Message-State: AOJu0Yy7WYw1pa6X3cLm2SfDv6hZ8IBtmJiEYKcaU44PMrdzRQtiZCMX
 BK9XYUZ2DUnOW8g/eTyFCLqcxRtEr35QSA==
X-Google-Smtp-Source: AGHT+IELSM/+TBXzqcpDrRE3tL9v7Brct3zQFKxeRMPqZd3xhSgR7iQXnDlVkbm9CMjURg1GYzNZxg==
X-Received: by 2002:a05:6808:17a2:b0:3bd:5782:f9a3 with SMTP id
 bg34-20020a05680817a200b003bd5782f9a3mr10931240oib.76.1705475167946; 
 Tue, 16 Jan 2024 23:06:07 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 bn21-20020a056a00325500b006d99056c4edsm688584pfb.187.2024.01.16.23.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 23:06:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 17 Jan 2024 16:06:02 +0900
Subject: [PATCH v2] coroutine-ucontext: Save fake stack for pooled
 coroutine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-asan-v2-1-26f9e1ea6e72@daynix.com>
X-B4-Tracking: v=1; b=H4sIAFl8p2UC/13MQQ7CIBCF4as0sxYzQK2pq97DdIEw2FkIBgxp0
 3B3sUuX/8vLt0OmxJTh1u2QqHDmGFqoUwd2MeFJgl1rUKh6lFIJk00Q9BjGi70Oo+8R2vWdyPN
 6MPe59cL5E9N2qEX+1j+gSCEFaY0eHaJWdnJmC7yebXzBXGv9AryreeSZAAAA
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, 
 Lingfeng Yang <lfy@google.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Coroutine may be pooled even after COROUTINE_TERMINATE if
CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
I'm seeing stack corruption without fake stack being saved.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added missing set_current() (Marc-André Lureau)
- Added G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN)) (Marc-André Lureau)
- Renamed terminate() to terminate_asan() for clarity and consistency.
- Changed terminate_asan() to call start_switch_fiber_asan() for
  consistency.
- Link to v1: https://lore.kernel.org/r/20240112-asan-v1-1-e330f0d0032c@daynix.com
---
 util/coroutine-ucontext.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 7b304c79d942..8ef603d081ea 100644
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

---
base-commit: f614acb7450282a119d85d759f27eae190476058
change-id: 20240112-asan-eb695c769f40

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


