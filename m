Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6549FA860
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Dec 2024 23:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPU5f-0004vy-H2; Sun, 22 Dec 2024 17:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPU5c-0004vj-O9
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 17:06:21 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPU5Z-00057E-OD
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 17:06:20 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EC958114015B;
 Sun, 22 Dec 2024 17:06:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 22 Dec 2024 17:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1734905176; x=1734991576; bh=LG
 qfuFvTx6AXuOMiCrnNuDlaxkZLcME87NlDEqNPt0E=; b=ktarGK3uneF4X8Mwp7
 mg+nYMS/ky8GpQ0bBWqCc0dxElKPc+eDfnM07gHa3fwYfxjZkwJGaeyLP2k/ZCZ1
 rOtXG9W2ln00Saurp8/KWNXjRz/a/8lad/ECQoFzB+SKiC6ZPV8nwPj9bGaa/KZj
 sil1+JtLmJ/lnqvFy5UZkJoViNbOuM4GvNUf1EtGaNcA6bDUJKKLBlTlxGPiGVcH
 JqEZyB7hM7VProfOFRbx0zoC1Y+T7bBujYjf/fYFV0funKSXQhgUWW25rlxCcp6+
 /mfdhU2Ad3h0qEHLaYUOS7zm0J4etDDOdt1LGHCkN+FL+0Lx3B87RHs2kyApn7rc
 s7MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1734905176; x=1734991576; bh=LGqfuFvTx6AXuOMiCrnNuDlaxkZL
 cME87NlDEqNPt0E=; b=FkZjz93/yfDmvPCrSSLthMjsiOV6Z+vYH4EN+lt/EG09
 quCRgDDepaV+VFl4YKumhY6jlBhvaUEMfNegn8BjFAIlnn5HKJS3vH0XosoevC+i
 RV9bp3LKngyLipuqyyztyBLBmNfwifFBNFAE3tTQdXS8tDl/sBP7E7+bka2bT1hd
 vQdTC0lcyg/0vPZtG6QfBAjJ9Jmgrh+hls5NgdNEfZ2t3ekZNb2dbrbjNLIaUjnh
 AlSGm/ekM/RaV8RMcB9jYduCWFe4UF4p/xw3+V58aZXCAVTGhLP4fpJrMMz0pJSG
 /W9Rz2UxXBDq4Yu0j9GZL2gzBrkgyefs1hZJiS8YvA==
X-ME-Sender: <xms:V41oZ6SKB73mchrUIzuhP_yzYJVVYfxx18EcHFhYG86HEEcxuXukRg>
 <xme:V41oZ_x765GnjvQEHjG7VKmO-KPDRH4lNieAclU41IR2Xx3dZr4PSPbvffVq8FGro
 a39bsae1mHXqk1ROH4>
X-ME-Received: <xmr:V41oZ32KWH6FJHTlC9-v5dH7kjFvAuvH1eQYf2G_bQF_NThs_7LLtkCv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgudehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeen
 ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
 horghtrdgtohhmqeenucggtffrrghtthgvrhhnpeffteeugeektdfgjeevuedvgffhgedt
 vdfghedugefhgeehteeuudehudevjeethfenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgt
 ohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 hpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrohhsohhnghes
 lhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlrghurhgvnhhtsehvihhvihgvrhdrvg
 hupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphht
 thhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:V41oZ2CxPq76Vel9dn0fU1ynDeLPIhq7G2XK_nd9XLd0G5y806KPYA>
 <xmx:V41oZziK0YTmA2CKCY-8o48riP7SxgR7RJxHBJbmGch_GYkLIvMiHg>
 <xmx:V41oZyrG7EsSgXfvBlDC54UuzWO2N3DS1zezMsN73_AwkINarp0wog>
 <xmx:V41oZ2itL5ty_Sl4Lr9rdKt6YCSuHroyD97lnSPBAfYW578p7qJyew>
 <xmx:WI1oZ5ZktRBLGR89Qog-Tv2xpXOCZ0mCDr5vdPSixW9utaa27akPopAA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 17:06:14 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 22 Dec 2024 22:06:04 +0000
