Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F106DA15FB3
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Jan 2025 02:18:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJta-00078j-9k; Sat, 18 Jan 2025 20:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtW-0006qn-V2
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:30 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtU-0003MY-EU
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:30 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so4504498a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249267; x=1737854067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q55Z6JAFa4QpEJ8TsmFf/6pKyZUDknBgvusG+66LWAY=;
 b=X1anMRtet68AQr/o8iQbj5O4S0f87XDDtK/w+0PnM6LUrA1/y2fCCRynpZbFPQ2Skr
 aFGa3oitIupRN6unSQbvAfyVdYTrXJ23n/BniXKd5ds3tU1LTaU9137jOhqJJNLeecvm
 SRqfYJZZjGVgabyfqYseyWUV2FXlYlmocsfRY/slJWtCaeN9RF/fWG1PhJEyswZ2KY9d
 ZKRXDOp4gxcPACQkBRTLeUVvIJv1LFsasDHO07JwSPDYGeOTcN5kunfMON8VBm/QGhSO
 2LvwDkaZanLWdMM5eFuxfxk4tX2aakbLQpiZt/XrlNYpXoINt5VkwgcysFxhHMF5GeA9
 R2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249267; x=1737854067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q55Z6JAFa4QpEJ8TsmFf/6pKyZUDknBgvusG+66LWAY=;
 b=mZoUBhmRSTv93WrMxE3WHO6rjSlIyrBcSumLvGQp5ywkHRHJN6jLsnlx6PB6oBLLHn
 GCPFAGeW4dSTRLNjC7bd4evOzkcTdiJGaga8NjFEBVNV8aOWbiJ0uiutACEoI4AKPsW8
 ogdjr4y+TOcqz7Gl/TjakP3CjNKu0FIbRiSVxKheLU9DiM1J/scrvR9KVd9bESMGaZPR
 kzBH4O8QHgicf6IF0tPOfUseKmv/CfSj7/0chWaDpE2s8Y88ylyiWYk+pwUJc9bXGk+O
 liKMGYdEId3fk1rYJLLwFpSTaQPZB4a7ewDW/+QT42oMKeyI3LVJxGwWKQmo7XP7yte9
 WB4g==
X-Gm-Message-State: AOJu0Yzg/YLVM9pNHN+OdMGoKm3UX7D8dme/V53KsXsvKdahyNACwysd
 irv8W8yYdiovxEbBHXZs8rki1b6A7xYM3KMQbjLPURqnWLkF1cln0Ass8h1t
X-Gm-Gg: ASbGncvUKdyxzvfWSx8+pXGNnH8KJUp4ChOoWqVNR4rE1XvVUdHfhfgxLJYvGQmzXRN
 nF5iODCTuY8PE+GDFVuzPXI9eE/UfKOaJmYTofvJaS5iDiLmScYE7SSuxZOL3V1h8qUIZoCDrEp
 QunfubjpwI6XQpMUWglzVX7KQFwtGQjZ9Q/sXhyxDhTg2F2cR3HTW+YJQzEDWRekm2FBzRZn5xj
 fo2/ngv6w/u3GzsNAaDvEHr25xMzlIldYGUvVuf9bT6s1hNivLFPP8QV1MxvwkofgL7GuJrMVar
 g1wxD3ynPn0Rte7d8+J9HgEFLT/9NqukJw0AVNTW3l5BVOqlqTz7E5TWrRf9YHiBG4o+meGjyA=
 =
X-Google-Smtp-Source: AGHT+IFqA5l8vu+XFmY2lG7jrhHVbjjACqw5FjsbIKcyqMuZ/95KrnbwMC2cB42ie1ugcLJ4RgsQQg==
X-Received: by 2002:a17:90a:c2c5:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2f782c9c88fmr12758167a91.16.1737249266783; 
 Sat, 18 Jan 2025 17:14:26 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 31/50] target/riscv: Support generic CSR indirect access
