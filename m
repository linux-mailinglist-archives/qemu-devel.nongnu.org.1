Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBB825D03
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:07:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtHC-0002ZW-Eo; Fri, 05 Jan 2024 18:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtH5-0002UF-By
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:48 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGz-0002Nn-Vu
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:43 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9bd63ec7fso84911b3a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495999; x=1705100799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6SzNMy+BloI1WRqHoc/Zi9LcRFCo1T2m2ZqztWkSc8=;
 b=B6xtDl/L3Tyb5/K4m6Lp88PxrJY/WNkrPtVkJ4HJwT71gB5nX83E5Xbmz2iMeLN7Wv
 qhptGnISEswPfSm7mx2X4xtZHiIGtBVz/YJE1T+TLtbvbvRg2TuiUMPN1Y6U6uV8ijJk
 ZT1Ol/MkiWnSEUo1bKdyGq6hJ2DzA3o/9dDBZB7V7aCNW20n15nulpJxGDRVGgOz78Ae
 ev13k27PI2RZmBEEU6vI9/NBEWvxWMNYXbQpXsujkjTn31c4rIVHUjS7DlS7raBpZ1O8
 7sM5CChiPMPwuvwGwxP4JgvjLPnAk0euhCRjAqdpc4Yt+Pzhz7cY64ds9FPuAYZw84Mr
 eEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495999; x=1705100799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6SzNMy+BloI1WRqHoc/Zi9LcRFCo1T2m2ZqztWkSc8=;
 b=l0wkChgpElf0VhJ78e0LZZEa3UO/EtDLn4PgA2Po7DunTIEgGjAR49cpvmPqqswrKR
 PUcXcUaE+zKh+ngAmHNk3/T6DS0SgF1EXPbbg8f4wFJM1csVzrUe9RY63NHoutdyo4aT
 8wdm9t0oYIH3gPVpMRaDHBu6uadxD88KOE0XNqX4dl2RqSHBVfj0GA3GkjkJl7TpiAth
 Oqgab0LbR86vOssN8pk0GZjUrAfGgG8/dr6Xok1uonipUpf3NiXR+fCsSAIh3RaUnaiI
 FQbAkn0biAJSbU+zEgyUq+JTkZr8oszQaH3srRG2GhhTOuYLdVKFHijjOL9YuAlvr5s3
 mP3A==
X-Gm-Message-State: AOJu0YxRu5+2ziDx1TVvYZNL6U3rPw3rVXsjYPNCmxj+daOFVvuLItPg
 IAFtiMOAax44QnFHpke0eUmHRPG0ScPXokgGEibhVloLs4oXQA==
X-Google-Smtp-Source: AGHT+IGPbfcHtNDZjjGQoy45jFq7epWYnNBg64bgigews1yHXJtSg7JEaYL8/P5ZogtccZz7GAd44g==
X-Received: by 2002:a05:6a00:9089:b0:6da:336f:a925 with SMTP id
 jo9-20020a056a00908900b006da336fa925mr92279pfb.29.1704495999476; 
 Fri, 05 Jan 2024 15:06:39 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 15/17] target/riscv/cpu.c: move 'mvendorid' to
 riscv_cpu_properties[]
Date: Fri,  5 Jan 2024 20:05:44 -0300
Message-ID: <20240105230546.265053-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Keep all class properties in riscv_cpu_properties[].

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9d4243891c..c725a4839d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1974,6 +1974,41 @@ static const PropertyInfo prop_cboz_blksize = {
     .set = prop_cboz_blksize_set,
 };
 
+static void prop_mvendorid_set(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t prev_val = cpu->cfg.mvendorid;
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s mvendorid (0x%x)",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mvendorid = value;
+}
+
+static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    uint32_t value = RISCV_CPU(obj)->cfg.mvendorid;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_mvendorid = {
+    .name = "mvendorid",
+    .get = prop_mvendorid_get,
+    .set = prop_mvendorid_set,
+};
+
 /*
  * RVA22U64 defines some 'named features' or 'synthetic extensions'
  * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
@@ -2060,6 +2095,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
     {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
+     {.name = "mvendorid", .info = &prop_mvendorid},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
@@ -2140,35 +2177,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint32_t prev_val = cpu->cfg.mvendorid;
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    if (!dynamic_cpu && prev_val != value) {
-        error_setg(errp, "Unable to change %s mvendorid (0x%x)",
-                   object_get_typename(obj), prev_val);
-        return;
-    }
-
-    cpu->cfg.mvendorid = value;
-}
-
-static void cpu_get_mvendorid(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    uint32_t value = RISCV_CPU(obj)->cfg.mvendorid;
-
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
@@ -2278,9 +2286,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
 
-    object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
-                              cpu_set_mvendorid, NULL, NULL);
-
     object_class_property_add(c, "mimpid", "uint64", cpu_get_mimpid,
                               cpu_set_mimpid, NULL, NULL);
 
-- 
2.43.0


