Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100479D216
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3OB-0002oI-Dl; Tue, 12 Sep 2023 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3No-0002bj-Jo
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:24:49 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Nj-0003Vx-9t
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:24:46 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ab7fb1172cso1812857b6e.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525081; x=1695129881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYMv3u9t6iklrr46zGtmAUTnviscaFaetm+bKYtnmrs=;
 b=MMPm3SDer95yOX2xeSGtVQTU4C9Jtwhg0fx5wWcgVLeMsEIn4lH40mlfBluCkaVyC9
 BF9n875qpj47SvUd4Ylo/tRSFnB4rkFpz3Vm3s7WuC49kly3bW6HlmHH3BaNIGx5ZrJh
 BXuwU5OQCLcw6P5b3Sl0Y2mvHpWD+lP3z23Y4ZUyUpvoLUAiaVVNTIU8InW7avK7c3t5
 pFMoSY5zH8VZ2VrbAMXlxMN2u//s3DDMJYKFn8YQBKr57PnguWa2E4V8ppKvW38Mq5tv
 kBgm4zJ006Ew3qbfuvXa/4IFhCWpz0IkStR9fx3hcXbzdlJpwrmZHe0MC2Eq4m0Ilc9H
 YkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525081; x=1695129881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYMv3u9t6iklrr46zGtmAUTnviscaFaetm+bKYtnmrs=;
 b=PqCNau3S0MCmKFJzgkrsyji4Ucc98QyoWhTpQ6liIpwn633XYA3wPQMB+FG1OFrosL
 ea26cRdXOW5pAQF8Bmk75KPVXiSchjCL0CIRPOqW0BTh42lEcc6TAKG5veGYVWj5BvdX
 n8IyPKaZifn+iZUU/nkIedaR9TqBQFSpE2lisqH7yEkK84u6KOicXajwWebd3wQUSRjY
 ezw+O+mCtX39O24iNC0WeYu9MPSmsuSVZXESSTv1GdQDKtHMdrLRCxkc59tuM/n58B2w
 4nMtgS8Rt70p1U4Y3sCPaQFRoGPLN2lGsZm/YgkopKb8JBkqQ+2spYbddoi1CbPsrKeh
 tRCg==
X-Gm-Message-State: AOJu0YzLlEUQbCPPG3sJsG4kwsOSByRyRVw3YBxXtCqeD+bkR5XwV0Gd
 o0V1kgB62W+/YcUhRq36z83eMRhZB88eJHXwTEI=
X-Google-Smtp-Source: AGHT+IHsiC5EvG8vvqEh1WjSU5sh/C8MsoL8kwamCyYFlU8nZ18MLvcSuUN+5VtfXix5xQZPU/jfYQ==
X-Received: by 2002:a05:6808:2099:b0:3a4:2941:b0d4 with SMTP id
 s25-20020a056808209900b003a42941b0d4mr15080289oiw.24.1694525080794; 
 Tue, 12 Sep 2023 06:24:40 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:24:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 03/20] target/riscv/cpu.c: split kvm prop handling to its
 own helper
Date: Tue, 12 Sep 2023 10:24:06 -0300
Message-ID: <20230912132423.268494-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22f.google.com
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
---
 target/riscv/cpu.c       | 65 +++++++++++++++++++++++++---------------
 target/riscv/kvm_riscv.h |  3 ++
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db640e7460..7b7c5649e7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1924,7 +1924,7 @@ static Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 };
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_KVM
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                                     const char *name,
                                     void *opaque, Error **errp)
@@ -1941,6 +1941,44 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
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
@@ -1958,39 +1996,18 @@ static void riscv_cpu_add_user_properties(Object *obj)
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
-- 
2.41.0


