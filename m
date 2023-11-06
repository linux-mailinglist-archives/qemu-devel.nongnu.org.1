Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41817E1FBB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:15:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxSi-0005X4-HA; Mon, 06 Nov 2023 06:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxSf-0005T4-Sj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:05 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxSd-0004yJ-JH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:05 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso3069867f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268880; x=1699873680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMjbC2xJWHxNTrhQC1HW/27kz6qe7U3LIUpfEfCgflY=;
 b=wc/dWq27vCi614hlxzXlIAdHnViZMW4pvLIyjQaA5AWDQn6nIhEqPQ9f3afNAaOr1M
 0GxVpNeM6QiCoohTKjln9qlInYsAzllFxlc9Gc8yMPLTF2weH1yh5dbFiswHCxJlcBra
 10CEib5FCDxuVO7DeRTcm3RuYq6hQ9BA4dDLkshVQ/ZUt3BHkOJr8EzNKijV5IdgvaGR
 dHyiumD30iztTAppXRvhZQpXKkU/xzQGEkX84uRR555CVbM6ixZLtMX8bfHkjMPGQrFF
 eKd+6uyuzDUxWBmXYxjQXyrXIl29ZlnkyczdlMTll/Xt58xQ7J+WnaeEqYimkB6McILj
 v9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268880; x=1699873680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMjbC2xJWHxNTrhQC1HW/27kz6qe7U3LIUpfEfCgflY=;
 b=hc/aE5LRulAdb98fJClRfnQfIEo/UXXlxVIPMG2V82stAmtg4t43oI41fkVOnCBHq7
 1xuz6zWCC45ftBRI5LB5xTJotbYMf6Ou6c8Ft3ZpiPgvd+48ycByjhm/u//jeR8f2W2m
 Nlh4hK4f0dVxV8+dhT3wluWyFtF8tkGkgjhBmoGXon+oRGJiSI8gQXQrCk6/6uSzCi7G
 aEYTwxGjUlKEUir4zT5Pu1r3pOmU9tr9044ZKdphv+4NrMwXE5wFN5hi0CHg4KbHROe2
 ELxeTtYp8HyI6CEOjddLSj9MCWBRTtFbr/iIpb8VoIffbSzNmx2NPHbdQw0gGQlfSawZ
 wQvA==
X-Gm-Message-State: AOJu0YyEMlZsU/p8KHA7ZWoIHRsBA6uzLJEIBagxZXHtTGyUuNFB742/
 bZ9Gmzt8QVi9kewmXDokRZBCVuj+hyqiSQDKEvM=
X-Google-Smtp-Source: AGHT+IH9X2GE3xs55/ZsOwgF8AvUm+DWjmmM+7ejsJtn9NBM/K//H0bsohOzSfHKuAoPE0hD1kKuBQ==
X-Received: by 2002:a5d:47a9:0:b0:32f:96c6:8bb with SMTP id
 9-20020a5d47a9000000b0032f96c608bbmr13753845wrb.7.1699268879845; 
 Mon, 06 Nov 2023 03:07:59 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a5d5604000000b0032f78feb826sm9106145wrv.104.2023.11.06.03.07.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:07:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 38/60] hw/cpu: Call object_class_is_abstract() once in
 cpu_class_by_name()
Date: Mon,  6 Nov 2023 12:03:10 +0100
Message-ID: <20231106110336.358-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Let CPUClass::class_by_name() handlers to return abstract classes,
and filter them once in the public cpu_class_by_name() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908112235.75914-3-philmd@linaro.org>
---
 include/hw/core/cpu.h  |  7 ++++---
 hw/core/cpu-common.c   | 14 +++++++++++---
 target/alpha/cpu.c     |  3 +--
 target/arm/cpu.c       |  3 +--
 target/avr/cpu.c       |  3 +--
 target/cris/cpu.c      |  3 +--
 target/hexagon/cpu.c   |  3 +--
 target/loongarch/cpu.c |  3 +--
 target/m68k/cpu.c      |  3 +--
 target/openrisc/cpu.c  |  3 +--
 target/riscv/cpu.c     |  3 +--
 target/rx/cpu.c        |  6 +-----
 target/sh4/cpu.c       |  3 ---
 target/tricore/cpu.c   |  3 +--
 target/xtensa/cpu.c    |  3 +--
 15 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6373aa4501..5d6f8dca43 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -102,7 +102,7 @@ struct SysemuCPUOps;
 /**
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
- * instantiatable CPU type.
+ *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
@@ -772,9 +772,10 @@ void cpu_reset(CPUState *cpu);
  * @typename: The CPU base type.
  * @cpu_model: The model string without any parameters.
  *
- * Looks up a CPU #ObjectClass matching name @cpu_model.
+ * Looks up a concrete CPU #ObjectClass matching name @cpu_model.
  *
- * Returns: A #CPUClass or %NULL if not matching class is found.
+ * Returns: A concrete #CPUClass or %NULL if no matching class is found
+ *          or if the matching class is abstract.
  */
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index baa6d28b64..d4112b8919 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -146,10 +146,18 @@ static bool cpu_common_has_work(CPUState *cs)
 
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
-    CPUClass *cc = CPU_CLASS(object_class_by_name(typename));
+    ObjectClass *oc;
+    CPUClass *cc;
 
