Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B2825D0C
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:09:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtHE-0002e6-Gl; Fri, 05 Jan 2024 18:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtH6-0002V3-Sz
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:48 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtH5-0002O9-5P
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:48 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-593f7a1afd7so44942eaf.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704496003; x=1705100803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Da0MLUydTEpvU4IrTY7VL5Q5HOXI7skkwxXmWZ0qCU=;
 b=YAwPKLF5Z/zGcl6jGmEEyAYjhTGyjSybNiv6Ps8goG0HK/99IjHqaybrrI813Efant
 0flHFGJx+byrHgBXs9HrJlKBqgFFgeRrSwxWODowucKJIxw9wTEi1m6XNgs/Vzt1h6Px
 fEw4eYT16R6pgPJ2eOjV/rwhimdja6lsKOLVaCoFDYt0Pfy1wcuDs2+TygL5CbTYTCvd
 r7ZhH80xC4I1UpjahgqbOrb0p5l+558pKfetmufhrscY7Dfk0UWOdmK++r1z2M3GaUBv
 yZ97mdIGonyAbYlGUGPhk0jh0Hnx6s2sfo/RY+zfryjHeHtyE8eWpkZNsKXR9JPwNV+X
 ld6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704496003; x=1705100803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Da0MLUydTEpvU4IrTY7VL5Q5HOXI7skkwxXmWZ0qCU=;
 b=LSFREET3xw1X2yVMlN7uRXmrLFMHB2wisvW3FmATctu6DnuwlA8UPyt5hTRQzWJIcb
 9ghst/4S5pQxThDz5Sko4BhWgX8Cv4W28GcLKrMj2ENGUtaIVmIucQS3Nrr7ezPpavE4
 nUoyo07ttEm8AaRDC0/UVNzCG5drNlgvBdVD7k6TW98DzmkgI9rLLeL/mLpfRXF6Kolb
 W9CFQMInFh7uJfflfN7q3yQ7Ml0Sgqk+3mEIl35izhnZsAOBDr7cQIJ0mzTAmD3iXUDc
 1tU/A8aKgA7VpYIavXIi7d8QKz0zk85ZSXYLHdTTbWu6NybnjPRS04cMvFR9bdn/GZJf
 kINQ==
X-Gm-Message-State: AOJu0Yxppku/V2fvULsZ+qcrSzDHqE8POxdP7HcwxVyB3T5JEKZroNN+
 Kl/BD2EB4+XX1vqOwSMH4WB7rv7BURsk6ppK8e/j4EcY8TP2Wg==
X-Google-Smtp-Source: AGHT+IGhKWxeKiOu/o0zVSA4JyjbSv1rcH9w1wHoTvcUV/EvTIMv/QhQXSHaXJVwjQFwZBuBa74jLQ==
X-Received: by 2002:a05:6358:4406:b0:172:e3d3:4906 with SMTP id
 z6-20020a056358440600b00172e3d34906mr257780rwc.34.1704496003016; 
 Fri, 05 Jan 2024 15:06:43 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:42 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 16/17] target/riscv/cpu.c: move 'mimpid' to
 riscv_cpu_properties[]
Date: Fri,  5 Jan 2024 20:05:45 -0300
Message-ID: <20240105230546.265053-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
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
 target/riscv/cpu.c | 68 ++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c725a4839d..6149f5960e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2009,6 +2009,41 @@ static const PropertyInfo prop_mvendorid = {
     .set = prop_mvendorid_set,
 };
 
+static void prop_mimpid_set(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint64_t prev_val = cpu->cfg.mimpid;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s mimpid (0x%" PRIu64 ")",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mimpid = value;
+}
+
+static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    uint64_t value = RISCV_CPU(obj)->cfg.mimpid;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_mimpid = {
+    .name = "mimpid",
+    .get = prop_mimpid_get,
+    .set = prop_mimpid_set,
+};
+
 /*
  * RVA22U64 defines some 'named features' or 'synthetic extensions'
  * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
@@ -2096,6 +2131,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
      {.name = "mvendorid", .info = &prop_mvendorid},
+     {.name = "mimpid", .info = &prop_mimpid},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
@@ -2177,35 +2213,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint64_t prev_val = cpu->cfg.mimpid;
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
-
-    if (!dynamic_cpu && prev_val != value) {
-        error_setg(errp, "Unable to change %s mimpid (0x%" PRIu64 ")",
-                   object_get_typename(obj), prev_val);
-        return;
-    }
-
-    cpu->cfg.mimpid = value;
-}
-
-static void cpu_get_mimpid(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    uint64_t value = RISCV_CPU(obj)->cfg.mimpid;
-
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -2286,9 +2293,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
 
-    object_class_property_add(c, "mimpid", "uint64", cpu_get_mimpid,
-                              cpu_set_mimpid, NULL, NULL);
-
     object_class_property_add(c, "marchid", "uint64", cpu_get_marchid,
                               cpu_set_marchid, NULL, NULL);
 
-- 
2.43.0


