Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 636567C7368
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqypI-0000O1-S6; Thu, 12 Oct 2023 12:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qqypG-0000J3-Ht
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:46:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qqypE-0004ZU-Nf
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:46:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so884848b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697129174; x=1697733974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOts4b/yKWOyvRcK5Dhr14q24ralKJ9G6DIFWf5s/iY=;
 b=Kun6vbEAUWyL2S0S8XuDLZV0cU+jX0WCyyDLhjqZL3QhV7K4KVAI+54MlKKzVhF/GP
 RnooMu8w1AG8Z5adRxYXKm44RWqTLuN1ggvRWtg1U4TsmP+gdvf6mAJNoN4UPEAJ4l7J
 WC/SQ63c/p1EjDO9ZOKG+KJ0ANNxEIVmT8izLT8UyoblKJ+8NgvttZBXwOKxXUwzZ580
 G1WH6VNYQwU0klBTzajyO91xYvsOPM68kogqi69SKeZswqprIfazcc1NVTy9WtiibHuL
 9sV7uFm24y2OklVRKTS/Q/gl9BJ/WgUNTaQwzENKaDC53u5zZXRs/3bOkU7UsayLun9I
 ylFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697129174; x=1697733974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOts4b/yKWOyvRcK5Dhr14q24ralKJ9G6DIFWf5s/iY=;
 b=AeEMpbV8HN/PnuY7MZ0C7XV6s20Iw+BgLsCnA6iNtOLk7tk/GayRgHw2Pi7kmmpnH3
 MfNrUVFB3Bh0dr2DMqCrfwWQLAooZjawpSnooU3vyWCN1nysCU4JwcVwYAtqLe2spt+v
 dkwWBF+sIiANRL3VwClwE9zmT6nt+CWBkFdcWozBR6mjVZOXm0pb0p7vOSXrEI3U2kxn
 9W1wfUVJwaNsLgCTDIYsUoL8jQOICxFsAUW79tsZwkrwA/kR96bI/qKhq66TC39EetuM
 QTHViFSLPFyJt1QieAP5HtijUqY2PZCTenxrumP+GKOlso9dXqCbQEgNUOrZYiw5vnGD
 BKTw==
X-Gm-Message-State: AOJu0YyIpDPkRv6gdjNzo4Kc1m6IseHKJAz0p4lFlWj/IgmQIZWBFet+
 TEndowQpikFk+p8hVQewc+1DS7v/uIKz5+2l8zk=
X-Google-Smtp-Source: AGHT+IE8pv7uzKjK4ZFEm0Cy+jHO0BYyHSuzflkfwm3PXCaoZ14G/rGhi4XLh2a9UXf6oMg51C64QQ==
X-Received: by 2002:a05:6a00:1c82:b0:69f:261:ae1e with SMTP id
 y2-20020a056a001c8200b0069f0261ae1emr23373566pfw.6.1697129174301; 
 Thu, 12 Oct 2023 09:46:14 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.196])
 by smtp.gmail.com with ESMTPSA id
 g5-20020aa78185000000b0068feb378b89sm12416805pfi.171.2023.10.12.09.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 09:46:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/4] target/riscv: rename ext_ifencei to ext_zifencei
Date: Thu, 12 Oct 2023 13:46:01 -0300
Message-ID: <20231012164604.398496-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012164604.398496-1-dbarboza@ventanamicro.com>
References: <20231012164604.398496-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a leading 'z' to improve grepping. When one wants to search for uses
of zifencei they're more likely to do 'grep -i zifencei' than 'grep -i
ifencei'.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                      | 22 +++++++++++-----------
 target/riscv/cpu_cfg.h                  |  2 +-
 target/riscv/insn_trans/trans_rvi.c.inc |  2 +-
 target/riscv/tcg/tcg-cpu.c              |  8 ++++----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5425bceac1..caf42ce68d 100644
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
-- 
2.41.0


