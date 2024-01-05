Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0B825D04
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:08:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtGc-0002Jx-7v; Fri, 05 Jan 2024 18:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGZ-0002Iu-HP
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:15 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGX-0002IY-Km
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:15 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bbc648bed4so88880b6e.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495971; x=1705100771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixKzdWlCm9Idlq+N5I8yFs7o3tkaQEUDfC9gkqTG2g4=;
 b=Kfl02X/w0uZT2bbzp+3kva8doDbvVZZgtP3tT/o/ib5UpP2QBNJcEUDShm0lVlTjSR
 xlSldTEal7LQ6oAmpcMXZV44argEbqWKL0K1vRTpMznMnE9yTWX3W4glv4o1zDFH9q+/
 nykSC7F7cwHIl8f7RAsXJ+wUtAjrQ688dxi7fdeRNgLLhvujsp189GZE5iWkpj5rnlpm
 Cziyo8PNj4ExTGTPid1UZt9UuguJbToMhcglEMh1rfRmdZY5fZugzRbXL/LpShGaSC12
 aTNvEeCQ9tcLIvjfmRonFs6cxyGb7RpIiLJrrcCn4R2+mEaeW19excysqMl/EF/TPg8Z
 j05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495971; x=1705100771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixKzdWlCm9Idlq+N5I8yFs7o3tkaQEUDfC9gkqTG2g4=;
 b=Y3u1SuLLWyXWMIimG2wnOP8V+S1hU07dhiUPJQmbU0+dsnaz2cRgQqQfCiuaCrCdhy
 hppDYjNjZwEsCag+rnmgu3aOxPgXyBBK4TX1DCfO+R7xtm5o2lQ7OGXRBOj9XJlSi6u3
 L37o6FErXrfxB1hdeWmp7BMVXvvIvD1QQlpRBIQybOZ/DHmjUpYKdAuDuhSk1BSY7qdu
 UWLZoEcdAwrUs5K7sK5stG8xJRRtd+urR3+ZswYcAmpt4FrJl/7rk4IhIuOP1Wg3LbEI
 Nc3Htg+Wn5pRDFiIunmmYld+kGHCcnaea6uCh8DVN0ZQcTr/4eZUS4wbjF63gStgQw5S
 GT8w==
X-Gm-Message-State: AOJu0Yw/vvWpVdAYFJIuTEG11goQuyK44+aKD6Q3XxIEN5lq2C6oc4i8
 6oVgmsWANQp0lhf8De91tAa9qQ4JwPlO3KaqS3liYG3o13di3w==
X-Google-Smtp-Source: AGHT+IEMYRErK09CcBZjf/x9dPIEOzbMjgXPgm2cnzhygaDoRccuNzzpgdo5S1h2HkyeS0dCv8k8bA==
X-Received: by 2002:a05:6358:5483:b0:174:d9c0:91a2 with SMTP id
 v3-20020a056358548300b00174d9c091a2mr157577rwe.56.1704495971438; 
 Fri, 05 Jan 2024 15:06:11 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:11 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 06/17] target/riscv: rework 'priv_spec'
Date: Fri,  5 Jan 2024 20:05:35 -0300
Message-ID: <20240105230546.265053-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22e.google.com
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

'priv_spec' and 'vext_spec' are two string options used as a fancy way
of setting integers in the CPU state (cpu->env.priv_ver and
cpu->env.vext_ver). It requires us to deal with string parsing and to
store them in cpu_cfg.

We must support these string options, but we don't need to store them.
We have a precedence for this kind of arrangement in target/ppc/compat.c,
ppc_compat_prop_get|set, getters and setters used for the
'max-cpu-compat' class property of the pseries ppc64 machine. We'll do
the same with both 'priv_spec' and 'vext_spec'.

For 'priv_spec', the validation from riscv_cpu_validate_priv_spec() will
be done by the prop_priv_spec_set() setter, while also preventing it to
be changed for vendor CPUs. Add two helpers that converts env->priv_ver
back and forth to its string representation. These helpers allow us to
get a string and set 'env->priv_ver' and return a string giving the
current env->priv_ver value. In other words, make the cpu->cfg.priv_spec
string obsolete.

Last but not the least, move the reworked 'priv_spec' option to
riscv_cpu_properties[].

