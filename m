Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9E831C69
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:26:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUH0-0000xT-Fw; Thu, 18 Jan 2024 10:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQUGx-0000qh-Vc; Thu, 18 Jan 2024 10:25:40 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQUGw-00074L-92; Thu, 18 Jan 2024 10:25:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3f29fea66so74215775ad.3; 
 Thu, 18 Jan 2024 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705591536; x=1706196336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsVO3XzE6qK2xy1kN50Qjep3b+zCKGJ+P5EuOLNL/uY=;
 b=UnWugjg1xeATJ2kmdkB/svGpvEB+YujooS2GYJ6X+PmYXzHntR9EWFrQf9Wg4GKs5g
 EizXB9zD36KeAD4vuuJGooMjkkbtFIntXZe6X1ore3QLXvbjQWiYOoBzx4jXF5IPO2CL
 Ubs/xgmu2EMWRD324smkDMuKIQ+q4CFC4z//nJhe9tqMdksLbVGja/GfS+eyPBlToU9S
 cbFFH51DwO1nAbrMN2iL0ubgSq5FQ9RKJCL962hsAa37MDSrnhp6rdpYEVimf9oGFg/a
 3Q+WrL2e9XZSnLuJKZRnNVrKcTnJCnMVxPBLSWiMnmkihBRWaKaqHlsOqzjHyq/7z6dA
 O7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705591536; x=1706196336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsVO3XzE6qK2xy1kN50Qjep3b+zCKGJ+P5EuOLNL/uY=;
 b=H4WlBIxyLGQjP2JptYjgOG5fDDTgSFBpunCSbi5arh0CNiYRcnJjUj0kdbiqV6lnp1
 1mIj/L5sVO80qW6kJOjqlsZ0E76tPnD7TcfquD+vOupFbMjX/NDlOnVUequnxMALLWJU
 guow1Z54ieJKZjqdM2fGBwCgDWVDOiM6Ck3YHEPnf1qOIy3Qq3DeueutJyF62+mmzdi3
 OkkkJ1tyDw2srqwJ+qUq2XcJJGGi28B7B8nbt/bMdQPwSwQzJ7S8pen/CJmmlPGdoyJL
 pCvSAKZzOvvwr3QBd3HqiXyvXg17VJx0JOa+I26vEBR3EwO9BbpE/+B73tyuMr0bd9aJ
 7nCA==
X-Gm-Message-State: AOJu0Yzlah3zN1S9vCr5+DQEgC0elUuCxI6qlORt0z2nnVucQPe3/+OT
 ppCHSOY7wS3N+0v7CsQGK+T5pZxYSXghj+dbAq1KIgxBrIu3ucm4T6OsEOQW
X-Google-Smtp-Source: AGHT+IG6Dy78rwUnFQU/4Hn+kTuEb8xmsbskvrA/UtQ8VwuwIpE0ndqYwY5vNv2LzHvXeQzjZ5/CGA==
X-Received: by 2002:a17:902:d505:b0:1d7:6ba:1246 with SMTP id
 b5-20020a170902d50500b001d706ba1246mr1062549plg.65.1705591536292; 
 Thu, 18 Jan 2024 07:25:36 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 ky12-20020a170902f98c00b001d4c98c7439sm1527067plb.276.2024.01.18.07.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:25:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] target/ppc: Make checkstop actually stop the system
Date: Fri, 19 Jan 2024 01:25:22 +1000
Message-ID: <20240118152523.178576-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118152523.178576-1-npiggin@gmail.com>
References: <20240118152523.178576-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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
serviced, and other CPUs run. Stop the machine with
qemu_system_guest_panicked.

Change the logging not to print separately to stderr because a
checkstop is a guest error (or perhaps a simulated machine error)
rather than a QEMU error. CPU registers are dumped.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Fix loop exit so it stops on the checkstop-causing instruction, rather than
  after it.

Since v2:
- Use qemu_system_guest_panicked rather than vm_stop (Richard)
- Move away from printing to stderr (Zoltan)
- Reduce changes to log messages.
---
 target/ppc/excp_helper.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1db6aaf7ee..022adc36c5 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -427,20 +429,29 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
+    FILE *f;
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
 
-    /* Machine check exception is not enabled. Enter checkstop state. */
-    fprintf(stderr, "Machine check while not allowed. "
-            "Entering checkstop state\n");
-    if (qemu_log_separate()) {
-        qemu_log("Machine check while not allowed. "
-                 "Entering checkstop state\n");
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Entering checkstop state: "
+                   "machine check with MSR[ME]=0\n");
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
     }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
+
+    qemu_system_guest_panicked(NULL);
+
+    cpu_loop_exit_noexc(cs);
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.42.0