Date: Sun, 19 Jan 2025 11:12:06 +1000
Message-ID: <20250119011225.11452-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the indirect access registers required by sscsrind/smcsrind
and the operations on them. Note that xiselect and xireg are used for
both AIA and sxcsrind, and the behavior of accessing them depends on
whether each extension is enabled and the value stored in xiselect.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-4-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  28 +++++++-
 target/riscv/csr.c      | 144 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index d51f3d8cef..6b1446fb7e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -173,6 +173,13 @@
 #define CSR_MISELECT        0x350
 #define CSR_MIREG           0x351
 
+/* Machine Indirect Register Alias */
+#define CSR_MIREG2          0x352
+#define CSR_MIREG3          0x353
+#define CSR_MIREG4          0x355
+#define CSR_MIREG5          0x356
+#define CSR_MIREG6          0x357
+
 /* Machine-Level Interrupts (AIA) */
 #define CSR_MTOPEI          0x35c
 #define CSR_MTOPI           0xfb0
@@ -222,6 +229,13 @@
 #define CSR_SISELECT        0x150
 #define CSR_SIREG           0x151
 
+/* Supervisor Indirect Register Alias */
+#define CSR_SIREG2          0x152
+#define CSR_SIREG3          0x153
+#define CSR_SIREG4          0x155
+#define CSR_SIREG5          0x156
+#define CSR_SIREG6          0x157
+
 /* Supervisor-Level Interrupts (AIA) */
 #define CSR_STOPEI          0x15c
 #define CSR_STOPI           0xdb0
@@ -288,6 +302,13 @@
 #define CSR_VSISELECT       0x250
 #define CSR_VSIREG          0x251
 
+/* Virtual Supervisor Indirect Alias */
+#define CSR_VSIREG2         0x252
+#define CSR_VSIREG3         0x253
+#define CSR_VSIREG4         0x255
+#define CSR_VSIREG5         0x256
+#define CSR_VSIREG6         0x257
+
 /* VS-Level Interrupts (H-extension with AIA) */
 #define CSR_VSTOPEI         0x25c
 #define CSR_VSTOPI          0xeb0
@@ -803,10 +824,13 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_EIE63                0xff
 #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
-#define ISELECT_MASK                       0x1ff
+#define ISELECT_MASK_AIA                   0x1ff
+
+/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+#define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
-#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
+#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
 
 /* IMSIC bits (AIA) */
 #define IMSIC_TOPEI_IID_SHIFT              16
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7f4348fe86..49648ddc95 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -306,6 +306,15 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
     return any32(env, csrno);
 }
 
+static RISCVException csrind_any(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcsrind) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
 {
     if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
@@ -389,6 +398,15 @@ static bool csrind_or_aia_extensions_present(CPURISCVState *env)
     return csrind_extensions_present(env) || aia_extensions_present(env);
 }
 
+static RISCVException csrind_smode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smode(env, csrno);
+}
+
 static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
 {
     if (!csrind_or_aia_extensions_present(env)) {
@@ -417,6 +435,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
 
 }
 
+static RISCVException csrind_hmode(CPURISCVState *env, int csrno)
+{
+    if (!csrind_extensions_present(env)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return hmode(env, csrno);
+}
+
 static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
 {
     if (!csrind_or_aia_extensions_present(env)) {
@@ -2068,7 +2095,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
     case CSR_SISELECT:
         return CSR_VSISELECT;
     case CSR_SIREG:
-        return CSR_VSIREG;
+    case CSR_SIREG2:
+    case CSR_SIREG3:
+    case CSR_SIREG4:
+    case CSR_SIREG5:
+    case CSR_SIREG6:
+        return CSR_VSIREG + (csrno - CSR_SIREG);
     default:
         return csrno;
     };
@@ -2108,7 +2140,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
         *val = *iselect;
     }
 
-    wr_mask &= ISELECT_MASK;
+    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind) {
+        wr_mask &= ISELECT_MASK_SXCSRIND;
+    } else {
+        wr_mask &= ISELECT_MASK_AIA;
+    }
+
     if (wr_mask) {
         *iselect = (*iselect & ~wr_mask) | (new_val & wr_mask);
     }
@@ -2247,6 +2284,56 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+/*
+ * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
+ *
+ * Perform indirect access to xireg and xireg2-xireg6.
+ * This is a generic interface for all xireg CSRs. Apart from AIA, all other
+ * extension using csrind should be implemented here.
+ */
+static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
+                              target_ulong isel, target_ulong *val,
+                              target_ulong new_val, target_ulong wr_mask)
+{
+    return -EINVAL;
+}
+
+static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
+                      target_ulong new_val, target_ulong wr_mask)
+{
+    bool virt = false;
+    int ret = -EINVAL;
+    target_ulong isel;
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Translate CSR number for VS-mode */
+    csrno = csrind_xlate_vs_csrno(env, csrno);
+
+    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG6 &&
+        csrno != CSR_MIREG4 - 1) {
+        isel = env->miselect;
+    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG6 &&
+               csrno != CSR_SIREG4 - 1) {
+        isel = env->siselect;
+    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
+               csrno != CSR_VSIREG4 - 1) {
+        isel = env->vsiselect;
+        virt = true;
+    } else {
+        goto done;
+    }
+
+    return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
+
+done:
+    return (env->virt_enabled && virt) ?
+            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+}
+
 static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong *val, target_ulong new_val,
                                 target_ulong wr_mask)
