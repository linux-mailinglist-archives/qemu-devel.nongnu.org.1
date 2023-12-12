Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957BE80EBA7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:24:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1ix-00056X-SX; Tue, 12 Dec 2023 07:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1ir-00055Y-69; Tue, 12 Dec 2023 07:18:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1im-0000Ay-1k; Tue, 12 Dec 2023 07:18:48 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9EAB3AEF4;
 Tue, 12 Dec 2023 15:18:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8F7983B942;
 Tue, 12 Dec 2023 15:18:31 +0300 (MSK)
Received: (nullmailer pid 1003401 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 01/31] linux-user: xtensa: fix signal delivery in FDPIC
Date: Tue, 12 Dec 2023 15:17:49 +0300
Message-Id: <20231212121831.1003318-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Max Filippov <jcmvbkbc@gmail.com>

In FDPIC signal handlers are passed around as FD pointers. Actual code
address and GOT pointer must be fetched from memory by the QEMU code
that implements kernel signal delivery functionality. This change is
equivalent to the following kernel change:
9c2cc74fb31e ("xtensa: fix signal delivery to FDPIC process")

Cc: qemu-stable@nongnu.org
Fixes: d2796be69d7c ("linux-user: add support for xtensa FDPIC")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit 1b173d06068c4a4e93fad88205399232925967a4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index f5fb8b5cbe..32dcfa5229 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -157,6 +157,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 {
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
+    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
+    abi_ulong handler = 0;
+    abi_ulong handler_fdpic_GOT = 0;
     uint32_t ra;
     bool abi_call0;
     unsigned base;
@@ -165,6 +168,17 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     frame_addr = get_sigframe(ka, env, sizeof(*frame));
     trace_user_setup_rt_frame(env, frame_addr);
 
+    if (is_fdpic) {
+        abi_ulong funcdesc_ptr = ka->_sa_handler;
+
+        if (get_user_ual(handler, funcdesc_ptr)
+            || get_user_ual(handler_fdpic_GOT, funcdesc_ptr + 4)) {
+            goto give_sigsegv;
+        }
+    } else {
+        handler = ka->_sa_handler;
+    }
+
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -185,14 +199,21 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
-        ra = ka->sa_restorer;
+        if (is_fdpic) {
+            if (get_user_ual(ra, ka->sa_restorer)) {
+                unlock_user_struct(frame, frame_addr, 0);
+                goto give_sigsegv;
+            }
+        } else {
+            ra = ka->sa_restorer;
+        }
     } else {
         /* Not used, but retain for ABI compatibility. */
         install_sigtramp(frame->retcode);
         ra = default_rt_sigreturn;
     }
     memset(env->regs, 0, sizeof(env->regs));
-    env->pc = ka->_sa_handler;
+    env->pc = handler;
     env->regs[1] = frame_addr;
     env->sregs[WINDOW_BASE] = 0;
     env->sregs[WINDOW_START] = 1;
@@ -212,6 +233,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->regs[base + 3] = frame_addr + offsetof(struct target_rt_sigframe,
                                                 info);
     env->regs[base + 4] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    if (is_fdpic) {
+        env->regs[base + 11] = handler_fdpic_GOT;
+    }
     unlock_user_struct(frame, frame_addr, 1);
     return;
 
-- 
2.39.2


