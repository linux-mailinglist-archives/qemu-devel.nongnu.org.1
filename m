Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA07E32EE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bqy-0002YV-Oj; Mon, 06 Nov 2023 21:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqw-0002Y7-PN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqu-0002MA-O3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso34145475ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324203; x=1699929003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7zpUGOYrjD3uHZVbI1uQ8QPnjATiBPY4PGbEzxIln4=;
 b=AUcYgEvzE5V3FYASMfZxVh0zZEMprzB5jy1HmwHs8O1L4r+PIJHNQHr8uwdCdioj9+
 I5XmsTwD4QMcWn8VM8Umza79jrd3khf0eodQbqdzbRJz/I0I/OKhfNLVZlC+VL9lFtqp
 ou0ELWvnusMmENR/srsM35nQXzc2ArKQCJbU0Hv6n8gE+6y5ud9i4dHgBnmwoL7AJTVy
 mBm7YokIAexDlsvJC+kHzBgqPYJiLfEimZtz3u0jxxdzghidBaO01A22i0vhtjifV5za
 qcZ4y6ehXD3dGIRDBg9S+bJ95e2s9KcJn1Oa+npeZ9fsYdPXZbV2IyCZqbJCS9hPdWXu
 GzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324203; x=1699929003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7zpUGOYrjD3uHZVbI1uQ8QPnjATiBPY4PGbEzxIln4=;
 b=nzdACSfGFas0/IcvtSfKzr26hD2wClnNT4Y8Re0eFDvEd+5tX8ilU8ymjiNBe61GOg
 ufIe99b6Z1rn6krhX1EXKVadVbdPo+x4stLuZoVGkAfUFL6OWGy1FAap5yDjpYB5JFoX
 Hb0m2qEve/85Cf/aHkoha89GuadKyOIyDU6aWLFojDOkaBTnrgUgUhQTAQkPOyL1uvmv
 z9vDu4ys++KTXetZSMapyXjVyWwRi7lL4IEQYqs77JQIM2pnvFSeVgn6SO3Dkj2cMj1n
 aRGqMmri0WuMSXnES6iUBqjYbgjzbGhakonZLxPjN7LVZ5i3xoitkyAmT2rdV2vz2vR6
 I+FA==
X-Gm-Message-State: AOJu0YztUWf95pWtKHTLI1M+YLPdBmvh1N07pbV7KSj8d29YfJzPILt+
 LtF1rs5PZQb/MNMnrwQoSYunfha34IikAg==
X-Google-Smtp-Source: AGHT+IEyY0jLGoeWsU/CJxhWnFRG2EXFxw9CDo+ETCf/YKO3eU3xTj7kEjY/285hew9+DQ6RgGKJQA==
X-Received: by 2002:a17:902:f303:b0:1cc:32be:b13 with SMTP id
 c3-20020a170902f30300b001cc32be0b13mr16406687ple.64.1699324202838; 
 Mon, 06 Nov 2023 18:30:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/49] target/riscv: rename ext_icsr to ext_zicsr
Date: Tue,  7 Nov 2023 12:28:58 +1000
Message-ID: <20231107022946.1055027-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add a leading 'z' to improve grepping. When one wants to search for uses
of zicsr they're more likely to do 'grep -i zicsr' than 'grep -i icsr'.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231012164604.398496-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     |  2 +-
 hw/riscv/boot.c            |  2 +-
 target/riscv/cpu.c         | 22 +++++++++++-----------
 target/riscv/csr.c         |  2 +-
 target/riscv/gdbstub.c     |  2 +-
 target/riscv/tcg/tcg-cpu.c | 14 +++++++-------
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a3f96eb878..9ea30da7e0 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -62,7 +62,7 @@ struct RISCVCPUConfig {
     bool ext_zksh;
     bool ext_zkt;
     bool ext_zifencei;
-    bool ext_icsr;
+    bool ext_zicsr;
     bool ext_icbom;
     bool ext_icboz;
     bool ext_zicond;
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 52bf8e67de..0ffca05189 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -414,7 +414,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
         reset_vec[4] = 0x0182b283;   /*     ld     t0, 24(t0) */
     }
 
