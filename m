Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB307C63E9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn47-00031j-Fw; Thu, 12 Oct 2023 00:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn43-0002pB-TN
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn41-0002XP-Kz
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9d922c039so4599325ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083963; x=1697688763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxnSYb8s8zmKapLM+nBg4+txEuL4+O5Nn2EFotCrF6c=;
 b=BBltfyKXusR5u9Ih5EqzkMEF3oTockMofBuzCap939zz921Yv6TODMASXG9Bp/nqKu
 bn4g+Xo/Euq2T3Qwmst7RQnAGMWg6YHOgqQ0o1I3rr6mNZzpNcY5ZSCE8BzWJkd14mPj
 PV2m9/TOKdpZGFGi1C9x2IZaTpDHDmNYaZSpioZpqwGodOi/vYDzRVbkqtyceOz0Zkpn
 r6GM4FnrfHr6a4eNqN5zrzmWbY7DGKsOez7Whn5lqOj59iPU5I9jigBGRiGlbMPUvMTy
 wMiGbU2lcRuZVFlBrVs2AY7QLsu8XLo3apOv8SxvsGKiVJK8KzNylh0XAM67mZJxHsvV
 0Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083963; x=1697688763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxnSYb8s8zmKapLM+nBg4+txEuL4+O5Nn2EFotCrF6c=;
 b=YI11iAolaBki7MSwD12Chmy3eVxl6ZcFoTISOCkwaxljO+Ju98Dg7kNs2OtuJGTnmc
 3cN+r8LB9CZI7lW9+oStZfDg7eqjVH32JPDi4e60QJ4oy3SXDcngqe7R7oJ/t6iW2GZy
 DTU2XQ6e3/q98aPZEM9VJdZ/rdilybWlTSDmMats5/e0l8Ws83BopArCjI1enVgIrM5s
 BEPsWFCM/tKBgjBMujNw8v9+xIQD1DtGqAWG8uiWlckp0dcr3ZBSmEfQDSx/9IKkBh69
 OoDcz5iHHE14hv5MW73xeZ3Ct9T5K4Z9QI57Nyir//5SuvWv0y/ZCMBo6370oZnZhaH/
 6CQw==
X-Gm-Message-State: AOJu0YwudcmMMWkbipTpesZA/iBcqSTcvBbybCLwbhADPEBL32IJr72X
 SVMAPra7BzSvdgsB5ozRE3BNfREe02AxwQ==
X-Google-Smtp-Source: AGHT+IFIWM2V0nVQ6tmUMrFR3C10K+Tpmvoz6+Y9XlWF9Exe6Ce4fQv9aUOuEbHqYAH38s2+gdZL2g==
X-Received: by 2002:a17:902:e743:b0:1c9:bf02:6638 with SMTP id
 p3-20020a170902e74300b001c9bf026638mr6517153plf.51.1697083963132; 
 Wed, 11 Oct 2023 21:12:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/54] target/riscv: move 'host' CPU declaration to kvm.c
Date: Thu, 12 Oct 2023 14:10:25 +1000
Message-ID: <20231012041051.2572507-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

This CPU only exists if we're compiling with KVM so move it to the kvm
specific file.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 15 ---------------
 target/riscv/kvm.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a6a26c0268..d78f73aa55 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -652,18 +652,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
 }
 #endif
 
-#if defined(CONFIG_KVM)
-static void riscv_host_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-#if defined(TARGET_RISCV32)
-    set_misa(env, MXL_RV32, 0);
-#elif defined(TARGET_RISCV64)
-    set_misa(env, MXL_RV64, 0);
-#endif
-}
-#endif /* CONFIG_KVM */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2037,9 +2025,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
-#if defined(CONFIG_KVM)
-    DEFINE_CPU(TYPE_RISCV_CPU_HOST,             riscv_host_cpu_init),
-#endif
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,   rv32_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 1e4e4456b3..31d2ede4b6 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -1271,3 +1271,24 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
+
+static void riscv_host_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+
+#if defined(TARGET_RISCV32)
+    env->misa_mxl_max = env->misa_mxl = MXL_RV32;
+#elif defined(TARGET_RISCV64)
+    env->misa_mxl_max = env->misa_mxl = MXL_RV64;
+#endif
+}
+
+static const TypeInfo riscv_kvm_cpu_type_infos[] = {
+    {
+        .name = TYPE_RISCV_CPU_HOST,
+        .parent = TYPE_RISCV_CPU,
+        .instance_init = riscv_host_cpu_init,
+    }
+};
+
+DEFINE_TYPES(riscv_kvm_cpu_type_infos)
-- 
2.41.0


