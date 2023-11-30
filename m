Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202C7FF80C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 18:20:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8khO-00055M-1d; Thu, 30 Nov 2023 12:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8khM-00054p-DO
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:19:36 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8khK-0006dW-NN
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:19:36 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cfd78f8a12so11478805ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701364773; x=1701969573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AVZp+ShOFPnRVGbrxy+gEaCEjJII13GdahT5QjjZRQ=;
 b=lrKtjcp4iD44ddDt+38ff1sTh07kyzWCrBbjo0FBI10Tyru+fkEY+9xuHlTKJMXxlp
 Iq71JtjFpH3ymd6Xlcfs4/hQrCDAAD8+GyNGE86f6yzBOBsZZ2FFG8326NHpBVok0pcL
 AgVNGQ4mh9RsdByEAdkNb03ylsn8XtW5twjXFS57jwZY1GtyiKVaqmOCFJH/DUFMhvw6
 zQmLI1UsJOmbsyRVTXAAXFxlKaXQx0YUT8qC01xOnHZDHhtC8enu3/FQhfXnYUF8khDE
 K37kItPnr2cO33rBVnbUKECYzUPYYmrtPwnevgUMkzHLDiVR4Db/s2mgLACgcGuSVe3S
 QwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701364773; x=1701969573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2AVZp+ShOFPnRVGbrxy+gEaCEjJII13GdahT5QjjZRQ=;
 b=pV7RV/pfk2swJScDLRDhDFSJ9uSAuSHxPPRwUrk4ONMRzZjNhAVz+weJrULwDnJp0l
 ykXJx/5BoVSK+har0mJBiR5KpRvGolNwJmlikfTjYS1zHt4+TxcUpkTungPRNEpsQvO9
 cAozzVJtu6IjOVko1J6s1uiOmJaWMPpcPgW6EDNncEYYQ4x1hqDVJBlk5YapIgPiPS8Z
 +yhgJOwxDX0XpQnKqysFt3pRQoTmaEIoYbiWfFpmQrl+k3opIpbKENyohuVswj4ZyrQH
 vTejWCgs/lM98z8IKP4qtActaPX6AxObn6B29sun9qGlBz9fay4P27Q05kXhDZEM4XHe
 qFKg==
X-Gm-Message-State: AOJu0YzCbdeA2NN1QunxJbuOGM3Z2epYJUSaIdssPn4bNnWA9MTk370Z
 3G29vIVQ3jk095qcQd1i9oRQdswCYWw=
X-Google-Smtp-Source: AGHT+IEBAQmDacIdXBc8zqhpCfcbC5Je57QOeZuOLb8eBjjZitoFaDdn5wwPaaCStjwNP9cTVBeVHw==
X-Received: by 2002:a17:903:1248:b0:1cc:68a5:f388 with SMTP id
 u8-20020a170903124800b001cc68a5f388mr28097488plh.33.1701364773036; 
 Thu, 30 Nov 2023 09:19:33 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a201:19d0:7eb0:c76b:d82c:8f94])
 by smtp.gmail.com with ESMTPSA id
 bc3-20020a170902930300b001cc29ffcd96sm1645926plb.192.2023.11.30.09.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:19:32 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] target/xtensa: use generic instruction breakpoint
 infrastructure
