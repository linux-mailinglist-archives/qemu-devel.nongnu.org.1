Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E17D1941
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 00:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtyAH-0003zX-Tm; Fri, 20 Oct 2023 18:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyAF-0003yv-6f
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:19 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyA9-0007in-0e
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso18548645ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697841611; x=1698446411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sy4kLpVJRuW/SgpzplTJbAsp6e9iAb3C3a2/ZEAAxKs=;
 b=ED/Xe3uMU3SQyUFgCeQ1xXQj3mNZhAZlVFFQgnj3KVh3z6bTYHKJHPEbZbArVg/VJh
 bwdCB9I15B5+oXAlUX0XxNQPckbwIF//9lMhC4Be1Xa3B3XU+2KJmHMz5XVqAKNWiLps
 SGC5nLRfkOjZMRQFLIBPgaUJJbnTauBHeTMmVYWtrzRmtIYcEDAu03FobzjP6NFzfBJ+
 hQUFlokW/ofg8Auu8hSl1AnJrOg2INEVkFeXDgW/3oNugepTNkt9LHbfkxzntazgQt42
 odtg+fuWkozGFvlgQYRJTYOasyrfaUKsP4xuhTj1NuiKGLpxjx+1nFcef4qrYYt0siui
 +fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697841611; x=1698446411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sy4kLpVJRuW/SgpzplTJbAsp6e9iAb3C3a2/ZEAAxKs=;
 b=cASv1F/UwbcX4PebMINTTq+dwvPm5RliK9PxnauZWGBxBjS/oH8rd8yfolJLhoS2jx
 Op4WX8sMiDSUhRtOyGj3CgWyo+EM7rDFsYJIXmB2GtU69sONLhFJycj+cwunL5yGr+Ku
 4NzaWHltzW88DsEIyWOalAEtGcGKipyqWL8BuLRncwCP4O8ziiQp1LoxJzaYgeehOrcd
 w4xBepo3p6kGNWiAkhbTI8HeG7+2bY3i29iErLTdpzfFj/j5ri+mVUycqTOM0kzovmNR
 kZdzKdmZN32o3Fb50HDWgHSodqFTBLyTYmNQSsrM6nvGWvJ19J+DnHOvpOQqMGvff3fO
 9apA==
X-Gm-Message-State: AOJu0Ywn0+Xz3LwGNyRKL4ks/LHFI/pFVEMExJ6cIY/IIDbVqI+W0vdW
 ANjl07CqwjenRkgUfeMroxuWRj2SmJyYYN772tI=
X-Google-Smtp-Source: AGHT+IHqYB0tBIePJQPzG4s6N6BRd06BiDk9m8bVuUeDERQfRjwUpPugg3XQGZXoP0Am3LntwFXdCA==
X-Received: by 2002:a17:902:ce88:b0:1bc:1e17:6d70 with SMTP id
 f8-20020a170902ce8800b001bc1e176d70mr4573127plg.24.1697841611363; 
 Fri, 20 Oct 2023 15:40:11 -0700 (PDT)
Received: from grind.. ([177.45.186.249]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170902704100b001c61921d4d2sm1992373plt.302.2023.10.20.15.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 15:40:10 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 4/6] target/riscv/tcg: add MISA user options hash
Date: Fri, 20 Oct 2023 19:39:49 -0300
Message-ID: <20231020223951.357513-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020223951.357513-1-dbarboza@ventanamicro.com>
References: <20231020223951.357513-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3dd4783191..59b75a14ac 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -34,6 +34,7 @@
 
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
+static GHashTable *misa_ext_user_opts;
 
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
@@ -669,6 +670,10 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    g_hash_table_insert(misa_ext_user_opts,
+                        GUINT_TO_POINTER(misa_bit),
+                        (gpointer)value);
+
     prev_val = env->misa_ext & misa_bit;
 
     if (value == prev_val) {
@@ -732,6 +737,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
+    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -752,7 +758,13 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
@@ -989,6 +1001,7 @@ static void tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
-- 
2.41.0


