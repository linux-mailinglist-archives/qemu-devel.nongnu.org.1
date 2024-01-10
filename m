Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E782966C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:43:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNV64-00049o-78; Wed, 10 Jan 2024 04:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNV60-00049W-Sz
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:42:00 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNV5y-0005DD-KY
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:42:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3376d424a79so2355031f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704879715; x=1705484515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvpjklloQqLJWuh5tOiXToABttFWNtQpc5qmtnSK9gc=;
 b=bAIl2vHQqvhW025PKd8WxPWP+Z96DOVu5XVUkjRZl13XM5qBstpU5rSBdrXh0WL+3T
 zgp1QgYQUTgos+uZp+bOJLwfJOYDyVYf21DP38sd/UwDwAVe9ZwnqbZetYY41lDfz/SO
 0bGDjbfPqAK63VzqWOfPaGynJMYMWpUURKYr4wGWIsdzAEVYef/xC8A02Yij3GBP2eRC
 PyW+aK0+ZOHWt6y2CQj6612zrrkcucSYFkGIRruAm+AcT5lZpK5xkhwCNP6lnOtDe1Tn
 CgbmQGOQtbCLfdVZMa2QIOGFLgief442IOvKHK0nOFzXiYE4Rn/1KcZIDMR2qmTxkq7Q
 xqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704879715; x=1705484515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvpjklloQqLJWuh5tOiXToABttFWNtQpc5qmtnSK9gc=;
 b=h4+h8iQoYxqQptiLKVuACKjNRiXAuDLpld7A+YZT4y7PlCARHG+wgoESSZqIUHucEl
 R08R3j8o24JMxuflj++50XcqxmVYs/OPrxqOHRbUQF3RJUZc4C6v2dQ3EztiQH8rIHk8
 BShnk6qyJ6mwyDK95WJ6Z3tko/o25hGwQ6nZ7VK7+lIs5W5SEm43p+9yJo3BNCZYt5Zg
 4QkFWFHJ/0JgNKlI5K27fvv9kC0qyGgbrHYIO8xE9sWrcjLkyfp5D+pxIUt+HYrwldil
 Hb04F+3R5yfDhOwcbZ1tH2GF+P1/qziT31hqFmompkBVfRbj5tzrfbOVfcsptyQiex4s
 YJ/w==
X-Gm-Message-State: AOJu0Yxzqemlfn7zKZu9I5n0+D1YANK2qqzwNfZOJ5F6rJKx5Ybtroey
 kspLL9zCYrY+CW6oisd7xAFLwQqFIAikhpgV2FKVFbKTJNk=
X-Google-Smtp-Source: AGHT+IGezTfpxI/1I9rZRhJcxRMd2jPuBQNQzmGJCSRG2XcLZup57GlLxRfK3pvZRMhmef87UFiLiA==
X-Received: by 2002:a05:6000:1181:b0:337:53d4:6b77 with SMTP id
 g1-20020a056000118100b0033753d46b77mr339210wrx.56.1704879715410; 
 Wed, 10 Jan 2024 01:41:55 -0800 (PST)
Received: from localhost.localdomain ([176.167.134.179])
 by smtp.gmail.com with ESMTPSA id
 df8-20020a5d5b88000000b003376d4248a9sm4441749wrb.71.2024.01.10.01.41.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 01:41:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 8/9a] target/loongarch: Restrict TCG-specific code
Date: Wed, 10 Jan 2024 10:41:51 +0100
Message-ID: <20240110094152.52138-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
References: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

In preparation of supporting KVM in the next commit.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
[PMD: Split from bigger patch, part 1]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 6614a094c8..d9f8661cfd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/qtest.h"
-#include "exec/cpu_ldst.h"
+#include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
@@ -20,8 +20,11 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
 #endif
-#include "tcg/tcg.h"
 #include "vec.h"
+#ifdef CONFIG_TCG
+#include "exec/cpu_ldst.h"
+#include "tcg/tcg.h"
+#endif
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -110,12 +113,13 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
-
-    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    if (tcg_enabled()) {
+        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
+        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
     }
 }
 
@@ -140,7 +144,10 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 
     return (pending & status) != 0;
 }
+#endif
 
+#ifdef CONFIG_TCG
+#ifndef CONFIG_USER_ONLY
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
@@ -322,7 +329,6 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
-#ifdef CONFIG_TCG
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
                                               const TranslationBlock *tb)
 {
@@ -560,7 +566,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
     }
 #endif
 
+#ifdef CONFIG_TCG
     restore_fp_status(env);
+#endif
     cs->exception_index = -1;
 }
 
@@ -703,8 +711,10 @@ static void loongarch_cpu_init(Object *obj)
     CPULoongArchState *env = &cpu->env;
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
+#ifdef CONFIG_TCG
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
+#endif
     memory_region_init_io(&env->system_iocsr, OBJECT(cpu), NULL,
                           env, "iocsr", UINT64_MAX);
     address_space_init(&env->address_space_iocsr, &env->system_iocsr, "IOCSR");
@@ -804,7 +814,9 @@ static struct TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+#ifdef CONFIG_TCG
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
+#endif
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
-- 
2.41.0