After all said and done, we don't need to store the 'priv_spec' string in
the CPU state, and we're now protecting vendor CPUs from priv_ver
changes:

$ ./build/qemu-system-riscv64 -M virt -cpu sifive-e51,priv_spec="v1.12.0"
qemu-system-riscv64: can't apply global sifive-e51-riscv-cpu.priv_spec=v1.12.0:
    CPU 'sifive-e51' does not allow changing the value of 'priv_spec'
Current 'priv_spec' val: v1.10.0
$

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 73 +++++++++++++++++++++++++++++++++++++-
 target/riscv/cpu.h         |  3 ++
 target/riscv/cpu_cfg.h     |  1 -
 target/riscv/tcg/tcg-cpu.c | 29 ---------------
 4 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index df8e0b43f7..f3316c5082 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1675,8 +1675,77 @@ static const PropertyInfo prop_pmp = {
     .set = prop_pmp_set,
 };
 
+static int priv_spec_from_str(const char *priv_spec_str)
+{
+    int priv_version = -1;
+
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+        priv_version = PRIV_VERSION_1_12_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
+        priv_version = PRIV_VERSION_1_11_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_10_0_STR)) {
+        priv_version = PRIV_VERSION_1_10_0;
+    }
+
+    return priv_version;
+}
+
+static const char *priv_spec_to_str(int priv_version)
+{
+    switch (priv_version) {
+    case PRIV_VERSION_1_10_0:
+        return PRIV_VER_1_10_0_STR;
+    case PRIV_VERSION_1_11_0:
+        return PRIV_VER_1_11_0_STR;
+    case PRIV_VERSION_1_12_0:
+        return PRIV_VER_1_12_0_STR;
+    default:
+        return NULL;
+    }
+}
+
+static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    g_autofree char *value = NULL;
+    int priv_version = -1;
+
+    visit_type_str(v, name, &value, errp);
+
+    priv_version = priv_spec_from_str(value);
+    if (priv_version < 0) {
+        error_setg(errp, "Unsupported privilege spec version '%s'", value);
+        return;
+    }
+
+    if (priv_version != cpu->env.priv_ver && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %s\n", name,
+                          object_property_get_str(obj, name, NULL));
+        return;
+    }
+
+    cpu_option_add_user_setting(name, priv_version);
+    cpu->env.priv_ver = priv_version;
+}
+
+static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    const char *value = priv_spec_to_str(cpu->env.priv_ver);
+
+    visit_type_str(v, name, (char **)&value, errp);
+}
+
+static const PropertyInfo prop_priv_spec = {
+    .name = "priv_spec",
+    .get = prop_priv_spec_get,
+    .set = prop_priv_spec_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
 
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
@@ -1765,6 +1834,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
 
+    {.name = "priv_spec", .info = &prop_priv_spec},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1ece80a604..ee65ed555a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -93,6 +93,9 @@ typedef struct riscv_cpu_profile {
 extern RISCVCPUProfile *riscv_profiles[];
 
 /* Privileged specification version */
+#define PRIV_VER_1_10_0_STR "v1.10.0"
+#define PRIV_VER_1_11_0_STR "v1.11.0"
+#define PRIV_VER_1_12_0_STR "v1.12.0"
 enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 0612668144..68965743b6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,7 +139,6 @@ struct RISCVCPUConfig {
     bool ext_XVentanaCondOps;
 
     uint32_t pmu_mask;
-    char *priv_spec;
     char *vext_spec;
     uint16_t vlen;
     uint16_t elen;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2c2ce51b19..a24c5e7e58 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -295,29 +295,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
-{
-    CPURISCVState *env = &cpu->env;
-    int priv_version = -1;
-
-    if (cpu->cfg.priv_spec) {
-        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
-            priv_version = PRIV_VERSION_1_12_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
-            priv_version = PRIV_VERSION_1_11_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
-            priv_version = PRIV_VERSION_1_10_0;
-        } else {
-            error_setg(errp,
-                       "Unsupported privilege spec version '%s'",
-                       cpu->cfg.priv_spec);
-            return;
-        }
-
-        env->priv_ver = priv_version;
-    }
-}
-
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
@@ -876,12 +853,6 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
-    riscv_cpu_validate_priv_spec(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.43.0


