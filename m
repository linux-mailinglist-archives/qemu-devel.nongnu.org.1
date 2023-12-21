Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3581BDA1
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:53:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGNDk-0002xQ-SL; Thu, 21 Dec 2023 12:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGNDU-0002ad-LP
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:52:16 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGNDR-0007zM-CB
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:52:15 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-593fbe8147fso589576eaf.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703181131; x=1703785931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpmUU/M2F0JQBGZ1AE03p/H6VED1FMWRt3KvMis82zE=;
 b=Qf8nINca8pZt0flAkc3ua7PDJmHItW5WFCLTlgMZVwI4rttcchFrSNB4GyuGVnSKwO
 gh2ulIbV1dVGEeLY/WfvxMxY2+8OFUxQzzKpFStMEuE67+mcv2kWKyJ2hsA+trpHwyHy
 gf5fy0Nq2wWe/iSkDgBeGIvWJJM/LHlfF/fkums+bKo4bb+FOp4oqbqJKsiJ7IoZUvb9
 gebKwN3pGvw6PK8PtJ04IMN5s9wkyaMaxzYmDab5N1oux3ICHwYWpFqpVfMVc8wYRkUB
 gEXZqmAGXQJmG8QwaHbWxxgjGC6KeO+oSWcURkSANhHjaPDq+Q2eRkqUUL713gi7PnCF
 WkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703181131; x=1703785931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpmUU/M2F0JQBGZ1AE03p/H6VED1FMWRt3KvMis82zE=;
 b=abiTZlhPMdya7VJ6QirTwJWszPaxSaaFJQkttGXGyS7cL8LLCWnq4h9P//5PLaG3fL
 Pq+iUNGCk702318AOHgP56BjrPF3NZencV3qkXitJJBVUu4k93pjdAXAr/mNO0SxBafE
 EzbIfNpDP8gHPKPhkIhckl7mpIBtxLfl9/NZtZQhauJBnvv7WIM4J2G1q7R6eKWx/oOr
 JlfcHTpQGLN8gFBn4AWnMAQiIlpLN8C8gcDhOsvamEcWVjwtTNn7j4XCeQ5damWCiIla
 Ca9RhZhR86TZQQRs4rRw+TkwQosKQQSEz3dkyMeHkCOC4lTKE08uxKxxh39QrfQjsnlt
 AyHg==
X-Gm-Message-State: AOJu0Yy6+4ZseODRk0u7y4EtT05tM7b5+qSQHJzt2tcUGBbaiit2TIh1
 D9vVEp9Xe27VU0+W47PuyGzObRYOFr8im9svJ2+VB3PB874llg==
X-Google-Smtp-Source: AGHT+IGWxxo1X1OGUpvhclNrzlJGTZaDl39TCrd7+a27HyK/yBNlsCXkkxGE3MPSRX3Eu5+lnQ/Y5w==
X-Received: by 2002:a05:6358:1a91:b0:173:3300:d901 with SMTP id
 gm17-20020a0563581a9100b001733300d901mr120519rwb.38.1703181131426; 
 Thu, 21 Dec 2023 09:52:11 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a63f50a000000b005b18c53d73csm1806261pgh.16.2023.12.21.09.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:52:11 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 09/16] target/riscv: move 'elen' to riscv_cpu_properties[]
Date: Thu, 21 Dec 2023 14:51:30 -0300
Message-ID: <20231221175137.497379-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221175137.497379-1-dbarboza@ventanamicro.com>
References: <20231221175137.497379-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc34.google.com
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

Do the same thing we did with 'vlen' in the previous patch with 'elen'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 52 ++++++++++++++++++++++++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  5 ----
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b75d9dee3c..aec1968cad 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1723,9 +1723,54 @@ const PropertyInfo prop_vlen = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
-Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
+static void prop_elen_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(value)) {
+        error_setg(errp, "Vector extension ELEN must be power of 2");
+        return;
+    }
+
+    /* Always allow setting a default value */
+    if (cpu->cfg.elen == 0) {
+        cpu->cfg.elen = value;
+        return;
+    }
+
+    if (value != cpu->cfg.elen && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.elen);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.elen = value;
+}
+
+static void prop_elen_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.elen;
 
+    visit_type_uint16(v, name, &value, errp);
+}
+
+const PropertyInfo prop_elen = {
+    .name = "elen",
+    .get = prop_elen_get,
+    .set = prop_elen_set,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
@@ -1748,6 +1793,9 @@ static Property riscv_cpu_properties[] = {
     {.name = "vlen", .info = &prop_vlen,
      .set_default = true, .defval.u = 128},
 
+    {.name = "elen", .info = &prop_elen,
+     .set_default = true, .defval.u = 64},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8ec858e096..84064ef7e0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -185,11 +185,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         return;
     }
 
-    if (!is_power_of_2(cfg->elen)) {
-        error_setg(errp, "Vector extension ELEN must be power of 2");
-        return;
-    }
-
     if (cfg->elen > 64 || cfg->elen < 8) {
         error_setg(errp,
                    "Vector extension implementation only supports ELEN "
-- 
2.43.0


