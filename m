Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBFBBD969
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 12:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hye-0006ND-Dw; Mon, 06 Oct 2025 05:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyb-0006Ll-M5
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:53 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyZ-0003pU-Q6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:53 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id B5C8E60B98
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:40 +0200 (CEST)
Received: (qmail 18776 invoked by uid 990); 6 Oct 2025 09:57:40 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:40 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v7 11/25] target/m68k: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:06 +0200
Message-ID: <1246174a278a434ffae2f202fcdc586bebb01d95.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.994071) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.594071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=FRZ2j8rbmm/3ycj8ZP5YixYFG9zzEquVSOdWN5ofsr0=;
 b=orFPOe8MEQC5yqX1iBZdCP6iobJgZ9GYxs8ncYtzkv32eAFuCTejCcdRjyw0Y4DNTWwg3ZYgrL
 sD/cinYP97ZlFE/SlAtbl7XO4vHqOFCrAX7PC58mQNGPigCTOPTqePZSS6hD7fAda0W1nV7Ocbtk
 GTfj+S/hXgFAGxrwEcFwhQbxRh8/a+drI7t42cYFSeVV20iJdqJrYx8RDsPjy0xKxUYVamwdQ36W
 iaYP7KaVMcEnCGiiyt+S2JlhpcgXtBhyARQ9s5T10kUYrMhWFpOE69SSn3/AysOZjIQxh5I/n94S
 7hyNmZ5FzNK/l03TMZmKZETP7dp0L5C11s2AdOG3NaVpW3uGlM1bb3s6jpHEfJt+HsPrDlqHUiGr
 UG5gTMS6a7YbJgLR7ed4vJqxEveiXoj4h27ODWv4zPzuhDYs1mlVdEaRe+0duIhYmW8YwnlTyQBw
 SSOm61zAkMJXBwb+URDyx99UgHvZbmq8xlVgdMnefDdzU23D2XLjsLFxIhLdvt30quQFPGA47Ng2
 eT6tRAZxWNXXmgkHBPH6VhWZX3eSHx+dSAKS2VQlVDTWyH29CsGHJhJ3GP8cABTtDMDgxVnWIgFq
 Q1l5w6Qh96J22WxV3WbGkaMfb69dFPNWjdIjIhL7YMHE0SamI+lwBhpOr4SHmprs3kmhR4Zad8JD
 k=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Motorola 68000 targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/m68k/op_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f29ae12af8..e9c20a8e03 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "semihosting/semihost.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 
@@ -183,6 +184,21 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_SPURIOUS ... EXCP_INT_LEVEL_7:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    case EXCP_SEMIHOSTING:
+        qemu_plugin_vcpu_hostcall_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+        break;
+    }
+}
+
 static void cf_interrupt_all(CPUM68KState *env, int is_hw)
 {
     CPUState *cs = env_cpu(env);
@@ -203,6 +219,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             return;
         case EXCP_SEMIHOSTING:
             do_m68k_semihosting(env, env->dregs[0]);
+            qemu_plugin_vcpu_hostcall_cb(cs, retaddr);
             return;
         }
     }
@@ -239,6 +256,8 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, retaddr);
 }
 
 static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
@@ -277,6 +296,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     uint32_t sp;
     uint32_t vector;
     uint16_t sr, oldsr;
+    uint64_t last_pc = env->pc;
 
     if (!is_hw) {
         switch (cs->exception_index) {
@@ -417,6 +437,8 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     env->aregs[7] = sp;
     /* Jump to vector.  */
     env->pc = cpu_ldl_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+
+    do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
 
 static void do_interrupt_all(CPUM68KState *env, int is_hw)
-- 
2.49.1


