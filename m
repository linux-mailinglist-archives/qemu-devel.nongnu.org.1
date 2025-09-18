Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D05B3883A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 19:07:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJaz-0006qp-6q; Wed, 27 Aug 2025 13:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJa3-0006KN-5X; Wed, 27 Aug 2025 13:05:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZs-0007jY-NM; Wed, 27 Aug 2025 13:05:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A5A1D14C72C;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B543E2698F2;
 Wed, 27 Aug 2025 20:03:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 10/18] linux-user/aarch64: Support TPIDR2_MAGIC signal
 frame record
Date: Wed, 27 Aug 2025 20:03:45 +0300
Message-ID: <20250827170356.2698446-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

FEAT_SME adds the TPIDR2 userspace-accessible system register, which
is used as part of the procedure calling standard's lazy saving
scheme for the ZA registers:
 https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving-scheme

The Linux kernel has a signal frame record for saving
and restoring this value when calling signal handlers, but
we forgot to implement this. The result is that code which
tries to unwind an exception out of a signal handler will
not work correctly.

Add support for the missing record.

Cc: qemu-stable@nongnu.org
Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250725175510.3864231-3-peter.maydell@linaro.org>
(cherry picked from commit 99870aff907b1c863cd32558b543f0ab0d0e74ba)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b265cfd470..17865356d8 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -120,6 +120,13 @@ struct target_za_context {
 #define TARGET_ZA_SIG_CONTEXT_SIZE(VQ) \
     TARGET_ZA_SIG_ZAV_OFFSET(VQ, VQ * TARGET_SVE_VQ_BYTES)
 
+#define TARGET_TPIDR2_MAGIC 0x54504902
+
+struct target_tpidr2_context {
+    struct target_aarch64_ctx head;
+    uint64_t tpidr2;
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -252,6 +259,14 @@ static void target_setup_za_record(struct target_za_context *za,
     }
 }
 
+static void target_setup_tpidr2_record(struct target_tpidr2_context *tpidr2,
+                                       CPUARMState *env)
+{
+    __put_user(TARGET_TPIDR2_MAGIC, &tpidr2->head.magic);
+    __put_user(sizeof(struct target_tpidr2_context), &tpidr2->head.size);
+    __put_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -402,6 +417,12 @@ static bool target_restore_za_record(CPUARMState *env,
     return true;
 }
 
+static void target_restore_tpidr2_record(CPUARMState *env,
+                                         struct target_tpidr2_context *tpidr2)
+{
+    __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -409,6 +430,7 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_fpsimd_context *fpsimd = NULL;
     struct target_sve_context *sve = NULL;
     struct target_za_context *za = NULL;
+    struct target_tpidr2_context *tpidr2 = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     int sve_size = 0;
@@ -459,6 +481,14 @@ static int target_restore_sigframe(CPUARMState *env,
             za_size = size;
             break;
 
+        case TARGET_TPIDR2_MAGIC:
+            if (tpidr2 || size != sizeof(struct target_tpidr2_context) ||
+                !cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+                goto err;
+            }
+            tpidr2 = (struct target_tpidr2_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -496,6 +526,9 @@ static int target_restore_sigframe(CPUARMState *env,
     if (za && !target_restore_za_record(env, za, za_size, &svcr)) {
         goto err;
     }
+    if (tpidr2) {
+        target_restore_tpidr2_record(env, tpidr2);
+    }
     if (env->svcr != svcr) {
         env->svcr = svcr;
         arm_rebuild_hflags(env);
@@ -567,8 +600,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         .total_size = offsetof(struct target_rt_sigframe,
                                uc.tuc_mcontext.__reserved),
     };
-    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0;
-    int sve_size = 0, za_size = 0;
+    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
+    int sve_size = 0, za_size = 0, tpidr2_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -584,6 +617,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         sve_ofs = alloc_sigframe_space(sve_size, &layout);
     }
     if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
+        tpidr2_size = sizeof(struct target_tpidr2_context);
+        tpidr2_ofs = alloc_sigframe_space(tpidr2_size, &layout);
         /* ZA state needs saving only if it is enabled.  */
         if (FIELD_EX64(env->svcr, SVCR, ZA)) {
             za_size = TARGET_ZA_SIG_CONTEXT_SIZE(sme_vq(env));
@@ -643,6 +678,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     if (za_ofs) {
         target_setup_za_record((void *)frame + za_ofs, env, za_size);
     }
+    if (tpidr2_ofs) {
+        target_setup_tpidr2_record((void *)frame + tpidr2_ofs, env);
+    }
 
     /* Set up the stack frame for unwinding.  */
     fr = (void *)frame + fr_ofs;
-- 
2.47.2


