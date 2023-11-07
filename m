Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C957E32EB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bqw-0002Y4-4p; Mon, 06 Nov 2023 21:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqt-0002W3-Dq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:03 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bqr-0002BH-7J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:03 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27ff83feb29so4895680a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324199; x=1699928999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBHdtGkhdIsTynNenPpt3LElifNcd19zbMZr8mYJw3I=;
 b=HtwwlOZgTLzCWbGJd52DJEDGELKCWXxRdEok2r+HYF9CQmDO61WN/QY8d6YsSJTRGz
 43GwokbpwuYu/z/Q2ON/ZmK2CQWqDf6fab4LVfOonpgVLcwULwUzXfPgWi4BiYCXxl6c
 397Bi8btLPMLdTuiZ80DCp/MyoDhHJb+2d8ntXFTnqQzUO4pg2UCt7gT66woOFsvWcKG
 Ut9OxtNkvXklSghomVi4tTIkw4S8TsVws/opZbVuo/wocvyHfuV1TRKix+T0KCo7C2V8
 eaO1PpQMzBEaPwndav0NRjuBuXIHmsjFuSHqQBF0/DrEkWcJiU3Oj9kbf7WhgwFihGDN
 jXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324199; x=1699928999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBHdtGkhdIsTynNenPpt3LElifNcd19zbMZr8mYJw3I=;
 b=f8t1jIic1rE0jTMFLZaB566VWRjcFZGvrS8ZwnXgraMIIPXidKlgGN6FoxRTR+J4cG
 I8AXbJGn1ctNAaMCkUdBt3IZcgOWLRXeH6s/BDh7rTOg0KNpcRCWqF2G+TGjKD9IzDKe
 2uR3zTkB89l3/9aLVKODOMNJZOB9ajNuKHUN0jWjZrffuQ6G8XWAkX4dxf0LM7fQQ0du
 bBIEyVqLZ2AewcI/ssasBqXsx6fZpbnR5eq/NPYuSF5B5ZBj3zhDgMSYy4D/L0Dnt3ut
 GgRP2tdHghT4QOHZhoTEsZqWHP62wdy25V+tGBO6XnJsxaQ8P7jQk2OPd2NswzkfYbI3
 9lXg==
X-Gm-Message-State: AOJu0YyrsjhMlHMkBwP15fDqC7ZtugNC/j4KQaqjgxwJgK/Bofz9vWf5
 KWDPEE9aXiK+xO3cL666tL5hvYaa3YSLlA==
X-Google-Smtp-Source: AGHT+IEO8PwcZ1FAMo03JGydC39FLqQX0rUjbbEeGq7IwA7Pe4vwL+TWbrrYPqbmu5Lc6G/Gv1bVtA==
X-Received: by 2002:a17:90a:ce8b:b0:27d:7887:ddc5 with SMTP id
 g11-20020a17090ace8b00b0027d7887ddc5mr24277465pju.32.1699324199246; 
 Mon, 06 Nov 2023 18:29:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:29:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/49] target/riscv: rename ext_ifencei to ext_zifencei
Date: Tue,  7 Nov 2023 12:28:57 +1000
Message-ID: <20231107022946.1055027-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
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
of zifencei they're more likely to do 'grep -i zifencei' than 'grep -i
ifencei'.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231012164604.398496-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                  |  2 +-
 target/riscv/cpu.c                      | 22 +++++++++++-----------
 target/riscv/tcg/tcg-cpu.c              |  8 ++++----
 target/riscv/insn_trans/trans_rvi.c.inc |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 0e6a0f245c..a3f96eb878 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -61,7 +61,7 @@ struct RISCVCPUConfig {
     bool ext_zksed;
     bool ext_zksh;
     bool ext_zkt;
-    bool ext_ifencei;
+    bool ext_zifencei;
     bool ext_icsr;
     bool ext_icbom;
     bool ext_icboz;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac4a6c7eec..3693eabb34 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -80,7 +80,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_icboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
-    ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
+    ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
@@ -382,7 +382,7 @@ static void riscv_any_cpu_init(Object *obj)
     env->priv_ver = PRIV_VERSION_LATEST;
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
@@ -430,7 +430,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
@@ -448,7 +448,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
 }
@@ -494,7 +494,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 
     /* Enable ISA extensions */
     cpu->cfg.mmu = true;
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
     cpu->cfg.ext_icbom = true;
@@ -566,7 +566,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
@@ -584,7 +584,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
 }
@@ -602,7 +602,7 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.epmp = true;
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
 }
@@ -619,7 +619,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
 }
@@ -1242,7 +1242,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
-    MULTI_EXT_CFG_BOOL("zifencei", ext_ifencei, true),
+    MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_icsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
@@ -1347,7 +1347,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 
 /* Deprecated entries marked for future removal */
 const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
-    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
+    MULTI_EXT_CFG_BOOL("Zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
     MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a28918ab30..9b8f3f54a7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -278,7 +278,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         !(riscv_has_ext(env, RVI) && riscv_has_ext(env, RVM) &&
           riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
           riscv_has_ext(env, RVD) &&
-          cpu->cfg.ext_icsr && cpu->cfg.ext_ifencei)) {
+          cpu->cfg.ext_icsr && cpu->cfg.ext_zifencei)) {
 
         if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
             !cpu->cfg.ext_icsr) {
@@ -286,15 +286,15 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
             return;
         }
 
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ifencei)) &&
-            !cpu->cfg.ext_ifencei) {
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei)) &&
+            !cpu->cfg.ext_zifencei) {
             error_setg(errp, "RVG requires Zifencei but user set "
                        "Zifencei to false");
             return;
         }
 
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zifencei), true);
 
         env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
         env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 25cb60558a..faf6d65064 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -799,7 +799,7 @@ static bool trans_fence(DisasContext *ctx, arg_fence *a)
 
 static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
 {
-    if (!ctx->cfg_ptr->ext_ifencei) {
+    if (!ctx->cfg_ptr->ext_zifencei) {
         return false;
     }
 
-- 
2.41.0


