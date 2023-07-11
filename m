Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A93674EE6A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:21:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCIL-0002tS-7O; Tue, 11 Jul 2023 08:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCI2-0002SW-6G
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:16:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHz-0005WW-KA
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:16:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso63851245e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077778; x=1691669778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXRL5F89g/bx9rOgMuCB2lIwE21xlqpM41j48uY4U8o=;
 b=LqOxSWHTDrMxP1hUgjuZsLgKuzZoinz2hOko7f230ADBH/xsf5bZ4jgXRxbQAeTdbq
 3wrBNtQWqM8fRcgBRX8bAYwkAQYsYMGFkUwXn7KnolYmv8nSfw8TY0UGlVar8zUaR2ah
 zjB2G2H/N+jzqxPxJ6USwIBRdxJYkq0xMWFft9atOgUh9DUFmYJtLuto7TM6QHHuXK4b
 Iy+EZNdA3TXNye8VlXCXuoDy3eFrPfICgzl+NBDintZVVs5DZlH9020cGoCkKFQLxqxB
 r84080yDCx92MtsYSPTAzpwQEiCOQs8o/FaFh993TKukU3zuzWClOCReJRNJoC6GJKew
 W7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077778; x=1691669778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXRL5F89g/bx9rOgMuCB2lIwE21xlqpM41j48uY4U8o=;
 b=XgUa2Zo9k8IAV4bvwEfw/uOSc5Rko2RoEQnlHPziNCCy0mSlKWGwJESr4VgyScpNRr
 uQ4s/TYQJ6aHOnfkAnEKbnZhJ0NApn4B99ltbLeN0kVgJvvnOj3Cpji98ByRsOZ9ErMn
 Tdc0FwjvLxSiJ3hrZqvN94Xeq3HnATXF7Z4FGKrMxmCV8JF0MPpjo8/LnRRXz+hizZWn
 b4djmnvN20H6pKspMrfnjxdBva4iX58Uu2byaZal5wNFaQknWPg28Hp1BLXgXng+xm7j
 3DE7udMi2VlMKXsj7yvgiSzK2gvCDbb7chxt4CgACiv+33nbaVen9BvFif9q34Xw+jrf
 oPOg==
X-Gm-Message-State: ABy/qLaaEqNeLrxi7+dW5TUpDvN21umKGWF9meVO0IWiUx13bQXT7IeG
 7drcYiXzIDUw6sv4HQ928Z3xL7VtwjNeIwwwkqU=
X-Google-Smtp-Source: APBJJlHoxHlsY9TUzyqOizpBhe/QIPDyl6kggJbn6BJntlDmkCDfGyKpdIDcb7CbKQ3vzffMvfow4Q==
X-Received: by 2002:a5d:4d0b:0:b0:313:e20c:b8e0 with SMTP id
 z11-20020a5d4d0b000000b00313e20cb8e0mr15656329wrt.23.1689077777843; 
 Tue, 11 Jul 2023 05:16:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adff80f000000b00313f9a0c521sm2120349wrp.107.2023.07.11.05.16.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:16:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/16] target/riscv: Restrict TCG-specific prototype
 declarations
Date: Tue, 11 Jul 2023 14:14:52 +0200
Message-Id: <20230711121453.59138-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
index 6d78e59214..d2a9764317 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -479,7 +479,10 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
+#ifdef CONFIG_TCG
 void riscv_translate_init(void);
+#endif
+
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uint32_t exception, uintptr_t pc);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 91433f3041..c96819daf7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,7 +38,9 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
+#ifdef CONFIG_TCG
 #include "tcg/tcg.h"
+#endif
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
@@ -782,6 +784,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+#ifdef CONFIG_TCG
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -799,6 +802,7 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
         }
     }
 }
+#endif
 
 static bool riscv_cpu_has_work(CPUState *cs)
 {
@@ -815,6 +819,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #endif
 }
 
+#ifdef CONFIG_TCG
 static void riscv_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
@@ -837,6 +842,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     }
     env->bins = data[1];
 }
+#endif
 
 static void riscv_cpu_reset_hold(Object *obj)
 {
@@ -1991,6 +1997,8 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
+#ifdef CONFIG_TCG
+
 #include "hw/core/tcg-cpu-ops.h"
 
 static const struct TCGCPUOps riscv_tcg_ops = {
@@ -2009,6 +2017,7 @@ static const struct TCGCPUOps riscv_tcg_ops = {
     .debug_check_watchpoint = riscv_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
+#endif /* CONFIG_TCG */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
 {
@@ -2152,7 +2161,9 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
+#ifdef CONFIG_TCG
     cc->tcg_ops = &riscv_tcg_ops;
+#endif /* CONFIG_TCG */
 
     object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
                               cpu_set_mvendorid, NULL, NULL);
-- 
2.38.1


