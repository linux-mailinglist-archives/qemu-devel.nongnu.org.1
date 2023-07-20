Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397375B584
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:21:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXKS-0008UJ-Pj; Thu, 20 Jul 2023 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJm-0007jH-AV
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:19:59 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJk-0004a2-Nh
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:19:58 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1baf02c36e0so789403fac.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873595; x=1690478395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9/FrzUx3PVpnnFHAiBC8xSPgKQwTkUU1opDFHziErI=;
 b=K1KyuWISc35DwNKs8uvuzpFiWr11q5PCzdNlCAJM3esH0M4gaqOoP/4OvSbYBBbmkA
 OwqAQ+na2oqjmQmJvP3Tr2aQU9E4gqItH4h1u5nzOhHlKGppZ9XKjnQYhHAeaftbpi9Z
 4yIwM4WWHQx7K5fAlMNFxDgQndkTtnxVeMPbqTwXkmsrz2mhUP1PlhXMKNBvmaxwluYe
 IY4h9qVL77gG9SFyuJTNih2wnKnRCPOfQ/KIMU2l7c5YpB0A/i9Dx2/uKNFZUXkTe9dv
 v+e8BCIFL+e/yPk8kU6GQRWBP96f5iEEBF8wkP9MK5zHiWWLbLm24qF5pUSsSjQSx6H2
 fonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873595; x=1690478395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9/FrzUx3PVpnnFHAiBC8xSPgKQwTkUU1opDFHziErI=;
 b=gYxEBrnbA+gRsWbMNQFRPiBr4/JKCZMx9nPASq7F4t+VkDJ7taoALkROoVG1oApge0
 QXeHTmsE5HsuPS38US9STEKybrV0HZyMhDMDjsDV+jiKbsSujCJxzygfMu1qBDxuZn2r
 mUnPcuE++9vv9cTCE4EJFMYCxMxy8JCSpRkCwUllusK4uEunmRhOh2Hq9y/92i7xh0P0
 SVYTZvnbeZm6a2GufLwzadRQaIy78Y5KYNovE0fPUKmGkG2O8fdDFWL9wkY7W/ycFBnZ
 ALUPNOsfy3sNPi/EJHvckKfTZACLT8p6f2/hytRukFTj5q4lV+OwjzMEDxqrRDXCZ5Nt
 FAvw==
X-Gm-Message-State: ABy/qLagwFGP2FG7VQvYYAYLU2SKAD0DDu53OMJih5y/sl1xV+zok3Ev
 eJj6gqxIwIao5RUAhwg8jb4Fq1seaMgz+Rfx3Ocq8g==
X-Google-Smtp-Source: APBJJlG02zsC4HmVTQoAZhirG1wsUgtlvZ4gNh47UVFufaa6oPGt8hiINk0sv3xJhi10hCXfWaagHg==
X-Received: by 2002:a05:6870:73c7:b0:1b0:2203:2bed with SMTP id
 a7-20020a05687073c700b001b022032bedmr90185oan.59.1689873594892; 
 Thu, 20 Jul 2023 10:19:54 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:19:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 05/11] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Thu, 20 Jul 2023 14:19:27 -0300
Message-ID: <20230720171933.404398-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720171933.404398-1-dbarboza@ventanamicro.com>
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
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
index 4dadb7f0a0..3a20a41dfc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1807,20 +1807,6 @@ static Property riscv_cpu_extensions[] = {
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
 
@@ -1837,6 +1823,21 @@ static Property riscv_cpu_extensions[] = {
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
 
@@ -1901,6 +1902,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_extensions[i].name);
     }
 
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_vendor_exts); i++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_vendor_exts[i].name);
+    }
+
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, riscv_cpu_options[i].name)) {
@@ -1939,6 +1944,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


