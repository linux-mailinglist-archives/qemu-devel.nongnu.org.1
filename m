Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2A7ADE43
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpq2-0000dB-NC; Mon, 25 Sep 2023 13:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppz-0000cg-2F
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:40 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppw-0002Bs-Uv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:38 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27763d36661so1501931a91.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664654; x=1696269454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIlNvKVe9OTA8egt3cf/svUMIvB2+X3kSHOpaS7W4Ek=;
 b=XKXEI1jc6N1hzE1Z+zh9EPwHn/+YkiH8vrTRqzmv2nBIdwOu0fX3YsK40LSCzmPBrn
 JE6ny6tgLSxbg0aInf2uThzCA+FHgtBiLyyrlSNVZV1ZdQxR9/gzHp8fqtQT/oBUIgcY
 /2/kzTJhpSeVBLr8SDB3IwSQhlLJtOfhzA9PrXlidUyIe90qIncF1wpDe7UL8r3yPTh0
 S+rRl8UJ0pPJXuLUqbFToB7vWMXsKqQRRlACzAPN0k3TgDXLlsHApfnVvOIztce5BrIE
 FvGGTJRALyZ0S+IR6IxY9fsgLsoCqy0cJCHJEbz5EG+f3xdu1ktFcbWFfp13KqxJBi+N
 SL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664654; x=1696269454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIlNvKVe9OTA8egt3cf/svUMIvB2+X3kSHOpaS7W4Ek=;
 b=X/mWOUk6RYMYN0pHVFqV2EPG186mAbesNHIkKl33zJD+QHJXBkCMrWp/4+JgC5vpaH
 nu6G7sZeeChmvgr7PSKLEUwgL7Gb0BvWnb0Q3dVWgGb/NH6mcf8QXPEGXz1nUWZlcSnk
 AjlCcf15+HxS4wHgshqPPUAtLdWp6VoD/XU/Cx5VZh17yO4JXwVd3JRAN3ofgzMQyL11
 ymCWZXHPcS2hbYLXkiaNmEkYZSs05vYd2y1tz9Twkv2lujXZUb4K5IUOYRyOzHXxeJqT
 2zdjh95d/abZ68c+YlCgDwMVGWQ8cEvZAW6XAGV9xiX11DeTF2GqZPTLa039OOySvdgN
 qaGg==
X-Gm-Message-State: AOJu0Yzvoa3rdCc1TcQi3uCs7ZheFkWT3+gZ0uBMeZEM6GgL9e7a1kzv
 KACu+4ARWx/I19LUurslHaQNE6AEuVAZ6mPSemc=
X-Google-Smtp-Source: AGHT+IFCx45lTshLhjQezFzfkqdu8K2pLDRu29JA/8ySPRDFvR6+wTjsz5fZrInb0uYM8UqGQC1Lqw==
X-Received: by 2002:a17:90b:3a92:b0:273:cec7:23ee with SMTP id
 om18-20020a17090b3a9200b00273cec723eemr6533788pjb.37.1695664654368; 
 Mon, 25 Sep 2023 10:57:34 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 06/19] target/riscv: move 'host' CPU declaration to kvm.c
Date: Mon, 25 Sep 2023 14:56:56 -0300
Message-ID: <20230925175709.35696-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


