Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBFA8307F8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6qB-0005xP-5e; Wed, 17 Jan 2024 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rQ6q9-0005x9-D0
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:24:25 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rQ6q7-0004mz-Na
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:24:25 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28e141e677cso746279a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705501462; x=1706106262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlkiDEQSbUcxiOcelE1IKzpKtiEnrHVfzqVpep2aw+s=;
 b=Atbcf8je6B2BekL9ns7f3j2QyBGK5iPxB4365az2aW0le0w+MF48vF66W0FV/s/Jqk
 3bb0qQJOKOTkgbiXugWfu5VudWTD8h6uHzJ6GlOqjiTXz/xN4N4jFll+9eQI3OCebDp8
 bqaTyl2+SBRO69Pl2x4mkmgC/8M/m859E3gjfEV7abKavq1uVhUtqGjTgN3DdUywg8iZ
 NpqBQAzf4XnwM2xPcaKU9dETGtovny45RUHkkW1LWo4P/Da6fixB75wD/kDrtXGMIl6t
 Lv+Ijd1ovW92iMJRUfDQjt51LEy1VLwP3oaaIOpaAea1TlpmDN7dR+JU0uyRAoc5J/xv
 YAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501462; x=1706106262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlkiDEQSbUcxiOcelE1IKzpKtiEnrHVfzqVpep2aw+s=;
 b=G943R2Zf4iGhZ0vdMsyJrVwHgrnYn/KPTdq0J1t8rTwUhTDwa0u+xqR6+ZzkAvyTQg
 qGH2Wge8GALjemSRrsSC3l9lP/FyvxzW4alXDIwT3haHnMXAhsb1Rr3rC+XRx/TdQGEJ
 RNC+ffcGZrUvw4L6oUA+O1ZtoauH0WGQ4OViB+OELA5aK4wzxPm7NLs6VyRxEb2RK2MP
 yv5wUty3ce52KSi6g2Bzuz+PhEqNiRkXddRAzvsHU1FC/zxr6ErdjCyJ2o7eS3Cv8Qub
 i+K+55B3mAUcXmgMVjVKF48usUPfFFTkllnXoswDwVnxZquFQY+Hdu0sWuL1JDoQR5kO
 v57g==
X-Gm-Message-State: AOJu0Yy56G0sLmr0mgYrptXeq31pym1kHRI4XVGKZZhrYF+PalPWsNBM
 9gkXdr+AaOZxY/k10Kv9nAfG167VPBS06A==
X-Google-Smtp-Source: AGHT+IHpgPcmeGAG4mBWuJtWQJN+6P19aRCMHQI0ncWyzaKhnWn0gcvSOprfx/HZ1L63KZ80ougcaQ==
X-Received: by 2002:a17:90b:1b0b:b0:28d:2e64:88ae with SMTP id
 nu11-20020a17090b1b0b00b0028d2e6488aemr15094731pjb.2.1705501462141; 
 Wed, 17 Jan 2024 06:24:22 -0800 (PST)
Received: from brahaspati.localdomain ([49.37.250.249])
 by smtp.gmail.com with ESMTPSA id
 mf15-20020a17090b184f00b0028cef2025ddsm14277657pjb.15.2024.01.17.06.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:24:21 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH v2 1/2] target/riscv: Convert sdtrig functionality from
 property to an extension
Date: Wed, 17 Jan 2024 19:54:11 +0530
Message-Id: <20240117142412.1615505-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117142412.1615505-1-hchauhan@ventanamicro.com>
References: <20240117142412.1615505-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pj1-x1033.google.com
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

The debug trigger (sdtrig) capability is controlled using the debug property.
The sdtrig is an ISA extension and should be treated so. The sdtrig extension
may or may not be implemented in a system. Therefore, it must raise an illegal
instruction exception when it is disabled and its CSRs are accessed.

This patch removes the "debug" property and replaces it with ext_sdtrig extension.
It also raises an illegal instruction exception when the extension is disabled and
its CSRs are accessed.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c        | 7 +++----
 target/riscv/cpu_cfg.h    | 2 +-
 target/riscv/cpu_helper.c | 2 +-
 target/riscv/csr.c        | 2 +-
 target/riscv/machine.c    | 2 +-
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b07a76ef6b..c770a7e506 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -909,7 +909,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -1068,7 +1068,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1393,6 +1393,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-sdtrig", ext_sdtrig, true),
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
 
@@ -1480,8 +1481,6 @@ Property riscv_cpu_options[] = {
 };
 
 static Property riscv_cpu_properties[] = {
-    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
-
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..341ebf726a 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -109,6 +109,7 @@ struct RISCVCPUConfig {
     bool ext_zvfbfwma;
     bool ext_zvfh;
     bool ext_zvfhmin;
+    bool ext_sdtrig;
     bool ext_smaia;
     bool ext_ssaia;
     bool ext_sscofpmf;
@@ -145,7 +146,6 @@ struct RISCVCPUConfig {
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
-    bool debug;
     bool misa_w;
 
     bool short_isa_string;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e7e23b34f4..3f7c2f1315 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -126,7 +126,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c50a33397c..8dbb49aa88 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -543,7 +543,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 72fe2374dc..8f9787a30f 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -231,7 +231,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.ext_sdtrig;
 }
 
 static int debug_post_load(void *opaque, int version_id)
-- 
2.34.1


