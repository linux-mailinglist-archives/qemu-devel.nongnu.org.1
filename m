Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A029D7C63F9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn53-0007QF-9I; Thu, 12 Oct 2023 00:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4s-00075o-5I
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4q-0002ma-8R
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c5c91bec75so4405095ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084014; x=1697688814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIcfnYj0BwsMk8n33R0diJT2K2a9CUNvY/olegakgJw=;
 b=UKTHVwRHzxcYA9NEe8Q32VABvfJ+tku6cJp/0fWBKRl6ECcfL8CmwAUT3C76jzfjHn
 /PA0PqbFGxGj0qTZcYcrQoZD8upUyLiQcPWKSshCfo61yHQsQtNySYUpbIly/UXSXS9U
 G6vMcc8c+1kV7CJOh3WuwJgyldSBOu+N6ubpk6M3/TE/VWOHSgEP/kq79bTtzWF0jESN
 sqoV+TGw7i87n5JIyE6HvcTk4axrL9q/iG+iW/yGpZIOWi3iHAqmvF0x1B6Laa39BILT
 TcgU1nWUWvhyOrVHQEh81ZI9By23nC3kpWO/4NSM4l3Zwo3QiC4ONl3PBesQDWs9eKcv
 HCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084014; x=1697688814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIcfnYj0BwsMk8n33R0diJT2K2a9CUNvY/olegakgJw=;
 b=liUWSzqo3ukSXx4a/yaoHrGnvAksNjMq3hlwJOsVMPb5A4ogWAN6c32SK7NBrRHAhF
 Oj6Y65oxtK6xQ3Fs3bisHgP870z0gBhAMRmcBMXkm4n/NGoJ2lYq/OI8CcjRKVpWNKWv
 Hn1JfunENzZkybeDpuae9xNRso0SyiRMGDRI+LQUfmLv/TgDDdNQaYxJ2mSMtKUpEeYL
 dVIo0m7RNVSL3KOuF82d0Y6Ior/ZwsXYhybV/J1HYJzsTtOOiYdBukN9K0yT3SnJ9avs
 NXz9UtZJCcEl5RlgMFuZPWFR7wqOjvwOIfQcy3UcUafTVhIj9un2heA1iA7GvERtA+yu
 OWqA==
X-Gm-Message-State: AOJu0YzqDsFWjBGv3ldY6Hvy+2zvROVPMi1hQ137e8a1VYeHpuXoxOQG
 +660seEHSTeVA9RGAnzGCX+UfRAuu//YSQ==
X-Google-Smtp-Source: AGHT+IFxtzmxpgBVQ2hsAxVqaQcw8WE9iy1F4u29TgXp2mgoKE1HY+0FtpXE/pZB+Gm1BwVgWDfA3A==
X-Received: by 2002:a17:902:6ac2:b0:1c9:c35f:9a25 with SMTP id
 i2-20020a1709026ac200b001c9c35f9a25mr4818605plt.34.1697084014111; 
 Wed, 11 Oct 2023 21:13:34 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:33 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/54] target/riscv/tcg-cpu.c: add extension properties for all
 cpus
Date: Thu, 12 Oct 2023 14:10:40 +1000
Message-ID: <20231012041051.2572507-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

At this moment we do not expose extension properties for vendor CPUs
because that would allow users to change them via command line. The
drawback is that if we were to add an API that shows all CPU properties,
e.g. qmp-query-cpu-model-expansion, we won't be able to show extensions
state of vendor CPUs.

We have the required machinery to create extension properties for vendor
CPUs while not allowing users to enable extensions. Disabling existing
extensions is allowed since it can be useful for debugging.

Change the set() callback cpu_set_multi_ext_cfg() to allow enabling
extensions only for generic CPUs. In cpu_add_multi_ext_prop() let's not
set the default values for the properties if we're not dealing with
generic CPUs, otherwise the values set in cpu_init() of vendor CPUs will
be overwritten. And finally, in tcg_cpu_instance_init(), add cpu user
properties for all CPUs.

For the veyron-v1 CPU, we're now able to disable existing extensions
like smstateen:

$ ./build/qemu-system-riscv64 --nographic -M virt \
    -cpu veyron-v1,smstateen=false

But setting extensions that the CPU didn't set during cpu_init(), like
V, is not allowed:

$ ./build/qemu-system-riscv64 --nographic -M virt \
    -cpu veyron-v1,v=true
qemu-system-riscv64: can't apply global veyron-v1-riscv-cpu.v=true:
  'veyron-v1' CPU does not allow enabling extensions

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230926183109.165878-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 64 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 104e91846a..2e462e7d11 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -549,6 +549,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
+static bool riscv_cpu_is_generic(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
+}
+
 /*
  * We'll get here via the following path:
  *
@@ -632,13 +637,27 @@ static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
     target_ulong misa_bit = misa_ext_cfg->misa_bit;
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    bool value;
+    bool generic_cpu = riscv_cpu_is_generic(obj);
+    bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
+    prev_val = env->misa_ext & misa_bit;
+
+    if (value == prev_val) {
+        return;
+    }
+
     if (value) {
+        if (!generic_cpu) {
+            g_autofree char *cpuname = riscv_cpu_get_name(cpu);
+            error_setg(errp, "'%s' CPU does not allow enabling extensions",
+                       cpuname);
+            return;
+        }
+
         env->misa_ext |= misa_bit;
         env->misa_ext_mask |= misa_bit;
     } else {
@@ -688,6 +707,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
+    bool use_def_vals = riscv_cpu_is_generic(cpu_obj);
     int i;
 
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
@@ -706,7 +726,9 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
                             cpu_set_misa_ext_cfg,
                             NULL, (void *)misa_cfg);
         object_property_set_description(cpu_obj, name, desc);
-        object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
+        if (use_def_vals) {
+            object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
+        }
     }
 }
 
@@ -714,17 +736,32 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
-    bool value;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool generic_cpu = riscv_cpu_is_generic(obj);
+    bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
-    isa_ext_update_enabled(RISCV_CPU(obj), multi_ext_cfg->offset, value);
-
     g_hash_table_insert(multi_ext_user_opts,
                         GUINT_TO_POINTER(multi_ext_cfg->offset),
                         (gpointer)value);
+
+    prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
+
+    if (value == prev_val) {
+        return;
+    }
+
+    if (value && !generic_cpu) {
+        g_autofree char *cpuname = riscv_cpu_get_name(cpu);
+        error_setg(errp, "'%s' CPU does not allow enabling extensions",
+                   cpuname);
+        return;
+    }
+
+    isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
 }
 
 static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
@@ -739,11 +776,17 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 static void cpu_add_multi_ext_prop(Object *cpu_obj,
                                    const RISCVCPUMultiExtConfig *multi_cfg)
 {
+    bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
+
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
                         NULL, (void *)multi_cfg);
 
+    if (!generic_cpu) {
+        return;
+    }
+
     /*
      * Set def val directly instead of using
      * object_property_set_bool() to save the set()
@@ -828,20 +871,13 @@ static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
 }
 
-static bool riscv_cpu_has_user_properties(Object *cpu_obj)
-{
-    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
-}
-
 static void tcg_cpu_instance_init(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
 
-    if (riscv_cpu_has_user_properties(obj)) {
-        multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-        riscv_cpu_add_user_properties(obj);
-    }
+    multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+    riscv_cpu_add_user_properties(obj);
 
     if (riscv_cpu_has_max_extensions(obj)) {
         riscv_init_max_cpu_extensions(obj);
-- 
2.41.0


