Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC77D6DB3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHZ-0001o8-Rz; Wed, 25 Oct 2023 09:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHE-0001Qi-El
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHC-0002zE-8c
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso41231485ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241824; x=1698846624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waCZsK0sspsHGxnpaGd6gIqrENxMiNl1xxH2aoo3R58=;
 b=WRWynaRTu1VGt8553NPf58+9bf2wk0Dqyt321sq3Uw6+jQNNrKEnS90r1NqRRCekFt
 mi3aWGL94P25G+2m1sdYkAkfV4p0N0H90JbYUH0HNI58PoRRTVF4PCPzbGeIOe/ArRWY
 lCGSjpiqxs2pRZ8aAJMRJLyF9nYXYGQfFwZFs5dolCj6UOJphQN9QlSyM7l3UAH6/IkR
 qtVux9x9zlXvH3s5wGGgM/1rLJSSFgybjsyNYRmhZ0OenzfwTguZT9ieF7d7WI7TFf9Q
 v3Ad4vdmR9oO5+Tb3y3/iAU6DKrK5uoGmixjbzX3OjaUl1z+T9jWpAaWfyd8Lu81GDXU
 w9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241824; x=1698846624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=waCZsK0sspsHGxnpaGd6gIqrENxMiNl1xxH2aoo3R58=;
 b=Bn2fs+mx+ubdrm0MZswfWmXp/zEstLKXGl2NQ2MW5C4De7jv2LOnsaeYDi9mKwY7kV
 AGFVhzB+hKIiSagLJJ7GGZRIhIryu1+9j6jDSvch1i1DC9ZvPg2w/oS4vGfSOGE04l+z
 G7RrBPZDAmWPYkPN031DLBYnJ1w/0qxg33vZAYlpXeGXvgPYNA4w7YN9owNo2lmxh11Z
 cc8bJiStPAvtK4IFcA91gzr3mdFPaugt1fil/e5gQhXds5TKzdYdy8JqZkmG/UHDpWeo
 4o+8sW0WlWOwq+T2hOCrK6RxL9ukE6kxC3/rC1lVFFlZyxbb8FL0RWn/OHbQNK9K7oS4
 HDOg==
X-Gm-Message-State: AOJu0YweGVPKnYBaE9eIu/Dd/A8m9vqKa7tLHCvtKlBEDNf9a5AS6F2k
 Ln1sQlyH1DfvGx7P164RAjB9WbiqYbgzWaYAO90=
X-Google-Smtp-Source: AGHT+IHZEM43RYzbBtX15CrCm6kNZm0alQ+m3uX3wbihQd/sWI+jKEro4s/HixSV7F/ni1+fnB1yfw==
X-Received: by 2002:a17:903:2283:b0:1ca:1cf3:e72e with SMTP id
 b3-20020a170903228300b001ca1cf3e72emr13891393plh.45.1698241824442; 
 Wed, 25 Oct 2023 06:50:24 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 5/9] target/riscv/tcg: add riscv_cpu_write_misa_bit()
Date: Wed, 25 Oct 2023 10:49:57 -0300
Message-ID: <20231025135001.531224-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025135001.531224-1-dbarboza@ventanamicro.com>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

We have two instances of the setting/clearing a MISA bit from
env->misa_ext and env->misa_ext_mask pattern. And the next patch will
end up adding one more.

Create a helper to avoid code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/tcg/tcg-cpu.c | 44 ++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3fc318704..b2489a5317 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,20 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
+                                     bool enabled)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (enabled) {
+        env->misa_ext |= bit;
+        env->misa_ext_mask |= bit;
+    } else {
+        env->misa_ext &= ~bit;
+        env->misa_ext_mask &= ~bit;
+    }
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -692,20 +706,14 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value) {
-        if (!generic_cpu) {
-            g_autofree char *cpuname = riscv_cpu_get_name(cpu);
-            error_setg(errp, "'%s' CPU does not allow enabling extensions",
-                       cpuname);
-            return;
-        }
-
-        env->misa_ext |= misa_bit;
-        env->misa_ext_mask |= misa_bit;
-    } else {
-        env->misa_ext &= ~misa_bit;
-        env->misa_ext_mask &= ~misa_bit;
+    if (value && !generic_cpu) {
+        g_autofree char *cpuname = riscv_cpu_get_name(cpu);
+        error_setg(errp, "'%s' CPU does not allow enabling extensions",
+                   cpuname);
+        return;
     }
+
+    riscv_cpu_write_misa_bit(cpu, misa_bit, value);
 }
 
 static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
@@ -749,7 +757,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
-    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -770,13 +777,8 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
                             NULL, (void *)misa_cfg);
         object_property_set_description(cpu_obj, name, desc);
         if (use_def_vals) {
-            if (misa_cfg->enabled) {
-                env->misa_ext |= bit;
-                env->misa_ext_mask |= bit;
-            } else {
-                env->misa_ext &= ~bit;
-                env->misa_ext_mask &= ~bit;
-            }
+            riscv_cpu_write_misa_bit(RISCV_CPU(cpu_obj), bit,
+                                     misa_cfg->enabled);
         }
     }
 }
-- 
2.41.0


