Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E33728295E5
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:10:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURv-0007Pi-Gt; Wed, 10 Jan 2024 04:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURi-00061L-32
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:23 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNURf-0004s1-MH
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:00:21 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbc648bed4so3690805b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877218; x=1705482018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Axs0H56Btt4TxmenWBzfcgI1G5BHWnRaIUY418ZTC6I=;
 b=iUD5bTTvNrjm8JrvHSqE86rxH5hmxqZlGz7fBA+74oC28XlKxjRuE+leJA50PPXVg6
 GhFLpdIAZL3h/nGFpRU+us7wcJkUPULKY1f0M1yc/EXd3g7Mb+srz2G2USuihc8OpNwF
 WTgkRKsHw+dwoPpuru9sIeDfjBlgsUtHHBt0y6nbYmmOTAF1S0TeLlUm0uVMHb0nVjV3
 0t1qm+j2MGDvuj7XSMXaEJDmeLzCft3n88kpyFBaC32VVrkccIgW91iJO3H0kw3Lol9C
 RQ+1Bv6sq6zDoBibTAXvN6fa4IWrtyU9SeW8ASyaE6nZ/yAPWA+1vrUfI6E/HIavKwMv
 AD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877218; x=1705482018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Axs0H56Btt4TxmenWBzfcgI1G5BHWnRaIUY418ZTC6I=;
 b=ehvkwYFodEkLabqhmol8sGFzbQZGISN3w2nG5DOBeDCltvDlD/6AK6YoLZLsufv+2/
 YfxcastIbtq0npS87ngWG7+C7Ga6lbPbhqFqaB0AtcTRtdsUszfaTSh1VwRCwGZ2YoEE
 W6xG6twNAHuuvUBeusgg2uDAs2uDLlFc2WDy2vHAoapCQ5k5UifXesg9oELrIoBbuo49
 GdXV4PgGCuhm/hu4stnYdnY8Vek+6wt9rtm3GLNWTMK+U/hJ3fGRVmP/GCoU9dz/VSug
 RoNEwT7YXbPfiqe4wKm8UYoMx7N4/kK+O0KdHjcremRbLnLkkufoqseVCWhqvSRwTPqz
 /FQg==
X-Gm-Message-State: AOJu0Yw9YxAE7i98IpdT0EpY5tBVFSAD0Ecv70otupRu1Qq97Ja9rBry
 BhE4VXEjV6M06vgJZuRA6GjvUHiEZQAqzy+t
X-Google-Smtp-Source: AGHT+IHpXyjUTRpc15z3IrV0Pz0ygiKYMKNG6Eg2r2k3qZjfzJ+SoLIa4WiYFyFVgpZkgV7ydfb5SA==
X-Received: by 2002:a05:6808:13c4:b0:3bd:4416:42f9 with SMTP id
 d4-20020a05680813c400b003bd441642f9mr826637oiw.82.1704877218398; 
 Wed, 10 Jan 2024 01:00:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:00:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 40/65] target/riscv/tcg: add riscv_cpu_write_misa_bit()
Date: Wed, 10 Jan 2024 18:57:08 +1000
Message-ID: <20240110085733.1607526-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We have two instances of the setting/clearing a MISA bit from
env->misa_ext and env->misa_ext_mask pattern. And the next patch will
end up adding one more.

Create a helper to avoid code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231218125334.37184-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 731ec2279e..dd8f49b2a6 100644
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
@@ -833,13 +847,9 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
              */
             env->priv_ver = PRIV_VERSION_1_12_0;
         }
-
-        env->misa_ext |= misa_bit;
-        env->misa_ext_mask |= misa_bit;
-    } else {
-        env->misa_ext &= ~misa_bit;
-        env->misa_ext_mask &= ~misa_bit;
     }
+
+    riscv_cpu_write_misa_bit(cpu, misa_bit, value);
 }
 
 static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
@@ -883,7 +893,6 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
-    CPURISCVState *env = &RISCV_CPU(cpu_obj)->env;
     bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
@@ -904,13 +913,8 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
2.43.0


