Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41158787B55
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIc5-00088A-Ny; Thu, 24 Aug 2023 18:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIc2-000834-U4
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:34 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbx-0006Mj-Ss
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:33 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57129417cecso215656eaf.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915328; x=1693520128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUBtrrficoesMMyl2Z7hby5wyrmieKKmlV4Mkm53lYg=;
 b=EIM/pB+jvkwKaBTiFWePbGrBvWEzLVyr/zcwZwu/5F3rKEje9KwuhKqRN2jm2+5nOZ
 BjNWP/YJg8wOtsdeMWzgeHLrc2Eyyf1yDqVv+2YeG6GsSzYORzo4kMXY+SLoGxuBcgqB
 U4ONtdgHxcWZmz7LPCAiKneyjjRS0IH68J/Vq6KzmOhNP2VFTGDkBVNStbLCQchpvo+m
 XmnzVhV9IrePP4mNso9D05I/iWpw8Yk6TlIM4s1zWz4TX/FUxY2zo6QMcdFCmHqHAYUi
 kCPQZhcj+9MLOtca1ZijiZhK4Q4kTM/CRhI62vRwJ4T04GTO9c/glgXuyu6COj+9mgPy
 Gb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915328; x=1693520128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUBtrrficoesMMyl2Z7hby5wyrmieKKmlV4Mkm53lYg=;
 b=dwhd21a6XVkyHDiXpDqtGkHFadcTzpcXWK72d2kFC+GJ37jP/jYHU/QCFppKt1FH9b
 TKRkJcHKb4/s3wqejU5SAsxYXGTUt2AQmIYNX3p8Bsm8/krBrxAS48RkURqABr2IBs4u
 QCz6KzGk18r+LINb57V+jHgbfK2eyeWiq6LFFCjlUGQOPkrMl5ieIcPQ+F+saM/GX8wu
 3XdQyYEhcMje9Z49iob4XXp+NWepZ0dbJ26ixvGwLfUdLeyYbMadaezTA53UYKOWX0Jw
 BzQCXZlXBku7UxYQCPyn1DASZUBHSPLKTAPbrKtDIg57fyDNkD7fBigL+iEtgNAoXCad
 abig==
X-Gm-Message-State: AOJu0YymGdTay5dUDtP0Y3dL0GMXz5zPb172zPhvQNiNm81NoyuMk7PQ
 JOGEJ2gS0eSK2cs+gTPVTyPYr/S0wXR1SQbxTUY=
X-Google-Smtp-Source: AGHT+IEfXSDXP4fDx7KmGTkeJeRbzFtAcpqLc0eWoWd/9Z4NlraFdUtqM/RtWpOGwhEyL/r4VTZSXg==
X-Received: by 2002:a4a:274a:0:b0:56e:9d63:9ac5 with SMTP id
 w10-20020a4a274a000000b0056e9d639ac5mr2509998oow.2.1692915328574; 
 Thu, 24 Aug 2023 15:15:28 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 16/20] target/riscv/cpu.c: use
 cpu_cfg_ext_auto_update() during realize()
Date: Thu, 24 Aug 2023 19:14:36 -0300
Message-ID: <20230824221440.484675-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
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
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c56abf8395..0fe2ce0add 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1194,7 +1194,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zfh) {
-        cpu->cfg.ext_zfhmin = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
     }
 
     if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
@@ -1220,17 +1220,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
@@ -1244,7 +1244,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     }
 
     if (cpu->cfg.ext_zvfh) {
-        cpu->cfg.ext_zvfhmin = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvfhmin), true);
     }
 
     if (cpu->cfg.ext_zvfhmin && !cpu->cfg.ext_zve32f) {
@@ -1274,7 +1274,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* Set the ISA extensions, checks should have happened above */
     if (cpu->cfg.ext_zhinx) {
-        cpu->cfg.ext_zhinxmin = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
     }
 
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
@@ -1295,12 +1295,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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
 
@@ -1368,26 +1368,26 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


