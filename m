Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E402788821
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZD-0001jg-FX; Fri, 25 Aug 2023 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZ0-0001cr-RA
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:23 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWYu-0006vv-VF
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:20 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1c0fcbf7ae4so609514fac.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968954; x=1693573754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CP2vhp8LlfcJBLP8hC7S4lzTEN+iHBj8lw+Q9+3k1Bo=;
 b=CnDjicOe/w24l7Is1+NEobjXQ428x8b34e8UzNUYNbeKwM0rOJo8ae7P+edP13Z3Ll
 TxOdd9y6isji+Q6bjcKZWwAUjsSfyx4CK+Ya85M/afa9gGIPWAmvzjyBd1H4lJ7afdrS
 GDwQ8vUAi7OpixAKX/HrbQwA8iQvBIjGS9dMiS0MvN6vvcwcM1eLY/X5DG8s3FamVgP0
 CqF+YdqmqZpDUkQrMdsNMtKCndFL5+V5RU84HMq/8KruaDFqqR/6ZCTLz6gA/t7d85gw
 hip3rhdwW5naDI86vUYQW64Yil1vcr7F7Iq2CR9GJd+7M8+pCXGGlqIJVrviNE/6GLpr
 N5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968954; x=1693573754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CP2vhp8LlfcJBLP8hC7S4lzTEN+iHBj8lw+Q9+3k1Bo=;
 b=CNr1gF/vwrmqQMACw+xbMx0j8e/Sz41TxaURNQo2Ce2gYtU97xyJXuUzstNCoNKvGG
 QE6PBiH79k4yOjgEfxR490Lll3+X9VlTITz1INukfyfvo+m+LzHbHpVngW/MmeCupsBo
 27HNucK3hCAuY64gVbrE3pA+L1VOQIyzN+X9HBKieGrMlbN0rKDChWJWBKJFR91hE59q
 o1DWqn06W7oI1b/NLNyUWe6EUqXYFCdzvd1yUUx+U26VlpBWPQFzrUP/9p/spZoGLOQO
 61apZyNtCQG49ryyvxtK0/ENlYz9d5NGQ/n24zofRBkTQIAo6IyG10+N+ZldmrHth0jD
 TMpQ==
X-Gm-Message-State: AOJu0Yzk/QhaS7bucjZnqAf3emBHXPtWzhhaHJGkfRx6E5GmbLWccQs0
 MZnA1PBaNEHo+QDPxlddPL8jzd8szM0TXdRlSIg=
X-Google-Smtp-Source: AGHT+IFWgAYa2e83wBl9+zYNysZhFIPQoqx6PBo6kV5dPKkkjN+vVa7mF/bnhuPxcxAK5pJ2c5liRQ==
X-Received: by 2002:a05:6870:e312:b0:1bf:304f:80cd with SMTP id
 z18-20020a056870e31200b001bf304f80cdmr2840675oad.51.1692968954724; 
 Fri, 25 Aug 2023 06:09:14 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 05/20] target/riscv/cpu.c: add 'user_extension_properties'
 class prop
Date: Fri, 25 Aug 2023 10:08:38 -0300
Message-ID: <20230825130853.511782-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2c.google.com
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

We want to use a post_init hook to call the cpu_instance_init callback
from each accelerator, moving repetitive code from the cpu_init()
functions to be handled by the accelerator class. But first we need to
ensure that we don't change behavior - vendor CPUs shouldn't expose user
properties, generic CPUs should expose.

Create a new 'user_extension_properties' class property. It'll be
initialized during the class init of each CPU type, where only generic
(dynamic) CPUs will enable it. This new property will be used shortly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  3 +++
 target/riscv/cpu.c     | 46 +++++++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index f3fbe37a2c..7c76dc0dcc 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -24,6 +24,7 @@
 
 #define TYPE_RISCV_CPU "riscv-cpu"
 #define TYPE_RISCV_DYNAMIC_CPU "riscv-dynamic-cpu"
+#define TYPE_RISCV_VENDOR_CPU "riscv-vendor-cpu"
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
@@ -68,5 +69,7 @@ struct RISCVCPUClass {
     /*< public >*/
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+
+    bool user_extension_properties;
 };
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 839b83e52a..e2e8724dc2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1975,6 +1975,20 @@ void riscv_cpu_list(void)
     g_slist_free(list);
 }
 
+static void riscv_dynamic_cpu_class_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *rcc = RISCV_CPU_CLASS(c);
+
+    rcc->user_extension_properties = true;
+}
+
+static void riscv_vendor_cpu_class_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *rcc = RISCV_CPU_CLASS(c);
+
+    rcc->user_extension_properties = false;
+}
+
 #define DEFINE_CPU(type_name, initfn)      \
     {                                      \
         .name = type_name,                 \
@@ -1989,6 +2003,13 @@ void riscv_cpu_list(void)
         .instance_init = initfn               \
     }
 
+#define DEFINE_VENDOR_CPU(type_name, initfn) \
+    {                                        \
+        .name = type_name,                   \
+        .parent = TYPE_RISCV_VENDOR_CPU,     \
+        .instance_init = initfn              \
+    }
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -2003,6 +2024,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_DYNAMIC_CPU,
         .parent = TYPE_RISCV_CPU,
+        .class_init = riscv_dynamic_cpu_class_init,
+        .abstract = true,
+    },
+    {
+        .name = TYPE_RISCV_VENDOR_CPU,
+        .parent = TYPE_RISCV_CPU,
+        .class_init = riscv_vendor_cpu_class_init,
         .abstract = true,
     },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
@@ -2012,17 +2040,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,   rv32_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32_sifive_e_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,   rv64_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64_sifive_u_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SHAKTI_C,         rv64_sifive_u_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_THEAD_C906,       rv64_thead_c906_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_VEYRON_V1,        rv64_veyron_v1_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64_sifive_e_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,         rv64_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906,       rv64_thead_c906_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,        rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
 #endif
 };
-- 
2.41.0


