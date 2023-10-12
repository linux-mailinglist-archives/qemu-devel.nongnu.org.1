Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B97C6403
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn5Q-0000ol-Rz; Thu, 12 Oct 2023 00:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5O-0000oL-CN
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5M-0002th-Ha
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c8a1541232so5102595ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084047; x=1697688847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYHov5PJBHPQVgLpbJE2BN7JR91mlxyydclLaOCmUkM=;
 b=brwZrPLMaY/LzCtHRQ7SsSOvOy3nbkNoeT4V7+MWyjLyF3fd1Cn0LM7eWKHC9fRq3K
 DWp5tTlHPnmJzbL9RuE+4QyChqHteptmSVzIghyy8Mylw7CHsAeRHjA3TE7kYNHK55wW
 VKmFx1d9DGAOC4vjhkYTLuz4YF1xnethUGg7qsfsyGydGH0X4mGTmNLnJhn6U3AGxLtr
 gqW958K+nz32q6PD/0kA/30oqKqV/2U2x6AYJQOKmosSDBLQvmvfJLRuZWUuAX09gvwz
 jyXX8MZf8msIOMgNaZJuuwkWmqPI8+/yYEst8uFi/rpt4gRKB8n49lResPAsaMgtDAnk
 Z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084047; x=1697688847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYHov5PJBHPQVgLpbJE2BN7JR91mlxyydclLaOCmUkM=;
 b=YlnlQpKnWoquxUKMsxT6t2xmc94ni5fOytcoztNVePOJ3GRjJfR0hB4+YU455S55Cc
 x3ULYuGEw0X7Pu2aMGDgTP2o5YZTKRAOAcB7sd6Rff6OBlSAXWcgmCHsy+pgPMQ0B1Di
 Zcw2qD4ZX8tc8GOf2hm0LUVsTLy6kN9uf9RrwEAxfSZqEhM8nvLv0wnTTaBVv5kN92ee
 YQKyr5p2LZ+7pE59GQmSrw3P4HQApQw7WBjzs5GtMriGHfK5MJdGTtN5v/km1713zwHq
 ZGxWF47tQssHKvBQralDxVuU8PMTMcYWUi7xf0aUTvv+Cvq+FIMAV6kVYG4yoJp7GUGe
 hZbw==
X-Gm-Message-State: AOJu0Ywb93NjPP2p9SGazkG0gHWEEZ9AQTxkF6sz0XsBgvzqmK46UCBD
 TtaTDJz14Ry2cPkxsL7uGjFOgt2s2AGyYA==
X-Google-Smtp-Source: AGHT+IEi1CyyYArcKXaXsyQbyHQHdKQki/aC5a0GpDNckhcXtHarhLZoWlukOta0rGK1R9zWUTECYQ==
X-Received: by 2002:a17:902:7207:b0:1c1:dbd6:9bf6 with SMTP id
 ba7-20020a170902720700b001c1dbd69bf6mr20256165plb.41.1697084046827; 
 Wed, 11 Oct 2023 21:14:06 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:14:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 53/54] target/riscv: deprecate capital 'Z' CPU properties
Date: Thu, 12 Oct 2023 14:10:50 +1000
Message-ID: <20231012041051.2572507-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

At this moment there are eleven CPU extension properties that starts
with capital 'Z': Zifencei, Zicsr, Zihintntl, Zihintpause, Zawrs, Zfa,
Zfh, Zfhmin, Zve32f, Zve64f and Zve64d. All other extensions are named
with lower-case letters.

We want all properties to be named with lower-case letters since it's
consistent with the riscv-isa string that we create in the FDT. Having
these 11 properties to be exceptions can be confusing.

Deprecate all of them. Create their lower-case counterpart to be used as
maintained CPU properties. When trying to use any deprecated property a
warning message will be displayed, recommending users to switch to the
lower-case variant:

./build/qemu-system-riscv64 -M virt -cpu rv64,Zifencei=true --nographic
qemu-system-riscv64: warning: CPU property 'Zifencei' is deprecated. Please use 'zifencei' instead