Date: Thu, 30 Nov 2023 09:19:19 -0800
Message-Id: <20231130171920.3798954-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
References: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Don't embed ibreak exception generation into TB and don't invalidate TB
on ibreak address change. Add CPUBreakpoint pointers to xtensa
CPUArchState, use cpu_breakpoint_insert/cpu_breakpoint_remove_by_ref to
manage ibreak breakpoints and provide TCGCPUOps::debug_check_breakpoint
callback that recognizes valid instruction breakpoints.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c        |  1 +
 target/xtensa/cpu.h        |  4 ++++
 target/xtensa/dbg_helper.c | 46 +++++++++++++++++++++++++-------------
 target/xtensa/helper.c     | 12 ++++++++++
 target/xtensa/translate.c  | 17 --------------
 5 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index e20fe87bf255..b74ee8917065 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -235,6 +235,7 @@ static const struct TCGCPUOps xtensa_tcg_ops = {
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
+    .debug_check_breakpoint = xtensa_debug_check_breakpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index dd8172930653..8a423706d8c0 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -229,6 +229,7 @@ enum {
 #define MAX_NCCOMPARE 3
 #define MAX_TLB_WAY_SIZE 8
 #define MAX_NDBREAK 2
+#define MAX_NIBREAK 2
 #define MAX_NMEMORY 4
 #define MAX_MPU_FOREGROUND_SEGMENTS 32
 
@@ -547,6 +548,8 @@ struct CPUArchState {
 
     /* Watchpoints for DBREAK registers */
     struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
+    /* Breakpoints for IBREAK registers */
+    struct CPUBreakpoint *cpu_breakpoint[MAX_NIBREAK];
 };
 
 /**
@@ -590,6 +593,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+bool xtensa_debug_check_breakpoint(CPUState *cs);
 #endif
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void xtensa_count_regs(const XtensaConfig *config,
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 3e0c9e8e8be0..497dafca719c 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -33,27 +33,21 @@
 #include "exec/exec-all.h"
 #include "exec/address-spaces.h"
 
-static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
-{
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-    int ret = xtensa_get_physical_addr(env, false, vaddr, 2, 0,
-                                       &paddr, &page_size, &access);
-    if (ret == 0) {
-        tb_invalidate_phys_addr(&address_space_memory, paddr,
-                                MEMTXATTRS_UNSPECIFIED);
-    }
-}
-
 void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
 {
+    CPUState *cs = env_cpu(env);
     uint32_t change = v ^ env->sregs[IBREAKENABLE];
     unsigned i;
 
     for (i = 0; i < env->config->nibreak; ++i) {
         if (change & (1 << i)) {
-            tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
+            if (v & (1 << i)) {
+                cpu_breakpoint_insert(cs, env->sregs[IBREAKA + i],
+                                      BP_CPU, &env->cpu_breakpoint[i]);
+            } else {
+                cpu_breakpoint_remove_by_ref(cs, env->cpu_breakpoint[i]);
+                env->cpu_breakpoint[i] = NULL;
+            }
         }
     }
     env->sregs[IBREAKENABLE] = v & ((1 << env->config->nibreak) - 1);
@@ -62,12 +56,32 @@ void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
 void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 {
     if (env->sregs[IBREAKENABLE] & (1 << i) && env->sregs[IBREAKA + i] != v) {
-        tb_invalidate_virtual_addr(env, env->sregs[IBREAKA + i]);
-        tb_invalidate_virtual_addr(env, v);
+        CPUState *cs = env_cpu(env);
+
+        cpu_breakpoint_remove_by_ref(cs, env->cpu_breakpoint[i]);
+        cpu_breakpoint_insert(cs, v, BP_CPU, &env->cpu_breakpoint[i]);
     }
     env->sregs[IBREAKA + i] = v;
 }
 
+bool xtensa_debug_check_breakpoint(CPUState *cs)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = &cpu->env;
+    unsigned int i;
+
+    if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
+        return false;
+    }
+    for (i = 0; i < env->config->nibreak; ++i) {
+        if (env->sregs[IBREAKENABLE] & (1 << i) &&
+            env->sregs[IBREAKA + i] == env->pc) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         uint32_t dbreakc)
 {
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index dbeb97a953cc..151da75a41c5 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -231,6 +231,18 @@ void xtensa_breakpoint_handler(CPUState *cs)
             }
             cpu_loop_exit_noexc(cs);
         }
+    } else {
+        if (cpu_breakpoint_test(cs, env->pc, BP_GDB)
+            || !cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
+            return;
+        }
+        if (env->sregs[ICOUNT] == 0xffffffff &&
+            xtensa_get_cintlevel(env) < env->sregs[ICOUNTLEVEL]) {
+            debug_exception_env(env, DEBUGCAUSE_IC);
+        } else {
+            debug_exception_env(env, DEBUGCAUSE_IB);
+        }
+        cpu_loop_exit_noexc(cs);
     }
 }
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index de899405994e..87947236ca3a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1123,19 +1123,6 @@ static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContext *dc)
     return xtensa_op0_insn_len(dc, b0);
 }
 
-static void gen_ibreak_check(CPUXtensaState *env, DisasContext *dc)
-{
-    unsigned i;
-
-    for (i = 0; i < dc->config->nibreak; ++i) {
-        if ((env->sregs[IBREAKENABLE] & (1 << i)) &&
-                env->sregs[IBREAKA + i] == dc->pc) {
-            gen_debug_exception(dc, DEBUGCAUSE_IB);
-            break;
-        }
-    }
-}
-
 static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
                                          CPUState *cpu)
 {
@@ -1205,10 +1192,6 @@ static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         gen_set_label(label);
     }
 
-    if (dc->debug) {
-        gen_ibreak_check(env, dc);
-    }
-
     disas_xtensa_insn(env, dc);
 
     if (dc->icount) {
-- 
2.39.2


