Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCE73FD24
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE92R-0005Yw-Mr; Tue, 27 Jun 2023 09:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92M-0005Vg-5L; Tue, 27 Jun 2023 09:47:21 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qE92K-0001Kf-FW; Tue, 27 Jun 2023 09:47:17 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3457a3ada84so19119865ab.1; 
 Tue, 27 Jun 2023 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687873634; x=1690465634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHM7lQ1CxTswl5wS4KtHJQCjIkcqUSymVrzuiruH8XM=;
 b=Ix9t+4Iqv+Ivp6WmqrSBufFYG7/mYacCUWtwUZrE8TXpj3Vace76UIpBhBTd9kbLoJ
 +i118kYcsO0HN5EDsSNl1+L6OBNrchw7idfovth1enOkCZxE3mRq8LxdtGdh3XaF34Ee
 1/VEDbLPhodKx+1SegKF5RWHpuM9uYvKfYi2JUV23DYuq9BnnBsIsltgmwwIL/1R5feT
 r71chtVyJlw7d+zcYnQxqOc2ZKpo0X3C3HVhXyFX81saIpsSdG60MJskRqQGOByAwUlF
 +DFPxe00ikGM5HaI2XX9CQudeSrrK/Y0lqGdTZrZ6pseOts+P3e80LlonzZHpZMxl9zm
 l9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687873634; x=1690465634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHM7lQ1CxTswl5wS4KtHJQCjIkcqUSymVrzuiruH8XM=;
 b=f2Ytu7oQ0whASdC0JqQ8JFPC3eBILoUPCjj8QvMBzAB01iS3eXfdNeT7SkuP2kSPUK
 aligfIY/E6Xf3P+dvWUkelY2UQNRExsJdUA1rH1vFwpnr/jyT5akix3pGnLG3n7uc91o
 scrhQPYkamLWAI1frWVYPjCDoFlgxbRvt+0BjH7xSxNeauixKs/WJPiF3HwlSD9aH0Hx
 l62Z8AKSvkoQo6Vk8l+uxnl+guIUpLkY+7I4Q/dr0huY8p4+TqAsaiOZUC+Tuf313WSZ
 NwgJ/oO1EITL2JajWqHbGmEu358i48KlaUdpuhORSKmkfaH/iEZn900Dsa+YkgzgQv1c
 Nkgg==
X-Gm-Message-State: AC+VfDy2bRYqYFIUaeQHLWMzRmAq//lI1MjoNxvbV5ScNm0kd1Cpd70h
 W6+Lf+omyz5DciS9yEcw6jvGur9zkYc=
X-Google-Smtp-Source: ACHHUZ52qllpJNLkqnFInduQVygXOG5zq0/Jl0E5b99eyyoeu9Cb7Hxj0Qg2JcK+1guwJjR3T6/sKw==
X-Received: by 2002:a92:d184:0:b0:345:a201:82c0 with SMTP id
 z4-20020a92d184000000b00345a20182c0mr5973562ilz.32.1687873634528; 
 Tue, 27 Jun 2023 06:47:14 -0700 (PDT)
Received: from wheely.local0.net (193-116-109-121.tpgi.com.au.
 [193.116.109.121]) by smtp.gmail.com with ESMTPSA id
 d9-20020a63f249000000b0051eff0a70d7sm5741384pgk.94.2023.06.27.06.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 06:47:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system
Date: Tue, 27 Jun 2023 23:46:43 +1000
Message-Id: <20230627134644.260663-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627134644.260663-1-npiggin@gmail.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12a.google.com
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

checkstop state does not halt the system, interrupts continue to be
serviced, and other CPUs run.

Stop the machine with vm_stop(), and print a register dump too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Fix loop exit so it stops on the attn instruction, rather than
  after it.

 target/ppc/excp_helper.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 5beda973ce..28d8a9b212 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -186,19 +187,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
              env->error_code);
 }
 
-static void powerpc_checkstop(CPUPPCState *env)
+static void powerpc_checkstop(CPUPPCState *env, const char *reason)
 {
     CPUState *cs = env_cpu(env);
 
-    /* Machine check exception is not enabled. Enter checkstop state. */
-    fprintf(stderr, "Machine check while not allowed. "
-            "Entering checkstop state\n");
+    vm_stop(RUN_STATE_GUEST_PANICKED);
+
+    fprintf(stderr, "Entering checkstop state: %s\n", reason);
+    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
     if (qemu_log_separate()) {
-        qemu_log("Machine check while not allowed. "
-                 "Entering checkstop state\n");
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            fprintf(logfile, "Entering checkstop state: %s\n", reason);
+            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+            qemu_log_unlock(logfile);
+        }
     }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
+
+    cpu_loop_exit_noexc(cs);
 }
 
 #if defined(TARGET_PPC64)
@@ -483,7 +489,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
-            powerpc_checkstop(env);
+            powerpc_checkstop(env, "machine check with MSR[ME]=0");
         }
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
@@ -602,7 +608,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
-            powerpc_checkstop(env);
+            powerpc_checkstop(env, "machine check with MSR[ME]=0");
         }
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
@@ -763,7 +769,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
-            powerpc_checkstop(env);
+            powerpc_checkstop(env, "machine check with MSR[ME]=0");
         }
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
@@ -936,7 +942,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
-            powerpc_checkstop(env);
+            powerpc_checkstop(env, "machine check with MSR[ME]=0");
         }
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
@@ -1119,7 +1125,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
-            powerpc_checkstop(env);
+            powerpc_checkstop(env, "machine check with MSR[ME]=0");
         }
         /* machine check exceptions don't have ME set */
         new_msr &= ~((target_ulong)1 << MSR_ME);
@@ -1424,7 +1430,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
-            powerpc_checkstop(env);
+            powerpc_checkstop(env, "machine check with MSR[ME]=0");
         }
         if (env->msr_mask & MSR_HVB) {
             /*
-- 
2.40.1