This will give users some time to change their scripts before we remove
the capital 'Z' properties entirely.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231009112817.8896-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst  | 23 ++++++++++++++++++++++
 target/riscv/cpu.h         |  1 +
 target/riscv/cpu.c         | 39 +++++++++++++++++++++++++++-----------
 target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++-
 4 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5e3965a674..1c4d7f36f0 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -340,6 +340,29 @@ of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
 CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
 CPU type starting in 8.2.
 
+RISC-V CPU properties which start with capital 'Z' (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+All RISC-V CPU properties which start with capital 'Z' are being deprecated
+starting in 8.2. The reason is that they were wrongly added with capital 'Z'
+in the past. CPU properties were later added with lower-case names, which
+is the format we want to use from now on.
+
+Users which try to use these deprecated properties will receive a warning
+recommending to switch to their stable counterparts:
+
+- "Zifencei" should be replaced with "zifencei"
+- "Zicsr" should be replaced with "zicsr"
+- "Zihintntl" should be replaced with "zihintntl"
+- "Zihintpause" should be replaced with "zihintpause"
+- "Zawrs" should be replaced with "zawrs"
+- "Zfa" should be replaced with "zfa"
+- "Zfh" should be replaced with "zfh"
+- "Zfhmin" should be replaced with "zfhmin"
+- "Zve32f" should be replaced with "zve32f"
+- "Zve64f" should be replaced with "zve64f"
+- "Zve64d" should be replaced with "zve64d"
+
 Block device options
 ''''''''''''''''''''
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8298f8bf63..f8ffa5ee38 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -722,6 +722,7 @@ typedef struct RISCVCPUMultiExtConfig {
 extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
+extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
 extern Property riscv_cpu_options[];
 
 typedef struct isa_ext_data {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cdeb24cb5e..ac4a6c7eec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1242,17 +1242,17 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
-    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
-    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
-    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
-    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
-    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
-    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
-    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
-    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
-    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
-    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
-    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("zifencei", ext_ifencei, true),
+    MULTI_EXT_CFG_BOOL("zicsr", ext_icsr, true),
+    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
+    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
+    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
+    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
+    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
+    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
+    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
+    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
@@ -1345,6 +1345,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/* Deprecated entries marked for future removal */
+const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
+    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
+    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
+    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
+    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
+    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
+    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
+    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
+    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
+    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
+    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a042bb6cda..a28918ab30 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -731,6 +731,25 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
+static bool cpu_ext_is_deprecated(const char *ext_name)
+{
+    return isupper(ext_name[0]);
+}
+
+/*
+ * String will be allocated in the heap. Caller is responsible
+ * for freeing it.
+ */
+static char *cpu_ext_to_lower(const char *ext_name)
+{
+    char *ret = g_malloc0(strlen(ext_name) + 1);
+
+    strcpy(ret, ext_name);
+    ret[0] = tolower(ret[0]);
+
+    return ret;
+}
+
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -743,6 +762,13 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (cpu_ext_is_deprecated(multi_ext_cfg->name)) {
+        g_autofree char *lower = cpu_ext_to_lower(multi_ext_cfg->name);
+
+        warn_report("CPU property '%s' is deprecated. Please use '%s' instead",
+                    multi_ext_cfg->name, lower);
+    }
+
     g_hash_table_insert(multi_ext_user_opts,
                         GUINT_TO_POINTER(multi_ext_cfg->offset),
                         (gpointer)value);
@@ -776,13 +802,14 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
                                    const RISCVCPUMultiExtConfig *multi_cfg)
 {
     bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
+    bool deprecated_ext = cpu_ext_is_deprecated(multi_cfg->name);
 
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
                         NULL, (void *)multi_cfg);
 
-    if (!generic_cpu) {
+    if (!generic_cpu || deprecated_ext) {
         return;
     }
 
@@ -825,6 +852,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


