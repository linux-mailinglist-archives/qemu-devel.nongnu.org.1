Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9297C63DC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3T-0001cv-Eh; Thu, 12 Oct 2023 00:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3P-0001Vp-7l
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3N-0002MR-BF
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so4618205ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083921; x=1697688721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZZD9Xx0PTI5oMjWNryPKTgPO2boAzXqZDzTWwKiXuc=;
 b=WVEds+h2B17hGN4ET4JoQ2fssF/QJ3dGdqwIV4h/8NWuqFIhvYdw6y1hxiEMNtxtVS
 tvAGlNF1eczpWsOjUVEaCTqOE9hwKwLsCFxQuXj2rAcTwBTm99WN5hnl/rLyKip0qlFY
 QMSB+p3Gl/CSRMqB83k+Z9Ytfms8jafYB3I0YadrEnlUKpXMHW7YeiJ9HPsmxby9SWPr
 DLULczUvd3CTOLlb5QaSy8s1D3gJAjE2t7MVPC8JsmMCCnLY7Q6zaTDunxu/u2yJfyMm
 9PY7C7K3MZqsFXhLsVZWzhruvc7IyrDM85Pt7qQ+jwoX+Cj8SXlyvNcKEAnWDN/KP6bk
 Rw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083921; x=1697688721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZZD9Xx0PTI5oMjWNryPKTgPO2boAzXqZDzTWwKiXuc=;
 b=AQNtvGOTMR03o0prXi+ezfWt4YzNcAYCvoy8t9GI+GuDIEo1UDGLBHZX7Rfx1ALfbe
 ldjUbF3+G0h9yTQzlcbrGJ0BLChKJEPXCizWtDfI9rpFWZ6P0GGIxa1hq9VFixlzcOTC
 ARqJxBuL8fUd7dxDc+ir1UnCRpyTuf3mGLJl+xbLqsXLfV/xCu/bg6X1wrXb6fPGvS4k
 dKAtLYqJZG0gQlqHEzWJByqMwH09hdPXnwuGs7cv2XqjGLahohV8RyvPIVhbC7ImZJgq
 IjsKhaIZ3EuMEgavNyYHt6+3wArGirBjF605BtiHufY45gF5JJmWcugyW1PIiGCZ5mFY
 tGFg==
X-Gm-Message-State: AOJu0YzfSxWHx2kds3SwYwStLdbGPIuMlGwhSTyRMAjpPsPXRpZ7a8AR
 95p/1hr6a0fcwMGwTH9s/DNvIFGKJLIGCg==
X-Google-Smtp-Source: AGHT+IGBY0La+FdnOOHODW8fazqGyG0HdXTFl5VT3S5jOw22OBYuszgj82JCWKd4IGZkqCznvjYcHg==
X-Received: by 2002:a17:902:d214:b0:1c7:398c:a437 with SMTP id
 t20-20020a170902d21400b001c7398ca437mr18518554ply.69.1697083920888; 
 Wed, 11 Oct 2023 21:12:00 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:00 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 16/54] target/riscv/cpu.c: use cpu_cfg_ext_auto_update() during
 realize()
Date: Thu, 12 Oct 2023 14:10:13 +1000
Message-ID: <20231012041051.2572507-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20230912132423.268494-17-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bd73b61d3c..25fef13ef0 100644
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


