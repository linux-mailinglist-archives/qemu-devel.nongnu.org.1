Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA57C63BD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn2h-0000vl-KV; Thu, 12 Oct 2023 00:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2e-0000vI-EB
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2c-00025u-LK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso4582625ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083876; x=1697688676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joN4I6hLiMGFiPKk6rIQGIaVgumEWTT2aSNqBdUtXFo=;
 b=Bl0U7WaU8s4RhO+Ri4uiIuTxztXT6DC3w1LY1vc1PE1qGdDWFzSjHjKOjm6L0JXKsk
 io/TLUiC9o5Ln0kHoMXmB15CZzO6Ro12HMd7iF1VLccYac8b5IZphiHawJHcPHr4i8XY
 w5rV6BBUr6cGKIlaY987MkXTuYBMxHAf7MFbP8pLlFLf2gujuG8WIhHStFech+L81EIg
 QOQ1n+dDrK6z9BvKjeQIVomxdaOJjbrgXIbZJvUcoJjN6xo1sus7ZCiAQw+V/t1hSMQU
 EI/0XgYw1UJl3HYHYWX6CNLssXSDt0lVXCjuPU7iBrgF5juBIAztkrxmr9mBFUJzCPon
 PnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083876; x=1697688676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joN4I6hLiMGFiPKk6rIQGIaVgumEWTT2aSNqBdUtXFo=;
 b=CMUoQSkUYA9DyNqocfMfCoIb0X/rlK0y6vQ2NXjB3EZT/mKR5bbjBmVOMCX3pu52OW
 EazGm4eU+dU6fXdagNFrDctcPlsdLFoyai7/M17VMJhph+vGfK1Yuqjx41ojSOYv6b1T
 FZS74UJXnUP2a6vyB4dL9C8t7Cg8/Pv1TP6ezksWcX6Z2mEb4qgNGzsJsAaR8ZYYKuGt
 zH1juzhvrpye3jcRjj81tGLUCPicw/bhkj68T8xKRGSegDoiG6iCdcwshVxSkUHj6/gG
 r1Zn59wN1tJoHaNU8chaSqVd52A5ywaJLhm8OWFL5ec58lsT9t5gR26+rFaiC/6eDvuz
 xPog==
X-Gm-Message-State: AOJu0YwBC1B+mhSvC7gAqYwxI2k+jo0JK0UqaQRzqEsheR99Biq6GVy7
 Ta+OdYTLPyT/0DXAjKd95h9cDpA2WY/Cbw==
X-Google-Smtp-Source: AGHT+IG5gA1GbUeRj5UCd67k94Jm7kPj5kpkXrdwK2XDHEmmWPgsKs6ZqZ2KuU2dtPztF8bg2+5HVA==
X-Received: by 2002:a17:902:6ac2:b0:1c9:c35f:9a25 with SMTP id
 i2-20020a1709026ac200b001c9c35f9a25mr4815541plt.34.1697083876593; 
 Wed, 11 Oct 2023 21:11:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/54] target/riscv/cpu.c: split kvm prop handling to its own
 helper
Date: Thu, 12 Oct 2023 14:10:00 +1000
Message-ID: <20231012041051.2572507-4-alistair.francis@wdc.com>
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

Future patches will split the existing Property arrays even further, and
the existing code in riscv_cpu_add_user_properties() will start to scale
bad with it because it's dealing with KVM constraints mixed in with TCG
constraints. We're going to pay a high price to share a couple of common
lines of code between the two.

Create a new kvm_riscv_cpu_add_kvm_properties() helper that will be
forked from riscv_cpu_add_user_properties() if we're running KVM. The
helper includes all properties that a KVM CPU will add. The rest of
riscv_cpu_add_user_properties() body will then be relieved from having
to deal with KVM constraints.

The helper was declared in kvm_stubs.h, while being implemented in
cpu.c, to allow '--enable-debug' builds to work. The compiler won't
remove the kvm_riscv_cpu_add_kvm_properties() reference when
'kvm_enabled()' is false if we end up with an unused function. Even
though being a KVM only helper we can't implement it in kvm.c due to its
many dependencies inside cpu.c, so make it public in kvm_riscv.h and
keep its implementation in cpu.c for now. We'll move it to kvm.c in the
near future.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm_riscv.h |  3 ++
 target/riscv/cpu.c       | 65 +++++++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index de8c209ebc..69e807fbfb 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -19,6 +19,9 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
+/* Temporarily implemented in cpu.c */
+void kvm_riscv_cpu_add_kvm_properties(Object *obj);
+
 void kvm_riscv_init_user_properties(Object *cpu_obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e02f399c81..2a8fbd214a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1920,7 +1920,7 @@ static Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_KVM
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                                     const char *name,
                                     void *opaque, Error **errp)
@@ -1937,6 +1937,44 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                    propname);
     }
 }
+
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
+void kvm_riscv_cpu_add_kvm_properties(Object *obj)
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
 #endif
 
 /*
@@ -1954,39 +1992,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_add_satp_mode_properties(obj);
 
     if (kvm_enabled()) {
-        kvm_riscv_init_user_properties(obj);
+        kvm_riscv_cpu_add_kvm_properties(obj);
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


