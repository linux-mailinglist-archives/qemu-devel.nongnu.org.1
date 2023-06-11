Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF472B4A7
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tlj-0000Fi-Iy; Sun, 11 Jun 2023 18:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlh-0000E2-45; Sun, 11 Jun 2023 18:42:41 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tle-0004gT-5T; Sun, 11 Jun 2023 18:42:40 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7BB5E748A68;
 Mon, 12 Jun 2023 00:42:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44906748A64; Mon, 12 Jun 2023 00:42:33 +0200 (CEST)
Message-Id: <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686522199.git.balaton@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 03/10] target/ppc: Move common check in exception handlers to
 a function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:33 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All powerpc exception handlers share some code when handling machine
check exceptions. Move this to a common function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 112 ++++++++-------------------------------
 1 file changed, 23 insertions(+), 89 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 3783315fdb..e4532f5088 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -403,6 +403,23 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
+static void powerpc_checkstop_state(CPUPPCState *env)
+{
+    if (!FIELD_EX64(env->msr, MSR, ME)) {
+        CPUState *cs = env_cpu(env);
+
+        /* Machine check exception is not enabled. Enter checkstop state. */
+        fprintf(stderr, "Machine check while not allowed. "
+                "Entering checkstop state\n");
+        if (qemu_log_separate()) {
+            qemu_log("Machine check while not allowed. "
+                     "Entering checkstop state\n");
+        }
+        cs->halted = 1;
+        cpu_interrupt_exittb(cs);
+    }
+}
+
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUState *cs = CPU(cpu);
@@ -445,21 +462,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         srr1 = SPR_40x_SRR3;
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        if (!FIELD_EX64(env->msr, MSR, ME)) {
-            /*
-             * Machine check exception is not enabled.  Enter
-             * checkstop state.
-             */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
-            if (qemu_log_separate()) {
-                qemu_log("Machine check while not allowed. "
-                        "Entering checkstop state\n");
-            }
-            cs->halted = 1;
-            cpu_interrupt_exittb(cs);
-        }
-
+        powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -576,21 +579,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_CRITICAL:    /* Critical input                         */
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        if (!FIELD_EX64(env->msr, MSR, ME)) {
-            /*
-             * Machine check exception is not enabled.  Enter
-             * checkstop state.
-             */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
-            if (qemu_log_separate()) {
-                qemu_log("Machine check while not allowed. "
-                        "Entering checkstop state\n");
-            }
-            cs->halted = 1;
-            cpu_interrupt_exittb(cs);
-        }
-
+        powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -749,21 +738,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        if (!FIELD_EX64(env->msr, MSR, ME)) {
-            /*
-             * Machine check exception is not enabled.  Enter
-             * checkstop state.
-             */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
-            if (qemu_log_separate()) {
-                qemu_log("Machine check while not allowed. "
-                        "Entering checkstop state\n");
-            }
-            cs->halted = 1;
-            cpu_interrupt_exittb(cs);
-        }
-
+        powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -934,21 +909,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        if (!FIELD_EX64(env->msr, MSR, ME)) {
-            /*
-             * Machine check exception is not enabled.  Enter
-             * checkstop state.
-             */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
-            if (qemu_log_separate()) {
-                qemu_log("Machine check while not allowed. "
-                        "Entering checkstop state\n");
-            }
-            cs->halted = 1;
-            cpu_interrupt_exittb(cs);
-        }
-
+        powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1129,21 +1090,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         srr1 = SPR_BOOKE_CSRR1;
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        if (!FIELD_EX64(env->msr, MSR, ME)) {
-            /*
-             * Machine check exception is not enabled.  Enter
-             * checkstop state.
-             */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
-            if (qemu_log_separate()) {
-                qemu_log("Machine check while not allowed. "
-                        "Entering checkstop state\n");
-            }
-            cs->halted = 1;
-            cpu_interrupt_exittb(cs);
-        }
-
+        powerpc_checkstop_state(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1376,20 +1323,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
-        if (!FIELD_EX64(env->msr, MSR, ME)) {
-            /*
-             * Machine check exception is not enabled.  Enter
-             * checkstop state.
-             */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
-            if (qemu_log_separate()) {
-                qemu_log("Machine check while not allowed. "
-                        "Entering checkstop state\n");
-            }
-            cs->halted = 1;
-            cpu_interrupt_exittb(cs);
-        }
+        powerpc_checkstop_state(env);
         if (env->msr_mask & MSR_HVB) {
             /*
              * ISA specifies HV, but can be delivered to guest with HV
-- 
2.30.9