Subject: [PATCH] target/loongarch: Implement semihosting support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-semihosting-v1-1-8a770df60e9c@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAEuNaGcC/0XMQQ6DIBCF4auYWZdERlvEqzQuqAw6SQsVrGliv
 HuJLLr8X/K+HRJFpgR9tUOkjRMHn0NeKhhn4ycSbHMD1thKRCkSvXgOaWU/idHJzqmmwavTkB/
 vSI6/p3YfSkdaPhldy/g3+6qIUounEY8QTtDebNeiMkrput8QhuP4ASK3CcCiAAAA
X-Change-ID: 20241221-semihosting-cf18f73325f9
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12628;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RY0rBeqIMIxRJsJccvsGez9zycrPY3IZqU+acMM58+4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSM3rBtgkbtdU2zNOcb5M9ZqNT5/2vJzCObZ/xfaX35q
 1j0N4f3HaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRu94Mfzgc9x07q3emZw/j
 zCo3Gz6+XNObLrcF6g5+fKI710SruZCR4b+IwS2bPy/ybY4fuTFfJ3vO/4fCLlW80461aSmwPjE
 LYgUA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wire up ARM_COMPATIBLE_SEMIHOSTING for LoongArch.

The semihosting ABI (i.e. "dbcl 0xab" for semihosting call and Arm
compatible settings) is confirmed by LA132 (1C103)'s OpenOCD
implementation.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 configs/targets/loongarch64-linux-user.mak         |  2 +
 linux-user/loongarch64/cpu_loop.c                  | 12 ++++++
 linux-user/qemu.h                                  |  5 ++-
 qemu-options.hx                                    | 11 ++---
 target/loongarch/Kconfig                           |  1 +
 target/loongarch/common-semi-target.h              | 49 ++++++++++++++++++++++
 target/loongarch/cpu.c                             |  6 +++
 target/loongarch/cpu.h                             |  3 ++
 .../tcg/insn_trans/trans_privileged.c.inc          | 41 +++++++++---------
 target/loongarch/tcg/translate.c                   |  1 +
 tests/tcg/loongarch64/semicall.h                   | 19 +++++++++
 11 files changed, 124 insertions(+), 26 deletions(-)

diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index dfded79dfa8531dfd0cb8928e47922810d4b7f41..ad3754dfdd0c39ebfa8c308326f744888e34c10e 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -4,3 +4,5 @@ TARGET_BASE_ARCH=loongarch
 TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,64
+CONFIG_SEMIHOSTING=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 73d7b6796a4261a77e73d8504b4ba9a722ae822d..426a772e6929e8e3c4b6e6f387b9c0ecf102b8c6 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -10,6 +10,7 @@
 #include "user-internals.h"
 #include "cpu_loop-common.h"
 #include "signal-common.h"
+#include "semihosting/common-semi.h"
 
 void cpu_loop(CPULoongArchState *env)
 {
@@ -84,6 +85,10 @@ void cpu_loop(CPULoongArchState *env)
         case EXCCODE_ASXD:
             env->CSR_EUEN |= R_CSR_EUEN_ASXE_MASK;
             break;
+        case EXCCODE_SEMIHOST:
+            do_common_semihosting(cs);
+            set_pc(env, env->pc + 4);
+            break;
 
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
@@ -99,6 +104,9 @@ void cpu_loop(CPULoongArchState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    CPUState *cpu = env_cpu(env);
+    TaskState *ts = get_task_state(cpu);
+    struct image_info *info = ts->info;
     int i;
 
     for (i = 0; i < 32; i++) {
@@ -106,4 +114,8 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     }
     env->pc = regs->csr.era;
 
+    ts->stack_base = info->start_stack;
+    ts->heap_base = info->brk;
+    /* This will be filled in on the first SYS_HEAPINFO call.  */
+    ts->heap_limit = 0;
 }
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 67bc81b1499014739b002509a4e7a18afe977433..8ddbfa886881e5d7d02f45f8657d985efd863d96 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -103,7 +103,7 @@ struct TaskState {
     FPA11 fpa;
 # endif
 #endif
-#if defined(TARGET_ARM) || defined(TARGET_RISCV)
+#if defined(TARGET_ARM) || defined(TARGET_LOONGARCH) || defined(TARGET_RISCV)
     int swi_errno;
 #endif
 #if defined(TARGET_I386) && !defined(TARGET_X86_64)
@@ -121,7 +121,8 @@ struct TaskState {
 #ifdef TARGET_M68K
     abi_ulong tp_value;
 #endif
-#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
+#if defined(TARGET_ARM) || defined(TARGET_LOONGARCH) || \
+    defined(TARGET_M68K) || defined(TARGET_RISCV)
     /* Extra fields for semihosted binaries.  */
     abi_ulong heap_base;
     abi_ulong heap_limit;
diff --git a/qemu-options.hx b/qemu-options.hx
index cc694d3b890c8ad9c5fad0a1f689781191d8e97a..0c4d599ab9e4e0e443aedc1b1c8733be1ab524ed 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5011,10 +5011,11 @@ ERST
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
     QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
+    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_LOONGARCH)
 SRST
 ``-semihosting``
-    Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, RISC-V only).
+    Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, RISC-V,
+    LoongArch only).
 
     .. warning::
       Note that this allows guest direct access to the host filesystem, so
