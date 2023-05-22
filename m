Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCD70BF5E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15KN-00062y-9w; Mon, 22 May 2023 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q15K3-0005gJ-DR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:36 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q15K1-0007Zk-9B
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:35 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6af6f83fc49so1373750a34.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684761092; x=1687353092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LWzsvoeyRZYi55W6g8LfclyvLfCv9pYejizExVpUFk=;
 b=ZPrII9l8DK50q5NFkgYEA/rdXW/qrmoGRV1CFTNCYQLpQbecEn1xIBWm/QIjeBHooq
 pVZ8T8nnv9qv5ehs/++AF7XnsIxCiHg68tk42OFfJ/nkfijtC1bXEm6RWfm88WQ9DzKa
 B/zFbCf/4gCe3uETB5AAhgWuEZkrCyFPtcUqAv8C0dCP32V7YcX2RqAkxA9aGlcb+E/H
 vwE0PUP5Ybwn74kSh4zadiZKEW63cKjX5xjqAbztnlC1ya2IhSNWBEh/RKNwh2YYSLRp
 XJpl44nAAc9MO7FM1hdbXs9uEldHYp5908iEPd/wiLxi57u9PI48Yu0BcNjFAr0ZGU5L
 xDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761092; x=1687353092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LWzsvoeyRZYi55W6g8LfclyvLfCv9pYejizExVpUFk=;
 b=j1jKbAb6bSFiZeYdW/40o759lv55JAY7axia+rb/lJvW3t0G5BHiWQnbZyZ5VFa5HF
 UPLuXzpdQiyZGt3IggcN/A9+eDEEUvQqGLVSHxb4wIEAC5D7N5hiPSu6EU/QDuzhxTdW
 tTYbs9ueXqhgU6uIR8tI/yTAq+v3370uLCDbD+r/laa580v5qDXWwqMiExETme8zhehL
 cFRTm9KKbLoSae5MNR/0UDc3MYaJcm67JKJnLzu+nQhzsEbFzsUoMW3FgdSlbJDo/YAV
 hB3ucMtUpJwoiKIik8WPtPKTf8m5VjQgu0IAEJ3bwf77zpJ2nubyTalTtqQOm40N97PQ
 E5rQ==
X-Gm-Message-State: AC+VfDwsPCYpTgPQirPqLKdFNzmpxn3XWWbFbKTq7gQLMQalJCtmFjDO
 qQloDkVsDDlaA7Tykv6oOrXMaaZ9Zut5m5HW1KArOngG7EflF9W0TRRNomEO8gQZASrugJBFBcf
 GEr8vmIEDBSTdzJzFQq2UzZnzBrG+loRzXFc/19/hGg47xravmDKNzye2U43ZOQAnc+B4WlFkCE
 z9
X-Google-Smtp-Source: ACHHUZ4WbvReLo/eOT52/x9/1QwMZkw/DWw2xaQaZH+zvbaTVn0ieWxQd+dVnFzxwdW4y3+EA9GIlA==
X-Received: by 2002:a9d:644c:0:b0:6ad:d1b3:d35f with SMTP id
 m12-20020a9d644c000000b006add1b3d35fmr5191056otl.37.1684761091646; 
 Mon, 22 May 2023 06:11:31 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a9d6c83000000b006af731d100fsm1369182otr.75.2023.05.22.06.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 06:11:31 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v3 2/4] target/riscv: Add Smrnmi CSRs.
Date: Mon, 22 May 2023 06:11:21 -0700
Message-Id: <20230522131123.3498539-3-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522131123.3498539-1-tommy.wu@sifive.com>
References: <20230522131123.3498539-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=tommy.wu@sifive.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/cpu.c      |  5 +++
 target/riscv/cpu.h      |  4 ++
 target/riscv/cpu_bits.h | 11 ++++++
 target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 39b74569b1..1b645c5485 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -810,6 +810,11 @@ static void riscv_cpu_reset_hold(Object *obj)
         riscv_trigger_init(env);
     }
 
+    if (cpu->cfg.ext_smrnmi) {
+        env->rnmip = 0;
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+    }
+
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6c14b93cb5..f44fd95f16 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -368,6 +368,10 @@ struct CPUArchState {
     uint64_t kvm_timer_frequency;
 
     /* RNMI */
+    target_ulong mnscratch;
+    target_ulong mnepc;
+    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
+    target_ulong mnstatus;
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7cb43b88f3..d7bd4538ab 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -355,6 +355,12 @@
 #define CSR_PMPADDR14       0x3be
 #define CSR_PMPADDR15       0x3bf
 
+/* RNMI */
+#define CSR_MNSCRATCH       0x740
+#define CSR_MNEPC           0x741
+#define CSR_MNCAUSE         0x742
+#define CSR_MNSTATUS        0x744
+
 /* Debug/Trace Registers (shared with Debug Mode) */
 #define CSR_TSELECT         0x7a0
 #define CSR_TDATA1          0x7a1
@@ -624,6 +630,11 @@ typedef enum {
 #define SATP64_ASID         0x0FFFF00000000000ULL
 #define SATP64_PPN          0x00000FFFFFFFFFFFULL
 
+/* RNMI mnstatus CSR mask */
+#define MNSTATUS_NMIE       0x00000008
+#define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPP       0x00001800
+
 /* VM modes (satp.mode) privileged ISA 1.10 */
 #define VM_1_10_MBARE       0
 #define VM_1_10_SV32        1
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4451bd1263..a1d39fc116 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -536,6 +536,18 @@ static RISCVException debug(CPURISCVState *env, int csrno)
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
+
+static RISCVException rnmi(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (cpu->cfg.ext_smrnmi) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
 #endif
 
 static RISCVException seed(CPURISCVState *env, int csrno)
@@ -2336,6 +2348,66 @@ static RISCVException rmw_miph(CPURISCVState *env, int csrno,
     return ret;
 }
 
+static int read_mnscratch(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnscratch;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mnscratch = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mnepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnepc;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mnepc = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mncause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mncause;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mncause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mncause = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mnstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnstatus;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
+
+    if (riscv_has_ext(env, RVH)) {
+        /* Flush tlb on mnstatus fields that affect VM. */
+        if ((val ^ env->mnstatus) & MNSTATUS_MNPV) {
+            tlb_flush(env_cpu(env));
+        }
+
+        mask |= MNSTATUS_MNPV;
+    }
+
+    /* mnstatus.mnie can only be cleared by hardware. */
+    env->mnstatus = (env->mnstatus & MNSTATUS_NMIE) | (val & mask);
+    return RISCV_EXCP_NONE;
+}
+
 /* Supervisor Trap Setup */
 static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
                                         Int128 *val)
@@ -4204,6 +4276,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                         write_sstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* RNMI */
+    [CSR_MNSCRATCH] = { "mnscratch", rnmi, read_mnscratch, write_mnscratch,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNEPC]     = { "mnepc",     rnmi, read_mnepc,     write_mnepc,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNCAUSE]   = { "mncause",   rnmi, read_mncause,   write_mncause,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNSTATUS]  = { "mnstatus",  rnmi, read_mnstatus,  write_mnstatus,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },
-- 
2.31.1


