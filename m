Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5B7DD738
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:42:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvWo-0005LY-C3; Tue, 31 Oct 2023 16:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWn-0005Kn-D7
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:39:57 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWk-0007Xu-Ka
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:39:57 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7afd45199so61543467b3.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698784793; x=1699389593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WNGUEi7DdjNsGvcaweyFFL2laQnnHF6y+myc6DAZlE=;
 b=bHhWbqIhly32fGqDoq+jl9SApVGEhVaude95upojpAESBhcPwWk7IvPP3+xcMGXIY9
 2Qm678zCkcLYgvFA4d++1jXDaVpur8ExUHTJnJZsj24+/ZhW+WJxbh7NbhPV3I+2Zs4c
 tfPM6H4wfBJ/ERjRLVq5wKjnVmv93s/psJSZm2D6u+C/9Y6ckx7ozJzDn8wS+tUFjZra
 gvwoN9TFkndoIp2g76BxzKI1yWGlkxwbLwt2Wl2fOQhY92revQgS8VMeVzzTqesMgXP8
 PSQNL1hGS4feuW+9rwV+orEeHVyTlI57IWjJOSyg/0MJgiYZjeO806lBlnEh7y8QRHLx
 kWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698784793; x=1699389593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WNGUEi7DdjNsGvcaweyFFL2laQnnHF6y+myc6DAZlE=;
 b=DEXVz/klMAnl5ojBTN6W7tJkx4JR3IoZ/86/nbbHhcElcLjKrWai4eZjPx5d7KqA6O
 tZ7jMid7GP8QRoyUtoneCXd0L2j904L8fzc2B7/Zd/xRdMijfbG7MrErU57Q/B1xIYwd
 LcUx6WTyOSYGFgJHJ6zu7Pl5n8wrBNZQwbzrgG3VG0ZqefqV4neSMXbxyyxQEmnq5XaD
 iDMmqZAF7AVJJGQ4gOzACJADe8Hjn4GgaWquA60NzaLvykXZbuQ+Yxx1aQc1RyrOm3gj
 ikVNn6rUL28UvRf9dL1ftmHji9VELFMSVMo++8ASHlpeKLnBX1SJFeTvd/3toC5eNYkb
 Y2+w==
X-Gm-Message-State: AOJu0YyPqG5lfsRMQKPwHblsBFm4RMt3Y8nzhllyNzY0MuinOxBue3bC
 Kk0SjsycoEnj9nAe5mfqr6+SW8Sw9jo9/2EsM94=
X-Google-Smtp-Source: AGHT+IG/dGbSJpirKqop+6SACZEu8ZSNEWKQjsaxqlKpfDDoqjHnalFXOnPu0bEbVwGQq5nR2kn8+A==
X-Received: by 2002:a81:ac21:0:b0:5a5:65e:b847 with SMTP id
 k33-20020a81ac21000000b005a5065eb847mr13129196ywh.34.1698784792923; 
 Tue, 31 Oct 2023 13:39:52 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 k1-20020a81ff01000000b005add997ae53sm1272802ywn.81.2023.10.31.13.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:39:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 10/16] target/riscv/tcg: add MISA user options hash
Date: Tue, 31 Oct 2023 17:39:10 -0300
Message-ID: <20231031203916.197332-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031203916.197332-1-dbarboza@ventanamicro.com>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112b.google.com
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
index 3e31a41859..70cd07efd7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -34,6 +34,7 @@
 
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
+static GHashTable *misa_ext_user_opts;
 
 static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
@@ -700,6 +701,10 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    g_hash_table_insert(misa_ext_user_opts,
+                        GUINT_TO_POINTER(misa_bit),
+                        (gpointer)value);
+
     prev_val = env->misa_ext & misa_bit;
 
     if (value == prev_val) {
@@ -763,6 +768,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
+    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -783,7 +789,13 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
@@ -1020,6 +1032,7 @@ static void tcg_cpu_instance_init(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
+    misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     riscv_cpu_add_user_properties(obj);
 
-- 
2.41.0