@@ -5027,11 +5028,11 @@ DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
     "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]\n" \
     "                semihosting configuration\n",
 QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
+QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_LOONGARCH)
 SRST
 ``-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]``
-    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V
-    only).
+    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V,
+    LoongArch only).
 
     .. warning::
       Note that this allows guest direct access to the host filesystem, so
diff --git a/target/loongarch/Kconfig b/target/loongarch/Kconfig
index 46b26b1a85715e779672bea93152a3c62c170fe2..ba8918d7045e9056107415612a7c756701923231 100644
--- a/target/loongarch/Kconfig
+++ b/target/loongarch/Kconfig
@@ -1,2 +1,3 @@
 config LOONGARCH64
     bool
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG
diff --git a/target/loongarch/common-semi-target.h b/target/loongarch/common-semi-target.h
new file mode 100644
index 0000000000000000000000000000000000000000..066d2ea1af35861521beabfc4f31c496c9bc3e03
--- /dev/null
+++ b/target/loongarch/common-semi-target.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Target-specific parts of semihosting/arm-compat-semi.c.
+ *
+ * Copyright (c) 2005, 2007 CodeSourcery.
+ * Copyright (c) 2019, 2022 Linaro
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef TARGET_LOONGARCH_COMMON_SEMI_TARGET_H
+#define TARGET_LOONGARCH_COMMON_SEMI_TARGET_H
+
+static inline target_ulong common_semi_arg(CPUState *cs, int argno)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    return env->gpr[4 + argno];
+}
+
+static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    env->gpr[4] = ret;
+}
+
+static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+{
+    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
+}
+
+static inline bool is_64bit_semihosting(CPUArchState *env)
+{
+    return !is_va32(env);
+}
+
+static inline target_ulong common_semi_stack_bottom(CPUState *cs)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    return env->gpr[3];
+}
+
+static inline bool common_semi_has_synccache(CPUArchState *env)
+{
+    return true;
+}
+
+#endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314bf707bea7f2c0eca5590841e68a2a97..9591f091f35eb001f255dc00b8a26276c9624a96 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -21,6 +21,7 @@
 #include "cpu-csr.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
+#include "semihosting/common-semi.h"
 #endif
 #include "vec.h"
 #ifdef CONFIG_KVM
@@ -71,6 +72,7 @@ static const struct TypeExcp excp_names[] = {
     {EXCCODE_BCE, "Bound Check Exception"},
     {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
     {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCCODE_SEMIHOST, "Semihosting"},
     {EXCP_HLT, "EXCP_HLT"},
 };
 
@@ -179,6 +181,10 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     switch (cs->exception_index) {
+    case EXCCODE_SEMIHOST:
+        do_common_semihosting(cs);
+        set_pc(env, env->pc + 4);
+        return;
     case EXCCODE_DBP:
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DCL, 1);
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, ECODE, 0xC);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 86c86c6c958db1a215a3e76a27f379bd4a095fb6..2b466a046d552a8c62cb0c4f57c3ac50c64f21a7 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -115,6 +115,9 @@ FIELD(FCSR0, CAUSE, 24, 5)
 #define  EXCCODE_BTE                 EXCODE(21, 0)
 #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode used for debug */
 
