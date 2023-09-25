Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4627AD6B3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjRh-000815-Oi; Mon, 25 Sep 2023 07:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkjRd-00080O-5j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:08:05 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qkjRb-0004yi-99
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:08:04 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2776fa0fac2so269784a91.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695640082; x=1696244882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TkihxOb1Ze9kBNwOpxN1B7IxndIuM622YRcEJSQozbo=;
 b=NmRkVsRCCSOlFXF8T2eXWxi1v+of5pCJAVLve/EGPE+RG0lPfTANSo0wDYT7cYufyN
 BfXdyiDhs7CFkyQjU2q0+61Tn1SrEnSRmfP81Izy6umN8rnraYApT80m3Wk5MW+zerD6
 /Yv0UmHhpNxQ6ArEdButhqmrxzwKUtdDAO3LBTShoTCe05Zn89vEOKGLEHgya119g26p
 5avEvW3XUu93JIErwprrFMI4gCpvSAOcnnLX1MUC0i0Yi/1iuh9APBQB8MTUKXMSOFK/
 /n5kYL0hnNYBgVQXXM2CMk5i3MRiAU67AlP5zhmy1PNgxrepDJzb1D/RKFKA1BCJiyCN
 17KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695640082; x=1696244882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TkihxOb1Ze9kBNwOpxN1B7IxndIuM622YRcEJSQozbo=;
 b=p4EMqF+wCCYORZKoVA6nHfKxZDLygGD/hUYaHlcNtaB6Rwg350g6z2Abz7MUdCh26F
 MwfdBZBUAi7/LEVZTWnYF+Pbid+/DBJ9bStSTymunGv1qjU6PLnr/X78Npv20GKvshHP
 fD3m/GxSMyHfcB0CigdB5FuSpQ2pFVsQ62hw+K29XOV+Z8FEIRptvPdq2WlXepQuSM/j
 28VJ8BMPZ0SySPqdkHLVSfUamcpAxr7P8GpuBexpDkWJl4gqxP1akwaljZBWQFAVZhjw
 VQqfVRHMsM1p0i/MoumByPC9KD1jeTsvIiQI3qQlLKNxyppVbiT3bfd3u/NOQy4f9Pul
 Br2g==
X-Gm-Message-State: AOJu0YwyzFEZhBlAgjkBljfz7Uqa5QqKdys3nc+j28Cox8//h4DAWd9p
 8V/sPBIiGzuEyPe938FrZc6k6g==
X-Google-Smtp-Source: AGHT+IGBlDvzcoAGYUEfg4CdsdnIsqmzNM8rRHVxIBNGC2DSqX1miXyUy1aOYUvpXk3MtRZMlZTIcA==
X-Received: by 2002:a17:90a:bc47:b0:274:751a:3f3 with SMTP id
 t7-20020a17090abc4700b00274751a03f3mr14995417pjv.7.1695640081563; 
 Mon, 25 Sep 2023 04:08:01 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 x4-20020a17090abc8400b00262eccfa29fsm9464026pjr.33.2023.09.25.04.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 04:08:00 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] Add epmp to extensions list and rename it to smepmp
Date: Mon, 25 Sep 2023 16:37:47 +0530
Message-Id: <20230925110747.534238-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=mchitale@ventanamicro.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

Smepmp is a ratified extension which qemu refers to as epmp.
Rename epmp to smepmp and add it to extension list so that
it is added to the isa string.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c |  9 +++++----
 target/riscv/cpu.h |  2 +-
 target/riscv/csr.c |  6 +++---
 target/riscv/pmp.c | 12 ++++++------
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index befa64528f..0fb01788e7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -126,6 +126,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -488,7 +489,7 @@ static void rv32_ibex_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
-    cpu->cfg.epmp = true;
+    cpu->cfg.ext_smepmp = true;
 }
 
 static void rv32_imafcu_nommu_cpu_init(Object *obj)
@@ -1198,12 +1199,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
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
 
@@ -1560,7 +1561,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zcmt", RISCVCPU, cfg.ext_zcmt, false),
 
     /* ePMP 0.9.3 */
-    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
+    DEFINE_PROP_BOOL("smepmp", RISCVCPU, cfg.ext_smepmp, false),
     DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
     DEFINE_PROP_BOOL("x-ssaia", RISCVCPU, cfg.ext_ssaia, false),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de7e43126a..9b4b012896 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -434,6 +434,7 @@ struct RISCVCPUConfig {
     bool ext_zvfh;
     bool ext_zvfhmin;
     bool ext_smaia;
+    bool ext_smepmp;
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool rvv_ta_all_1s;
@@ -468,7 +469,6 @@ struct RISCVCPUConfig {
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
-    bool epmp;
     bool debug;
     bool misa_w;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4451bd1263..d9ecc222e7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -519,9 +519,9 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static RISCVException epmp(CPURISCVState *env, int csrno)
+static RISCVException smepmp(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->epmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
         return RISCV_EXCP_NONE;
     }
 
@@ -4337,7 +4337,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIPH]       = { "vsiph",       aia_hmode32, NULL, NULL, rmw_vsiph },
 
     /* Physical Memory Protection */
-    [CSR_MSECCFG]    = { "mseccfg",  epmp, read_mseccfg, write_mseccfg,
+    [CSR_MSECCFG]    = { "mseccfg", smepmp, read_mseccfg, write_mseccfg,
                          .min_priv_ver = PRIV_VERSION_1_11_0           },
     [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 1f5aca42e8..f498e414f0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -88,7 +88,7 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     if (pmp_index < MAX_RISCV_PMPS) {
         bool locked = true;
 
-        if (riscv_cpu_cfg(env)->epmp) {
+        if (riscv_cpu_cfg(env)->ext_smepmp) {
             /* mseccfg.RLB is set */
             if (MSECCFG_RLB_ISSET(env)) {
                 locked = false;
@@ -243,7 +243,7 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, target_ulong addr,
 {
     bool ret;
 
-    if (riscv_cpu_cfg(env)->epmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
         if (MSECCFG_MMWP_ISSET(env)) {
             /*
              * The Machine Mode Whitelist Policy (mseccfg.MMWP) is set
@@ -354,9 +354,9 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
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
@@ -381,7 +381,7 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                  * If mseccfg.MML Bit set, do the enhanced pmp priv check
                  */
                 if (mode == PRV_M) {
-                    switch (epmp_operation) {
+                    switch (smepmp_operation) {
                     case 0:
                     case 1:
                     case 4:
@@ -412,7 +412,7 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                         g_assert_not_reached();
                     }
                 } else {
-                    switch (epmp_operation) {
+                    switch (smepmp_operation) {
                     case 0:
                     case 8:
                     case 9:
-- 
2.34.1


