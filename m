Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6475D765F65
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9B4-0001Hj-0x; Thu, 27 Jul 2023 18:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9B1-0001Gt-95
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:43 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9Az-0004si-Me
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:43 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5634db21a58so1058607eaf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495780; x=1691100580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZB106qDcqCPEEX28m2ZsSGLTI4RFzwz7nPc4dEn3fSk=;
 b=TrwPVu6pzcQzCxSqgpF/EK5PsR2/dtoyD04rrvOOyIeG1qYPG/M9rECZrspDRZVcXM
 q2aGoBsiWkgPTf8tjpAp+CHruQUBobt4CNlrtDbLZJUK0n6cPuKjNqqiDlPHhoU3GLQr
 HjTS3NKaWb3yVTbgGQg5sr/vhqDHJzgkMqKXY7SF2kLP65cFF5yoO4OiWe2QHr3YqCKX
 5hOV5wN53ZXuzASU/xEzXdzkiATqzrJDofRfJyvLqk/sGdQnpO6tzzRhy2N79lareaGd
 7t7HdHwWBa6g9YNkIulmG4wDv0uDYZLwrVNcNWtanKFzRNfmtgjk7DFIt52nOE1gB4JQ
 bmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495780; x=1691100580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZB106qDcqCPEEX28m2ZsSGLTI4RFzwz7nPc4dEn3fSk=;
 b=POe8zxOulFKEB87nZSmGwIa5XHslZNctTjM1RmxSwen6i4jPjFC5CNMC8VCr9J4dJO
 d/X7XZXSbOS8VjcZ7LhNtsN2LDKqWNM7ioS7LDia3uiNTjGbjs3S1jLK/elO+aQcej+t
 Fg5zjkVb3g1yjTrQwkl/SgIQeveeP62hu3wMsVIpZfv/Ox0AbE7d7apH9r9df6eiD7Ak
 FzljaHpwsYdiRRU38O0ch4N8fB1/HBKKmjRIl9/exZ7adkM4XINTZCqiaCM9clkQ5mRh
 hZAue/o+L4TsOZJnTTKkihvu8LJvwGo14EN17Y15ofAuCR2S5jR/lwMAtLB8mhkinLPm
 3nIA==
X-Gm-Message-State: ABy/qLaAJ8G3/cPAynYlJCdv9XL+BCSIhVsBFKx9rEKAOUvigvyGt5DG
 WV7rTvl91JC69pozcpgASoRyjqDZ4bbV4n1uIZhydQ==
X-Google-Smtp-Source: APBJJlFDyl/Zr9CrTi45TW6jhedlVLMsRPR2cOH34U91MOKJopqEz1qOHH6GF/TmzfSgCkpjDH7uuw==
X-Received: by 2002:a4a:2a49:0:b0:565:83d1:e3cc with SMTP id
 x9-20020a4a2a49000000b0056583d1e3ccmr811109oox.2.1690495780204; 
 Thu, 27 Jul 2023 15:09:40 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:09:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 03/12] target/riscv/cpu.c: split kvm prop handling to its
 own helper
Date: Thu, 27 Jul 2023 19:09:18 -0300
Message-ID: <20230727220927.62950-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
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

Future patches will split the existing Property arrays even further, and
the existing code in riscv_cpu_add_user_properties() will start to scale
bad with it because it's dealing with KVM constraints mixed in with TCG
constraints. We're going to pay a high price to share a couple of common
lines of code between the two.

Create a new riscv_cpu_add_kvm_properties() that will be forked from
riscv_cpu_add_user_properties() if we're running KVM. The helper
includes all properties that a KVM CPU will add. The rest of
riscv_cpu_add_user_properties() body will then be relieved from having
to deal with KVM constraints.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2fa2581742..f1a292d967 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1881,6 +1881,46 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
+{
+    /* Check if KVM created the property already */
+    if (object_property_find(obj, prop_name)) {
+        return;
+    }
+
+    /*
+     * Set the default to disabled for every extension
+     * unknown to KVM and error out if the user attempts
+     * to enable any of them.
+     */
+    object_property_add(obj, prop_name, "bool",
+                        NULL, cpu_set_cfg_unavailable,
+                        NULL, (void *)prop_name);
+}
+
+static void riscv_cpu_add_kvm_properties(Object *obj)
+{
+    Property *prop;
+    DeviceState *dev = DEVICE(obj);
+
+    kvm_riscv_init_user_properties(obj);
+    riscv_cpu_add_misa_properties(obj);
+
+    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
+        /* Check if KVM created the property already */
+        if (object_property_find(obj, riscv_cpu_options[i].name)) {
+            continue;
+        }
+        qdev_property_add_static(dev, &riscv_cpu_options[i]);
+    }
+}
+#endif
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1896,39 +1936,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_add_satp_mode_properties(obj);
 
     if (kvm_enabled()) {
-        kvm_riscv_init_user_properties(obj);
+        riscv_cpu_add_kvm_properties(obj);
+        return;
     }
 #endif
 
     riscv_cpu_add_misa_properties(obj);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-#ifndef CONFIG_USER_ONLY
-        if (kvm_enabled()) {
-            /* Check if KVM created the property already */
-            if (object_property_find(obj, prop->name)) {
-                continue;
-            }
-
-            /*
-             * Set the default to disabled for every extension
-             * unknown to KVM and error out if the user attempts
-             * to enable any of them.
-             */
-            object_property_add(obj, prop->name, "bool",
-                                NULL, cpu_set_cfg_unavailable,
-                                NULL, (void *)prop->name);
-            continue;
-        }
-#endif
         qdev_property_add_static(dev, prop);
     }
 
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
-        /* Check if KVM created the property already */
-        if (object_property_find(obj, riscv_cpu_options[i].name)) {
-            continue;
-        }
         qdev_property_add_static(dev, &riscv_cpu_options[i]);
     }
 }
-- 
2.41.0


