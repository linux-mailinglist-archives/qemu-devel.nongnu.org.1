Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B4746296
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 20:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGOMv-0002gr-5l; Mon, 03 Jul 2023 14:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOMf-0001rY-1K
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:33:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOMd-0000YY-Ey
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:33:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso48884245e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688409209; x=1691001209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/Ag52mYeMLcz5dTXyLeWb+yN0agDUVbGHXjacUVb1Y=;
 b=QimSnIr4A1evvU4JI+U4so4B40f8UdFV/ODe/OpkcB7t015M6Nu7fK0aGVd0ZmhZGc
 MvoxRWPbIMYtdn0wECSMS5x8uyuuXz0tfXDNz5pYwLWBNIUhSVS9R5Ss2n9dIPNkoRDT
 +pEyVCeQ/EoyFxYU9RwUI6YEJY3CNuK9BM3HRoNlVFH5IP33vm77CbXBlKlzadd9lrtF
 V5Iu2DdhhQ5KmWrIUylb4QRp02fcWo8WQlSsj8p58CgSkYlIg3MBOrNikWjWBj6U9Vu0
 Aj2wSqymUNEOVlXiqAHT3PrZ1iAbBTeRfrLAFgHo0ha0GFB8Tbj3omEqVRWNMAPqQAoq
 veyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688409209; x=1691001209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/Ag52mYeMLcz5dTXyLeWb+yN0agDUVbGHXjacUVb1Y=;
 b=ZE0MOW69YdlyUuN9nVQFhzM2RjpKMtSh48Iuryc0HYm/AG0zRzMtYY2vpq5V6U8BSa
 KcHAXK7XnPPBczh6tUY18oAU4tj+GS+cGPRvfdyRlIEX1kvsdTAjzVjq/LdYEZVZxiSI
 kteTX/tAK1Tj8mh062Q/3eaD/GcgSI64AaAUbA0Wudvek3/E/zrxr8wW9YGqxqGXxhOJ
 QEkLQ/j7vrQVVs3s+WeTVoKOCWfOjmwOBjUMyIaTQXVCDp/jE0np9kEBL7EuKiKwGO3E
 cthHMNeVeHG8Vtlvf18PdS/8bMYmni7at04LlI4pqQ77EXLo388lPIM293X02mIOLs6u
 CzHA==
X-Gm-Message-State: ABy/qLYDvskZJQu98wHFif8+h2uj2irrNgHEtnYaDjSyckSEdGZhJVdH
 pG5ZfrhdoDG5fnBZldC9ygjJfMFn/lyZATdonXgpDw==
X-Google-Smtp-Source: APBJJlHpVbfSsWtFxcoaY9FyHZc3FJaZzYgzvzA3ayRjWgORX4D7oxSWkhKYLfPoaL436kZSYNlgKA==
X-Received: by 2002:a05:600c:22c4:b0:3fb:d1c1:9b79 with SMTP id
 4-20020a05600c22c400b003fbd1c19b79mr5038548wmg.30.1688409209597; 
 Mon, 03 Jul 2023 11:33:29 -0700 (PDT)
Received: from localhost.localdomain ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a7bcb10000000b003fbb5142c4bsm14194043wmj.18.2023.07.03.11.33.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Jul 2023 11:33:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 15/16] target/riscv: Restrict TCG-specific prototype
 declarations
Date: Mon,  3 Jul 2023 20:31:44 +0200
Message-Id: <20230703183145.24779-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230703183145.24779-1-philmd@linaro.org>
References: <20230703183145.24779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h |  3 +++
 target/riscv/cpu.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 42bd7efe4c..ab1968deb7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -474,7 +474,10 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
+#ifdef CONFIG_TCG
 void riscv_translate_init(void);
+#endif
+
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uint32_t exception, uintptr_t pc);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cd01af3595..31ca1a4ff9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -37,7 +37,9 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
+#ifdef CONFIG_TCG
 #include "tcg/tcg.h"
+#endif
 
 /* RISC-V CPU definitions */
 
@@ -785,6 +787,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+#ifdef CONFIG_TCG
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -802,6 +805,7 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
         }
     }
 }
+#endif
 
 static bool riscv_cpu_has_work(CPUState *cs)
 {
@@ -818,6 +822,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #endif
 }
 
+#ifdef CONFIG_TCG
 static void riscv_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
@@ -840,6 +845,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     }
     env->bins = data[1];
 }
+#endif
 
 static void riscv_cpu_reset_hold(Object *obj)
 {
@@ -1871,6 +1877,8 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
+#ifdef CONFIG_TCG
+
 #include "hw/core/tcg-cpu-ops.h"
 
 static const struct TCGCPUOps riscv_tcg_ops = {
@@ -1889,6 +1897,7 @@ static const struct TCGCPUOps riscv_tcg_ops = {
     .debug_check_watchpoint = riscv_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
+#endif /* CONFIG_TCG */
 
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
@@ -1919,7 +1928,9 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
+#ifdef CONFIG_TCG
     cc->tcg_ops = &riscv_tcg_ops;
+#endif /* CONFIG_TCG */
 
     device_class_set_props(dc, riscv_cpu_properties);
 }
-- 
2.38.1


