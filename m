Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27384724125
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 13:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6V1E-0002hr-RJ; Tue, 06 Jun 2023 07:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1q6V1A-0002fz-Nt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:38:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1q6V15-0008A3-HE
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:38:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-657c4bcad0bso619813b3a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686051499; x=1688643499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5XyhAMoDpcD2PvKAHbfJxoR+Hl1/S3rQpLL4TguLsrw=;
 b=WygHCKizb+31xW8hgoS/pdlUB7unymdWJ5tmHj1zUz6yFPUa4K0I9dmdsCF44OjSfG
 utT07KqVhMrqK/SeLVtGJUSXin8wvAhxeHMJWq0bCsf0sJKJpBlH7WEsT9q3EetWe/Hs
 jte9f90P5AUQAXGKAn0uflhNPIHso5Xzvz9A9JwrgSpN286b5/g9Fc7QBO2lfHj7KdOB
 zY1gakG2ou3TejYCnUBZfbrzPQ+i6TTot9RrJTxZTqG6NpUB5sngUnBSMDHQuLtpG0zn
 EedKNb7OTy3pPsKw+qyTpUnHI3hADiCnjKLwhDmWDn8uhMZqIJxBhupvWmwHWPkraUmP
 EcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686051499; x=1688643499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5XyhAMoDpcD2PvKAHbfJxoR+Hl1/S3rQpLL4TguLsrw=;
 b=JWRUPnfqWlKBr0nHkfdDUAR4WQH9d9yjMWNucpPbTRkO6S5czd9RVetfuaiwJ9yBIF
 dYrZkX/5sOIwGFyYySCBwDV7x3nyI1kenev7CV5+OqGYVZWgaDcKsfyy2vpSn4m2i27p
 JnBVCuLJuZALOMv4+9IY9daJWim2xpSxMcJ+3M1o89OHY1KsjDbla9gpv6rHey8c3+5q
 xpUpHZu655O9IY5RwS058y5Z4RvpzXuDukkR+xtThFnfjdqDJEO+U4sSuyShX4tllaCG
 MasxUnxTeMHxd55XROCa3buJyrrnKBTctbx3V3OIp64QJVXNShOtrlTvp4o3OqE/xV6Y
 8OYQ==
X-Gm-Message-State: AC+VfDyaZOJm2YWwoHm4OHLTPV+yOITwKevRrp1orTa5E/cW7fGk98YH
 dgmCYLn8fUr3uLzYLP0kJBKa/Q==
X-Google-Smtp-Source: ACHHUZ5LKWe0AnYdVrUxAuNYnV2/wzxutp9uSC2SQmcL+MB0nM4Tq7F3yYLbS8hJopjEGokfsqLOzQ==
X-Received: by 2002:a05:6a20:4292:b0:111:a0e5:d29d with SMTP id
 o18-20020a056a20429200b00111a0e5d29dmr2706391pzj.4.1686051499538; 
 Tue, 06 Jun 2023 04:38:19 -0700 (PDT)
Received: from saptrishi.. ([2405:201:d019:c279:cac6:c564:908b:19a9])
 by smtp.gmail.com with ESMTPSA id
 t24-20020aa79398000000b0063799398eaesm4470360pfe.51.2023.06.06.04.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 04:38:19 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH] Add epmp to extensions list and rename it to smepmp
Date: Tue,  6 Jun 2023 17:08:12 +0530
Message-Id: <20230606113812.519723-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Smepmp is a ratified extension which qemu refers to as epmp.
Rename epmp to smepmp and add it to extension list so that
it is added to the isa string.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c     |  9 +++++----
 target/riscv/cpu_cfg.h |  2 +-
 target/riscv/csr.c     |  6 +++---
 target/riscv/pmp.c     | 12 ++++++------
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 881bddf393..cf3d1c3207 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,6 +127,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -547,7 +548,7 @@ static void rv32_ibex_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
-    cpu->cfg.epmp = true;
+    cpu->cfg.ext_smepmp = true;
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_ifencei = true;
@@ -1336,12 +1337,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
+    if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
         /*
          * Enhanced PMP should only be available
          * on harts with PMP support
          */
-        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
+        error_setg(errp, "Invalid configuration: SMEPMP requires PMP support");
         return;
     }
 
@@ -1676,7 +1677,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
 
     /* ePMP 0.9.3 */
-    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
+    DEFINE_PROP_BOOL("smepmp", RISCVCPU, cfg.ext_smepmp, false),
     DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
     DEFINE_PROP_BOOL("x-ssaia", RISCVCPU, cfg.ext_ssaia, false),
 
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c4a627d335..d79b022e35 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -87,6 +87,7 @@ struct RISCVCPUConfig {
     bool ext_zvfh;
     bool ext_zvfhmin;
     bool ext_smaia;
+    bool ext_smepmp;
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool rvv_ta_all_1s;
@@ -121,7 +122,6 @@ struct RISCVCPUConfig {
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
-    bool epmp;
     bool debug;
     bool misa_w;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58499b5afc..d9bc591348 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -523,9 +523,9 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static RISCVException epmp(CPURISCVState *env, int csrno)
+static RISCVException smepmp(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->epmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
         return RISCV_EXCP_NONE;
     }
 
@@ -4356,7 +4356,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIPH]       = { "vsiph",       aia_hmode32, NULL, NULL, rmw_vsiph },
 
     /* Physical Memory Protection */
-    [CSR_MSECCFG]    = { "mseccfg",  epmp, read_mseccfg, write_mseccfg,
+    [CSR_MSECCFG]    = { "mseccfg", smepmp, read_mseccfg, write_mseccfg,
                          .min_priv_ver = PRIV_VERSION_1_11_0           },
     [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 418738afd8..18246e1737 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -87,7 +87,7 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     if (pmp_index < MAX_RISCV_PMPS) {
         bool locked = true;
 
-        if (riscv_cpu_cfg(env)->epmp) {
+        if (riscv_cpu_cfg(env)->ext_smepmp) {
             /* mseccfg.RLB is set */
             if (MSECCFG_RLB_ISSET(env)) {
                 locked = false;
@@ -337,9 +337,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
         /*
          * Convert the PMP permissions to match the truth table in the
-         * ePMP spec.
+         * SMEPMP spec.
          */
-        const uint8_t epmp_operation =
+        const uint8_t smepmp_operation =
             ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
             ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
             (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
@@ -364,7 +364,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                  * If mseccfg.MML Bit set, do the enhanced pmp priv check
                  */
                 if (mode == PRV_M) {
-                    switch (epmp_operation) {
+                    switch (smepmp_operation) {
                     case 0:
                     case 1:
                     case 4:
@@ -395,7 +395,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                         g_assert_not_reached();
                     }
                 } else {
-                    switch (epmp_operation) {
+                    switch (smepmp_operation) {
                     case 0:
                     case 8:
                     case 9:
@@ -576,7 +576,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
         }
     }
 
-    if (riscv_cpu_cfg(env)->epmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
         /* Sticky bits */
         val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
         if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
-- 
2.34.1


