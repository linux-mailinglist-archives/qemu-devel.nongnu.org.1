Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A938233A3
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:42:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Ej-00044z-5V; Wed, 03 Jan 2024 12:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5ET-0002dD-JD
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:46 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5ER-0001cw-Vj
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:45 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso1434204b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704303640; x=1704908440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P47JvB6Aj0fl5W0avy5vyCnxmg8G6WNczQqsL8+H3h8=;
 b=hEc1mPU1/KBHEjewKhZBmnn4AcU/DPC6yp2eR+sLAEEPPYboar+hbtpLjdomESzMMh
 n0wbgPL6IC4eyb6JgRKvZt5kbrl/DM8QfvU661N8TjNXRUt7V5CmuiK3gm0gKA5UsfFu
 XvybqEhr2g8nQ50i3IPDIJU6v9wis/MVEYCEvIqT7LZNxRfzl3iWPYGkDyTYqtmSKDGS
 cACjzXYRNPcpb7NKwQySyDPR8RKKDQ5gz57JwHMmso0HzH0Sbc3MRdDS/oQ8GpXW3qv+
 4I/tNkbVpvcGOufiWA0EuZ8RVAigK/lmZPzSR7qBTlPFWNCDThipoOesw4pcjpL8rKmK
 xv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303640; x=1704908440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P47JvB6Aj0fl5W0avy5vyCnxmg8G6WNczQqsL8+H3h8=;
 b=Pw3zPuiLc2df4NspVUDsHaF8x6ui6AFbRX+B2348JQ4mSiB9Dh6q0CslXvfeWKB+Wn
 hyQ6OynQUWCgbIdnwc6LO8bxZ14mspOPVSixQyd/wMmGKhxKymUwMQJ8rMepxTO9gU+E
 x/mccmzE+847L2MZGkg7GDXaZJo27wP+5JbHxiaY0lsezieRZgIlZYjmfqHOefl8/GaG
 ahxOxwSDKM0HsHrZw3wYzLl4rMJEx568bfoYtgcNCh5qT1bJ25ADC2cJiOCqYGy5X3Q4
 h6vd3k/JivIHSEB8imlUrhPnjchyiraV3Wz4k2EP2j+BfDL30bGfYI9Tc6qQb11zdC9P
 7PPQ==
X-Gm-Message-State: AOJu0YwErHGYKVd5h8OvXHZGRcCiHZzE3XYrVUoOHBs/yT23Or7bVstm
 994Kq9sbeM2YfdrcdBFaf5Z8/8kV620heOajQ9arzWZpg5DL+g==
X-Google-Smtp-Source: AGHT+IHttDU/YhKaWoA/ylMBkfm9rzgHOYvBgFx5NXAngAqcnieC4a+nU3efuNM69s82WG0q5RvbQg==
X-Received: by 2002:a62:5f86:0:b0:6d9:c16b:207c with SMTP id
 t128-20020a625f86000000b006d9c16b207cmr5616662pfb.10.1704303640157; 
 Wed, 03 Jan 2024 09:40:40 -0800 (PST)
Received: from grind.. ([189.79.21.107]) by smtp.gmail.com with ESMTPSA id
 v3-20020aa78503000000b006d7f1ae421csm24042050pfn.145.2024.01.03.09.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:40:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, vladimir.isaev@syntacore.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 05/16] target/riscv: move 'pmp' to riscv_cpu_properties[]
Date: Wed,  3 Jan 2024 14:40:02 -0300
Message-ID: <20240103174013.147279-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103174013.147279-1-dbarboza@ventanamicro.com>
References: <20240103174013.147279-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

Move 'pmp' to riscv_cpu_properties[], creating a new setter() for it
that forbids 'pmp' to be changed in vendor CPUs, like we did with the
'mmu' option.

We'll also have to manually set 'pmp = true' to generic CPUs that were
still relying on the previous default to set it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9f1407b73f..01b3b57cee 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -420,6 +420,7 @@ static void riscv_max_cpu_init(Object *obj)
     RISCVMXL mlx = MXL_RV64;
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
 #ifdef TARGET_RISCV32
     mlx = MXL_RV32;
@@ -439,6 +440,7 @@ static void rv64_base_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV64, 0);
@@ -568,6 +570,7 @@ static void rv128_base_cpu_init(Object *obj)
     }
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV128, 0);
@@ -584,6 +587,7 @@ static void rv32_base_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV32, 0);
@@ -1596,9 +1600,38 @@ static const PropertyInfo prop_mmu = {
     .set = prop_mmu_set,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
 
+    if (cpu->cfg.pmp != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.pmp = value;
+}
+
+static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.pmp;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_pmp = {
+    .name = "pmp",
+    .get = prop_pmp_get,
+    .set = prop_pmp_set,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
 
@@ -1618,6 +1651,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
     {.name = "mmu", .info = &prop_mmu},
+    {.name = "pmp", .info = &prop_pmp},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
-- 
2.43.0


