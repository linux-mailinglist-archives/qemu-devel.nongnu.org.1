Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D7765F76
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9B8-0001Kr-J4; Thu, 27 Jul 2023 18:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9B6-0001Ju-9c
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:48 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9B4-0004tc-OF
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:48 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-56c42bb70abso1005116eaf.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495785; x=1691100585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCeGqZOqU3/KmLKkLA2Ofj9O0444tQLInbZA480lJ3A=;
 b=QGFlX64joZOTPOAv3O9iDqUyfQGzczHeuf5ttRCuIGIb61yBwtRF+o56+j6T1/2IGs
 m3cuhWP6HgRh7xTJAlmGSDBs9ZJjUjNw3g3560seEkY3i34IrwIiuBjoO6Ad20j8c7/8
 SwyUkg/odZDMmC1WoYFFb/DLRh/RyMhSHQQrMrfLeInlpmlIr3MHmS88PS8b21bTD+d8
 zHtdrT80ooZogQZCgVE8+G7jIOQSpB9ehz5ycwtJGHWyqw7B6iA2IQLYmN25X/1btk33
 PmNpylwVS+0I8C4uKhGZUX2heRLIRZDaFqw5COv/faR7n3kHaUrtlbBCPa0pQPVWZNNr
 7KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495785; x=1691100585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCeGqZOqU3/KmLKkLA2Ofj9O0444tQLInbZA480lJ3A=;
 b=XlKGF+UgtlpBZ7WStboMPGkpSSlB8i5PY0zIYVAVoD5lmpKaZDoUYXQClhUH0SThMd
 F6T64+GuCYnXoVt6f+2cYPY85yMC72+FuMZUcSKIvdcoXOVvuWtulIEfhUefesT21RSm
 eduweD2rHb4beOzM2e1CJ8NCKuUk4AufbuhEN88I2GBZ7FsXmKkGk/sa8OiDZUDCyyEd
 TgGSDGcd06TubWcLdCQrNeBWum97NlfbZisnBVKUMbx6psVwtRzOWncBZNuKsMAoy/pH
 m7bKthRMsd/RAY068EVzijsINDR6TCi6z1C5tswmPKyXcgUes/e1HEY7eC93Mi3YMxPT
 QFOw==
X-Gm-Message-State: ABy/qLa564+fZehjGW3/1VU1977zlNp+0aBMEChFG+883cUG8ZoUwJpZ
 vo3uRG1+tN/jP5A6J88fmliuvTvloR+wbMutYe82qQ==
X-Google-Smtp-Source: APBJJlHUK/JnF19JBmbsYqbVdr77aQOV1vaKY5SPrIrNNBzuiCxkBe1mEOBXVXKA12CbF1c4suVY0g==
X-Received: by 2002:a4a:341e:0:b0:566:f211:5fc4 with SMTP id
 b30-20020a4a341e000000b00566f2115fc4mr788473ooa.5.1690495785427; 
 Thu, 27 Jul 2023 15:09:45 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:09:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 05/12] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Thu, 27 Jul 2023 19:09:20 -0300
Message-ID: <20230727220927.62950-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Our goal is to make riscv_cpu_extensions[] hold only ratified,
non-vendor extensions.

Create a new riscv_cpu_vendor_exts[] array for them, changing
riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties()
accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33a2e9328c..c8e1de68d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1814,20 +1814,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
 
-    /* Vendor-specific custom extensions */
-    DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
-    DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
-    DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
-    DEFINE_PROP_BOOL("xtheadcmo", RISCVCPU, cfg.ext_xtheadcmo, false),
-    DEFINE_PROP_BOOL("xtheadcondmov", RISCVCPU, cfg.ext_xtheadcondmov, false),
-    DEFINE_PROP_BOOL("xtheadfmemidx", RISCVCPU, cfg.ext_xtheadfmemidx, false),
-    DEFINE_PROP_BOOL("xtheadfmv", RISCVCPU, cfg.ext_xtheadfmv, false),
-    DEFINE_PROP_BOOL("xtheadmac", RISCVCPU, cfg.ext_xtheadmac, false),
-    DEFINE_PROP_BOOL("xtheadmemidx", RISCVCPU, cfg.ext_xtheadmemidx, false),
-    DEFINE_PROP_BOOL("xtheadmempair", RISCVCPU, cfg.ext_xtheadmempair, false),
-    DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
-    DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
-
     /* These are experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
 
@@ -1844,6 +1830,21 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
 };
 
+static Property riscv_cpu_vendor_exts[] = {
+    DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
+    DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
+    DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
+    DEFINE_PROP_BOOL("xtheadcmo", RISCVCPU, cfg.ext_xtheadcmo, false),
+    DEFINE_PROP_BOOL("xtheadcondmov", RISCVCPU, cfg.ext_xtheadcondmov, false),
+    DEFINE_PROP_BOOL("xtheadfmemidx", RISCVCPU, cfg.ext_xtheadfmemidx, false),
+    DEFINE_PROP_BOOL("xtheadfmv", RISCVCPU, cfg.ext_xtheadfmv, false),
+    DEFINE_PROP_BOOL("xtheadmac", RISCVCPU, cfg.ext_xtheadmac, false),
+    DEFINE_PROP_BOOL("xtheadmemidx", RISCVCPU, cfg.ext_xtheadmemidx, false),
+    DEFINE_PROP_BOOL("xtheadmempair", RISCVCPU, cfg.ext_xtheadmempair, false),
+    DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
+    DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
+};
+
 static Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
 
@@ -1908,6 +1909,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_extensions[i].name);
     }
 
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_vendor_exts); i++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_vendor_exts[i].name);
+    }
+
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, riscv_cpu_options[i].name)) {
@@ -1946,6 +1951,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
         qdev_property_add_static(dev, &riscv_cpu_options[i]);
     }
+
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_vendor_exts); i++) {
+        qdev_property_add_static(dev, &riscv_cpu_vendor_exts[i]);
+    }
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


