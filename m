Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1617A8E98
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:39:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4tV-000517-Gh; Wed, 20 Sep 2023 17:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4tT-0004zF-Pr
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:37:59 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qj4tR-0006VH-V5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:37:59 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6c21b2c6868so208625a34.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695245876; x=1695850676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cv6lw/UDU2mmgm0nArWAGoChrZBEcccRRUUgz2CCcZg=;
 b=lnhfZgVKUqAQZqDFjs9vPNRfHGPQY75g5IF2dGATAvVt15adCVpvbCjrF9diPPWffF
 okGCzTFBgaTLLqge5fn9bqkd9reOvejK1iTorn+Z1PzmDJaSrdv2n6F2HhfAHCPlOGod
 UPrKtkpCxscgH5N/rUX7EeiYZJwDtvlxpB6SkqlGTa465Pfb6sddFzt8Zx04girOzBw0
 XB4ysJ6+PtZLdG4k7uUx9lAZnaciD2mKY/iTXEvovqmxjMYwEXMGtjq7OxasBSR/x0C5
 0N1MvvVzMnJiML5wwNJ9qOQqMWFps3U3Y6h5KWiDlEq3Mk7wdAfFTEiWQ67KpVrpasP1
 mCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695245876; x=1695850676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cv6lw/UDU2mmgm0nArWAGoChrZBEcccRRUUgz2CCcZg=;
 b=C35C5/rmVaZ88slZZIqcg8Vg1lR8XFWMhjzunNfNhc93cCMwx8ca4I3LOKmWXtJy8s
 hfSFWDjHr0z8s0NjTK1ukdURlhB1EqGqpkGx7eTzLl6ItoHZ9QcztL+Tub0hzmCCLIrU
 GEH/sb2iiEiU08e1S2V/FMo4AseRsf3Z8jd0yGeRUOV5eIEDqqxDowIFBLURpyhqgsgM
 OxYmRbNbFUXNnmmM50d5o/4hDyaqxujjdf/vOHMROwmVN1dtm1XDJleciM53nFAKcNHE
 SB+5AT99FEtxgILdwpgtCUOH3rlEAvz4IEA4+0s2dQU2+sZUOd8ooO4Y2wnW7IeCDDpQ
 0O0w==
X-Gm-Message-State: AOJu0Yybd9/6kmi8Yumrj5JkS3s6Z66/laE/TSpkW48DVsSDi8V/S1a4
 5/X55W/Hz/5vHYhmi8TpfeLAdnouray9lXFg5wo=
X-Google-Smtp-Source: AGHT+IGH1U2Cl3nF73fVy93IXIruHU5PN1D7cKqZPa9DPdoMSGfrKsFskZ5J4NzYNkjElOecH2P/xw==
X-Received: by 2002:a05:6830:128d:b0:6b9:c49f:1af7 with SMTP id
 z13-20020a056830128d00b006b9c49f1af7mr3930933otp.20.1695245876254; 
 Wed, 20 Sep 2023 14:37:56 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 e1-20020a9d7301000000b006b83a36c08bsm64415otk.53.2023.09.20.14.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:37:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/8] target/riscv/tcg-cpu.c: add extension properties for all
 cpus
Date: Wed, 20 Sep 2023 18:37:37 -0300
Message-ID: <20230920213743.716265-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920213743.716265-1-dbarboza@ventanamicro.com>
References: <20230920213743.716265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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

At this moment we do not expose extension properties for vendor CPUs
because that would allow users to change them via command line. But that
comes at a cost: if we were to add an API that shows all CPU properties,
e.g. qmp-query-cpu-model-expansion, we won't be able to show the extension
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
---
 target/riscv/tcg/tcg-cpu.c | 64 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f31aa9bcc4..a90ee63b06 100644
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