+/* QEMU Internal Exceptions */
+#define  EXCCODE_SEMIHOST            EXCODE(63, 0)
+
 /* cpucfg[0] bits */
 FIELD(CPUCFG0, PRID, 0, 32)
 
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7e4ec93edb3c415268489014def22e85a0de6fb4..c9776081b8026b7aaafd49a0c55aab1779bc206b 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -7,6 +7,28 @@
 
 #include "cpu-csr.h"
 
+static bool check_plv(DisasContext *ctx)
+{
+    if (ctx->plv == MMU_PLV_USER) {
+        generate_exception(ctx, EXCCODE_IPE);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
+{
+    if (semihosting_enabled(ctx->plv == MMU_PLV_USER) && a->imm == 0xab) {
+        generate_exception(ctx, EXCCODE_SEMIHOST);
+        return true;
+    }
+    if (check_plv(ctx)) {
+        return false;
+    }
+    generate_exception(ctx, EXCCODE_DBP);
+    return true;
+}
+
 #ifdef CONFIG_USER_ONLY
 
 #define GEN_FALSE_TRANS(name)   \
@@ -37,7 +59,6 @@ GEN_FALSE_TRANS(cacop)
 GEN_FALSE_TRANS(ldpte)
 GEN_FALSE_TRANS(lddir)
 GEN_FALSE_TRANS(ertn)
-GEN_FALSE_TRANS(dbcl)
 GEN_FALSE_TRANS(idle)
 
 #else
@@ -151,15 +172,6 @@ static const CSRInfo csr_info[] = {
     CSR_OFF(DSAVE),
 };
 
-static bool check_plv(DisasContext *ctx)
-{
-    if (ctx->plv == MMU_PLV_USER) {
-        generate_exception(ctx, EXCCODE_IPE);
-        return true;
-    }
-    return false;
-}
-
 static const CSRInfo *get_csr(unsigned csr_num)
 {
     const CSRInfo *csr;
@@ -475,15 +487,6 @@ static bool trans_ertn(DisasContext *ctx, arg_ertn *a)
     return true;
 }
 
-static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
-{
-    if (check_plv(ctx)) {
-        return false;
-    }
-    generate_exception(ctx, EXCCODE_DBP);
-    return true;
-}
-
 static bool trans_idle(DisasContext *ctx, arg_idle *a)
 {
     if (check_plv(ctx)) {
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 1fca4afc731c048816618d87610a0cc0fe7579b1..9eaac98034fe7f3481007c3d69794a973d326f00 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -16,6 +16,7 @@
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
 #include "fpu/softfloat.h"
+#include "semihosting/semihost.h"
 #include "translate.h"
 #include "internals.h"
 #include "vec.h"
diff --git a/tests/tcg/loongarch64/semicall.h b/tests/tcg/loongarch64/semicall.h
new file mode 100644
index 0000000000000000000000000000000000000000..0f29f7a52cee9b3273aba1c773e8f9d91fde7011
--- /dev/null
+++ b/tests/tcg/loongarch64/semicall.h
@@ -0,0 +1,19 @@
+/*
+ * Semihosting Tests - LoongArch Helper
+ *
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
+{
+    register uintptr_t t asm("a0") = type;
+    register uintptr_t a0 asm("a1") = arg0;
+
+    asm("dbcl 0xab\n\t"
+        : "=r" (t)
+        : "r" (t), "r" (a0));
+
+    return t;
+}

---
base-commit: 8529d6fb65882418a924b4c4817e15ffda2a6839
change-id: 20241221-semihosting-cf18f73325f9
prerequisite-change-id: 20241219-la-booting-d6d8427a7790:v2
prerequisite-patch-id: d034c987c8746e03b7d0c2556e98fda93e32a84c
prerequisite-patch-id: 3f9c8f90f5466f56ba3dd3569be8ed4f1b0452e2

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


