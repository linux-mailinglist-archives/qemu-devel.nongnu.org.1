Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 906FC7C63F8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4l-0006Fn-3a; Thu, 12 Oct 2023 00:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4e-0005oJ-TD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4d-0002h3-0a
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so3297435ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084001; x=1697688801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McHKOPQuN5tj42C7iRQBsktsmvLNmdNaZJdDRL/HmxY=;
 b=LthvSd8Cdw6H+s3R9R2+13r0W6d2sTZW7ShSNLJQxVBcDPBIqHEzYBhI+EVFDiyeo4
 rlxFDYC+ee5Cd+UXgAQB/5wxG8KHDXug/0mmgxLhCnIPjTn+dcCOW4bp2LAlKygatlHo
 9pNR+pQIFW5Wmfd8rC3pn0gGT7+7QfDU1GbuYdNEJ/1uuEDyl2fHzfQrPtxvPjaUvXv0
 ro2D1o8FSW8Zm6ZDnEQyCpQkx+0RNq3jPGZv8maXy8MiD53GCDQ/xu2m+vrjSXWJnNqi
 5eLyvL3EEKa5C8hzwzzvF9mrPuqZxnjoiKcae7QOhKsjeLNmEl7F5z7ss2nB06/i0ITc
 2Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084001; x=1697688801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McHKOPQuN5tj42C7iRQBsktsmvLNmdNaZJdDRL/HmxY=;
 b=RKnV3dC6TlkVpJ/TTL88FDree0SbCthv7TwASIlqsK/NvScY4Yi853oNxqRA8iw8lD
 B+iOkHhtMUXMlivldBIeZYzG5c1+kGNbS9E4scLLfHKyM1SPSNlsoltkJwN4oR+gZeAD
 lKZVGkgwcOdislNwrGD0Ug3Yj+3ItdX9OE0kcOlkDXiMS18JfRW+T1P3XGK7o9GWkXti
 BTR91n5q+KOgCz31tgRkDg84Oi4O5RsvdrD295uGJ8ZPHWmLDczvP8bxUbjXhKgM2KpU
 oyC11iDkATNpJLXsYL1tR2NC8zXn65AFAh/j1zL5xz6GqTtE+MMmBpKASTYnHHgadcMv
 th9Q==
X-Gm-Message-State: AOJu0YzGLz4ZZmjYtKmz+Z9Odd/99edaajPfTbOCF1L/UkfoJYhWGD9i
 cnjHW9AL5Y/G07eEHHWHsQj2EP0GNr1nKg==
X-Google-Smtp-Source: AGHT+IG2THN35eUPPqf1jVQL68/GcP7Kq7N3tYQWh+sIidhmPJaHKvoXW1s2qRIIyJ5IOtI/w7TgRQ==
X-Received: by 2002:a17:902:6b04:b0:1c3:1c74:5d0a with SMTP id
 o4-20020a1709026b0400b001c31c745d0amr18577996plk.34.1697084001269; 
 Wed, 11 Oct 2023 21:13:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/54] target/riscv/tcg: move riscv_cpu_add_misa_properties()
 to tcg-cpu.c
Date: Thu, 12 Oct 2023 14:10:36 +1000
Message-ID: <20231012041051.2572507-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

All code related to MISA TCG properties is also moved.

At this point, all TCG properties handling is done in tcg-cpu.c, all KVM
properties handling is done in kvm-cpu.c.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-18-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 -
 target/riscv/cpu.c         | 90 --------------------------------------
 target/riscv/tcg/tcg-cpu.c | 90 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 91 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9d41beafec..089c7e6d95 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -726,7 +726,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern Property riscv_cpu_options[];
 
-void riscv_cpu_add_misa_properties(Object *cpu_obj);
 void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1c42e2590e..d758d61ff8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1207,47 +1207,6 @@ static void riscv_cpu_init(Object *obj)
 #endif /* CONFIG_USER_ONLY */
 }
 
-typedef struct RISCVCPUMisaExtConfig {
-    target_ulong misa_bit;
-    bool enabled;
-} RISCVCPUMisaExtConfig;
-
-static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
-    target_ulong misa_bit = misa_ext_cfg->misa_bit;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    bool value;
-
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-
-    if (value) {
-        env->misa_ext |= misa_bit;
-        env->misa_ext_mask |= misa_bit;
-    } else {
-        env->misa_ext &= ~misa_bit;
-        env->misa_ext_mask &= ~misa_bit;
-    }
-}
-
-static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
-    target_ulong misa_bit = misa_ext_cfg->misa_bit;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    bool value;
-
-    value = env->misa_ext & misa_bit;
-
-    visit_type_bool(v, name, &value, errp);
-}
-
 typedef struct misa_ext_info {
     const char *name;
     const char *description;
@@ -1308,55 +1267,6 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
     return val;
 }
 
