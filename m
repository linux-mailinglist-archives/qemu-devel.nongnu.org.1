Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6173B29E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCc23-0000jD-1c; Fri, 23 Jun 2023 04:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc21-0000ie-0q; Fri, 23 Jun 2023 04:20:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCc1z-0002tB-8F; Fri, 23 Jun 2023 04:20:36 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-543ae6ce8d1so369719a12.2; 
 Fri, 23 Jun 2023 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687508433; x=1690100433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAeWCYAlTb2aqEPCBDmE25oHqVckLOxsVAOrw8DbLjI=;
 b=EA2orlZtwtDlQ+8Kb/5mJCg6CpoiSYLkaymCe5o8ef9x3VmBHoWtV8WLv3tbxk2S+r
 im5yxB0CC/5Qtawj9ZusIfkh9ANpOlYRec+9AtODwhn0YUyOFcgbXlEyU+XonwlrHhOc
 1P6Ek56nbytxiygPvqwDLjvUyoQQzMRtrzRBUpNIPqiEclSgUiVLBnwVF4QcAFd7T1aY
 Vif1k2WlcRzlzEWLOdZcE6sJ2uCWPjI/cB+T7HCExvLgQRIIshkOsT3veTVqgG8Z9n2X
 9+csGe6TJ+kY0Wf+AC3IqfFnWc+/DHtmtoVRxufUVuIJA2AjDmcYKym9PbVt9qW7Dy38
 eePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508433; x=1690100433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAeWCYAlTb2aqEPCBDmE25oHqVckLOxsVAOrw8DbLjI=;
 b=lApB2WLIB/j48001tLuF2jYag6+BUpvFYqob6w5pqaMiX//CrlYX+YQW/JTFk8tNK7
 Y4ArlabuVObksbVack9bbeOnPwkilLEXTHfwxb/SuuTq43zpKwxFvx0KMjAUb2z8asLI
 jYpItYAago8W+IpNC4IDycL+SxecEkygroC911zGOuok8hpeS1rdAWC0pgKbhBdKmwbu
 qL9diIZNr7LJw89To2n80VHHxHnNPZ/2QjhPbLHur5xny2Ine4sTrCjZA+rdbL/r1rxW
 PzuDiP21/biITjY4XRuzZhNris8wgjODrce79SNgmRieMksSUtxWnL12BzM/wj5P1t+V
 xeww==
X-Gm-Message-State: AC+VfDzK2CDgIALnnqBpl3SBmQd216NfV9JjE8+bXPR0DZ4KFDdhv/SO
 61/RuxwM1v3zQyAjlsvibCl+881yqeI=
X-Google-Smtp-Source: ACHHUZ7gPaKrOKsPUH/tAHf55qI+KQ3p8W8g+fo8VuOQda4lbUHC7Ndv1cJFdRzC0q6RkYyVZmo7HQ==
X-Received: by 2002:a05:6a21:78a9:b0:10a:cb95:5aa3 with SMTP id
 bf41-20020a056a2178a900b0010acb955aa3mr25901059pzc.7.1687508433357; 
 Fri, 23 Jun 2023 01:20:33 -0700 (PDT)
Received: from wheely.local0.net ([1.146.27.231])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a62e70f000000b0066884d4efdbsm5780604pfh.12.2023.06.23.01.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:20:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 4/4] target/ppc: Make checkstop stop the system
Date: Fri, 23 Jun 2023 18:19:53 +1000
Message-Id: <20230623081953.290875-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623081953.290875-1-npiggin@gmail.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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
 target/ppc/excp_helper.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4bfcfc3c3d..51e83d7f07 100644
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
@@ -165,6 +166,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
              env->error_code);
 }
 
+static void powerpc_checkstop(PowerPCCPU *cpu, const char *reason)
+{
+    CPUState *cs = CPU(cpu);
+
+    vm_stop(RUN_STATE_GUEST_PANICKED);
+
+    fprintf(stderr, "Entering checkstop state: %s\n", reason);
+    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+    if (qemu_log_separate()) {
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            fprintf(logfile, "Entering checkstop state: %s\n", reason);
+            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+            qemu_log_unlock(logfile);
+        }
+    }
+}
+
 #if defined(TARGET_PPC64)
 static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
                                 target_ulong *msr)
@@ -406,21 +425,9 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 
 static void powerpc_mcheck_test_and_checkstop(CPUPPCState *env)
 {
-    CPUState *cs = env_cpu(env);
-
-    if (FIELD_EX64(env->msr, MSR, ME)) {
-        return;
-    }
-
-    /* Machine check exception is not enabled. Enter checkstop state. */
-    fprintf(stderr, "Machine check while not allowed. "
-            "Entering checkstop state\n");
-    if (qemu_log_separate()) {
-        qemu_log("Machine check while not allowed. "
-                 "Entering checkstop state\n");
+    if (!FIELD_EX64(env->msr, MSR, ME)) {
+        powerpc_checkstop(env_archcpu(env), "machine check with MSR[ME]=0");
     }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.40.1


