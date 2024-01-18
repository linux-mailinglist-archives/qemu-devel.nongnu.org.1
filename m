Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6D2831C10
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU2D-0003Yw-4Y; Thu, 18 Jan 2024 10:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0m-0001Ff-Sa; Thu, 18 Jan 2024 10:08:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0k-0008Ct-VH; Thu, 18 Jan 2024 10:08:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso102534625ad.0; 
 Thu, 18 Jan 2024 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590533; x=1706195333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Olm3BaehHNgI2qFx/qMhuvBGnuIZS2/POinOe4v1pxk=;
 b=M0kd4eAwWCtgHZzQmKx4c+JKi0BMp5v4ArdcE3AEj6Z6UhRslEbf+lzOmFOh66qnir
 xxRutICwv99QI/VNLtb78v4TPMbCNv6mN1B5r9BcL3wCpLRQGD03ZLUt6XkKjEwxeUgh
 1C2dJsbZxVfwxPfQWH8cElenLEGbNq8dHn/4WDSEh4OjwXZaCdubiAjL3ugNpusYhkYe
 RbEjhbXCUIiQcM+pBCJNKAASp1uFEz7bTvXNWn7hTaUO5VW77Bci12acq6zcYwL6Nw87
 Oc47ZWclznIF+2K0HK4oJN+WqFt57VerfSep8AhjMdvGbbJEWIBHBXzR5W+x0JH0WnbY
 Klog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590533; x=1706195333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Olm3BaehHNgI2qFx/qMhuvBGnuIZS2/POinOe4v1pxk=;
 b=lXIUHrcEGYzTPHE15VsxFjeK7EKo3UzIj1Mw9xXxXaBmsS+66pnYUFbFgFDdWgBTu8
 csCojXNATvKkXllyCZIbxtM6rhyPWV3hJfOFcd31wIpSA2e2Dkriu9qH2YzAulNfHiww
 1JuSIDrGLqTGew00e2BGs2iZGIiJrd1WV11k7pISR/T6SmwFWhlt6zjHl7aZpz1tSJdu
 cnofwzQz7ptnsIGp9ImiZ0qPEmk1x3fAPvVUmU4SZtgrZw+/W/adOuxjCigl2JRAbPoa
 Q0aOXbl8WiLYQmwrX1HoM5t7I/TjE9jc4geqEwmOvAe4TDW4EZifuY5TjPWVVtLr29fQ
 aApw==
X-Gm-Message-State: AOJu0YwUQSWzfEK99UZrfrW3UQiw7HvWxtQCPQaEloicCREfmbk9Olxt
 UpM8Lit07WS8eqO2sJyuVIoDp0cZRk067yCLKMkA9A0M422A2Z3WdBbTDtvN
X-Google-Smtp-Source: AGHT+IHUHzWDaAU1SkOc3GYiimuNotS6zvrINZ+CoIhj9BPjCs0jkipz5JH8GJzDq2/vQakZU3yr3Q==
X-Received: by 2002:a17:902:f68e:b0:1d4:bd0a:2252 with SMTP id
 l14-20020a170902f68e00b001d4bd0a2252mr1060283plg.55.1705590532974; 
 Thu, 18 Jan 2024 07:08:52 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 26/26] target/ppc: add SMT support to msgsnd broadcast
Date: Fri, 19 Jan 2024 01:06:44 +1000
Message-ID: <20240118150644.177371-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

msgsnd has a broadcast mode that sends hypervisor doorbells to all
threads belonging to the same core as the target. A "subcore" mode
sends to all or one thread depending on 1LPAR mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                              |  6 +-
 target/ppc/helper.h                           |  2 +-
 target/ppc/excp_helper.c                      | 57 +++++++++++++------
 .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a50440ea51..376aee652f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1165,7 +1165,11 @@ FIELD(FPSCR, FI, FPSCR_FI, 1)
 
 #define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
 
-#define DBELL_BRDCAST                  PPC_BIT(37)
+#define DBELL_BRDCAST_MASK             PPC_BITMASK(37, 38)
+#define DBELL_BRDCAST_SHIFT            25
+#define DBELL_BRDCAST_SUBPROC          (0x1 << DBELL_BRDCAST_SHIFT)
+#define DBELL_BRDCAST_CORE             (0x2 << DBELL_BRDCAST_SHIFT)
+
 #define DBELL_LPIDTAG_SHIFT            14
 #define DBELL_LPIDTAG_MASK             (0xfff << DBELL_LPIDTAG_SHIFT)
 #define DBELL_PIRTAG_MASK              0x3fff
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 43333b4d5e..cb1b5345fb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -695,7 +695,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
 
 DEF_HELPER_1(msgsnd, void, tl)
 DEF_HELPER_2(msgclr, void, env, tl)
-DEF_HELPER_1(book3s_msgsnd, void, tl)
+DEF_HELPER_2(book3s_msgsnd, void, env, tl)
 DEF_HELPER_2(book3s_msgclr, void, env, tl)
 #endif
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 030260e8a9..1db6aaf7ee 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3067,7 +3067,7 @@ void helper_msgsnd(target_ulong rb)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *cenv = &cpu->env;
 
-        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
+        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
             ppc_set_irq(cpu, irq, 1);
         }
     }
@@ -3086,6 +3086,16 @@ static bool dbell_type_server(target_ulong rb)
     return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
 }
 
+static inline bool dbell_bcast_core(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
+}
+
+static inline bool dbell_bcast_subproc(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
@@ -3095,32 +3105,43 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
     ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
 }
 
-static void book3s_msgsnd_common(int pir, int irq)
+void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
 {
-    CPUState *cs;
+    int pir = rb & DBELL_PROCIDTAG_MASK;
+    bool brdcast = false;
+    CPUState *cs, *ccs;
+    PowerPCCPU *cpu;
 
-    bql_lock();
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *cenv = &cpu->env;
+    if (!dbell_type_server(rb)) {
+        return;
+    }
 
-        /* TODO: broadcast message to all threads of the same  processor */
-        if (cenv->spr_cb[SPR_PIR].default_value == pir) {
-            ppc_set_irq(cpu, irq, 1);
-        }
+    cpu = ppc_get_vcpu_by_pir(pir);
+    if (!cpu) {
+        return;
     }
-    bql_unlock();
-}
+    cs = CPU(cpu);
 
-void helper_book3s_msgsnd(target_ulong rb)
-{
-    int pir = rb & DBELL_PROCIDTAG_MASK;
+    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
+                                 (env->flags & POWERPC_FLAG_SMT_1LPAR))) {
+        brdcast = true;
+    }
 
-    if (!dbell_type_server(rb)) {
+    if (cs->nr_threads == 1 || !brdcast) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
         return;
     }
 
-    book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
+    /*
+     * Why is bql needed for walking CPU list? Answer seems to be because ppc
+     * irq handling needs it, but ppc_set_irq takes the lock itself if needed,
+     * so could this be removed?
+     */
+    bql_lock();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
+    }
+    bql_unlock();
 }
 
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index 0142801985..8abbb89630 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -59,7 +59,7 @@ static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
 
 #if !defined(CONFIG_USER_ONLY)
     if (is_book3s_arch2x(ctx)) {
-        gen_helper_book3s_msgsnd(cpu_gpr[a->rb]);
+        gen_helper_book3s_msgsnd(tcg_env, cpu_gpr[a->rb]);
     } else {
         gen_helper_msgsnd(cpu_gpr[a->rb]);
     }
-- 
2.42.0