@@ -2279,8 +2366,21 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
          goto done;
     };
 
+    /*
+     * Use the xiselect range to determine actual op on xireg.
+     *
+     * Since we only checked the existence of AIA or Indirect Access in the
+     * predicate, we should check the existence of the exact extension when
+     * we get to a specific range and return illegal instruction exception even
+     * in VS-mode.
+     */
     if (xiselect_aia_range(isel)) {
         return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
+    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
+               riscv_cpu_cfg(env)->ext_sscsrind) {
+        return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
 done:
@@ -2760,7 +2860,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
-    if (riscv_cpu_cfg(env)->ext_smaia) {
+    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -2853,7 +2953,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
-    if (riscv_cpu_cfg(env)->ext_ssaia) {
+    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
         wr_mask |= SMSTATEEN0_SVSLCT;
     }
 
@@ -5062,6 +5162,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MIREG]    = { "mireg",    csrind_or_aia_any,   NULL, NULL,
                        rmw_xireg                                       },
 
+    /* Machine Indirect Register Alias */
+    [CSR_MIREG2]   = { "mireg2", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG3]   = { "mireg3", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG4]   = { "mireg4", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG5]   = { "mireg5", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+    [CSR_MIREG6]   = { "mireg6", csrind_any, NULL, NULL, rmw_xiregi,
+                       .min_priv_ver = PRIV_VERSION_1_12_0          },
+
     /* Machine-Level Interrupts (AIA) */
     [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
     [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
@@ -5193,6 +5305,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SIREG]      = { "sireg",      csrind_or_aia_smode, NULL, NULL,
                          rmw_xireg                                          },
 
+    /* Supervisor Indirect Register Alias */
+    [CSR_SIREG2]      = { "sireg2", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG3]      = { "sireg3", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG4]      = { "sireg4", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG5]      = { "sireg5", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_SIREG6]      = { "sireg6", csrind_smode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* Supervisor-Level Interrupts (AIA) */
     [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
     [CSR_STOPI]      = { "stopi",      aia_smode, read_stopi },
@@ -5275,6 +5399,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIREG]      = { "vsireg",      csrind_or_aia_hmode, NULL, NULL,
                           rmw_xireg                                         },
 
+    /* Virtual Supervisor Indirect Alias */
+    [CSR_VSIREG2]     = { "vsireg2", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG3]     = { "vsireg3", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG4]     = { "vsireg4", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG5]     = { "vsireg5", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+    [CSR_VSIREG6]     = { "vsireg6", csrind_hmode, NULL, NULL, rmw_xiregi,
+                          .min_priv_ver = PRIV_VERSION_1_12_0                },
+
     /* VS-Level Interrupts (H-extension with AIA) */
     [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
     [CSR_VSTOPI]      = { "vstopi",      aia_hmode, read_vstopi },
-- 
2.48.1