-    assert(cpu_model && cc->class_by_name);
-    return cc->class_by_name(cpu_model);
+    oc = object_class_by_name(typename);
+    cc = CPU_CLASS(oc);
+    assert(cc->class_by_name);
+    assert(cpu_model);
+    oc = cc->class_by_name(cpu_model);
+    if (oc == NULL || object_class_is_abstract(oc)) {
+        return NULL;
+    }
+    return oc;
 }
 
 static void cpu_common_parse_features(const char *typename, char *features,
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index fae2cb6ec7..39cf841b3e 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -126,8 +126,7 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
     int i;
 
     oc = object_class_by_name(cpu_model);
-    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) != NULL &&
-        !object_class_is_abstract(oc)) {
+    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) != NULL) {
         return oc;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index df6496b019..25e9d2ae7b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2401,8 +2401,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
     oc = object_class_by_name(typename);
     g_strfreev(cpuname);
     g_free(typename);
-    if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
-        object_class_is_abstract(oc)) {
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU)) {
         return NULL;
     }
     return oc;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 14d8b9d1f0..44de1e18d1 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -157,8 +157,7 @@ static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
     ObjectClass *oc;
 
     oc = object_class_by_name(cpu_model);
-    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) == NULL ||
-        object_class_is_abstract(oc)) {
+    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) == NULL) {
         oc = NULL;
     }
     return oc;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index be4a44c218..675b73ac04 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -95,8 +95,7 @@ static ObjectClass *cris_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(CRIS_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_CRIS_CPU) ||
-                       object_class_is_abstract(oc))) {
+    if (oc != NULL && !object_class_dynamic_cast(oc, TYPE_CRIS_CPU)) {
         oc = NULL;
     }
     return oc;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1adc11b713..9d1ffc3b4b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -63,8 +63,7 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
     oc = object_class_by_name(typename);
     g_strfreev(cpuname);
     g_free(typename);
-    if (!oc || !object_class_dynamic_cast(oc, TYPE_HEXAGON_CPU) ||
-        object_class_is_abstract(oc)) {
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_HEXAGON_CPU)) {
         return NULL;
     }
     return oc;
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ef1bf89dac..06d1b9bb95 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -648,8 +648,7 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
         }
     }
 
-    if (object_class_dynamic_cast(oc, TYPE_LOONGARCH_CPU)
-        && !object_class_is_abstract(oc)) {
+    if (object_class_dynamic_cast(oc, TYPE_LOONGARCH_CPU)) {
         return oc;
     }
     return NULL;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 538d9473c2..11c7e0a790 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -111,8 +111,7 @@ static ObjectClass *m68k_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(M68K_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc != NULL && (object_class_dynamic_cast(oc, TYPE_M68K_CPU) == NULL ||
-                       object_class_is_abstract(oc))) {
+    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_M68K_CPU) == NULL) {
         return NULL;
     }
     return oc;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f5a3d5273b..1173260017 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -164,8 +164,7 @@ static ObjectClass *openrisc_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(OPENRISC_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_OPENRISC_CPU) ||
-                       object_class_is_abstract(oc))) {
+    if (oc != NULL && !object_class_dynamic_cast(oc, TYPE_OPENRISC_CPU)) {
         return NULL;
     }
     return oc;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac4a6c7eec..63624e8b76 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -636,8 +636,7 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
     oc = object_class_by_name(typename);
     g_strfreev(cpuname);
     g_free(typename);
-    if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
-        object_class_is_abstract(oc)) {
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU)) {
         return NULL;
     }
     return oc;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 4d0d3a0c8c..9cc9d9d15e 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -111,16 +111,12 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
     char *typename;
 
     oc = object_class_by_name(cpu_model);
-    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) != NULL &&
-        !object_class_is_abstract(oc)) {
+    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) != NULL) {
         return oc;
     }
     typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc != NULL && object_class_is_abstract(oc)) {
-        oc = NULL;
-    }
 
     return oc;
 }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 788e41fea6..a8ec98b134 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -152,9 +152,6 @@ static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
 
     typename = g_strdup_printf(SUPERH_CPU_TYPE_NAME("%s"), s);
     oc = object_class_by_name(typename);
-    if (oc != NULL && object_class_is_abstract(oc)) {
-        oc = NULL;
-    }
 
 out:
     g_free(s);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 5ca666ee12..034e01c189 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -132,8 +132,7 @@ static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(TRICORE_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (!oc || !object_class_dynamic_cast(oc, TYPE_TRICORE_CPU) ||
-        object_class_is_abstract(oc)) {
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_TRICORE_CPU)) {
         return NULL;
     }
     return oc;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ea1dae7390..e20fe87bf2 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -141,8 +141,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc == NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU) ||
-        object_class_is_abstract(oc)) {
+    if (oc == NULL || !object_class_dynamic_cast(oc, TYPE_XTENSA_CPU)) {
         return NULL;
     }
     return oc;
-- 
2.41.0


