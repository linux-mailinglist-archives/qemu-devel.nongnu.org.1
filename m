Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A2F79028F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6S-0007oS-B0; Fri, 01 Sep 2023 15:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6Q-0007nf-I0
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:46 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6O-0002wc-Bf
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:46 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57124ee486dso1386036eaf.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597603; x=1694202403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLI6XRWquA7GljCqRWTp6ZnGkttnS3Le6iqh21z4yTk=;
 b=KmEVoh9OtnMcSNJkosIvOBztHh1wdveFl90z5RK0mCz5cSsJ+XbF6z4NBjPt6LFOaN
 Hj0qG8SZs818mCAzBU9rtFzhVmwIpXceAD19uzyav2rFF8y7UDxQ1VWo2CNN0lL3jd+8
 WPrZsIobSl04CtknK/jnT38H7t8mDfl93AfnJT7KvbsB2thkb6wElOTZzOz60fOw+IQr
 SYvZDJBhAYrOzXGShiaitp5hJ7jF6sj0KksjVcHPeP6wX2uDKNcoryhz3DHSW1XAWGMX
 dFQafhWHn5liGvfwyB9Z5NCO8prRZNbwOiwZ7HwTzPh8//LStwR7GVfBZLPYbkuUML8u
 N42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597603; x=1694202403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLI6XRWquA7GljCqRWTp6ZnGkttnS3Le6iqh21z4yTk=;
 b=jcusbs36JPaT6I+bWJT/u42bqMykLu3GgXVLzwftcYK3jWYoWqSV/oyqmtbB0Flfg4
 6/yRF1gl/XOoRGDnISr+Pg/uD/Sx4DHp7u9A10Xsu4rk0wI7JpceHNq9EQEgItQoQ32v
 AEP1Qc84bjrGdRdtbt2oad+cYViw5cEIO0Yo5nUlg1JKZIKDvqE9DKBCOg5bEfmyRlEA
 KvsHMzw47US03tXDgm1qMFlvHujhaFvXTMDv/RCBBgKYQthCOOkZr5jOAPme5rGNHxJC
 ZzIpGHNicujPFIvp0pm6vfcDEQSp2Ke5iCAjzOam2kvLLZXDx1QFdAkb4x7c/4OmKbVs
 ud6A==
X-Gm-Message-State: AOJu0Yz0x5JAIAnimwxvp1s9nPH4MwoXguZqupkIbEGfcdQ1uvd6HdWS
 xLSOvnJZljKHVzhrQW+flBWUmZfT5nldzVycHtA=
X-Google-Smtp-Source: AGHT+IGb4I9titZFlufdJOylTkQKEIiyrMj45hZyH+ZAGqYtkx+Ub/cUCJKQdwQNz5KJt/ssjuG+Iw==
X-Received: by 2002:a4a:2a0f:0:b0:573:55f4:5175 with SMTP id
 k15-20020a4a2a0f000000b0057355f45175mr3805552oof.0.1693597603002; 
 Fri, 01 Sep 2023 12:46:43 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 03/20] target/riscv/cpu.c: split kvm prop handling to its
 own helper
Date: Fri,  1 Sep 2023 16:46:09 -0300
Message-ID: <20230901194627.1214811-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db640e7460..8e6d316500 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1943,6 +1943,46 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
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
@@ -1958,39 +1998,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