-    if (!harts->harts[0].cfg.ext_icsr) {
+    if (!harts->harts[0].cfg.ext_zicsr) {
         /*
          * The Zicsr extension has been disabled, so let's ensure we don't
          * run the CSR instruction. Let's fill the address with a non
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3693eabb34..566b7545e8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -79,7 +79,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_icbom),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_icboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
-    ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
+    ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
@@ -383,7 +383,7 @@ static void riscv_any_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 }
@@ -431,7 +431,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 }
@@ -449,7 +449,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
 
@@ -495,7 +495,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     /* Enable ISA extensions */
     cpu->cfg.mmu = true;
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
     cpu->cfg.ext_icbom = true;
     cpu->cfg.cbom_blocksize = 64;
@@ -567,7 +567,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 }
@@ -585,7 +585,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
 
@@ -603,7 +603,7 @@ static void rv32_ibex_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
 
@@ -620,7 +620,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
 
     /* inherited from parent obj via riscv_cpu_init() */
     cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_icsr = true;
+    cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
 #endif
@@ -1243,7 +1243,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
-    MULTI_EXT_CFG_BOOL("zicsr", ext_icsr, true),
+    MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
@@ -1348,7 +1348,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 /* Deprecated entries marked for future removal */
 const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
     MULTI_EXT_CFG_BOOL("Zifencei", ext_zifencei, true),
-    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
+    MULTI_EXT_CFG_BOOL("Zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
     MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4b4ab56c40..30cc21e979 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3858,7 +3858,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     int csr_min_priv = csr_ops[csrno].min_priv_ver;
 
     /* ensure the CSR extension is enabled */
-    if (!riscv_cpu_cfg(env)->ext_icsr) {
+    if (!riscv_cpu_cfg(env)->ext_zicsr) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 524bede865..58b3ace0fe 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -342,7 +342,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
         g_assert_not_reached();
     }
 
-    if (cpu->cfg.ext_icsr) {
+    if (cpu->cfg.ext_zicsr) {
         int base_reg = cs->gdb_num_regs;
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                                  riscv_gen_dynamic_csr_xml(cs, base_reg),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9b8f3f54a7..418b040d6d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -278,10 +278,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         !(riscv_has_ext(env, RVI) && riscv_has_ext(env, RVM) &&
           riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
           riscv_has_ext(env, RVD) &&
-          cpu->cfg.ext_icsr && cpu->cfg.ext_zifencei)) {
+          cpu->cfg.ext_zicsr && cpu->cfg.ext_zifencei)) {
 
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
-            !cpu->cfg.ext_icsr) {
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr)) &&
+            !cpu->cfg.ext_zicsr) {
             error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
             return;
         }
@@ -293,7 +293,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             return;
         }
 
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zicsr), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zifencei), true);
 
         env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
@@ -329,7 +329,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (riscv_has_ext(env, RVF) && !cpu->cfg.ext_icsr) {
+    if (riscv_has_ext(env, RVF) && !cpu->cfg.ext_zicsr) {
         error_setg(errp, "F extension requires Zicsr");
         return;
     }
@@ -434,7 +434,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zfinx) {
-        if (!cpu->cfg.ext_icsr) {
+        if (!cpu->cfg.ext_zicsr) {
             error_setg(errp, "Zfinx extension requires Zicsr");
             return;
         }
@@ -494,7 +494,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zcmt && !cpu->cfg.ext_icsr) {
+    if (cpu->cfg.ext_zcmt && !cpu->cfg.ext_zicsr) {
         error_setg(errp, "Zcmt extension requires Zicsr extension");
         return;
     }
-- 
2.41.0


