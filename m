Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB68233C1
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:48:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5F8-0006Qu-Ma; Wed, 03 Jan 2024 12:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5F3-000671-EH
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:41:21 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5F1-0001ti-50
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:41:21 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9bd63ec7fso2696818b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704303676; x=1704908476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF/CefTDmCNBoXHoOvJb6MgLa49HsmQNRxYOjxOKKz8=;
 b=Nf/AV0cP3gc2AswuKmaFy0HgT6oV2GDO+u0BsPeyVYguFaovGsMXlF/nMFbM51dAMh
 Mbtt6EBrALjoY9u8+LNeOnHZ63Nl0p7NNZ//RIfm6s14MU5lo1dQqEBu+UDG23oMnb6x
 txIIVYyV7k8Dyrsk9+PWtmCpA+aJrRsYngbYdB5VfTrcQafwSssdAJhrkd83O3aJjkxp
 gzw7aM3SHF5z0kn5EaeuhqOdPryqSmVyhpn1Ze1Me/otbQD2egYPder0IsG1if3J8BHO
 YTaU7EhIG0/nQCC/TVH9e/7L+WX2VTLfS4Hrb+j0yzn1f9TJBlBECHuRU6ZTntr4tMRq
 LbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303676; x=1704908476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UF/CefTDmCNBoXHoOvJb6MgLa49HsmQNRxYOjxOKKz8=;
 b=bP6u1V5ItRX0gyaWIxl+Z4VDV/3MLFIctELGjEDtqYHVdWoD6LbN50DfP8E9Lb7Tqa
 rm41476XnBzxvVFkn5T/N3D1raGk7pdE3bxhje8D1I3PbiVlyS4cd/ZCcplcYKxyfF0g
 /SaZbkPnbpb53M/RKqPv2VHlAdxEmzXAZwiRMZPCfQZLXNgzh/MRXfzy+zbmSSAsCm7F
 bfRj3+HIglzl9uvJ2jfi6sQwF+z8ePYFALYQ0lKwk/TpJ8bGMFY40WJ0FOtiqqXmDN0F
 JRZgrAASfJYL0A9cbJul0r7M0+6YCF0+hDTkB8tzGcAWsJ7NDk0WEUrXywQqFlkTXslC
 869A==
X-Gm-Message-State: AOJu0YxxEFL12wbffHeY7thK5aWWs9nVjKyiiNeZ9ecvP/SDPQBqs9t/
 vdzh426BydybWuknmX1D0ebV4XZBmmyrEeXeVJNyJxVhDKoFSQ==
X-Google-Smtp-Source: AGHT+IFh9XRFZCLmhi0GWDrFfNPXXmRetu84HJ9yjYqYlNySyev31FerDuTUMc5L70gt75IAmMy+8A==
X-Received: by 2002:a05:6a00:2e20:b0:6da:14f3:53e8 with SMTP id
 fc32-20020a056a002e2000b006da14f353e8mr6165879pfb.24.1704303676096; 
 Wed, 03 Jan 2024 09:41:16 -0800 (PST)
Received: from grind.. ([189.79.21.107]) by smtp.gmail.com with ESMTPSA id
 v3-20020aa78503000000b006d7f1ae421csm24042050pfn.145.2024.01.03.09.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:41:15 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, vladimir.isaev@syntacore.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 16/16] target/riscv/cpu.c: move 'marchid' to
 riscv_cpu_properties[]
Date: Wed,  3 Jan 2024 14:40:13 -0300
Message-ID: <20240103174013.147279-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103174013.147279-1-dbarboza@ventanamicro.com>
References: <20240103174013.147279-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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
 target/riscv/cpu.c | 110 +++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3ea823f5cf..c67741ffa7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1964,6 +1964,62 @@ static const PropertyInfo prop_mimpid = {
     .set = prop_mimpid_set,
 };
 
+static void prop_marchid_set(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint64_t prev_val = cpu->cfg.marchid;
+    uint64_t value, invalid_val;
+    uint32_t mxlen = 0;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s marchid (0x%" PRIu64 ")",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    switch (riscv_cpu_mxl(&cpu->env)) {
+    case MXL_RV32:
+        mxlen = 32;
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mxlen = 64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    invalid_val = 1LL << (mxlen - 1);
+
+    if (value == invalid_val) {
+        error_setg(errp, "Unable to set marchid with MSB (%u) bit set "
+                         "and the remaining bits zero", mxlen);
+        return;
+    }
+
+    cpu->cfg.marchid = value;
+}
+
+static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint64_t value = RISCV_CPU(obj)->cfg.marchid;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_marchid = {
+    .name = "marchid",
+    .get = prop_marchid_get,
+    .set = prop_marchid_set,
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
@@ -1984,6 +2040,7 @@ static Property riscv_cpu_properties[] = {
 
      {.name = "mvendorid", .info = &prop_mvendorid},
      {.name = "mimpid", .info = &prop_mimpid},
+     {.name = "marchid", .info = &prop_marchid},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
@@ -2049,56 +2106,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint64_t prev_val = cpu->cfg.marchid;
-    uint64_t value, invalid_val;
-    uint32_t mxlen = 0;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
-
-    if (!dynamic_cpu && prev_val != value) {
-        error_setg(errp, "Unable to change %s marchid (0x%" PRIu64 ")",
-                   object_get_typename(obj), prev_val);
-        return;
-    }
-
-    switch (riscv_cpu_mxl(&cpu->env)) {
-    case MXL_RV32:
-        mxlen = 32;
-        break;
-    case MXL_RV64:
-    case MXL_RV128:
-        mxlen = 64;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    invalid_val = 1LL << (mxlen - 1);
-
-    if (value == invalid_val) {
-        error_setg(errp, "Unable to set marchid with MSB (%u) bit set "
-                         "and the remaining bits zero", mxlen);
-        return;
-    }
-
-    cpu->cfg.marchid = value;
-}
-
-static void cpu_get_marchid(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    uint64_t value = RISCV_CPU(obj)->cfg.marchid;
-
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -2129,9 +2136,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
 
-    object_class_property_add(c, "marchid", "uint64", cpu_get_marchid,
-                              cpu_set_marchid, NULL, NULL);
-
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.43.0


