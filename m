Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E87C63EB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn46-0002y9-5l; Thu, 12 Oct 2023 00:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3z-0002aL-BB
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3w-0002WX-Vv
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c8a1541233so4702015ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083959; x=1697688759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTRcABrKshKpF2CiJWe97KgR3ggXqDl/A2oup6W9fiE=;
 b=D7xcb4wh0decPhyvY6JRzEDOoD7GS3JhVPqiZiCBp/31QbxpNWEdsQRf6twjv1HOlg
 Fqmi5J3NwT1dDSab70zY24a4gkkDi9+wi5v10Ym3BJ568OmKJtwKacKRWhH2WmVxO+rV
 SZNUNc16PxJaxDxZ0LrwJzw8nVZXmuCcfIUlkvVKyl7N4HFKVRssctpFWJ8jb094uvbM
 /B5XdI+fIR3V67AJlqrxbJHtgioKhndbL9NksSyvGsaiUSL6ckfSPawzSn8A12Ges2/2
 /v9BJT7k5+DjevvSpRk2Qgf+GnRNJ8LtoDraizBeFbTRinCKd3qP8nR6g3RG1xVpXqaG
 5B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083959; x=1697688759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTRcABrKshKpF2CiJWe97KgR3ggXqDl/A2oup6W9fiE=;
 b=dZNJyGm+r+7pETGiaDt3qkmcV1Nf6ISZ5w751ig+NK/7klPLr+zbJJhqJ8gsgW6854
 sUPJiIqOwHsZ6RVO1G4MxL54mZvBkMGEpJpWPVhHpFsEQ7QNqRlvIOQOCx+U4ETdiYkV
 uZVArUZi8x/DcMULP4On9EvZ4CPtYvAubZu3vMa9mBXfse0hD7UXK/YmN+MujvJzKZw3
 z5W08eon06zUXSEauA2ALAWLi3/2ImdwJB+qJ/CQ51EauasEBg4/X3S4tzhAG64390eF
 hToKOWy6bnmNvtGUoZ2aCYzuNIdihbC2eb6Z0mPYpDVex/VDUzUs4P+wjmT8I5pfq9SL
 USdA==
X-Gm-Message-State: AOJu0Yx4kNiWEDxHYETEGFYz99QrxwDuEv7C2ucWXc2B4A7gzwOQ+1cp
 Yjf40YKNquTfArDSG6Ft8yyQ0QIv58rK2w==
X-Google-Smtp-Source: AGHT+IEGaeF72DJGbWKe7hUxLWLvr6EbD5524ZQTpbXwccBNiKvXIMhEU188pdjn7hU//9Oy0rH+Jw==
X-Received: by 2002:a17:902:e881:b0:1c4:4c10:6ae3 with SMTP id
 w1-20020a170902e88100b001c44c106ae3mr27141238plg.23.1697083959237; 
 Wed, 11 Oct 2023 21:12:39 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/54] target/riscv/cpu.c: add .instance_post_init()
Date: Thu, 12 Oct 2023 14:10:24 +1000
Message-ID: <20231012041051.2572507-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

All generic CPUs call riscv_cpu_add_user_properties(). The 'max' CPU
calls riscv_init_max_cpu_extensions(). Both can be moved to a common
instance_post_init() callback, implemented in riscv_cpu_post_init(),
called by all CPUs. The call order then becomes:

riscv_cpu_init() -> cpu_init() of each CPU -> .instance_post_init()

In the near future riscv_cpu_post_init() will call the init() function
of the current accelerator, providing a hook for KVM and TCG accel
classes to change the init() process of the CPU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08cbd51ea1..a6a26c0268 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -427,8 +427,6 @@ static void riscv_max_cpu_init(Object *obj)
     mlx = MXL_RV32;
 #endif
     set_misa(env, mlx, 0);
-    riscv_cpu_add_user_properties(obj);
-    riscv_init_max_cpu_extensions(obj);
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
@@ -442,7 +440,6 @@ static void rv64_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV64, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -566,7 +563,6 @@ static void rv128_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV128, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -579,7 +575,6 @@ static void rv32_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV32, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -666,7 +661,6 @@ static void riscv_host_cpu_init(Object *obj)
 #elif defined(TARGET_RISCV64)
     set_misa(env, MXL_RV64, 0);
 #endif
-    riscv_cpu_add_user_properties(obj);
 }
 #endif /* CONFIG_KVM */
 
@@ -1215,6 +1209,37 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
 }
 #endif /* CONFIG_USER_ONLY */
 
+static bool riscv_cpu_is_dynamic(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
+}
+
+static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
+}
+
+static bool riscv_cpu_has_user_properties(Object *cpu_obj)
+{
+    if (kvm_enabled() &&
+        object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_HOST) != NULL) {
+        return true;
+    }
+
+    return riscv_cpu_is_dynamic(cpu_obj);
+}
+
+static void riscv_cpu_post_init(Object *obj)
+{
+    if (riscv_cpu_has_user_properties(obj)) {
+        riscv_cpu_add_user_properties(obj);
+    }
+
+    if (riscv_cpu_has_max_extensions(obj)) {
+        riscv_init_max_cpu_extensions(obj);
+    }
+}
+
 static void riscv_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
@@ -1764,11 +1789,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static bool riscv_cpu_is_dynamic(Object *cpu_obj)
-{
-    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
-}
-
 static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -2005,6 +2025,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_class_init,
-- 
2.41.0


