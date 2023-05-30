Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86971617B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zGJ-0002NF-3y; Tue, 30 May 2023 09:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFf-00021A-LQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:04 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFb-0006sq-Ua
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:02 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9741a0fd134so173929566b.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1685452736; x=1688044736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kKhfZuUHvptmbGv0BOJ1F+/oC8QuzwjZAu+Iu7mwvY=;
 b=XHVnTBh+GAagI1yXqCYh2TUH59DiYf9qIt5dpWKvkBL29q1CIPbyK6XqSVYzDQSXCK
 6SO/z61l7PpGOEJobtshKxZ0yVxFkcQzGIN12xGW5KHmLSAAdGl424/dP/Xb2zLR+kH7
 xjJraK4FdoBiW0n2v3T4niNmJHwomQ+qkneokFExpr+WNOx7vZqgAOgRsOLtg5D00Ik0
 DLMA8Y4fZX7zaNj+a3eN1utz18bLIzXJz9PGBo2AEETHXHCk4AyeiqGTerN9ljYn2biP
 aoWXYm5Geox81Xeun/sKA0nanaZ+80kFubuDsd/ugroSYJbM5qkhR+wi4yJBrq6/jf3g
 pwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452736; x=1688044736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kKhfZuUHvptmbGv0BOJ1F+/oC8QuzwjZAu+Iu7mwvY=;
 b=D9S5ntBHtuWwYkUXvNQLLUPWGVZ+xEr8Sy8x0o3N+/kPQtS7vI8+ILwfnk8LUPK/hE
 rhUt1JLLWWhSLUr78JNbJapuZepvhktJSwCVIY4l25YL8//mj5lYsbXLgFbAuqkE3iK3
 0LdmZ8qomnzD/0YXQVdyqgf3MKHkZEv7lSt9dj7eWWU5pDCvnVNcGsD3pv/FtSPhgb6D
 MO2lvBZw0fgzYreX11Bg5Y7qSe3qwzGqovPLELsZK5kDoAXg8UrMpb2lXPDPVYrUAJrm
 a9TlLAbOhkdlxHzpdMVeol4D2FITl7LjO2e3Ay4ZUL9ZE/+iWfhDQCklv0ua1V29lHZK
 cBEg==
X-Gm-Message-State: AC+VfDxnRdoYKNB4TjC4zpmpkIf+jTVh5RuPfW1EZY8AAIESPQzVwGcA
 5CX1g6TD3tvyK039SPIF/kjExt2+yaFXK4Wa67M=
X-Google-Smtp-Source: ACHHUZ78d8OpCqwYjRhQvjRwtAijmane9j2qJKMcEjYHs5T+I4Ul2vkLMDwNKgVVrSVylK9//4AseA==
X-Received: by 2002:a17:906:6a02:b0:96a:3f29:40d9 with SMTP id
 qw2-20020a1709066a0200b0096a3f2940d9mr2550517ejc.25.1685452735990; 
 Tue, 30 May 2023 06:18:55 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170907170800b0096f803afbe3sm7376156ejc.66.2023.05.30.06.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:18:55 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 7/9] disas/riscv: Provide infrastructure for vendor extensions
Date: Tue, 30 May 2023 15:18:41 +0200
Message-Id: <20230530131843.1186637-8-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x62d.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

A previous patch provides a pointer to the RISCVCPUConfig data.
Let's use this to add the necessary code for vendor extensions.
This patch does not change the current behaviour, but clearly
defines how vendor extension support can be added to the disassembler.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 disas/riscv.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 086edee6a2..db98e3ea6a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
 #include "disas/riscv.h"
+#include "target/riscv/cpu-config.h"
 
 typedef enum {
     /* 0 is reserved for rv_op_illegal. */
@@ -4599,13 +4600,38 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 /* disassemble instruction */
 
 static void
-disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst)
+disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
+            struct disassemble_info *info)
 {
+    RISCVCPUConfig *cfg = info->private_data;
     rv_decode dec = { 0 };
     dec.pc = pc;
     dec.inst = inst;
-    dec.opcode_data = rvi_opcode_data;
-    decode_inst_opcode(&dec, isa);
+
+    static const struct {
+        bool (*guard_func)(const RISCVCPUConfig *);
+        const rv_opcode_data *opcode_data;
+        void (*decode_func)(rv_decode *, rv_isa);
+    } decoders[] = {
+        { always_true_p, rvi_opcode_data, decode_inst_opcode },
+    };
+
+    for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
+        bool (*guard_func)(const RISCVCPUConfig *) = decoders[i].guard_func;
+        const rv_opcode_data *opcode_data = decoders[i].opcode_data;
+        void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
+
+        if (guard_func(cfg)) {
+            dec.opcode_data = opcode_data;
+            decode_func(&dec, isa);
+            if (dec.op != rv_op_illegal)
+                break;
+        }
+    }
+
+    if (dec.op == rv_op_illegal)
+        dec.opcode_data = rvi_opcode_data;
+
     decode_inst_operands(&dec, isa);
     decode_inst_decompress(&dec, isa);
     decode_inst_lift_pseudo(&dec);
@@ -4659,7 +4685,7 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         break;
     }
 
-    disasm_inst(buf, sizeof(buf), isa, memaddr, inst);
+    disasm_inst(buf, sizeof(buf), isa, memaddr, inst, info);
     (*info->fprintf_func)(info->stream, "%s", buf);
 
     return len;
-- 
2.40.1


