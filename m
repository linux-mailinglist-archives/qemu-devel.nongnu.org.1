Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE057F8527
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 21:25:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6cjB-000231-FX; Fri, 24 Nov 2023 15:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cj9-000226-20
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6cj7-0005LD-BF
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 15:24:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cfb30ce241so594895ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700857475; x=1701462275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T07mAdmI2OqKcKY4NnCC8XHhP1yglkcR7GVjfgsyYYY=;
 b=Y9KhYuoVd1JDJ9psjLDBHEwKKAYgNRKTAQQ8fsrQCHkTlBaQyJpuvoP6hdkLkIlAiR
 0oXZUPEIvGbiaSB2Cna6YdCUPHMNPFiMtdP8DHMcx5WJJtG2eiOpEmKdmESZUcstvKTg
 /fDdyq8cV8gMCGHlOKymOd6mNMmSlEiVttjDybDIbSgcixNJfo1iTf/+AJxC9C3TY0E+
 4iQsT3qo2rNkxReIMImR0wASc8UzaZdtlPVS8gQcAl/tXqQO7GLe1O2g4JGKOPbd0Dm2
 N3yIWsJzoBc7TjRpXpuqxvWjizICgMQuvWvO12FaTSaYPCmkK9sYrhDIAohHMGwtjmpm
 BURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700857475; x=1701462275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T07mAdmI2OqKcKY4NnCC8XHhP1yglkcR7GVjfgsyYYY=;
 b=T1Sw9mad7jsSgKVI0LMZVjuRtaPn+k+cLckWHQcSqGnBcaItY5FsVz1BdH6FnL8g/a
 cQkyakV05Y29Cz9u4270ugjAaXv42xluBMwAEt/Y4TRkLqAKreHE9xJfsFuB6dhmlKfC
 D7Z8xn5ZEeYRcDfLQ07cSy+48GrnkLfEcN1BCZV70LPP1wcvBRq1u4enEXURcx5WithX
 g6RnBiHXnkwm3mNHCNzR6JCBpI8xO1K26WbJthVUKJkFrTH13YyqXJb4mtaGcgIYvNDS
 PByj/zUwtkNtq9QqPmocrKQ6FFtME/zULgsbeXGabdKf+qi3zuJ3LDEsry8g9dVyOByV
 +6+Q==
X-Gm-Message-State: AOJu0YwsTE+WJiBngX1r5GKzOEl1L7G1TvEH5Bnsj5IWYS6DcL/MyGuX
 J+3OPrCykoF2TpIUwi5qVFSoWHU1iH+jWI0/5ac=
X-Google-Smtp-Source: AGHT+IEao6AUB8oCUjQP7ZynJavER//4ehIEMv0zqEHq1otDDTWPFTqKvyyhHUUVJTfG6Q+yTLr4aA==
X-Received: by 2002:a17:903:2596:b0:1cf:9d88:a0ef with SMTP id
 jb22-20020a170903259600b001cf9d88a0efmr3188242plb.59.1700857475278; 
 Fri, 24 Nov 2023 12:24:35 -0800 (PST)
Received: from grind.. ([152.250.131.119]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001c59f23a3fesm3548267plo.251.2023.11.24.12.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 12:24:34 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v12 11/18] target/riscv/tcg: add MISA user options hash
Date: Fri, 24 Nov 2023 17:23:46 -0300
Message-ID: <20231124202353.1187814-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
References: <20231124202353.1187814-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

We already track user choice for multi-letter extensions because we
needed to honor user choice when enabling/disabling extensions during
realize(). We refrained from adding the same mechanism for MISA
extensions since we didn't need it.

Profile support requires tne need to check for user choice for MISA
extensions, so let's add the corresponding hash now. It works like the
existing multi-letter hash (multi_ext_user_opts) but tracking MISA bits
options in the cpu_set_misa_ext_cfg() callback.

Note that we can't re-use the same hash from multi-letter extensions
because that hash uses cpu->cfg offsets as keys, while for MISA
extensions we're using MISA bits as keys.

After adding the user hash in cpu_set_misa_ext_cfg(), setting default
values with object_property_set_bool() in add_misa_properties() will end
up marking the user choice hash with them. Set the default value
manually to avoid it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 83d4dd00cf..2affc1f771 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -34,6 +34,7 @@
 
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
+static GHashTable *misa_ext_user_opts;
 
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
@@ -802,6 +803,10 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    g_hash_table_insert(misa_ext_user_opts,
+                        GUINT_TO_POINTER(misa_bit),
+                        (gpointer)value);
+
     prev_val = env->misa_ext & misa_bit;
 
     if (value == prev_val) {
@@ -873,6 +878,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
+    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -893,7 +899,13 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
                             NULL, (void *)misa_cfg);
         object_property_set_description(cpu_obj, name, desc);
         if (use_def_vals) {
-            object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
+            if (misa_cfg->enabled) {
+                env->misa_ext |= bit;
+                env->misa_ext_mask |= bit;
+            } else {
+                env->misa_ext &= ~bit;
+                env->misa_ext_mask &= ~bit;
+            }
         }
     }
 }
@@ -1142,6 +1154,7 @@ static void tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
-- 
2.41.0


