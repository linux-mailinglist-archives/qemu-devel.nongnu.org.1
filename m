Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD9AC3391
	for <lists+qemu-devel@lfdr.de>; Sun, 25 May 2025 11:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7uh-0001yX-EQ; Sun, 25 May 2025 05:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7ub-0001d6-7e; Sun, 25 May 2025 05:44:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7uZ-0004pI-KX; Sun, 25 May 2025 05:44:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11F3D124DF0;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC65E215F18;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 62/62] target/hppa: Fix FPE exceptions
Date: Sun, 25 May 2025 12:42:45 +0300
Message-Id: <20250525094246.174612-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Helge Deller <deller@gmx.de>

Implement FP exception register #1 (lower 32-bits of 64-bit fr[0]).
A proper implementation is necessary to allow the Linux kernel in
system mode and the qemu linux-user to send proper si_code values
on SIGFPE signal.

Always set the T-bit on taken exception, and merge over- and underflow
in system mode to just set overflow bit to mimic the behaviour I tested
on a physical machine.

The test program below can be used to verify correct behaviour. Note
that behaviour on SIGFPE may vary on different platforms. The program
should always detect the correct signal, but it may or may not be able
to sucessfully continue afterwards.

 #define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <fenv.h>
 #include <float.h>

 static void fpe_func(int sig, siginfo_t *i, void *v) {
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SIGFPE);
    sigprocmask(SIG_UNBLOCK, &set, NULL);
    printf("GOT signal %d with si_code %ld\n", sig, i->si_code);
 }

 int main(int argc, char *argv[]) {
    struct sigaction action = {
        .sa_sigaction = fpe_func,
        .sa_flags = SA_RESTART|SA_SIGINFO };
    sigaction(SIGFPE, &action, 0);
    feenableexcept(FE_OVERFLOW | FE_UNDERFLOW);
    double x = DBL_MIN;
    return printf("%lf\n", argc > 1
        ? 1.7976931348623158E308*1.7976931348623158E308
        : x / 10);
 }

Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit ebd394948de4e868cb8fc5b265a8a18f0935dce1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 0e44074ba8..ff3008a542 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -71,7 +71,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
 {
     uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
     uint32_t hard_exp = 0;
-    uint32_t shadow = env->fr0_shadow;
+    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
+    uint32_t fr1 = 0;
 
     if (likely(soft_exp == 0)) {
         env->fr[0] = (uint64_t)shadow << 32;
@@ -84,9 +85,22 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
     hard_exp |= CONVERT_BIT(soft_exp, float_flag_overflow,  R_FPSR_ENA_O_MASK);
     hard_exp |= CONVERT_BIT(soft_exp, float_flag_divbyzero, R_FPSR_ENA_Z_MASK);
     hard_exp |= CONVERT_BIT(soft_exp, float_flag_invalid,   R_FPSR_ENA_V_MASK);
-    shadow |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
+    if (hard_exp & shadow) {
+        shadow = FIELD_DP32(shadow, FPSR, T, 1);
+        /* fill exception register #1, which is lower 32-bits of fr[0] */
+#if !defined(CONFIG_USER_ONLY)
+        if (hard_exp & (R_FPSR_ENA_O_MASK | R_FPSR_ENA_U_MASK)) {
+            /* over- and underflow both set overflow flag only */
+            fr1 = FIELD_DP32(fr1, FPSR, C, 1);
+            fr1 = FIELD_DP32(fr1, FPSR, FLG_O, 1);
+        } else
+#endif
+        {
+            fr1 |= hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
+        }
+    }
     env->fr0_shadow = shadow;
-    env->fr[0] = (uint64_t)shadow << 32;
+    env->fr[0] = (uint64_t)shadow << 32 | fr1;
 
     if (hard_exp & shadow) {
         hppa_dynamic_excp(env, EXCP_ASSIST, ra);
-- 
2.39.5


