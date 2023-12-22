Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD981C9E9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYT-0001a7-94; Fri, 22 Dec 2023 07:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYP-0001Z7-Ci
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:01 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYL-00069d-N2
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:01 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so1376870a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247776; x=1703852576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMiNukS15sXZyEFe1/DpEuyjyQKpRoVTTin9o1fOUjw=;
 b=QmMgr+VHULFWx9+3Kv6cXz7qJmGhSg127781QYqXGJythaZXsT4SX0qUOGNhJYCStH
 Nst1qlTJA3E74mBwoLHnmmZoaiFTjJRSjGGTPlrUT1HgPG4lR6H8+EJeOAICcQE35ns1
 sgrqYZOgzmSN+6XvL90/oTM3kvR+HrPp5hleB0C7ZuMjiRrCWVQp2MI/7EtI7WOYQlhr
 iGxSueVN2kxecZgoLQVlCqDsvJpCv1pX4inqMCKKY9KtzjkHV0Zm8hoc2n9Q5ZddaIJD
 luTsQAOjA6SjVGQE0XXWJ1XTHqM0JZf3TU0+noovIyP1SqugH01gR1iyxNKlgU736oO4
 ZHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247776; x=1703852576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMiNukS15sXZyEFe1/DpEuyjyQKpRoVTTin9o1fOUjw=;
 b=IVxozQsvAjdsnQUa441AlZnAQeZ2nL99ICRUOeni6Goo/EEUDIKui8F/vnph5+40JV
 65vBp9OddVHq6Fa/zHPae/+jmZRa8j1r3tpCHxjwN9oPd175mmltSqq9BHC98NLVRn/C
 VKf32MJYfCqKvHbnq6+AtbXD5/YZzR79d4iYT8IMbz5W937NrZljp1K4QURrZXPDoEl4
 gH4iiquum/XRDlTVmoGA6NOht4Tb/DeYM3APWvUu3Ddy4heJ+J4Z/lITQc3lmI99OggC
 xqfa1W2qCyFsJZ5ZlKT6CAzu3kciEtVne0Adw1faFECF7VOhaad10e1e8M+pP8h2duh0
 Fpeg==
X-Gm-Message-State: AOJu0YyDEunOt5Xe2rfO7sktcEJasT6YniZ2kJ9KP4my1HbSoM137+5Y
 Yy8+WolljY/ouO+R3RAbmHnrx22d0QOu7mbI4fJirOv78KuS+A==
X-Google-Smtp-Source: AGHT+IF9U3E6k7sk8LhGa8fFxDLg15xPPDAg7iyHuMn9KB6zMu/e+4LLvs8PpHAHb3met77aFFGr0Q==
X-Received: by 2002:a05:6a20:3d89:b0:190:351b:a2ae with SMTP id
 s9-20020a056a203d8900b00190351ba2aemr1332715pzi.62.1703247775764; 
 Fri, 22 Dec 2023 04:22:55 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:22:55 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 05/16] target/riscv: move 'pmp' to riscv_cpu_properties[]
Date: Fri, 22 Dec 2023 09:22:24 -0300
Message-ID: <20231222122235.545235-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52b.google.com
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
 target/riscv/cpu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 080713b9b5..bdb6466c84 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -411,6 +411,7 @@ static void riscv_max_cpu_init(Object *obj)
     RISCVMXL mlx = MXL_RV64;
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
 #ifdef TARGET_RISCV32
     mlx = MXL_RV32;
@@ -430,6 +431,7 @@ static void rv64_base_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV64, 0);
@@ -559,6 +561,7 @@ static void rv128_base_cpu_init(Object *obj)
     }
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV128, 0);
@@ -575,6 +578,7 @@ static void rv32_base_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
 
     cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 
     /* We set this in the realise function */
     riscv_cpu_set_misa(env, MXL_RV32, 0);
@@ -1526,9 +1530,37 @@ static const PropertyInfo prop_mmu = {
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
 
@@ -1549,6 +1581,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
     {.name = "mmu", .info = &prop_mmu},
+    {.name = "pmp", .info = &prop_pmp},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
-- 
2.43.0


