Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A257D6DAB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHN-0001XD-Oa; Wed, 25 Oct 2023 09:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHB-0001OJ-2Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveH9-0002xj-94
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca816f868fso38775365ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241821; x=1698846621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TO1H8gJ6ZohB9qQmCb+Bwz50ozsTKnVTDuHe1doEDk=;
 b=fhB6qDHoxBXBXi9xxhAU54zhIBDSst4hCGLZNDetXIDM6YOWAo/gbUXUgd/xT0vL8x
 93zbMndPWMSUedk8QNp0TmumzqXwZg00euUsTG120PYiwkFaTErz8d7ldr/Ipr/cgOrH
 GvECLiDHtMdB6W/2Qv6mlcztQtqFz0pYhmZQ86BtDqS8+9O2cIhu8z9QlaX4xlWb+ZZF
 MNwuSTaKK5ypxUOm8KVC1Hny5Kr+FCOd93l7UqoblaUyEFlKABeE+7yIARhCzpCzDWt4
 hicjxt9MXcKiErUehYVUnzeWbbIn2Uvn31A8JOVHN4y/FzzSAgbidIO5r7KuoCmGtWG6
 TmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241821; x=1698846621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TO1H8gJ6ZohB9qQmCb+Bwz50ozsTKnVTDuHe1doEDk=;
 b=gF5a5JtmeldTa8EoBDdZeF9l4vyJducI9J8f+3c4ZGQ0y6a8/15pjTdzFuVy98KtWQ
 XIcJ9Y+gREfyyMi6y7Zot7uP/RwHt5+cMI3Y7/E0Hy8aEgG2VRyhXgZ2aCHnYbQgLC6n
 hcF6oUXRgL8LJoxvNVMCvbXsf3nUPUsfy0ZNQOzWvEMdUPfVNvOeBJuFEOL0JeLMqWQV
 Ihr0wjMNp4k69hd0uCh/i9d9rabpcfqCGNaSLpzaV1XjBqO2b2xzPq0EfJS349uqQIPh
 u31AOeqxfMwC77dQfmseuL3FLaDpJxsg6oRCgX+Z/OSUNBMUwZB8qBy1rJ0sxb3cwZ43
 hD3w==
X-Gm-Message-State: AOJu0Yz/A3gdlJrBEhSbkjCm1gqR5WG+r/K9K+aBcngUg/dfzzzVB4ue
 v+2TQvLqIeUPFh0miDyLvv9xnoLeR3KP2lG5Ukc=
X-Google-Smtp-Source: AGHT+IGjdTPhN9uuDJvGqj+HnwwTyC1HPEGNW83iSmSmlQMw/X6sONKLmZNheKAcxV3H4fYThZ1Dvw==
X-Received: by 2002:a17:902:e887:b0:1c6:3222:c67c with SMTP id
 w7-20020a170902e88700b001c63222c67cmr15848546plg.23.1698241821533; 
 Wed, 25 Oct 2023 06:50:21 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 4/9] target/riscv/tcg: add MISA user options hash
Date: Wed, 25 Oct 2023 10:49:56 -0300
Message-ID: <20231025135001.531224-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025135001.531224-1-dbarboza@ventanamicro.com>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
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
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 572ae9c902..f3fc318704 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -34,6 +34,7 @@
 
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
+static GHashTable *misa_ext_user_opts;
 
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
@@ -681,6 +682,10 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    g_hash_table_insert(misa_ext_user_opts,
+                        GUINT_TO_POINTER(misa_bit),
+                        (gpointer)value);
+
     prev_val = env->misa_ext & misa_bit;
 
     if (value == prev_val) {
@@ -744,6 +749,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
+    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -764,7 +770,13 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
@@ -995,6 +1007,7 @@ static void tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
-- 
2.41.0


