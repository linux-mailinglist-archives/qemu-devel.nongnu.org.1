Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8DB72C293
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fRz-0001iQ-F0; Mon, 12 Jun 2023 07:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRj-0001fU-Tu
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRh-0002O0-VF
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51868eb05ecso116478a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1686568248; x=1689160248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkAMEVyzwX3r13VSEWNYe54HokbN7timc+0PXlgn+kE=;
 b=TYSMtQzVP5nXio2f8BInzekLu0UL/yVfbko66xF0p+Dt4sbZsHHYeFPKFZf4zVUTcr
 0EYG/LGpk07UY8P453jhawl67SSA342Xr2dnh3m7CQRf/S+/8COb6UMsRBG+6hJ2WDRp
 WonaU+Cp2ji+sPwD7SOVimDYkdA9/ARvJqudHJJniq/iIGfL+L5EIjCuXcW1Q57U2ZfS
 58Soc3JYb+dD5kOnxU2vKosOpwD+j5biRP0TEYoZZcX/njUI8GFEEWZpVI2FPeoLilY8
 b+VAsXkGoqo7/ohBjRuzoHQGMIVcj8Y/hQXPI5BgsQ+nB9PboagcPAU3uloEEuFKnV1D
 XkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686568248; x=1689160248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkAMEVyzwX3r13VSEWNYe54HokbN7timc+0PXlgn+kE=;
 b=CHVUxVaS2wP4GdVmQRapG+iYN//XcCI3+XIFKs8ZtmaNhQbpj0VdxsMqRwxc90PTaX
 LxzzrVXQDeBHSH0Kv7aGM5Zw1eGsVPKH7Z4X9bQLIXttoR3sPQT42ieP6vOpH0FrS4Hi
 QnaqlnAfRekIDAwna2O1lZuf6FsxAwDebSCpauECub4IA6GT6xPYyirRPFYGnbZss7BD
 uulGaJjA9LxIjsfBZZQNOP0ZqXpa4KOFnklwC2/7aZE+oQT/Z7FDzTGSp75AO3yRU/Lx
 FoRE3+18ylmFIUE4lNzEo65YaqZqmfzplJmoOwv/bWczIOm0fuhzf8QPk8TjqdDUP9a4
 v6Ug==
X-Gm-Message-State: AC+VfDyFB2WnLjjxE2UXeR8XqZ0QVCTTGZTJE7e60XohRBwPDmowXKKx
 DkcXeGeVYDTwRsheFLImJ3985A==
X-Google-Smtp-Source: ACHHUZ5hbqMo0LbuNitEe5qWzeqTmyAZtxIVLtxtkObu6tmhkRH7RGtCg9ZoOmpgOoI7KngnwkJXFg==
X-Received: by 2002:a17:907:3181:b0:96f:f451:187f with SMTP id
 xe1-20020a170907318100b0096ff451187fmr8784553ejb.7.1686568248431; 
 Mon, 12 Jun 2023 04:10:48 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 w23-20020a1709064a1700b00978723f594bsm5000948eju.101.2023.06.12.04.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 04:10:47 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v2 7/8] disas/riscv: Add support for XVentanaCondOps
Date: Mon, 12 Jun 2023 13:10:33 +0200
Message-Id: <20230612111034.3955227-8-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
References: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x52c.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

This patch adds XVentanaCondOps support to the RISC-V disassembler.

Co-developed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 disas/meson.build      |  5 ++++-
 disas/riscv-xventana.c | 41 +++++++++++++++++++++++++++++++++++++++++
 disas/riscv-xventana.h | 18 ++++++++++++++++++
 disas/riscv.c          |  4 ++++
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 disas/riscv-xventana.c
 create mode 100644 disas/riscv-xventana.h

diff --git a/disas/meson.build b/disas/meson.build
index 832727e4b3..e0ee326411 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -6,7 +6,10 @@ common_ss.add(when: 'CONFIG_M68K_DIS', if_true: files('m68k.c'))
 common_ss.add(when: 'CONFIG_MICROBLAZE_DIS', if_true: files('microblaze.c'))
 common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mips.c', 'nanomips.c'))
 common_ss.add(when: 'CONFIG_NIOS2_DIS', if_true: files('nios2.c'))
-common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files('riscv.c'))
+common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
+    'riscv.c',
+    'riscv-xventana.c'
+))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
 common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa.c'))
diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
new file mode 100644
index 0000000000..a0224d1fb3
--- /dev/null
+++ b/disas/riscv-xventana.c
@@ -0,0 +1,41 @@
+/*
+ * QEMU RISC-V Disassembler for xventana.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "disas/riscv.h"
+#include "disas/riscv-xventana.h"
+
+typedef enum {
+    /* 0 is reserved for rv_op_illegal. */
+    ventana_op_vt_maskc = 1,
+    ventana_op_vt_maskcn = 2,
+} rv_ventana_op;
+
+const rv_opcode_data ventana_opcode_data[] = {
+    { "vt.illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
+    { "vt.maskc", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "vt.maskcn", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+};
+
+void decode_xventanacondops(rv_decode *dec, rv_isa isa)
+{
+    rv_inst inst = dec->inst;
+    rv_opcode op = rv_op_illegal;
+
+    switch (((inst >> 0) & 0b11)) {
+    case 3:
+        switch (((inst >> 2) & 0b11111)) {
+        case 30:
+            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
+            case 6: op = ventana_op_vt_maskc; break;
+            case 7: op = ventana_op_vt_maskcn; break;
+            }
+            break;
+        }
+        break;
+    }
+
+    dec->op = op;
+}
diff --git a/disas/riscv-xventana.h b/disas/riscv-xventana.h
new file mode 100644
index 0000000000..72be9ffa16
--- /dev/null
+++ b/disas/riscv-xventana.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU disassembler -- RISC-V specific header (xventana*).
+ *
+ * Copyright (c) 2023 VRULL GmbH
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_XVENTANA_H
+#define DISAS_RISCV_XVENTANA_H
+
+#include "disas/riscv.h"
+
+extern const rv_opcode_data ventana_opcode_data[];
+
+void decode_xventanacondops(rv_decode*, rv_isa);
+
+#endif /* DISAS_RISCV_XVENTANA_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index dc3bfb0123..c7bfd4ed32 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -22,6 +22,9 @@
 #include "target/riscv/cpu_cfg.h"
 #include "disas/riscv.h"
 
+/* Vendor extensions */
+#include "disas/riscv-xventana.h"
+
 typedef enum {
     /* 0 is reserved for rv_op_illegal. */
     rv_op_lui = 1,
@@ -4708,6 +4711,7 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
         void (*decode_func)(rv_decode *, rv_isa);
     } decoders[] = {
         { always_true_p, rvi_opcode_data, decode_inst_opcode },
+        { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
     };
 
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
-- 
2.40.1


