Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6BA7DFC8C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 23:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qygQs-0006Ka-EC; Thu, 02 Nov 2023 18:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygQq-0006K4-6R
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:44:56 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qygQo-00034p-LI
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 18:44:55 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a86b6391e9so17778347b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698965093; x=1699569893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttOZEwnMtrx2O8A3B+GxwhNzzyOqL9I46ZVTAWDu4h8=;
 b=Gw0mGiKFvHiZCq2aoVI1H6GmhMyyqQdFUW+6dvf6db4LuDGyuSfPhEZcN2UiP1rxsb
 8yFJZ2DPFoZg/vv2wF3xxVa4uR2XhENEGQdOYq4gV0eob8ehG3lKucawMCAbll15jneX
 AWarWqj2HxLJCIz22wneq1JW7OzdLLraNldkOA8eU2zci8ugQGMa0qCdS8jVUsBmQXws
 MdJ+7qZW1LTO/pWeC3JOrRseLqAwT+NftrnTHpVSBwcDFfouUC3veHuAcCcndNRs6g05
 TUXvZyzEJqgRVD0dqWN+PUOWUrM6MwodP01XXS6CiHtdM+2IygzYytH3yzslxmf0jtaV
 u45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965093; x=1699569893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttOZEwnMtrx2O8A3B+GxwhNzzyOqL9I46ZVTAWDu4h8=;
 b=ZoFSBrQkf2lhjVSTbNrRhZbr2OxvEvwGDsrSLlZIO9cgXbfwRzHEWVo1iXHOFniaoh
 SNZD/serY9ECt1AVRj57+5z0eGqI9Xcwb1ls/WVjU8AnFya5CKV4EYrupuQE3vRQIdDu
 VDqsmA17DT2xg1BEt4GKhGTYKP1b18DY3SEdBvfunlQWh6n6JoKfGz2eHK5nXrdFLlDJ
 4/36nzgHw+h/kNaKceGngwaOM0RDNzPUXqxJ8BDvxlchBic7VphpptuppfPKrbD9QIxJ
 /f/q4GMYT81HRCB5j7Sc8EJgy6jsNbXaMUX7c6tmA0RByZYaOhe0bqyZapiFgBljPqOH
 yYuQ==
X-Gm-Message-State: AOJu0YzNOkcdFbDpiu4BjlbcGLReuQtKMRsW/wYG7Zt7f22guWDKkhBC
 7F22nn0OwhQvhs/tGUF7fnPqx3/E+3V+rNlLR+Y=
X-Google-Smtp-Source: AGHT+IHCFgHGqSeR+lG4mJapzXoKRkaL7TuCDL4WpsD2b2zT5Hw349CdcBezOkmfNJkvP2zcjd07cw==
X-Received: by 2002:a81:9211:0:b0:5a7:a81b:d9af with SMTP id
 j17-20020a819211000000b005a7a81bd9afmr1210626ywg.7.1698965092759; 
 Thu, 02 Nov 2023 15:44:52 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 ce10-20020a05690c098a00b0059b24bd4f2asm259523ywb.57.2023.11.02.15.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 15:44:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 01/19] target/riscv: create TYPE_RISCV_VENDOR_CPU
Date: Thu,  2 Nov 2023 19:44:27 -0300
Message-ID: <20231102224445.527355-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102224445.527355-1-dbarboza@ventanamicro.com>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1135.google.com
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
index f3fbe37a2c..7831e86d37 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -24,6 +24,7 @@
 
 #define TYPE_RISCV_CPU "riscv-cpu"
 #define TYPE_RISCV_DYNAMIC_CPU "riscv-dynamic-cpu"
+#define TYPE_RISCV_VENDOR_CPU "riscv-vendor-cpu"
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d73e1da2a2..4bb677275c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1741,6 +1741,13 @@ void riscv_cpu_list(void)
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
@@ -1758,21 +1765,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


