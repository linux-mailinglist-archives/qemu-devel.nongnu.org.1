Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E408098F644
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Oct 2024 20:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQep-0007Sx-4i; Thu, 03 Oct 2024 14:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeR-0007GE-7F
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQeO-00054V-Ma
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:34:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b01da232aso10891505ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980446; x=1728585246;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfipH9u/Brft1+pMPkbr2H8aBkNzishpVxTjwiAZbgo=;
 b=wGcJvp6Ne4CebEuqCK6XC8wk7/KvoLO9ZPC9QYohA1SbelXXObRdpoLdcPHPGYywaN
 hSX+aQKCjeGKE7pyOTnALq915vEz2KsUFMrdMUiZuTsGGISubCg8HQO03K0V1dg6ltsC
 q4XMvRSSON/EosmuIu8PeTO4n+6zEda0OSHp6BLSOg+2iGIron0C9woISJorDncRtXRd
 5f+2+qzMknrrTqiOnvIr6mTumt0PIcqAmT2Y51+U3ieMOeuu5VKLfpF8HD5VnmCWZxui
 LRPl2dWpSYEHcsZyuqUDDd434iqWf53A0z9egi69UHKiiQsV3RUwzFjZ8fzL6NIaistX
 Xctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980446; x=1728585246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfipH9u/Brft1+pMPkbr2H8aBkNzishpVxTjwiAZbgo=;
 b=UnaKtMffawBq5a6r+TuYvXFLcZeMWbN3JQhBebBOhm8mXLcVvcVYi4jkzzNfMR7nf9
 I+lrqWietlji/2QvXl85mXck6A+8D/TPBnpqgoOTJKW2fgHYnm+SsgC2BL2eWmZjHemx
 flSAJJJkSrwgm3INvv3HjkhCGHrMOnRNXpYoMCbjY2u6J6op9tqImUtlnBajoaPEptTQ
 jEwq7M08XycV02H2yyyNL3xkdXecoNbvSewgElap7EoycTe9aVvg2m+4w1PatcgHUBl4
 V8Lp/7FlbDLhXXhuHd8V3Uv/6e51AX5VDeo0Zx1NpAlLAMCCVXyeNLgaubGss8zVjrnl
 4CLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPGoaJ517+nCBoXUH23ibsduhiMhXK6WVdiHJHLkWybt/zgFdTaDqgD0Dkkg5cXJUABGAqHC2MVm0e@nongnu.org
X-Gm-Message-State: AOJu0YyBcYc9wcA/3GY7szMdYLiGgsNKzXa9xFPN82YzVkeT8M+1N4NB
 i6QwpVT0YUUzxpOi36UBW1Lo9r2mFot0kMjp708GhEPHdnAesZQkDwyZY+LJ29E=
X-Google-Smtp-Source: AGHT+IGln98to+rnjQphNzDQ6PSBtC3MJRzk0GS8c0HMy/MXimzHC2Fz6sfe1iuMEHNfCF4qxsm+dQ==
X-Received: by 2002:a17:902:f683:b0:20b:5231:cd58 with SMTP id
 d9443c01a7336-20bff4b3472mr1204245ad.16.1727980445650; 
 Thu, 03 Oct 2024 11:34:05 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:34:05 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 15/21] target/riscv: AMO operations always raise store/AMO
 fault
Date: Thu,  3 Oct 2024 11:33:36 -0700
Message-ID: <20241003183342.679249-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241003183342.679249-1-debug@rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  9 ++++++++-
 target/riscv/cpu_helper.c  | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c |  1 +
 target/riscv/translate.c   |  2 +-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d39650636c..fb93b0c859 100644
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
 
@@ -234,6 +239,8 @@ struct CPUArchState {
     bool      elp;
     /* shadow stack register for zicfiss extension */
     target_ulong ssp;
+    /* env place holder for extra word 2 during unwind */
+    target_ulong excp_uw2;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ab46f694b5..3aae6343c8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1757,6 +1757,22 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
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
@@ -1769,6 +1785,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     bool virt = env->virt_enabled;
     bool write_gva = false;
+    bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
 
     /*
@@ -1804,6 +1821,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 6c0c319499..c62c221696 100644
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
index afa2ed4e3a..0322597bf6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1264,7 +1264,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_next &= ~TARGET_PAGE_MASK;
     }
 
-    tcg_gen_insn_start(pc_next, 0);
+    tcg_gen_insn_start(pc_next, 0, 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.45.0