-#define MISA_CFG(_bit, _enabled) \
-    {.misa_bit = _bit, .enabled = _enabled}
-
-static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
-    MISA_CFG(RVA, true),
-    MISA_CFG(RVC, true),
-    MISA_CFG(RVD, true),
-    MISA_CFG(RVF, true),
-    MISA_CFG(RVI, true),
-    MISA_CFG(RVE, false),
-    MISA_CFG(RVM, true),
-    MISA_CFG(RVS, true),
-    MISA_CFG(RVU, true),
-    MISA_CFG(RVH, true),
-    MISA_CFG(RVJ, false),
-    MISA_CFG(RVV, false),
-    MISA_CFG(RVG, false),
-};
-
-/*
- * We do not support user choice tracking for MISA
- * extensions yet because, so far, we do not silently
- * change MISA bits during realize() (RVG enables MISA
- * bits but the user is warned about it).
- */
-void riscv_cpu_add_misa_properties(Object *cpu_obj)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
-        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
-        int bit = misa_cfg->misa_bit;
-        const char *name = riscv_get_misa_ext_name(bit);
-        const char *desc = riscv_get_misa_ext_description(bit);
-
-        /* Check if KVM already created the property */
-        if (object_property_find(cpu_obj, name)) {
-            continue;
-        }
-
-        object_property_add(cpu_obj, name, "bool",
-                            cpu_get_misa_ext_cfg,
-                            cpu_set_misa_ext_cfg,
-                            NULL, (void *)misa_cfg);
-        object_property_set_description(cpu_obj, name, desc);
-        object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
-    }
-}
-
 #define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .enabled = _defval}
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 30740ba030..ef981ad0ce 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -580,6 +580,96 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
     return true;
 }
 
+typedef struct RISCVCPUMisaExtConfig {
+    target_ulong misa_bit;
+    bool enabled;
+} RISCVCPUMisaExtConfig;
+
+static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
+    target_ulong misa_bit = misa_ext_cfg->misa_bit;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value) {
+        env->misa_ext |= misa_bit;
+        env->misa_ext_mask |= misa_bit;
+    } else {
+        env->misa_ext &= ~misa_bit;
+        env->misa_ext_mask &= ~misa_bit;
+    }
+}
+
+static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
+    target_ulong misa_bit = misa_ext_cfg->misa_bit;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    bool value;
+
+    value = env->misa_ext & misa_bit;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+#define MISA_CFG(_bit, _enabled) \
+    {.misa_bit = _bit, .enabled = _enabled}
+
+static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
+    MISA_CFG(RVA, true),
+    MISA_CFG(RVC, true),
+    MISA_CFG(RVD, true),
+    MISA_CFG(RVF, true),
+    MISA_CFG(RVI, true),
+    MISA_CFG(RVE, false),
+    MISA_CFG(RVM, true),
+    MISA_CFG(RVS, true),
+    MISA_CFG(RVU, true),
+    MISA_CFG(RVH, true),
+    MISA_CFG(RVJ, false),
+    MISA_CFG(RVV, false),
+    MISA_CFG(RVG, false),
+};
+
+/*
+ * We do not support user choice tracking for MISA
+ * extensions yet because, so far, we do not silently
+ * change MISA bits during realize() (RVG enables MISA
+ * bits but the user is warned about it).
+ */
+static void riscv_cpu_add_misa_properties(Object *cpu_obj)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
+        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        int bit = misa_cfg->misa_bit;
+        const char *name = riscv_get_misa_ext_name(bit);
+        const char *desc = riscv_get_misa_ext_description(bit);
+
+        /* Check if KVM already created the property */
+        if (object_property_find(cpu_obj, name)) {
+            continue;
+        }
+
+        object_property_add(cpu_obj, name, "bool",
+                            cpu_get_misa_ext_cfg,
+                            cpu_set_misa_ext_cfg,
+                            NULL, (void *)misa_cfg);
+        object_property_set_description(cpu_obj, name, desc);
+        object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
+    }
+}
+
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-- 
2.41.0


