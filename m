Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D960758673
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:05:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrP-0002Wm-BL; Tue, 18 Jul 2023 17:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrI-0002WT-Hf
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:48 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrE-0007E5-Vh
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:47 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b9cf17f69cso99273a34.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714223; x=1692306223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtX5uAVjScWXWg9jMiQOg8kGObouTQ3OOuejDSciQPc=;
 b=nyMpd6gU2J/YaOQ97LzZzFNGoUO7zV4HDoYvpDY+2I95+J8xkse6IrOjbY5YhdvKrx
 hcXeHL3PwnXCnA0cozET0jcWm6+yA9sUbN60NTCgRCAg2zwXvL1mqwwJJf38vchjxO55
 Lpi0O+H+cZgSvth2unnXPPi+9e40h7EiFF2D9oTyN2xouvDV3IWWlSfSDBgI9KtcInLZ
 L8rQTrDrO5p2M+g0iEDcO6Om29jAWNU2SvvHBxk4Mxjuj9l+iA8bCGN7fTeDEIH6WVg1
 jBSWEgaSyw0hm69GcvTQajj2mtBpOy+U35bxr6A/GsFYe6ahPxHzqagsxEkIsTxkpI43
 h9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714223; x=1692306223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtX5uAVjScWXWg9jMiQOg8kGObouTQ3OOuejDSciQPc=;
 b=SvvppQN+7ZqI0olJCNmH6Qa2615iBJ1IJS+Cp5u/O3nndnxmZomnRq3JUQ5/azV2bf
 Hi3OQ6ysuZaZs/SLSH5I7F4u3v57m0yrv5Cos5YH6m3/OKg4O0u+fvwHWjdHdNbWwDMR
 pxL6Rdop+Aue2hUAmBu4EF1F2LMCFpa7kjAZBY48j6iV0YYGgvRTqP0RVR4bySGEs5d7
 c9FMDCjAl/BdOphHnXGi2zpMU4mL8n5qGsJqIkN6cY01lWOOn7ZAKDvQc3pa9UOIA1vK
 ux4LC0W18rl6TlC3OEyKT3B0+byZQycOA35oNxPYsViB6uvGfjxInd7xCdkwA+II/SvQ
 GENA==
X-Gm-Message-State: ABy/qLYP9WTNjzqv3koYSDBbJTJ2atRq4P/1vfTMjVJ63oZBk7S5az4k
 g41a0PvcaC24j+daw6hVmTOvuliDZ91dvPncglVxpw==
X-Google-Smtp-Source: APBJJlEuWe6ctw52BImYzfPzixzkbRZyE/cnsmlHeE7fatLDocNc+ZVORsDkO/7mP46F/gF8UqXfPw==
X-Received: by 2002:a9d:7608:0:b0:6b7:5777:f63e with SMTP id
 k8-20020a9d7608000000b006b75777f63emr200801otl.9.1689714223527; 
 Tue, 18 Jul 2023 14:03:43 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 03/11] target/riscv/cpu.c: split kvm prop handling
 to its own helper
Date: Tue, 18 Jul 2023 18:03:21 -0300
Message-ID: <20230718210329.200404-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32d.google.com
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
---
 target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 29f2543f6d..1b6d546522 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1872,6 +1872,46 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
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
@@ -1887,39 +1927,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


