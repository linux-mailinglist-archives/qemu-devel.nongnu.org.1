Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E1AC06B9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 10:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI13G-0007WS-Hx; Thu, 22 May 2025 04:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI13B-0007Uq-P6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:14 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI139-0003O7-9h
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 212D1A4E306;
 Thu, 22 May 2025 08:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1892C4CEEA;
 Thu, 22 May 2025 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747901589;
 bh=Q2Jud+Qo/Co5dwsffwNP+2WMO+4kLmz/GnQnSCCeKzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lz6Ipi4ywX0MVtj9h3NvLvHXi+Z4O5dsIlyVa1cM8hCriuWQE+Ftc68DrKNavLTuf
 DgAeVPpyxAvabVw8DxZmMNDO/eU4cV+Ris2DYWXb8qeHSUPdc68CeW4gNd37sVqXtp
 3lpZoNT5o/aW1TYwsxJRzTk5TzCJtGmGAJRgbxNKz0QzFK9E9iQXqurAkHSCl/FL6/
 JY52GFR2Hj16QB1o+Y6H79Q/mQy2dKkwjHwMDb3WFg93bKH9rSnbK/z23+nt7WjW63
 /Be61L1ykWoGiAofm5pvtdF4cxJBBFxiGn5ZhTdC8BAY/DSCDaXJIUfi5vniwkWrs8
 3D9uOIFWrNhow==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 3/3] target/hppa: Fix FPE exceptions
Date: Thu, 22 May 2025 10:12:57 +0200
Message-ID: <20250522081257.3409-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250522081257.3409-1-deller@kernel.org>
References: <20250522081257.3409-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 target/hppa/fpu_helper.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index a62d9d3083..294ce0a970 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -95,7 +95,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
 {
     uint32_t soft_exp = get_float_exception_flags(&env->fp_status);
     uint32_t hard_exp = 0;
-    uint32_t shadow = env->fr0_shadow;
+    uint32_t shadow = env->fr0_shadow & 0x3ffffff;
+    uint32_t fr1 = 0;
 
     if (likely(soft_exp == 0)) {
         env->fr[0] = (uint64_t)shadow << 32;
@@ -108,9 +109,22 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t ra)
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
2.47.0


