Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EECA74D5B7
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4c-0000W8-Tq; Mon, 10 Jul 2023 08:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4N-0008Uz-N0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4L-0002zF-A8
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:47 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2657d405ad5so2637495a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992363; x=1691584363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNWqFc570pVUFrMCEtWAqb27ZhyUZK3muLfCFxlvijs=;
 b=balHlrJy41s5/PZJRQfwJzXYCZRduLYCe34uZZBEQ8qAldYi6SRrcvR6y4r85MRnys
 MkZEswHGd83ypCztCR/szOUTBh1ES9y3p/uJgwAeqV7d8KXIELPQb0f8PmJWsWFSE4Bb
 SiY6CHnXmFTFZFQx8l/5QqnGqeF8VrG8TYqoxsqeI2VfPkxsrXe7o+TRHAKH4hMnrFVS
 xOrsVQtG4KtYwNYFb20y2Wlq8IRuqjoo8bcqo7ksra4B6fCctq2xQzTPfiSdJtg4UTHg
 JMfzLUtr/Oe0x/UxPBBpOub6K+sbGDlFt2RkAs4+LELVLkQhB7xc65mMD8L0IVz71yqD
 9etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992363; x=1691584363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNWqFc570pVUFrMCEtWAqb27ZhyUZK3muLfCFxlvijs=;
 b=JpVbQ+saaArc6EumnBQO42qkTv1OmsnW+F+YT+eLZFSpoq8JEnM7ard3BvyGvfb7iP
 be8iyOyyjIRfXZnHPSyeReiblyfO8L6g8aoHvW/EZQPjMymz9O732P59pjvQf9KSze1T
 7k68587U7vmJHV08WdogV7l3mHBxPCQcSbXXKP8WO/Wuzfjg4DXGhTygFwfGoQm0pywS
 14d99bA0rQbJpL+BFaJFsrRMgk04QAFadzkHkUSdyENM31xLUwsmHC3+AWWJpWtPEifu
 QLG/tWl3ozxPYqQGYDm/HI2aKTI7gJZSCqUCdEQPQ5pw7PJIzMqoiAFTyfrNCvXVHnZa
 wvJw==
X-Gm-Message-State: ABy/qLaGE7t8dFjwUAv6JfSilmjrPQqGU+BAq8+qlethFbir0PHEjpAR
 u8v2M9WfoSyZrP/hbKvhGuileZzz2wUHUg==
X-Google-Smtp-Source: APBJJlGJysRavq583xvaVbWouwR7Rsw6TD8ewC5eyGqkC93sr3d/GVMf8onS0n/MfnQEe1gwSlmMoQ==
X-Received: by 2002:a17:90b:34e:b0:262:ffc4:be7 with SMTP id
 fh14-20020a17090b034e00b00262ffc40be7mr12777128pjb.37.1688992363535; 
 Mon, 10 Jul 2023 05:32:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 07/54] disas/riscv: Add support for XVentanaCondOps
Date: Mon, 10 Jul 2023 22:31:18 +1000
Message-Id: <20230710123205.2441106-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230612111034.3955227-8-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xventana.h | 18 ++++++++++++++++++
 disas/riscv-xventana.c | 41 +++++++++++++++++++++++++++++++++++++++++
 disas/riscv.c          |  4 ++++
 disas/meson.build      |  5 ++++-
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 disas/riscv-xventana.h
 create mode 100644 disas/riscv-xventana.c

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
diff --git a/disas/meson.build b/disas/meson.build
index 3a480eb9f8..f2b21e120f 100644
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
-- 
2.40.1


