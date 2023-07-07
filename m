Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C907974B009
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:40:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgx-00029n-I7; Fri, 07 Jul 2023 07:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgv-000295-Je; Fri, 07 Jul 2023 07:32:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgt-0006au-S4; Fri, 07 Jul 2023 07:32:01 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b72329b63eso1643847a34.0; 
 Fri, 07 Jul 2023 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729518; x=1691321518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3XD+zMQc9MBKyg+I8shLS6qDaTHcOVV3+DAEwxdwTI=;
 b=MT6OdvmMoG3pOh6j6fFf2Pl/rwE4TqaT289ksAL1aA/K+o82EG1fTBUCujSJzM/FeV
 f1N41bJqADMwMpnzbnN7I6NmY59HQtWVmpNMpYMc/VKLu0Xny7agjZJtQJsCLTk7w5U8
 blnnNAUk/vl5P5I8tIghNBXNsDLGMFRZbHDfK+FpWTp+GDb3pU7Cx5bhOIC4nHsuE4Ha
 lb8mDmy5CR7+qwkPwBYCfYnwbd9cRmQfrGcLpL9AVskR6DX6hPv3ic1+Ec9M0l1lCJhE
 vtN5AZjYWyWY3KlewdR3nQg+LhIV9bDfR2RGHQ+k0yey+LlVHzBNWewJdv4dviRoqg+e
 j3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729518; x=1691321518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3XD+zMQc9MBKyg+I8shLS6qDaTHcOVV3+DAEwxdwTI=;
 b=B1g+VX1KOT+E4Zb3Q17XMRrtk0jq9AQpqwgOaW4qM1fIRqy3SQz9oEjpMBebzinGDo
 Bux6o8wZhYXw5rNmNgAIJL5dWbWzD4EY4vzpl/+jWri/6VcP5x2RcwBSAXuwicpftH8y
 ppgCS4LmPnaKmBR8joMBVtCKb0KlSmDLZEyyEbGXs/509xZBP/bC0HwURxNruemXJXGS
 kzYN0AMKbMBBII3ASPNRb1OlmyMr5hJL5JJWm3mSAO5Vm2k0UsHQQwDzRoiLBDSXVEcZ
 hAIwIeQNs0jT+iPEWiqr6wE2i9ZWOhhCtgZoBRN1Wa+5tWkMl/O6o+iHLTwiixgjFg7B
 CWFQ==
X-Gm-Message-State: ABy/qLa/CzJjaGWTwNatymoR/D+ZSG+s7VHSAF3TEtl4dryIyp87abYL
 liklAluIIugj5YB+L3p+hzt8/L7/TlI=
X-Google-Smtp-Source: APBJJlEkhpfXPpZSKqdrBPlZYJzsVlmOa8fScWKdtxx/Uk6UtB2WhK0m1w6gcuGlpu4GMSwXFNeGvA==
X-Received: by 2002:a9d:69d0:0:b0:6b7:4116:719e with SMTP id
 v16-20020a9d69d0000000b006b74116719emr4305995oto.8.1688729518331; 
 Fri, 07 Jul 2023 04:31:58 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:58 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 14/60] target/ppc: Move common check in exception handlers to a
 function
Date: Fri,  7 Jul 2023 08:30:22 -0300
Message-ID: <20230707113108.7145-15-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

All powerpc exception handlers share some code when handling machine
check exceptions. Move this to a common function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <9cfffaa35aa894086dd092af6b0b26f2d62ff3de.1686868895.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 114 +++++++++------------------------------
 1 file changed, 25 insertions(+), 89 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 3ddec06f65..d1d3d089a6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -424,6 +424,25 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
+static void powerpc_mcheck_checkstop(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    if (FIELD_EX64(env->msr, MSR, ME)) {
+        return;
+    }
+
+    /* Machine check exception is not enabled. Enter checkstop state. */
+    fprintf(stderr, "Machine check while not allowed. "
+            "Entering checkstop state\n");
+    if (qemu_log_separate()) {
+        qemu_log("Machine check while not allowed. "
+                 "Entering checkstop state\n");
+    }
+    cs->halted = 1;
+    cpu_interrupt_exittb(cs);
+}
+
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
     CPUState *cs = CPU(cpu);
@@ -466,21 +485,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
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
+        powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -597,21 +602,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
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
+        powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -770,21 +761,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
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
+        powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -955,21 +932,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
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
+        powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1150,21 +1113,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
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
+        powerpc_mcheck_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1467,20 +1416,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
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
+        powerpc_mcheck_checkstop(env);
         if (env->msr_mask & MSR_HVB) {
             /*
              * ISA specifies HV, but can be delivered to guest with HV
-- 
2.41.0


