Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3272C29D
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fRr-0001h1-CO; Mon, 12 Jun 2023 07:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRi-0001eo-J2
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:50 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRf-0002No-Vo
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-977ed383b8aso689530966b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1686568246; x=1689160246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY/EOWJAFs/8V36IJ3eYDYCf6pvhgBY3hOGUYOAT/HA=;
 b=BAvuFuL6Lnwfjqty/UXyFee9xHyg+Qh65bbKtDZXW9xcJIRVhGXuUeD9vWU3cpNp5a
 2du10znefpmqkG7Fuv+Rasr6SMiEEInWFxq+isSdr3HuRpXGBpDvlayz7ZMFDx8vobsF
 o5x903QTckhYa7qza7W/k8j2QDZ60QxGuGhy+NvgNQMmZsB4ip8DpxsO7/bFUMMz5XAS
 JVytCM3ns/x/x0i2eOskyKxVb0WOQLbMIczOsx+lTO5KRzVOUaQ2iiL+3p9Fs8snUuYt
 vDFafHWWhOsgToA3oLqsPtThTY0MCN3Z5LbTnx5nKUNLAJxh0rq45s+w4BRmDVwDasSJ
 VvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686568246; x=1689160246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oY/EOWJAFs/8V36IJ3eYDYCf6pvhgBY3hOGUYOAT/HA=;
 b=FczKfVsAyhwzEiqcsP1kgfOo39fdSkB363u79HOIDklFIqjN1Xq0mxFdAfRbgdNCnH
 DOTIfpbL9z7RGrrznW/JPbGEmPMymMiOnstZkOPSEKR3J0nYwQUyUYxxk1El8uMe7Uus
 rEzbapKhfJkdl4G9R8CT9KGaN1egbhkEYqP2qKGdnAx10wMdjOpq3KGpMhEhbj0NAJ+i
 jGUcEIDuuKTsQzzKq/MQjnNoVUiWFiCV6hEjNd4d2uMe0xVKEemywAScJJM8ZFDPZtM4
 aVjPYkymVMilehFOgXsq7c5rxMAkvzaPOR6MHYEYKyw9S4uS95p02d+j/7N4bGmkeyCd
 gSGQ==
X-Gm-Message-State: AC+VfDxygBtevqP1pYMhvMqI1kXUDo1htVFVB4dVFm5J3aEqUPoBFdqo
 MFi+4iCnUYwU4AJVRTYmpxszWw==
X-Google-Smtp-Source: ACHHUZ6lS9kN0p+NrET4BcgAPstLhA1G8GARB/SJXhK0fBVPd37g0BC0HvPdrw/RQ3BO5bBQynLCzA==
X-Received: by 2002:a17:907:96aa:b0:96f:d8a9:d045 with SMTP id
 hd42-20020a17090796aa00b0096fd8a9d045mr10798571ejc.59.1686568246780; 
 Mon, 12 Jun 2023 04:10:46 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 w23-20020a1709064a1700b00978723f594bsm5000948eju.101.2023.06.12.04.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 04:10:46 -0700 (PDT)
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
Subject: [PATCH v2 6/8] disas/riscv: Provide infrastructure for vendor
 extensions
Date: Mon, 12 Jun 2023 13:10:32 +0200
Message-Id: <20230612111034.3955227-7-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
References: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x630.google.com
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

A previous patch provides a pointer to the RISCVCPUConfig data.
Let's use this to add the necessary code for vendor extensions.
This patch does not change the current behaviour, but clearly
defines how vendor extension support can be added to the disassembler.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 disas/riscv.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index b6789ab92a..dc3bfb0123 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4700,9 +4700,33 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
     rv_decode dec = { 0 };
     dec.pc = pc;
     dec.inst = inst;
-    dec.opcode_data = rvi_opcode_data;
     dec.cfg = cfg;
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
+    if (dec.op == rv_op_illegal) {
+        dec.opcode_data = rvi_opcode_data;
+    }
+
     decode_inst_operands(&dec, isa);
     decode_inst_decompress(&dec, isa);
     decode_inst_lift_pseudo(&dec);
-- 
2.40.1


