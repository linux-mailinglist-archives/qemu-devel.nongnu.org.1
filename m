Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74083788825
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZD-0001iv-0O; Fri, 25 Aug 2023 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZ4-0001e4-Mf
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:28 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZ0-0006x7-Mk
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:25 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bcac140aaaso661824a34.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968961; x=1693573761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlahJq7amgNJXd0IPn13gKG30zx+KvrZ1IpSGdUFOIA=;
 b=oS/HW9808/GjSsGIrPoZQaZtO4900ja+jWLb+84BBfXVlu1y8Ft080yxRKPL0O8tls
 m2kCGr/7AZKpr2jpKhbm2tvyqIRyaRrgi2MOnX5RIvWL+MOPMau2qU+tB4RUIiKUIqD6
 JeOQexU+f0io/RvTYbtnW4D5DnoafuOjOzHH4XU0SfBidJsRvMOf7RTltJAE63+dKSQP
 2hkRr8QPm7RndxdM3OEdRTH1HDzzTDe1Ifp7gjlJ+oTokSARomsp2KvLqeW4hmtoRaDR
 k2KzF52tQvxRGdbQN4tQLwf1NERLs/z3BSadRndpoA6l3wSnL54VxwlkljTSrnTcBn9L
 oUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968961; x=1693573761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlahJq7amgNJXd0IPn13gKG30zx+KvrZ1IpSGdUFOIA=;
 b=HnnAX1GCFO0EFW/+Wuhu566sJoiajAGGqSuG0ZMXARdyvGlUG7sV4K+SLF2OtDIDsb
 30F9FuvJ1xAqrH7s3Sahc8feSlfdIpCK1RgcsdIORUVAss2LAOsqPh55Ay7xZJcFQLIt
 QW11c8OgPmSaPZbo7YKOjsz8U/3rd6cQ6WV+o8sx4cjK58mndT1Tp6I5Y1BvdzzDQtV/
 kDuYuiNogfZNrvrjzNM1oX43ZpbAuwjKEU0pdlfoIE4bw7QcMkxYXeJXiiE5qKT3jbh8
 idUcd6jACJNb8I7F7bm440PCvbliF7zVx46zCuDlc3lhrYeL9hB+n94NfMOAsisY0lm3
 p0gg==
X-Gm-Message-State: AOJu0YzcdFS3Q51ZNEPMxMKG6vPL5IaNigSuqx2TE9V/5ZHOHVK3l9em
 cOU9VXUcY3qXEDpWOgzP5j/CPuBVOt5RBjbpwQw=
X-Google-Smtp-Source: AGHT+IFjN6aen8knjY9VD1wH4tlI/vD8BGf1ZK4QsMcGaGPJOQ5uFYZ1m5rrstpHaO9IHRQhU7uuRw==
X-Received: by 2002:a05:6870:c081:b0:1b0:649f:e68a with SMTP id
 c1-20020a056870c08100b001b0649fe68amr3105336oad.25.1692968961249; 
 Fri, 25 Aug 2023 06:09:21 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 07/20] target/riscv/cpu.c: add .instance_post_init()
Date: Fri, 25 Aug 2023 10:08:40 -0300
Message-ID: <20230825130853.511782-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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

All generic CPUs call riscv_cpu_add_user_properties(). The 'max' CPU
calls riscv_init_max_cpu_extensions(). Both can be moved to a common
instance_post_init() callback, implemented in riscv_cpu_post_init(),
called by all CPUs. The call order then becomes:

riscv_cpu_init() -> cpu_init() of each CPU -> .instance_post_init()

A CPU class that wants to add user flags will let us know via the
'user_extension_properties' property. Likewise, 'cfg.max_features' will
determine if any given CPU, regardless of being the 'max' CPU or not,
wants to enable the maximum amount of extensions.

In the near future riscv_cpu_post_init() will call the init() function
of the current accelerator, providing a hook for KVM and TCG accel
classes to change the init() process of the CPU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c35d58c64b..f67b782675 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -430,8 +430,6 @@ static void riscv_max_cpu_init(Object *obj)
     mlx = MXL_RV32;
 #endif
     set_misa(env, mlx, 0);
-    riscv_cpu_add_user_properties(obj);
-    riscv_init_max_cpu_extensions(obj);
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
@@ -445,7 +443,6 @@ static void rv64_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV64, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -569,7 +566,6 @@ static void rv128_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV128, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -582,7 +578,6 @@ static void rv32_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV32, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -1212,6 +1207,20 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
 }
 #endif /* CONFIG_USER_ONLY */
 
+static void riscv_cpu_post_init(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
+
+    if (rcc->user_extension_properties) {
+        riscv_cpu_add_user_properties(obj);
+    }
+
+    if (cpu->cfg.max_features) {
+        riscv_init_max_cpu_extensions(obj);
+    }
+}
+
 static void riscv_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -2019,6 +2028,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof__(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_class_init,
-- 
2.41.0


