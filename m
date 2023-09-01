Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8F790294
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA8d-0001L1-Ir; Fri, 01 Sep 2023 15:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA77-0008DB-U3
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:34 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA75-0003NC-Ai
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:47:29 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-572a7141434so1325320eaf.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597646; x=1694202446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v023n2PbxiR5ip3T4K94HNm0FMcZR3bFuZyEZiJsIlY=;
 b=fCQbC7bhNXzZhgSX6kiyCVlQxoxMrD2mOSGjLMqfXZIMDUeqxgovbAW+5HEaCdtXm+
 6Q6we4cbtJkStcNDJU57fu04dz7qMvXVSCFqXzJtjlet14UWhE7fXNxC4gXG8cNYpsQC
 G5BZ0gzIN90Mqv5DluBjV4NPZeHPbVhSkjybejc5t7kAU2BnHK0E/AI0q0casMTtf8bb
 kxiohDdkfpjhPsvy1Ts/ROrqK2+AzQfEc4pw52lAZ/9BtHSdKqqqlBfNqTslLzV3c30n
 JBGaBHLd8chK7I5Y413ZV2zTK03yKK7OFo4ncDTjjwy9vHdvcOqBZD1Vs3fBjGArvbcc
 Qv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597646; x=1694202446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v023n2PbxiR5ip3T4K94HNm0FMcZR3bFuZyEZiJsIlY=;
 b=c7JvAVQY23iZrZeBb26LT7lZfFeZe9yVJo3In79q6FggAVOekUDyETTclHWsO1ZvaU
 3Sn3jq9CBQLi9DwfLZqB3S+3FAX8Ckj3vtb4bUjCjzFTd3NiUm/kt0PE0gJmlzbuHA59
 HI3yxdhaz3uiKEggaqZy2ZJBjAb1QsW3RyHjDcKvB/JwgMt3imq0Xy7OAXmQBjgS5XsB
 1cFXARczxGaiKTKnL4A5dJKTWx+hSI2FfMf/hVseitucbZx0UIMUtAZ+W8C+OTu3cEts
 mAl0eMcm+hneBWUYeaHtDqwDAEfm1EgjqI9xmUXmaT5xTHp0xp4tdSv+nDLGzQMlfIAQ
 N3Ew==
X-Gm-Message-State: AOJu0YxRYnybCqQd1MhdIqx9/UNSFwp7uFqMuWxWUVVoojfBqp79J0xD
 bNtCCOjwA68suxDaeHdgn7ppiVvtmbW2/JDNMVg=
X-Google-Smtp-Source: AGHT+IH0sLe5nw96Y9FJOg6fUZ4LK0xgMlXGc7Ho0GkFa/CDEPj4CUkt0g7nb5j83BUp53Tyn8p5NQ==
X-Received: by 2002:a4a:3008:0:b0:56c:e856:8b2c with SMTP id
 q8-20020a4a3008000000b0056ce8568b2cmr3440718oof.9.1693597645789; 
 Fri, 01 Sep 2023 12:47:25 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:47:25 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 16/20] target/riscv/cpu.c: use cpu_cfg_ext_auto_update()
 during realize()
Date: Fri,  1 Sep 2023 16:46:22 -0300
Message-ID: <20230901194627.1214811-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2c.google.com
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

Let's change the other instances in realize() where we're enabling an
extension based on a certain criteria (e.g. it's a dependency of another
extension).

We're leaving icsr and ifencei being enabled during RVG for later -
we'll want to error out in that case. Every other extension enablement
during realize is now done via cpu_cfg_ext_auto_update().

The end goal is that only cpu init() functions will handle extension
flags directly via "cpu->cfg.ext_N = true|false".

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a4876df5f4..eeaf69599e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1193,7 +1193,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zfh) {
-        cpu->cfg.ext_zfhmin = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
     }
 
     if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
@@ -1219,17 +1219,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
 
         /* The V vector extension depends on the Zve64d extension */
-        cpu->cfg.ext_zve64d = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64d), true);
     }
 
     /* The Zve64d extension depends on the Zve64f extension */
     if (cpu->cfg.ext_zve64d) {
-        cpu->cfg.ext_zve64f = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64f), true);
     }
 
     /* The Zve64f extension depends on the Zve32f extension */
     if (cpu->cfg.ext_zve64f) {
-        cpu->cfg.ext_zve32f = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32f), true);
     }
 
     if (cpu->cfg.ext_zve64d && !riscv_has_ext(env, RVD)) {
@@ -1243,7 +1243,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zvfh) {
-        cpu->cfg.ext_zvfhmin = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvfhmin), true);
     }
 
     if (cpu->cfg.ext_zvfhmin && !cpu->cfg.ext_zve32f) {
@@ -1273,7 +1273,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* Set the ISA extensions, checks should have happened above */
     if (cpu->cfg.ext_zhinx) {
-        cpu->cfg.ext_zhinxmin = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
     }
 
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
@@ -1294,12 +1294,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zce) {
-        cpu->cfg.ext_zca = true;
-        cpu->cfg.ext_zcb = true;
-        cpu->cfg.ext_zcmp = true;
-        cpu->cfg.ext_zcmt = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
         if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
-            cpu->cfg.ext_zcf = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
 
@@ -1367,26 +1367,26 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zk) {
-        cpu->cfg.ext_zkn = true;
-        cpu->cfg.ext_zkr = true;
-        cpu->cfg.ext_zkt = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkn), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkr), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkt), true);
     }
 
     if (cpu->cfg.ext_zkn) {
-        cpu->cfg.ext_zbkb = true;
-        cpu->cfg.ext_zbkc = true;
-        cpu->cfg.ext_zbkx = true;
-        cpu->cfg.ext_zkne = true;
-        cpu->cfg.ext_zknd = true;
-        cpu->cfg.ext_zknh = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkne), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknd), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknh), true);
     }
 
     if (cpu->cfg.ext_zks) {
-        cpu->cfg.ext_zbkb = true;
-        cpu->cfg.ext_zbkc = true;
-        cpu->cfg.ext_zbkx = true;
-        cpu->cfg.ext_zksed = true;
-        cpu->cfg.ext_zksh = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksed), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksh), true);
     }
 
     /*
-- 
2.41.0


