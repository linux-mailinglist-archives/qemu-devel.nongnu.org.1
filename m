Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D5A73B29A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCc20-0000iT-T2; Fri, 23 Jun 2023 04:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1y-0000h6-Ei; Fri, 23 Jun 2023 04:20:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1u-0002pV-LN; Fri, 23 Jun 2023 04:20:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-66615629689so201689b3a.2; 
 Fri, 23 Jun 2023 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687508428; x=1690100428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSMu7K59gsJkKuMnSScWtyJ//9NCTa8sk+fznKryss4=;
 b=FTt9tmP5hmjg3e9iH7J5Wj5cABIWNdGjDXbPDftm7VrXLC6xoYYuCaLuEZ/fKvO4NO
 iqIfkzPIhhJUD31Yg0THYTzMEUs4kSSzf1SyJhW1r0HfeIAo0REbmUD72YohcNM+kiDp
 DewVynTDqW/Zy/WVHpS8kePOdlfCCP3GEi7Ug82RyxAmq0cbaImsTW87D3+o2M0SOOUZ
 +KSXaMoNCQ8yR03gDDE/fO+q3b4YsihzRMiEhysI9IwEmf/90hQYJI4ZYTfFmfdWS7qR
 xKGW3zAjcOOp1vV9x3QDJiVJiBngqtC0QoiG3z3DndULF9vhRyM4E5z0yDImFBVNZZC0
 2wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508428; x=1690100428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSMu7K59gsJkKuMnSScWtyJ//9NCTa8sk+fznKryss4=;
 b=UclMArc7TJSJvJlgnjcXcs7tP25fhosVChyZ3x4F+gT5um6lS10qLxaErFd2YkHVkY
 63XAA5gc6bbyLlHoJavnOlotEuM0blMfH2JUHGGrpsgyaR6rYN4gEKMHcBYbtGniycPE
 e4EV9xnM3Be0JSz6Iw9jCAbDbFALG/7UA9zfsMGxn50f7aaE56OVpsO01vbXQ7MCHrMO
 mhY2UFA3D48X6c1Z0tp/KZNmpYCr+rM4Vfk9n/1iQ6stKQaOQrQr5MvjKsAvuMl5eoWV
 MK5AYUrD+91xQbMv4MybF6tRu+BlcnJ8xStqq3BeWjTdNU7OT4Wpr+ZPCewwzYF3famc
 7PKQ==
X-Gm-Message-State: AC+VfDzkdDT1NEW+UWlIC08+Chyz5pdcPuhagL4jJ5uqsScL0gpC+NT3
 41cOBaKazT/fXjZwR8Gu/yhUSCpFWZ4=
X-Google-Smtp-Source: ACHHUZ4WzmdABzN3af1zOLsg4YkJItSBELlYbfRbp1mEhy0Tkwfu0wnp8QHpoxryjvdT+QpgYGhpXQ==
X-Received: by 2002:a05:6a00:17a6:b0:666:e954:8ab5 with SMTP id
 s38-20020a056a0017a600b00666e9548ab5mr25767770pfg.5.1687508428240; 
 Fri, 23 Jun 2023 01:20:28 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.231])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a62e70f000000b0066884d4efdbsm5780604pfh.12.2023.06.23.01.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:20:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 3/4] target/ppc: Move common check in machne check handlers to
 a function
Date: Fri, 23 Jun 2023 18:19:52 +1000
Message-Id: <20230623081953.290875-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623081953.290875-1-npiggin@gmail.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
[np: tweak subject, rename function to powerpc_mcheck_test_and_checkstop]
Signed-off-by-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 114 +++++++++------------------------------
 1 file changed, 25 insertions(+), 89 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1c26828d8b..4bfcfc3c3d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -404,6 +404,25 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
+static void powerpc_mcheck_test_and_checkstop(CPUPPCState *env)
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
@@ -446,21 +465,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
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
+        powerpc_mcheck_test_and_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -577,21 +582,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
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
+        powerpc_mcheck_test_and_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -750,21 +741,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
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
+        powerpc_mcheck_test_and_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -935,21 +912,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
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
+        powerpc_mcheck_test_and_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1130,21 +1093,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
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
+        powerpc_mcheck_test_and_checkstop(env);
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1377,20 +1326,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
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
+        powerpc_mcheck_test_and_checkstop(env);
         if (env->msr_mask & MSR_HVB) {
             /*
              * ISA specifies HV, but can be delivered to guest with HV
-- 
2.40.1


