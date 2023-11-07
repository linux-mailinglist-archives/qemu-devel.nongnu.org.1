Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C89687E3310
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bs7-0003im-FQ; Mon, 06 Nov 2023 21:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bs1-0003VY-FK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:13 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Brx-0002oo-O6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:31:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc1ee2d8dfso47089995ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324262; x=1699929062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlX1VQasrS2peO0LifeKFR+P9fYeUoOJaqvdbWuFzgo=;
 b=CP3NBd6F6LKDzv/fuS9elgOTcQ+HVBuHeUsHTxBqlmOa/Fm4bY7wXyJPimt4QGQNTl
 WeRGXn6CNGJh6oEvlcHeSFdliIWlvO1mzB3bMr7/i2nC80HN7kNL8iw9a7SuvArcU6Cn
 jqL+NxB1ba7H4kMZKhrMhqQsfspoiEBjgkJB5A4t3dl24tjq3fAqWIzcCf5K8RnFzuII
 N34chfSIIoJ/qsraJtF7C3Moi4O7O66yLZpryvY/h1qhrU9XXvMltoZwY1wous0AF8GO
 hUbe95y2cdTG6h/wnShAiDi2klzpERxNCyRH3+Qssayf6YfktyPsv5LuDlgVbCu8U2Fy
 kbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324262; x=1699929062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlX1VQasrS2peO0LifeKFR+P9fYeUoOJaqvdbWuFzgo=;
 b=SLp0hwHRF1m0pM5s45rzSvOPTEqsj/D9/KLHOgqpEG/g2SP2WTEOH8JtpLoywsZ0nd
 IG4NluJr9Eojb6zPVTXjNtvfi3UdMzD9K/eyQ1znTOFlFxd0zzH2Fonej31O+SVoM9vU
 lRcuTjk1sVbAev8lNlsZvCB7Jaqbk5vuQgQ0EKmEhKvmkpjnrYQxQUDLBRhhRmJfSD6j
 NMfKWH9lrMXbgE/lxa9VsEVDVFp3bJUeT3kWu2hVvjqFJfQiMvo1OIw4Hxm1JZKvyYva
 J78Ro/8+qy3St/S1PNBzvQzbsOyCf8KspQr2pnMEV7VjTKPmaFTxLZ6piqSibGO9jHyi
 SVww==
X-Gm-Message-State: AOJu0YwkVpjsRvZFhGfgM8evFVEwPWrWG2Eb87Cz2yt5QVhBsKW3dtfv
 N2Fxm4Fq6fqLBSJHPsinxUCXOSc9Mbi00A==
X-Google-Smtp-Source: AGHT+IGLYZWcc3665NhU4sAHH+qrV6sFtq238wUPnAsc+FbM20y+gpEhuY9HUdVKsHO2mv/NhANUQQ==
X-Received: by 2002:a17:902:db10:b0:1cc:5833:cf4f with SMTP id
 m16-20020a170902db1000b001cc5833cf4fmr27688399plx.55.1699324262063; 
 Mon, 06 Nov 2023 18:31:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/49] Add epmp to extensions list and rename it to smepmp
Date: Tue,  7 Nov 2023 12:29:15 +1000
Message-ID: <20231107022946.1055027-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

Smepmp is a ratified extension which qemu refers to as epmp.
Rename epmp to smepmp and add it to extension list so that
it is added to the isa string.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231019065546.1431579-1-mchitale@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  2 +-
 target/riscv/cpu.c         |  8 +++-----
 target/riscv/csr.c         |  6 +++---
 target/riscv/pmp.c         | 12 ++++++------
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 208cac1c7c..e7ce977189 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -102,6 +102,7 @@ struct RISCVCPUConfig {
     bool ext_smaia;
     bool ext_ssaia;
     bool ext_sscofpmf;
+    bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
 
@@ -134,7 +135,6 @@ struct RISCVCPUConfig {
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
-    bool epmp;
     bool debug;
     bool misa_w;
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e0abe33d3..0c58c8571f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -134,7 +134,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
-    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, epmp),
+    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
@@ -600,12 +600,11 @@ static void rv32_ibex_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
-    cpu->cfg.epmp = true;
-
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
+    cpu->cfg.ext_smepmp = true;
 }
 
 static void rv32_imafcu_nommu_cpu_init(Object *obj)
@@ -1280,6 +1279,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
@@ -1345,8 +1345,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    /* ePMP 0.9.3 */
-    MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5be1c202c..f4e0a3962f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -524,9 +524,9 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static RISCVException epmp(CPURISCVState *env, int csrno)
+static RISCVException smepmp(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->epmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
         return RISCV_EXCP_NONE;
     }
 
@@ -4762,7 +4762,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIPH]       = { "vsiph",       aia_hmode32, NULL, NULL, rmw_vsiph },
 
     /* Physical Memory Protection */
-    [CSR_MSECCFG]    = { "mseccfg",  epmp, read_mseccfg, write_mseccfg,
+    [CSR_MSECCFG]    = { "mseccfg", smepmp, read_mseccfg, write_mseccfg,
                          .min_priv_ver = PRIV_VERSION_1_11_0           },
     [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5e60c26031..21d2489e27 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -91,7 +91,7 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     if (pmp_index < MAX_RISCV_PMPS) {
         bool locked = true;
 
-        if (riscv_cpu_cfg(env)->epmp) {
+        if (riscv_cpu_cfg(env)->ext_smepmp) {
             /* mseccfg.RLB is set */
             if (MSECCFG_RLB_ISSET(env)) {
                 locked = false;
@@ -340,9 +340,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
         /*
          * Convert the PMP permissions to match the truth table in the
-         * ePMP spec.
+         * Smepmp spec.
          */
-        const uint8_t epmp_operation =
+        const uint8_t smepmp_operation =
             ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
             ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
             (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
@@ -367,7 +367,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                  * If mseccfg.MML Bit set, do the enhanced pmp priv check
                  */
                 if (mode == PRV_M) {
-                    switch (epmp_operation) {
+                    switch (smepmp_operation) {
                     case 0:
                     case 1:
                     case 4:
@@ -398,7 +398,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                         g_assert_not_reached();
                     }
                 } else {
-                    switch (epmp_operation) {
+                    switch (smepmp_operation) {
                     case 0:
                     case 8:
                     case 9:
@@ -574,7 +574,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
         }
     }
 
-    if (riscv_cpu_cfg(env)->epmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
         /* Sticky bits */
         val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
         if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6771617226..c5ff03efce 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -565,12 +565,12 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
+    if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
         /*
          * Enhanced PMP should only be available
          * on harts with PMP support
          */
-        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
+        error_setg(errp, "Invalid configuration: Smepmp requires PMP support");
         return;
     }
 
-- 
2.41.0


