Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7973E1CD
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmzr-0004Nm-4o; Mon, 26 Jun 2023 10:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qDmzk-0004NB-8J
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:15:08 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qDmzi-0002pn-0Y
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:15:07 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 0EA7F11EF84;
 Mon, 26 Jun 2023 14:15:04 +0000 (UTC)
From: ~jhogberg <jhogberg@git.sr.ht>
Date: Thu, 08 Jun 2023 19:49:15 +0200
Subject: [PATCH qemu v4 1/2] target/arm: Handle IC IVAU to improve
 compatibility with JITs
MIME-Version: 1.0
Message-ID: <168778890374.24232.3402138851538068785-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168778890374.24232.3402138851538068785-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~jhogberg <john.hogberg@ericsson.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: John H=C3=B6gberg <john.hogberg@ericsson.com>

Unlike architectures with precise self-modifying code semantics
(e.g. x86) ARM processors do not maintain coherency for instruction
execution and memory, requiring an instruction synchronization
barrier on every core that will execute the new code, and on many
models also the explicit use of cache management instructions.

While this is required to make JITs work on actual hardware, QEMU
has gotten away with not handling this since it does not emulate
caches, and unconditionally invalidates code whenever the softmmu
or the user-mode page protection logic detects that code has been
modified.

Unfortunately the latter does not work in the face of dual-mapped
code (a common W^X workaround), where one page is executable and
the other is writable: user-mode has no way to connect one with the
other as that is only known to the kernel and the emulated
application.

This commit works around the issue by telling software that
instruction cache invalidation is required by clearing the
CPR_EL0.DIC flag (regardless of whether the emulated processor
needs it), and then invalidating code in IC IVAU instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1034

Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: John H=C3=B6gberg <john.hogberg@ericsson.com>
---
 target/arm/cpu.c    | 13 +++++++++++++
 target/arm/helper.c | 47 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4d5bb57f07..b82fb46157 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1674,6 +1674,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error =
**errp)
         return;
     }
=20
+    /*
+     * User mode relies on IC IVAU instructions to catch modification of
+     * dual-mapped code.
+     *
+     * Clear CTR_EL0.DIC to ensure that software that honors these flags uses
+     * IC IVAU even if the emulated processor does not normally require it.
+     */
+#ifdef CONFIG_USER_ONLY
+    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        cpu->ctr =3D FIELD_DP64(cpu->ctr, CTR_EL0, DIC, 0);
+    }
+#endif
+
     if (!cpu->has_vfp) {
         uint64_t t;
         uint32_t u;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4bee43bd0..235e3cd0b6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5228,6 +5228,36 @@ static void mdcr_el2_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
     }
 }
=20
+#ifdef CONFIG_USER_ONLY
+/*
+ * `IC IVAU` is handled to improve compatibility with JITs that dual-map the=
ir
+ * code to get around W^X restrictions, where one region is writable and the
+ * other is executable.
+ *
+ * Since the executable region is never written to we cannot detect code
+ * changes when running in user mode, and rely on the emulated JIT telling us
+ * that the code has changed by executing this instruction.
+ */
+static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    uint64_t icache_line_mask, start_address, end_address;
+    const ARMCPU *cpu;
+
+    cpu =3D env_archcpu(env);
+
+    icache_line_mask =3D (4 << extract32(cpu->ctr, 0, 4)) - 1;
+    start_address =3D value & ~icache_line_mask;
+    end_address =3D value | icache_line_mask;
+
+    mmap_lock();
+
+    tb_invalidate_phys_range(start_address, end_address);
+
+    mmap_unlock();
+}
+#endif
+
 static const ARMCPRegInfo v8_cp_reginfo[] =3D {
     /*
      * Minimal set of EL0-visible registers. This will need to be expanded
@@ -5267,7 +5297,10 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
     { .name =3D "CURRENTEL", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 0, .opc2 =3D 2, .crn =3D 4, .crm =3D 2,
       .access =3D PL1_R, .type =3D ARM_CP_CURRENTEL },
-    /* Cache ops: all NOPs since we don't emulate caches */
+    /*
+     * Instruction cache ops. All of these except `IC IVAU` NOP because we
+     * don't emulate caches.
+     */
     { .name =3D "IC_IALLUIS", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 0, .crn =3D 7, .crm =3D 1, .opc2 =3D 0,
       .access =3D PL1_W, .type =3D ARM_CP_NOP,
@@ -5280,9 +5313,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
       .accessfn =3D access_tocu },
     { .name =3D "IC_IVAU", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 3, .crn =3D 7, .crm =3D 5, .opc2 =3D 1,
-      .access =3D PL0_W, .type =3D ARM_CP_NOP,
+      .access =3D PL0_W,
       .fgt =3D FGT_ICIVAU,
-      .accessfn =3D access_tocu },
+      .accessfn =3D access_tocu,
+#ifdef CONFIG_USER_ONLY
+      .type =3D ARM_CP_NO_RAW,
+      .writefn =3D ic_ivau_write
+#else
+      .type =3D ARM_CP_NOP
+#endif
+    },
+    /* Cache ops: all NOPs since we don't emulate caches */
     { .name =3D "DC_IVAC", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 1, .opc1 =3D 0, .crn =3D 7, .crm =3D 6, .opc2 =3D 1,
       .access =3D PL1_W, .accessfn =3D aa64_cacheop_poc_access,
--=20
2.38.5


