Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52627D78DC
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnZN-00012x-I8; Wed, 25 Oct 2023 19:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvnZ6-0000wE-3W
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:45:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qvnZ4-0002Ih-B9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:45:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso1893795ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698277528; x=1698882328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81c4qw8D2sG0oJuCNbKNZJeJgmw9CLPFrKsbnhzd0Jk=;
 b=ogaZt6QTDmmuAWdD6pGDOrnmiH9hrVMFHg8AFJPJmw4YnMOt6NoqswPUOmR/EL42z2
 7qF9HbHsydEzLpVQTOggq3k1U0dT8Oh96pbVVzMzOL/7YkW63mHkT92lRvjt+6pltF0+
 1cEb0VRdgN++4dRESjF5QhE16KDyXZKJeZ0u8J8qjW7fbwI1H73yLxOESk/6iV/qoorj
 s4j2MAsFbfabi9KGxSvs9yey0sNYtoZTCeBM4u16StXD/OLhRY8glBL9EII/fni+hQ9h
 tJyVJ42GLgiJupnRmaZJfk1pnWx/0HTtjazkBM6lZPvFu5oRh8PPH/iSuMW2ntiaaWnb
 RuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698277528; x=1698882328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81c4qw8D2sG0oJuCNbKNZJeJgmw9CLPFrKsbnhzd0Jk=;
 b=oTdcIsQzavQdVbNnMgvggmJ3p/yCUeCO+f3ZZzhMXWjT4VbRp6Ivp6nLW8N6FoRYNR
 NC0HjOtyiNR01IaluLCu3Er/2TfmOGdzejehykdBhAAZlD1l+rj7jAuXPt7dVjoBwXsL
 l2GO/h8A1hgjxxkVLIFfRAsxFEw86Xd48Hf/LHw40mnN/2f89f35BdJ3i3KNv0mCnx+z
 XqhD8B500KBYbInwtYBb5mrKp2KgKtCYn/u5ryGa+GmcMIVyyNnAkfAg04sq1bePfN4m
 CGX6KQe76Jgf6xfuKnDurcOcFkySR37Jot5kpFtrX9VFOJ/4EGm1JAq3Ebm5VHUTQhsQ
 ZcLA==
X-Gm-Message-State: AOJu0Yw9qPNEd50iMLmT6F3clI8cWOyW5XbffSuztslt9AjLNyeYOwg/
 ipggead7Vl6LawIA19UCtr4X2iibLsE977GDMJo=
X-Google-Smtp-Source: AGHT+IGv7xDuqbe25p/l7zmcdPk0FE3nJ6k5daNUHnKmA3H3rdzzH41uMVokYTavvkWXsQ5AV3AmaA==
X-Received: by 2002:a17:902:d502:b0:1c4:4dbc:92bc with SMTP id
 b2-20020a170902d50200b001c44dbc92bcmr15525977plg.16.1698277528354; 
 Wed, 25 Oct 2023 16:45:28 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 w14-20020a170902e88e00b001c736746d33sm9738654plg.217.2023.10.25.16.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:45:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 06/10] target/riscv/tcg: add riscv_cpu_write_misa_bit()
Date: Wed, 25 Oct 2023 20:44:55 -0300
Message-ID: <20231025234459.581697-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025234459.581697-1-dbarboza@ventanamicro.com>
References: <20231025234459.581697-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We have two instances of the setting/clearing a MISA bit from
env->misa_ext and env->misa_ext_mask pattern. And the next patch will
end up adding one more.

Create a helper to avoid code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 44 ++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9a0d85d6e6..5d96ccb45c 100644
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
@@ -717,20 +731,14 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
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
@@ -774,7 +782,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
-    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -795,13 +802,8 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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


