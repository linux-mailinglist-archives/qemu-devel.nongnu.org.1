Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F24A7A7A46
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivGH-0005cg-2F; Wed, 20 Sep 2023 07:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGF-0005c1-CO
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:51 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGB-0002C0-Hh
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:50 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bdacc5ed66so446259a34.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208846; x=1695813646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z34lnycwKSt8MQkk4aJUxrt7LNLfPdCkA0rJx8DGw4o=;
 b=L69PIHIqoKASwJRpxeX6mtApb1KuwuxaDgepdhVxfCSyMENtPPgLKnPBLtsw+zK1vX
 9Fco2FAI3zbCbZKjbI4CE0HrbjO+7QOMR0C8EoJ8HHF+wLDoARxOUrbcpZyP1lPxFI7f
 AIZbjUQQ67LKefBnuTX6Pp6DyCtm4Rz4CNaMuWCFHNTQW+Kbbi6KzByWdhioXNlEXVjE
 U1tZUMCwDbu9jzU9dNPBiG5KZP8pGFfkzCKSQjMFWbK9eSQSfbVTvqXpVMEJo07IVVTZ
 JB5C+XJumEFlsi8o5AYXkBzrxj1Ab9yjUyQ7RV5VaSeV03+sfhZD9KaiP3+iIFrznUGt
 tYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208846; x=1695813646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z34lnycwKSt8MQkk4aJUxrt7LNLfPdCkA0rJx8DGw4o=;
 b=DEYqE19CT/dATmgR+gMiwq25PbkT4M0tlFAVEQPmXV25T2eMU+npBxRVERjS3YO9Ng
 sFf2z52A+wzT0La7E7b09uiIdl3yrpKysN3wnvSgBGAkxIL3AA2ZEtfDKBbES3WpAGZr
 ZJNYCdpHE44QwKvjrMGDcmG5+6j3RP6dQcdTJssOiN3MXPtxL/F/Hj/nmCUdnBAw16nF
 ixf9RNOlvYGbXIhH+9cZwICi4YngiKimQLZOXI1YF9cHtqJTmyiqb329m9EvV7K/7dVD
 OkJQNhidbqecTjVIirNQpue2TbbzbZGeEyjbgA5lF9uYkKaPrrTilMrYm8xxTn+FUem4
 opSQ==
X-Gm-Message-State: AOJu0YxAYdu0A/1CeZhmZYq9Y3/YAwCoP2YAVSE3bROKpWpbn6zN6B3n
 G4lWAwrDalgxPggOHUII0AUFQfKvx/GqVjEawbk=
X-Google-Smtp-Source: AGHT+IFateV7jbgTo6ALi8PviF6dW8ECRFBQSR6PNF5FvgxESe0k4ZODYbHLpvto4JtZdzP0lkEO9A==
X-Received: by 2002:a05:6830:3687:b0:6b9:5735:d9dc with SMTP id
 bk7-20020a056830368700b006b95735d9dcmr2932100otb.14.1695208846298; 
 Wed, 20 Sep 2023 04:20:46 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:20:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 06/19] target/riscv: move 'host' CPU declaration to kvm.c
Date: Wed, 20 Sep 2023 08:20:07 -0300
Message-ID: <20230920112020.651006-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This CPU only exists if we're compiling with KVM so move it to the kvm
specific file.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c | 15 ---------------
 target/riscv/kvm.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 848b58e7c4..f8368ce274 100644
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
@@ -2041,9 +2029,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


