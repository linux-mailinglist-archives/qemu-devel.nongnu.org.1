Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D48274EC
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:20:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsLZ-0003k8-3X; Mon, 08 Jan 2024 11:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMsLT-0003iU-PK
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:19:24 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMsLQ-0007pw-Ko
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:19:23 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso606091b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704730758; x=1705335558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AL8oPXnhktRfkfhm+uRxsJrTlLPRoGfdKXDwW+FK8BE=;
 b=aiJM/36z7tGnFRqYyB7Rp18n9sWAlLM88XcuFvE56RW691VdxY0hb11Y+QSiEzmH85
 44QF5Cg1c1yer7s5WwK0oPJyUE0bow3CR7h+yAnoJWW5ys+u2Muc3tbMpUtfavuqHzUq
 olHDRZGEhvIxvkSAs6oCIbiXneNeDiZXIZu9qouPo5DI6CE2DZlJdyIt/zxkwAPUDOFA
 fgEeRkioYM9VsYHbQylgUzICKyHaVwgOyWWfBq0RPINx4VK1W2UEUa1mWj7RI8M+mo9Z
 mHSVTvF4xV1b8RaJpu0ydtGsgFh2CAuBfHNnQELFd8dtkjYZRshf2uaQuU5QUcrjoude
 VsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704730758; x=1705335558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AL8oPXnhktRfkfhm+uRxsJrTlLPRoGfdKXDwW+FK8BE=;
 b=lesgR/uY9lLcGIsBILAZ6uQ8C3rM0nJBwggcGHzvUo9OLHqZB6cFQZ71IUj4knKp/F
 obayl+/gYYICrzclkp3mDRe9nb8U5HVB+W0fecs9vb4x+IMpvyfe7Qjze2X/eb4Js2PU
 UYv+TDGjOJFVERr4NIDkVw4iBGhTozhuwRW7Yqs1mKNDxI1XCC1hF2XhKwJuyMz48Jd7
 OmCfOKrPJlRHrdJyfcIaqcZ74j6Mvmry1/xSPTg7YCCGVKEHGN3oqLF+S8gERyuVHmFT
 UV+rSrz96w5CZSqeppW6VKQelP6KMmEfkipvn+YfcQ0gs9OyRWyNgADY40ul4mvVA9TD
 4UeQ==
X-Gm-Message-State: AOJu0YwhweDT/1AbE/VPHrbw7xbwOq7hguPfwuwbIxIF/AW0XQoFECqb
 hBxC15rzDowC1iJP3DP9VmvXIVw1KeSs0vXLVAXMRhqP8Ahblg==
X-Google-Smtp-Source: AGHT+IFXqzGbjuEH6mlM5T1SHw8AFwGqb0wzziiJRpQ13bXRy3ItNHS5cizwguuuasPWUzdG2pHBbA==
X-Received: by 2002:a05:6a00:1941:b0:6da:c623:f060 with SMTP id
 s1-20020a056a00194100b006dac623f060mr1334414pfk.68.1704730758421; 
 Mon, 08 Jan 2024 08:19:18 -0800 (PST)
Received: from grind.. ([189.79.22.11]) by smtp.gmail.com with ESMTPSA id
 b29-20020aa78edd000000b006db056542e6sm49151pfr.190.2024.01.08.08.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 08:19:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 2/2] target/riscv: add rv32i, rv32e and rv64e CPUs
Date: Mon,  8 Jan 2024 13:19:03 -0300
Message-ID: <20240108161903.353648-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108161903.353648-1-dbarboza@ventanamicro.com>
References: <20240108161903.353648-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

A bare bones 32 bit RVI CPU, rv32i, will make users lives easier when a
full customized 32 bit CPU is desired, and users won't need to disable
defaults by hand as they would with the rv32 CPU. [1] has an example of
a situation that would be avoided with rv32i.

In fact, add bare bones CPUs for RVE as well. Trying to use RVE in QEMU
requires one to disable every single default extension, including RVI,
and then add the desirable extension set. Adding rv32e/rv64e makes it
more pleasant to use embedded CPUs in QEMU.

[1] https://lore.kernel.org/qemu-riscv/258be47f-97be-4308-bed5-dc34ef7ff954@Spark/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  3 +++
 target/riscv/cpu.c     | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 9219c2fcc3..3670cfe6d9 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -34,7 +34,10 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
+#define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
+#define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
 #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
+#define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1202ec3e57..b9f10b773b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -576,6 +576,12 @@ static void rv64i_bare_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     riscv_cpu_set_misa(env, MXL_RV64, RVI);
 }
+
+static void rv64e_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa(env, MXL_RV64, RVE);
+}
 #else
 static void rv32_base_cpu_init(Object *obj)
 {
@@ -657,6 +663,18 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
+
+static void rv32i_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa(env, MXL_RV32, RVI);
+}
+
+static void rv32e_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa(env, MXL_RV32, RVE);
+}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -1948,6 +1966,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34,  rv32_imafcu_nommu_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34,  rv32_sifive_u_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I, rv32i_bare_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E, rv32e_bare_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,   rv64_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51,  rv64_sifive_e_cpu_init),
@@ -1957,6 +1977,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E, rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64, rva22s64_profile_cpu_init),
 #endif
-- 
2.43.0


