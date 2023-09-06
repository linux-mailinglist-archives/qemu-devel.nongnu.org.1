Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67F7937DE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdof4-0003IF-Tz; Wed, 06 Sep 2023 05:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdof2-0003GB-EN
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:20 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdoey-0005kH-Nr
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:20 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c09d760cb9so707690a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991835; x=1694596635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSr2lSljPMfDziUB5b/tWMJTQP/2QzYe7O9nDpyZRtU=;
 b=oRHZQ3fmkGYPfeYLulL5CnZW7CFbc9JVsg2iuP+ZCnXZCUR5qscDa/vhZT7oSoibFx
 7JX9JyvcGX3hZTAiJc25pIVV5lAWA1vBHA7NLUNrqOvCv1GvH0ivrQpHs64wLimkRH79
 FN9wyt4kNKLhhx55PUYbqTJezhVzvosQRNIez43r8Ov42uTLadRxVsWmaUoulX4vJK63
 XtOeqDx2QWpo9KYrAYKOkd9Om4enegL6A+JB1uDsMC+R6FwPFsc+uuRiPsGIrk6PUked
 /lbFAdISVnLWNrC/Ui+XlfGQR3y2rU9RrpPewnoRx1nNPXLZtaZ+l/1Z6LFMnFEP9LYF
 HoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991835; x=1694596635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSr2lSljPMfDziUB5b/tWMJTQP/2QzYe7O9nDpyZRtU=;
 b=Xk8kjJf2FuUgajrJZuMJyuX38Tv9MTaQ8eYGZGJGmsybiIFzXZNEo2XocrF7KAbcOD
 nDFrX/+A4DbGE7wWghEVGHViGZF3byRrXzDF5nulMNO082QnrXtuCoHMMHFZujT7NMRU
 76ZfyeTUpFYJ4cyBPNfoKQ2ofFTgN9L0327WAPAjuMw3AomSpO25N6rwyRtmMljgXM+C
 SEVJEBfgVLiwAk4Zkf2clFXEWCmx8mcDQXk4+IzBm41BxdRyC/1bFH26+OjhuLzj49ZJ
 1FxpE/H6UzJywV0h8FuwJN+u7BpslKW+OkGX3MmNXCpvOlfD9QPIe0FkMwY2pwy4xM3u
 MNAQ==
X-Gm-Message-State: AOJu0YxaF5sbdkHqr6WDleaSGc/qR5E3K00gzQpMEshr+jhMDHwYTAuf
 Jf5gOI2DiSEMYrilC9vM90HugMb+8tJbajSpcS0=
X-Google-Smtp-Source: AGHT+IEc3UVuOWwi6UevtE9BUV3xWuFIi/w55uPIiZyLtNBdudRVKAiKVFWnFXsdC5hlnWDha57CDA==
X-Received: by 2002:a9d:618a:0:b0:6bc:9c9b:e787 with SMTP id
 g10-20020a9d618a000000b006bc9c9be787mr15379151otk.8.1693991835354; 
 Wed, 06 Sep 2023 02:17:15 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 06/19] target/riscv: move 'host' CPU declaration to kvm.c
Date: Wed,  6 Sep 2023 06:16:33 -0300
Message-ID: <20230906091647.1667171-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
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

This CPU only exists if we're compiling with KVM so move it to the kvm
specific file.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 16 ----------------
 target/riscv/kvm.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4c6d595067..c15bb572d4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -652,19 +652,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
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
-    riscv_cpu_add_user_properties(obj);
-}
-#endif /* CONFIG_KVM */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2044,9 +2031,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
index 14763ec0cd..b4d8d7a46c 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -1227,3 +1227,24 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
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


