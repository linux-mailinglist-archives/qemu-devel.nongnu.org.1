Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858D95D5CF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Aug 2024 21:05:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZYI-00053w-Rc; Fri, 23 Aug 2024 15:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXz-0003sA-GJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXu-0004N9-5C
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-201d5af11a4so20876065ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439721; x=1725044521;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfpDUlicfMa/w7Dap5Ged0zMOz5gW8WXfevhHdhAvZk=;
 b=MNeyNPm7doG+SZLCufZ4rQllpR7zNOtSAesbFuJxhB+G8/P5lfiQLgWW75TyPhWvpD
 tYDoQNnpEuTYxxDzzchG6m403nwb1e5EKVFtc7ofkCQbcVt3L1+ADp5ZThv5u3Y4GosS
 T33HgRIMhGLNrxsW3prg3Ki4Kj1B+BE1b19CBnRRpxnacIOfoZKzgq7jTOQ85X4o7R4a
 8FazoMxitao6AVVnp7JyudnXkg9xAP0y4gvGWWklNLH4qC1UoOl+a8f+HJv1X98kA98y
 NamYAW4AwpDySreUIPEFVgAX1Aj+4MthlSIapp57s7C39Vg7NoLasrHg4BcEdgHkEUw/
 Hltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439721; x=1725044521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfpDUlicfMa/w7Dap5Ged0zMOz5gW8WXfevhHdhAvZk=;
 b=xBFCTOQajhW7VJwklxM54tTV0JacMqFAbte5Y/yUnfaSTaBgWnhmOSr5X4yD7ZDNnQ
 JcZY5wr6S1aQPYsxdhHOC3uyYpSz1Nm+LFqca3QF8pV8880nYEyz2ltsQc4uQxyunKw1
 grxKlGY1FyyID2EVGyUr5PH1r0oU+zY/ANUvESmJdO8bMdX0Lc+mz07z9gHBroc0tyZC
 VDIf6g2UUHrmDrViAYOLVMcEMqFImW9LvSPan2L3MA1N3PCnxUWy2sI9ME6DOQRgkTgb
 FH7UYpQozCACALMLMPpSNQP1zd5r8EPmwBhl3SvZR1kvz9pK4zOxTJsRbQOAHdlkrjd7
 Uc2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Mip8NOoc+8GH2xaqSFQbQEnWJdncsbeW4aOjuaWfKLUCty25UdBEc/McpIk9Z/1gmWsANbGydvJO@nongnu.org
X-Gm-Message-State: AOJu0YzRC6Qjv3/Fw56sjKz7PnHy0kfl2g7/CtAvzpgGtAl/2gBi5UFI
 kQRH/RlQdnbBAzj2jxLPBmxyOq3yRK9JnNIf87Uw93d7Qrm85TphmoJS587rKZI=
X-Google-Smtp-Source: AGHT+IGXNTuzVgF2vIb91tPRhcLjuDezUCbvQ9vLS8QnRiiNuNp7AC/7lGwUOc8T27VpjgOD8BY2KA==
X-Received: by 2002:a17:903:18d:b0:201:f70a:7492 with SMTP id
 d9443c01a7336-2039e54679fmr33901795ad.53.1724439720615; 
 Fri, 23 Aug 2024 12:02:00 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:02:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 12/17] target/riscv: AMO operations always raise store/AMO
 fault
Date: Fri, 23 Aug 2024 12:01:34 -0700
Message-ID: <20240823190140.4156920-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch adds one more word for tcg compile which can be obtained during
unwind time to determine fault type for original operation (example AMO).
Depending on that, fault can be promoted to store/AMO fault.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h         |  9 ++++++++-
 target/riscv/cpu_helper.c  | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c |  1 +
 target/riscv/translate.c   |  2 +-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index dcc3bc9d93..3143141863 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -46,8 +46,13 @@ typedef struct CPUArchState CPURISCVState;
 /*
  * RISC-V-specific extra insn start words:
  * 1: Original instruction opcode
+ * 2: more information about instruction
  */
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
+/*
+ * b0: Whether a instruction always raise a store AMO or not.
+ */
+#define RISCV_UW2_ALWAYS_STORE_AMO 1
 
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
@@ -226,6 +231,8 @@ struct CPUArchState {
     bool      elp;
     /* shadow stack register for zicfiss extension */
     target_ulong ssp;
+    /* env place holder for extra word 2 during unwind */
+    target_ulong excp_uw2;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 95ef7b0bd1..0f32bede39 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1740,6 +1740,22 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
     return xinsn;
 }
 
+static target_ulong promote_load_fault(target_ulong orig_cause)
+{
+    switch (orig_cause) {
+    case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
+        return RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
+
+    case RISCV_EXCP_LOAD_ACCESS_FAULT:
+        return RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+
+    case RISCV_EXCP_LOAD_PAGE_FAULT:
+        return RISCV_EXCP_STORE_PAGE_FAULT;
+    }
+
+    /* if no promotion, return original cause */
+    return orig_cause;
+}
 /*
  * Handle Traps
  *
@@ -1751,6 +1767,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
+    bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
 
     /*
@@ -1784,6 +1801,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_PAGE_FAULT:
         case RISCV_EXCP_STORE_PAGE_FAULT:
+            if (always_storeamo) {
+                cause = promote_load_fault(cause);
+            }
             write_gva = env->two_stage_lookup;
             tval = env->badaddr;
             if (env->two_stage_indirect_lookup) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4da26cb926..83771303a8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -129,6 +129,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
         env->pc = pc;
     }
     env->bins = data[1];
+    env->excp_uw2 = data[2];
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b1d251e893..16fff70dac 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1265,7 +1265,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_next &= ~TARGET_PAGE_MASK;
     }
 
-    tcg_gen_insn_start(pc_next, 0);
+    tcg_gen_insn_start(pc_next, 0, 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.44.0


