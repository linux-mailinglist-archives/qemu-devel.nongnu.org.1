Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E773EF30
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvWp-0006tx-Ot; Mon, 26 Jun 2023 19:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvWn-0006lt-6n
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:21:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvWk-0000L2-VQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:21:48 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b698937f85so36526831fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821705; x=1690413705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zj8kiNSf4zOVBRmaIbE7s7TNCE9jUZ9Fb7cv7kKoN8=;
 b=mUMyMdkpXZlZOkwqKRhDSRrKPzHZ4mi6GF2+P+1pEQJQLxqN9wRchyQs6vVdtXpdqj
 ezqPYqhn21ZRcOyyTlrqZylQYvFCQ88ZqNW4hgyUtmJwIdNw6TAB3CUZgr2emn4TZQrn
 t522ERmBSlqzhexXRX+9kv67BNyBywN8LBbwJmLLpdYB5BFKRO3oVcCmZxDDksX9dF6i
 yWHyplE7v/qGbJ8eB9RPK6NQfQ3Z2nY4jZBIT7F7A6qqojgktLQEu9GBoxYKAxrI1R5M
 b6/7skHVsbDgRsr9CaV3yIijIoxPLRmHf7yC/MhTCui7qCPyPjVYbuviV0q1RWOLnHLe
 ON8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821705; x=1690413705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zj8kiNSf4zOVBRmaIbE7s7TNCE9jUZ9Fb7cv7kKoN8=;
 b=afZN1uxP9fWFS2Os/jL4jDlDR90cQ0L4G0DkTCkB7KLwG00Guy0TicUOGGI4gOSonk
 MPXjmtIE1LuMLr7lj6klnshHKcGU8ppYzbuBo55u+0TVQDo48NBtYffET+x/KMYWTiIK
 WeT6PwQXRl3gba30Lx4pbVHeB13RQTH7zeBLwdP7WmvrjqA5LzDnSZAJrKb80ouKu87y
 OGXx291FUQzWA8bimr07ACQ9UlbHGspn8IE9cSINKIVgaUAuj9zucx2mqVPkBIHgFIRv
 aIR2ocjc7j0HGQ364fo7NXN8Zlk4yMEeix+H4lsW7AdW+jDu63zeVB7KLNwbSorhklID
 /E+Q==
X-Gm-Message-State: AC+VfDyZmlETSizc3mMnMlqksAb7St2cSoibPNUPVHpw8s9VsICsmXNh
 nZ5n9ejDhW7K2xkCoG2VY164syWvBfwxZDZUap4=
X-Google-Smtp-Source: ACHHUZ567FMfIYKiiz2M9olBgqdphBexRaZ9/LIUXgA+0/kuM38ER+J0hMg5gU/XkRJjXxSmK9e7zw==
X-Received: by 2002:a05:651c:102a:b0:2b6:a23c:580 with SMTP id
 w10-20020a05651c102a00b002b6a23c0580mr2169142ljm.5.1687821705062; 
 Mon, 26 Jun 2023 16:21:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 y3-20020aa7c243000000b0051bdf152295sm3247783edo.76.2023.06.26.16.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:21:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 15/16] target/riscv: Restrict TCG-specific prototype
 declarations
Date: Tue, 27 Jun 2023 01:20:06 +0200
Message-Id: <20230626232007.8933-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626232007.8933-1-philmd@linaro.org>
References: <20230626232007.8933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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
index 5945e13fe0..8f16655041 100644
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
index a1513bf5cc..2371bdd68a 100644
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
 
@@ -724,6 +726,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+#ifdef CONFIG_TCG
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -741,6 +744,7 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
         }
     }
 }
+#endif
 
 static bool riscv_cpu_has_work(CPUState *cs)
 {
@@ -757,6 +761,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #endif
 }
 
+#ifdef CONFIG_TCG
 static void riscv_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
@@ -779,6 +784,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     }
     env->bins = data[1];
 }
+#endif
 
 static void riscv_cpu_reset_hold(Object *obj)
 {
@@ -1785,6 +1791,8 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
+#ifdef CONFIG_TCG
+
 #include "hw/core/tcg-cpu-ops.h"
 
 static const struct TCGCPUOps riscv_tcg_ops = {
@@ -1803,6 +1811,7 @@ static const struct TCGCPUOps riscv_tcg_ops = {
     .debug_check_watchpoint = riscv_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
+#endif /* CONFIG_TCG */
 
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
@@ -1833,7 +1842,9 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
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


