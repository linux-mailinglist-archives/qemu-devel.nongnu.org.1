Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D0881C9E7
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:25:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYj-0001ov-7X; Fri, 22 Dec 2023 07:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYg-0001kX-6d
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:18 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYe-0006Cm-Hi
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:23:17 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c690c3d113so1312407a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247794; x=1703852594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjT1roLG7CfvuK19j5grmNGYenzehWol3dj+uSF8GyA=;
 b=Gqq5I7lL3cnScp8AG3OE7ZMGvG0wfHLMsuXhLOYrERbDoz8H/PD7yD1lP/e5Laej5X
 rjWNeiCm0b4y9dwhwmHbWSjVfE6BmCfld+IUxSZBVXZEqhEBLE1QbJPHAopfIiBSoQQy
 2YdjBdmlrnK69ewKS38+yoIQVtv1CfaMBf8lnmhM/WGs4mHbtflO6DqqSsujf7lVK06d
 6Kg10u/ey5P6bvdVQuSb1E5aaileGJvDzo2bKfeK0yscd84Gpi7pRufVpuOq5RB+Jnf7
 f0z7LOj2GJbavJ+QXZ/qrOJmGb6bLIepAw+AFqXzGOZDIG9bWnHmDI9lOAM3IZ5DKHZl
 49EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247794; x=1703852594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjT1roLG7CfvuK19j5grmNGYenzehWol3dj+uSF8GyA=;
 b=xUBNL3VWw6Cs62M0z+XiVCl2Xo1dGq9ghGAMSEwQVecqVcjxT+hhUzvgiz1JMvTZfM
 kVOQc4UvLe1vYiWWLvVOl0RjwOLxj8ZD/nQzY4iphhW6ofO+nV64qP/pQToSQ9LCRbGB
 HYx9MBv1iLZxJJGYIuGeSbrf3L6NPzLnuT5qyYMhymCaJXu1rh3yqCTV8o9bSh6MVBJH
 rNIFume5zS1rE6TohPNLodxM7ktHmEhotbivS6zDCpiE+UEDcm4q+WjUORHFfBxXiSM1
 MYHNQELJwHHwE4HSJl/POKi+mZmQ6Ha+xdAvbTJTktC0L54TCjCVe6DhyCwqQ5ddDRA1
 3+IA==
X-Gm-Message-State: AOJu0Yzv5MIs304kkqCQQHcRBGqT1TvfZ7ncsnbNIbzmeu7UorB6PiuR
 dNUC/I9XUYK0S7+DQA0ZHHVc8CXbRgzlJI8ogv+QtXzoYYejOw==
X-Google-Smtp-Source: AGHT+IE4F8vjbnuH1cEv7ZyNUOxqqActUpSzljHjqq8vuqIT6Q+jNaSUbXGP16FUumkDPGLYReLPRw==
X-Received: by 2002:a05:6a20:2593:b0:190:4b34:577d with SMTP id
 k19-20020a056a20259300b001904b34577dmr1085489pzd.88.1703247793879; 
 Fri, 22 Dec 2023 04:23:13 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:23:13 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 11/16] target/riscv: move 'cbom_blocksize' to
 riscv_cpu_properties[]
Date: Fri, 22 Dec 2023 09:22:30 -0300
Message-ID: <20231222122235.545235-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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

After adding a KVM finalize() implementation, turn cbom_blocksize into a
class property. Follow the same design we used with 'vlen' and 'elen'.

The duplicated 'cbom_blocksize' KVM property can be removed from
kvm_riscv_add_cpu_user_properties().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 46 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  4 ----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f49d31d753..50825522b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1776,8 +1776,49 @@ static const PropertyInfo prop_elen = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
+static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    /* Always allow setting a default value */
+    if (cpu->cfg.cbom_blocksize == 0) {
+        cpu->cfg.cbom_blocksize = value;
+        return;
+    }
+
+    if (value != cpu->cfg.cbom_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cbom_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cbom_blocksize = value;
+}
+
+static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cbom_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cbom_blksize = {
+    .name = "cbom_blocksize",
+    .get = prop_cbom_blksize_get,
+    .set = prop_cbom_blksize_set,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
@@ -1802,6 +1843,9 @@ static Property riscv_cpu_properties[] = {
     {.name = "elen", .info = &prop_elen,
      .set_default = true, .defval.u = 64},
 
+    {.name = "cbom_blocksize", .info = &prop_cbom_blksize,
+     .set_default = true, .defval.u = 64},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 70fb075846..1866b56913 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -484,10 +484,6 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    object_property_add(cpu_obj, "cbom_blocksize", "uint16",
-                        NULL, kvm_cpu_set_cbomz_blksize,
-                        NULL, &kvm_cbom_blocksize);
-
     object_property_add(cpu_obj, "cboz_blocksize", "uint16",
                         NULL, kvm_cpu_set_cbomz_blksize,
                         NULL, &kvm_cboz_blocksize);
-- 
2.43.0


