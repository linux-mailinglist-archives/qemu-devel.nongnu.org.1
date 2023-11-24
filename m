Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A213E7F8529
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 21:25:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6cij-0001oQ-Ds; Fri, 24 Nov 2023 15:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cif-0001o8-14
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cid-00057R-E2
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cf8720c6b7so17375315ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700857445; x=1701462245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g27N76GsCjcJjpEII+LykYnwIqcFv/pUM+HDkvpl0o4=;
 b=pbSEMAuBt7gqBWpghdL/Iu8JPIdBSgTV1jvT6yfhHyju6z88NGRvODIPUnCYMuk5oI
 fCOXew2Ca6zTP3fZdXuKmxTPxv09aue3Zh+sfwKGp91lJfKKMwpxczxS6r5aEiUkYqr8
 G7KZh7V8rH4D+uBueErd0OMGHpY9WWNDYUXUAMqXcCXzZZauYBgUOhZnFCXqgDSV93eu
 ZgK8mKhS2RqlLdnk+fAefx/bVny1LUL/w4D0c0z6aYP/yFyzHVLN3Qvngp37xhRvJC8r
 6npq4aBueVKNC4Jfe41CKr/nPiSa1Q4CIb0cdlWpL44PfNb7mlGmrki+nYzgS3JzSAeV
 +Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700857445; x=1701462245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g27N76GsCjcJjpEII+LykYnwIqcFv/pUM+HDkvpl0o4=;
 b=so/2/FuQJNdh6XkPk88zM+Ox4GhVfi9HonCZ1aVuuczNquiOUPyn5JBDUcorFqJuSu
 Zo85LcWpM7K0ofkHzMfRLmOjKs5XqCO/CIb5OMCzNIOw5l0A5ZNYsI8RJzbUQraMObtH
 NYECQw7SPSnfLZrbzKfU7ygIGQoD/y09UY88iAShl/UNFfzR5aVMcpQZoklvGqt64B68
 Met+ky7pUXdLphmgC2TJXoHDnY2nwpc9jTnodBUWbCpTEXCrFRibBHopGUEPZhvs4i74
 +mJE/QqdzBTy9HCpFIbTRD6+oFpup4H7HcciCn6IUIAOMB+6XXEHOzfdcwKIFVfd5mc7
 +KPA==
X-Gm-Message-State: AOJu0YywWxUTLocCP4NaKNJPke09UO4UAAX3MMNu9KxP+aTumRSMlEL1
 ClwLSWrppW744XREm9Q4uIw2+LCidTPepwafXe4=
X-Google-Smtp-Source: AGHT+IFxdad97pV5oZEMWnzGqq7Br8wo/SJI/VA7oh0Hca2gLVy4Q6LmXcgiFy7R1NIXjXPwMNjtUw==
X-Received: by 2002:a17:90b:3884:b0:285:9450:c1bf with SMTP id
 mu4-20020a17090b388400b002859450c1bfmr2388259pjb.25.1700857445549; 
 Fri, 24 Nov 2023 12:24:05 -0800 (PST)
Received: from grind.. ([152.250.131.119]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001c59f23a3fesm3548267plo.251.2023.11.24.12.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 12:24:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v12 01/18] target/riscv: create TYPE_RISCV_VENDOR_CPU
Date: Fri, 24 Nov 2023 17:23:36 -0300
Message-ID: <20231124202353.1187814-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
References: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

We want to add a new CPU type for bare CPUs that will inherit specific
traits of the 2 existing types:

- it will allow for extensions to be enabled/disabled, like generic
  CPUs;

- it will NOT inherit defaults, like vendor CPUs.

We can make this conditions met by adding an explicit type for the
existing vendor CPUs and change the existing logic to not imply that
"not generic" means vendor CPUs.

Let's add the "vendor" CPU type first.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 30 +++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 91b3361dec..ca7dd509e3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -23,6 +23,7 @@
 
 #define TYPE_RISCV_CPU "riscv-cpu"
 #define TYPE_RISCV_DYNAMIC_CPU "riscv-dynamic-cpu"
+#define TYPE_RISCV_VENDOR_CPU "riscv-vendor-cpu"
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 83c7c0cf07..220113408e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1778,6 +1778,13 @@ void riscv_cpu_list(void)
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
@@ -1795,21 +1802,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .parent = TYPE_RISCV_CPU,
         .abstract = true,
     },
+    {
+        .name = TYPE_RISCV_VENDOR_CPU,
+        .parent = TYPE_RISCV_CPU,
+        .abstract = true,
+    },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,   rv32_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,        rv32_ibex_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31,  rv32_sifive_e_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34,  rv32_imafcu_nommu_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34,  rv32_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,   rv64_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64_sifive_u_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SHAKTI_C,         rv64_sifive_u_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_THEAD_C906,       rv64_thead_c906_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_VEYRON_V1,        rv64_veyron_v1_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51,  rv64_sifive_e_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54,  rv64_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,    rv64_sifive_u_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906,  rv64_thead_c906_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
 #endif
 };
-- 
2.41.0


