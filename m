Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A173FD28
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE92P-0005WC-TG; Tue, 27 Jun 2023 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92I-0005VK-4R; Tue, 27 Jun 2023 09:47:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92G-0001Jv-99; Tue, 27 Jun 2023 09:47:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-666ecf9a081so4152538b3a.2; 
 Tue, 27 Jun 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687873630; x=1690465630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uQb/Fa9vHAGdeJPTXfK/VciCluvLl/3OTOc5Nw4Q7I=;
 b=RcslbAx+j60Kl6BJLkruBKCgyfhdDBPogUza2jlN/MqovlG0DJ/A14RUBN2BMpGCq9
 /6KSjX1WV/AbybFsoo52sZ664v8ugmpSaRrfxJl295zi4wMardhkBIOMljIhdSKP58U1
 wot3nElTZUWjesrUsRxAYpBG9tUfhytk9L46OZlpV5KFiDgG6JrEJ6SkREu0K6Id7amh
 3u0HoOid4qnLiRbfs4HT0x9q1TCamL9321J3Tcmo757YQZuH8eMQEm0Jumjo2Amehy6u
 dMpLUbOnXilFmWabobuYam175smM7Bn7ZgH3i4/xWZiInXLe7+3Iq1L8z7jf+JRKzf0p
 NkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687873630; x=1690465630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uQb/Fa9vHAGdeJPTXfK/VciCluvLl/3OTOc5Nw4Q7I=;
 b=UUip5+IA6h9nz6P0dS9kj2rMqudfYlHURo86MHEpl3/QtleZIX3sUkmcnzRL0c53Ba
 8H3MXBfmbrpo8ZvOkoc/U5Ur3ceWmdmTHlZFeX/07ErO9HwWfmqQPvRYHWkOGTIMfN0V
 mqW7fajI4waCroh0pTvoa0QOzAxxWTCYf7WY+odNtHPGY54dxr2lfnOUQ4F60NdLFekf
 BV8eNJ82aNayKY7wy1tvAtDspd1t7t7NvKyzJhowXwGOJaQMrMnF6cz7GJJq8EQ953i4
 6CFmv3OXTWeFkQ7D2RzVDLEMxnTukHP497sWwiObQnxh+kbY+pui/3+/cyWSezUiEJNi
 GBNQ==
X-Gm-Message-State: AC+VfDx4RwuhpTzZjqAaBVrT5PhRHaPvEX02iB+8wq/ApXSXRetRvOpj
 6t2LcDhjegu1FZulYdzMHkaskQxqL8g=
X-Google-Smtp-Source: ACHHUZ6RD5ksLhP/6zzMqrrTTPkoRKkN0mevvnPmdS4gOQ/QHnjy4ykoeRlZ9Ippjo7cuAkTPXIl7A==
X-Received: by 2002:a05:6a00:1783:b0:674:ff6d:1b39 with SMTP id
 s3-20020a056a00178300b00674ff6d1b39mr8713215pfg.9.1687873630214; 
 Tue, 27 Jun 2023 06:47:10 -0700 (PDT)
Received: from wheely.local0.net (193-116-109-121.tpgi.com.au.
 [193.116.109.121]) by smtp.gmail.com with ESMTPSA id
 d9-20020a63f249000000b0051eff0a70d7sm5741384pgk.94.2023.06.27.06.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 06:47:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/4] target/ppc: Move common check in machine check
 handlers to a function
Date: Tue, 27 Jun 2023 23:46:42 +1000
Message-Id: <20230627134644.260663-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627134644.260663-1-npiggin@gmail.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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
[np: adapted to make checkstop generally usable]
Signed-off-by-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Adjusted to avoid additional trivial wrapper function when
  making checkstop usable by other callers.

 target/ppc/excp_helper.c | 98 +++++++++-------------------------------
 1 file changed, 21 insertions(+), 77 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 13318fbbb9..5beda973ce 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -186,6 +186,21 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
              env->error_code);
 }
 
+static void powerpc_checkstop(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
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
 #if defined(TARGET_PPC64)
 static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
                                 target_ulong *msr)
@@ -468,20 +483,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
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
+            powerpc_checkstop(env);
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -599,20 +602,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
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
+            powerpc_checkstop(env);
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -772,20 +763,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
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
+            powerpc_checkstop(env);
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -957,20 +936,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
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
+            powerpc_checkstop(env);
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1152,20 +1119,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
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
+            powerpc_checkstop(env);
         }
-
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
 
@@ -1469,18 +1424,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
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
+            powerpc_checkstop(env);
         }
         if (env->msr_mask & MSR_HVB) {
             /*
-- 
2.40.1


