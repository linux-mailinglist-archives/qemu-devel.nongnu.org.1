Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19875A156D7
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 19:35:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1n-0003tz-VX; Fri, 17 Jan 2025 13:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1l-0003tT-MQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:05 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1i-0007dj-CH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:05 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso45791925ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138300; x=1737743100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NVJG2bsQGfiTlauYkPfoYl9GjxI4oxR+grahJAAroQ=;
 b=VtRDn1H83P8PP0huwIgUNqtZs32sOhBjXpt5ZuP0VemT2MS1Z5SsNHbur6d4OxdyKO
 +qTFnoikSBVsNRvNG2J9mbtVN/KJAggz+6JSAlefpTWVRPZIrlOnM0w4EsYCpW6Ni3Pn
 CNstNGK9YZ/uqLI4uGN0aLL6rE4Dh0XVPk+uL7oP0qCc2IbPkw/RaTdZA6wNDc0iYLmt
 nptr6Ky/9l3uC+KuMIgNJhsvgNFhpgVwo2C9dE44jruXJkFD4BPz4AYB4R6tdQnJqwH/
 diFvycbrecuq5riOtOQHiHCmlTRCsKUyYqXgBqRSZzmzD/R8xM5o4nauOkFyX8aYtk9o
 cOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138300; x=1737743100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NVJG2bsQGfiTlauYkPfoYl9GjxI4oxR+grahJAAroQ=;
 b=eZKlO82B7ECUdlBJQP6DAsv4p19J1FM/YWWXdSzGnus1RgrnyFoVI4kljN+wg1bbTo
 mMbr/Po/HZQ0uFJiYKGRAeVe9w0C6ADcrow4Wy7Nh6NiyLtnV3HtFnlEljIOLzhOhy+E
 +CdGRpNCiXcQ6vZF/i4Wi87fcfCbN9MYIrVbxUKozsqXtqEBcOIsbDmU4awtHL8HXYFy
 L2StLD1RrZOuRU4f6D69fke89LhaKySi30s4Z05zyo4If/wMxfyCAD1ra2MhOhQRrX/D
 Y2fbohrXxitVqDxOKqOnbJI0mqKHsXDdX+ca++EhjWSepn7Q8lbLd0zSJIQVwIbm4vgC
 rlpg==
X-Gm-Message-State: AOJu0YwMPNJFLYOPbZpaF4xAQwuMi63xBWA1GlMIqYMpbQ26KPUD/8r7
 /R/T3DeVZNPX/WQQlZNlmBq0nI1lKmDOOvzah2m4VPhFfMppzA9pU7iKNhaboDMs46FYMr+GSzW
 S
X-Gm-Gg: ASbGncuHzs8mLouvhYOyW5zPmndAI9yV+63NyX4xf55A4qTh/BeTQdsOeVNtQFVnJ7d
 5BZtL4104+qyWErTrWxRypNNHij0RQoVLS26agC7lt98kTLZtEUsjBYRXzwNkXB0F4oW01B6/od
 OIC6kqD+jHhywuQJnT6A3tcrrRjZOykPuKcov418q9vsKzIqoaOPH06RKaByuSAsMhQ/plApniZ
 ybskgKJ8PvVJ1n8HPEBrLfpaEbYti4KcIQsiNlD6010I2QLpc7RL8Y0Drvvl0Ay2Qh9v9L2kxYT
 TAUFxmkKa6+Nelg=
X-Google-Smtp-Source: AGHT+IFbEckj5d144UPxlhnQQ6+TCPjB3C0FseXde8vwRli3ZX0jAdSMdu/i2efT8Vq3w3O0d4Vwog==
X-Received: by 2002:a17:902:e751:b0:215:9d29:9724 with SMTP id
 d9443c01a7336-21c355c6146mr58886345ad.38.1737138300428; 
 Fri, 17 Jan 2025 10:25:00 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/68] tcg: Replace TCGOP_VECL with TCGOP_TYPE
Date: Fri, 17 Jan 2025 10:23:51 -0800
Message-ID: <20250117182456.2077110-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the replacement, drop the TCGType - TCG_TYPE_V64 adjustment,
except for the call to tcg_out_vec_op.  Pass type to tcg_gen_op[1-6],
so that all integer opcodes gain the type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      |   2 +-
 tcg/tcg-internal.h     |  13 ++---
 tcg/optimize.c         |  10 +---
 tcg/tcg-op-ldst.c      |  26 ++++++----
 tcg/tcg-op-vec.c       |   8 +--
 tcg/tcg-op.c           | 113 +++++++++++++++++++++++------------------
 tcg/tcg.c              |  11 ++--
 docs/devel/tcg-ops.rst |  15 +++---
 8 files changed, 105 insertions(+), 93 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a77ed12b9d..fe053296ac 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -439,7 +439,7 @@ struct TCGOp {
 #define TCGOP_CALLI(X)    (X)->param1
 #define TCGOP_CALLO(X)    (X)->param2
 
-#define TCGOP_VECL(X)     (X)->param1
+#define TCGOP_TYPE(X)     (X)->param1
 #define TCGOP_VECE(X)     (X)->param2
 
 /* Make sure operands fit in the bitfields above.  */
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 8099248076..072b36d85c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -92,12 +92,13 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
  */
 TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
 
-TCGOp *tcg_gen_op1(TCGOpcode, TCGArg);
-TCGOp *tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
-TCGOp *tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op1(TCGOpcode, TCGType, TCGArg);
+TCGOp *tcg_gen_op2(TCGOpcode, TCGType, TCGArg, TCGArg);
+TCGOp *tcg_gen_op3(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op4(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op5(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op6(TCGOpcode, TCGType, TCGArg, TCGArg,
+                   TCGArg, TCGArg, TCGArg, TCGArg);
 
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
diff --git a/tcg/optimize.c b/tcg/optimize.c
index c23f0d1392..6823569ee2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -370,7 +370,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
-        /* TCGOP_VECL and TCGOP_VECE remain unchanged.  */
+        /* TCGOP_TYPE and TCGOP_VECE remain unchanged.  */
         new_op = INDEX_op_mov_vec;
         break;
     default:
@@ -2866,13 +2866,7 @@ void tcg_optimize(TCGContext *s)
         copy_propagate(&ctx, op, def->nb_oargs, def->nb_iargs);
 
         /* Pre-compute the type of the operation. */
-        if (def->flags & TCG_OPF_VECTOR) {
-            ctx.type = TCG_TYPE_V64 + TCGOP_VECL(op);
-        } else if (def->flags & TCG_OPF_64BIT) {
-            ctx.type = TCG_TYPE_I64;
-        } else {
-            ctx.type = TCG_TYPE_I32;
-        }
+        ctx.type = TCGOP_TYPE(op);
 
         /*
          * Process each opcode.
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index a318011229..0d8fe3b4f5 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -87,14 +87,15 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
     return op;
 }
 
-static void gen_ldst(TCGOpcode opc, TCGTemp *vl, TCGTemp *vh,
+static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
                      TCGTemp *addr, MemOpIdx oi)
 {
     if (TCG_TARGET_REG_BITS == 64 || tcg_ctx->addr_type == TCG_TYPE_I32) {
         if (vh) {
-            tcg_gen_op4(opc, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
+            tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
+                        temp_arg(addr), oi);
         } else {
-            tcg_gen_op3(opc, temp_arg(vl), temp_arg(addr), oi);
+            tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
         }
     } else {
         /* See TCGV_LOW/HIGH. */
@@ -102,10 +103,11 @@ static void gen_ldst(TCGOpcode opc, TCGTemp *vl, TCGTemp *vh,
         TCGTemp *ah = addr + !HOST_BIG_ENDIAN;
 
         if (vh) {
-            tcg_gen_op5(opc, temp_arg(vl), temp_arg(vh),
+            tcg_gen_op5(opc, type, temp_arg(vl), temp_arg(vh),
                         temp_arg(al), temp_arg(ah), oi);
         } else {
-            tcg_gen_op4(opc, temp_arg(vl), temp_arg(al), temp_arg(ah), oi);
+            tcg_gen_op4(opc, type, temp_arg(vl),
+                        temp_arg(al), temp_arg(ah), oi);
         }
     }
 }
@@ -115,9 +117,9 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
     if (TCG_TARGET_REG_BITS == 32) {
         TCGTemp *vl = tcgv_i32_temp(TCGV_LOW(v));
         TCGTemp *vh = tcgv_i32_temp(TCGV_HIGH(v));
-        gen_ldst(opc, vl, vh, addr, oi);
+        gen_ldst(opc, TCG_TYPE_I64, vl, vh, addr, oi);
     } else {
-        gen_ldst(opc, tcgv_i64_temp(v), NULL, addr, oi);
+        gen_ldst(opc, TCG_TYPE_I64, tcgv_i64_temp(v), NULL, addr, oi);
     }
 }
 
@@ -250,7 +252,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     } else {
         opc = INDEX_op_qemu_ld_a64_i32;
     }
-    gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
 
@@ -319,7 +321,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
             opc = INDEX_op_qemu_st_a64_i32;
         }
     }
-    gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
@@ -590,7 +592,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
         } else {
             opc = INDEX_op_qemu_ld_a64_i128;
         }
-        gen_ldst(opc, tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+        gen_ldst(opc, TCG_TYPE_I128, tcgv_i64_temp(lo),
+                 tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -710,7 +713,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
         } else {
             opc = INDEX_op_qemu_st_a64_i128;
         }
-        gen_ldst(opc, tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+        gen_ldst(opc, TCG_TYPE_I128, tcgv_i64_temp(lo),
+                 tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index d4bb4aee74..364cd089df 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -143,7 +143,7 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
 void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
 {
     TCGOp *op = tcg_emit_op(opc, 2);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_TYPE(op) = type;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
@@ -153,7 +153,7 @@ void vec_gen_3(TCGOpcode opc, TCGType type, unsigned vece,
                TCGArg r, TCGArg a, TCGArg b)
 {
     TCGOp *op = tcg_emit_op(opc, 3);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_TYPE(op) = type;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
@@ -164,7 +164,7 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
                TCGArg r, TCGArg a, TCGArg b, TCGArg c)
 {
     TCGOp *op = tcg_emit_op(opc, 4);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_TYPE(op) = type;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
@@ -176,7 +176,7 @@ void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
-    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_TYPE(op) = type;
     TCGOP_VECE(op) = vece;
     op->args[0] = r;
     op->args[1] = a;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4a7e705367..872fb22ef8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -37,34 +37,39 @@
  */
 #define NI  __attribute__((noinline))
 
-TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
+TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGType type, TCGArg a1)
 {
     TCGOp *op = tcg_emit_op(opc, 1);
+    TCGOP_TYPE(op) = type;
     op->args[0] = a1;
     return op;
 }
 
-TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
+TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2)
 {
     TCGOp *op = tcg_emit_op(opc, 2);
+    TCGOP_TYPE(op) = type;
     op->args[0] = a1;
     op->args[1] = a2;
     return op;
 }
 
-TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
+TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGType type, TCGArg a1,
+                       TCGArg a2, TCGArg a3)
 {
     TCGOp *op = tcg_emit_op(opc, 3);
+    TCGOP_TYPE(op) = type;
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
     return op;
 }
 
-TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
+TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
                        TCGArg a3, TCGArg a4)
 {
     TCGOp *op = tcg_emit_op(opc, 4);
+    TCGOP_TYPE(op) = type;
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -72,10 +77,11 @@ TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
     return op;
 }
 
-TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
+TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
                        TCGArg a3, TCGArg a4, TCGArg a5)
 {
     TCGOp *op = tcg_emit_op(opc, 5);
+    TCGOP_TYPE(op) = type;
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -84,10 +90,11 @@ TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
     return op;
 }
 
-TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                       TCGArg a4, TCGArg a5, TCGArg a6)
+TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
+                       TCGArg a3, TCGArg a4, TCGArg a5, TCGArg a6)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
+    TCGOP_TYPE(op) = type;
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -107,132 +114,138 @@ TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
 # define DNI
 #endif
 
-static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
+static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGType type, TCGv_i32 a1)
 {
-    tcg_gen_op1(opc, tcgv_i32_arg(a1));
+    tcg_gen_op1(opc, type, tcgv_i32_arg(a1));
 }
 
-static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
+static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGType type, TCGv_i64 a1)
 {
-    tcg_gen_op1(opc, tcgv_i64_arg(a1));
+    tcg_gen_op1(opc, type, tcgv_i64_arg(a1));
 }
 
-static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
 {
-    return tcg_gen_op1(opc, a1);
+    return tcg_gen_op1(opc, type, a1);
 }
 
 static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
-    tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
+    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
 }
 
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
-    tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
+    tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
 static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
                                 TCGv_i32 a2, TCGv_i32 a3)
 {
-    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
+    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1),
+                tcgv_i32_arg(a2), tcgv_i32_arg(a3));
 }
 
 static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                 TCGv_i64 a2, TCGv_i64 a3)
 {
-    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
+    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1),
+                tcgv_i64_arg(a2), tcgv_i64_arg(a3));
 }
 
 static void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
                                  TCGv_i32 a2, TCGArg a3)
 {
-    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
+    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
 }
 
 static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
                                  TCGv_i64 a2, TCGArg a3)
 {
-    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
+    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
 static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
                                     TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
+    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
+                tcgv_ptr_arg(base), offset);
 }
 
 static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                     TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
+    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(val),
+                tcgv_ptr_arg(base), offset);
 }
 
 static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                 TCGv_i32 a3, TCGv_i32 a4)
 {
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4));
 }
 
 static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                 TCGv_i64 a3, TCGv_i64 a4)
 {
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
 static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                  TCGv_i32 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4);
 }
 
 static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                  TCGv_i64 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4);
 }
 
 static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    return tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, TCG_TYPE_I32,
+                       tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
 static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    return tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, TCG_TYPE_I64,
+                       tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
 static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                 TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
 }
 
 static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                 TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
 }
 
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4, a5);
 }
 
 static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                   TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4, a5);
 }
 
@@ -240,7 +253,7 @@ static void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                 TCGv_i32 a3, TCGv_i32 a4,
                                 TCGv_i32 a5, TCGv_i32 a6)
 {
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
                 tcgv_i32_arg(a6));
 }
@@ -249,7 +262,7 @@ static void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                 TCGv_i64 a3, TCGv_i64 a4,
                                 TCGv_i64 a5, TCGv_i64 a6)
 {
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
                 tcgv_i64_arg(a6));
 }
@@ -258,7 +271,7 @@ static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                  TCGv_i32 a3, TCGv_i32 a4,
                                  TCGv_i32 a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
 }
 
@@ -266,7 +279,7 @@ static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                  TCGv_i64 a3, TCGv_i64 a4,
                                  TCGv_i64 a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
@@ -274,7 +287,7 @@ static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGv_i32 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    return tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    return tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                        tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
@@ -283,7 +296,7 @@ static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
 void gen_set_label(TCGLabel *l)
 {
     l->present = 1;
-    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
+    tcg_gen_op1(INDEX_op_set_label, 0, label_arg(l));
 }
 
 static void add_as_label_use(TCGLabel *l, TCGOp *op)
@@ -296,7 +309,7 @@ static void add_as_label_use(TCGLabel *l, TCGOp *op)
 
 void tcg_gen_br(TCGLabel *l)
 {
-    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, label_arg(l)));
+    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, 0, label_arg(l)));
 }
 
 void tcg_gen_mb(TCGBar mb_type)
@@ -314,25 +327,25 @@ void tcg_gen_mb(TCGBar mb_type)
 #endif
 
     if (parallel) {
-        tcg_gen_op1(INDEX_op_mb, mb_type);
+        tcg_gen_op1(INDEX_op_mb, 0, mb_type);
     }
 }
 
 void tcg_gen_plugin_cb(unsigned from)
 {
-    tcg_gen_op1(INDEX_op_plugin_cb, from);
+    tcg_gen_op1(INDEX_op_plugin_cb, 0, from);
 }
 
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 {
-    tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
+    tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
 {
-    tcg_gen_op1_i32(INDEX_op_discard, arg);
+    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
 void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
@@ -1467,7 +1480,7 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_discard_i64(TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op1_i64(INDEX_op_discard, arg);
+        tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
     } else {
         tcg_gen_discard_i32(TCGV_LOW(arg));
         tcg_gen_discard_i32(TCGV_HIGH(arg));
@@ -3156,7 +3169,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
     } else if (TCG_TARGET_HAS_extr_i64_i32) {
-        tcg_gen_op2(INDEX_op_extrl_i64_i32,
+        tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
         tcg_gen_mov_i32(ret, (TCGv_i32)arg);
@@ -3168,7 +3181,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
     } else if (TCG_TARGET_HAS_extr_i64_i32) {
-        tcg_gen_op2(INDEX_op_extrh_i64_i32,
+        tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
@@ -3184,7 +3197,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
     } else {
-        tcg_gen_op2(INDEX_op_extu_i32_i64,
+        tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
                     tcgv_i64_arg(ret), tcgv_i32_arg(arg));
     }
 }
@@ -3195,7 +3208,7 @@ void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
     } else {
-        tcg_gen_op2(INDEX_op_ext_i32_i64,
+        tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
                     tcgv_i64_arg(ret), tcgv_i32_arg(arg));
     }
 }
@@ -3320,7 +3333,7 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
         tcg_debug_assert(idx == TB_EXIT_REQUESTED);
     }
 
-    tcg_gen_op1i(INDEX_op_exit_tb, val);
+    tcg_gen_op1i(INDEX_op_exit_tb, 0, val);
 }
 
 void tcg_gen_goto_tb(unsigned idx)
@@ -3335,7 +3348,7 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
     plugin_gen_disable_mem_helpers();
-    tcg_gen_op1i(INDEX_op_goto_tb, idx);
+    tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
 void tcg_gen_lookup_and_goto_ptr(void)
@@ -3350,6 +3363,6 @@ void tcg_gen_lookup_and_goto_ptr(void)
     plugin_gen_disable_mem_helpers();
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4578b185be..6838ecdefc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2616,7 +2616,8 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             nb_cargs = def->nb_cargs;
 
             if (def->flags & TCG_OPF_VECTOR) {
-                col += ne_fprintf(f, "v%d,e%d,", 64 << TCGOP_VECL(op),
+                col += ne_fprintf(f, "v%d,e%d,",
+                                  8 * tcg_type_size(TCGOP_TYPE(op)),
                                   8 << TCGOP_VECE(op));
             }
 
@@ -4709,7 +4710,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
 
     itype = its->type;
     vece = TCGOP_VECE(op);
-    vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+    vtype = TCGOP_TYPE(op);
 
     if (its->val_type == TEMP_VAL_CONST) {
         /* Propagate constant via movi -> dupi.  */
@@ -5176,8 +5177,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
     default:
         if (def->flags & TCG_OPF_VECTOR) {
-            tcg_out_vec_op(s, op->opc, TCGOP_VECL(op), TCGOP_VECE(op),
-                           new_args, const_args);
+            tcg_out_vec_op(s, op->opc, TCGOP_TYPE(op) - TCG_TYPE_V64,
+                           TCGOP_VECE(op), new_args, const_args);
         } else {
             tcg_out_op(s, op->opc, new_args, const_args);
         }
@@ -5203,7 +5204,7 @@ static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
     TCGTemp *ots, *itsl, *itsh;
-    TCGType vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+    TCGType vtype = TCGOP_TYPE(op);
 
     /* This opcode is only valid for 32-bit hosts, for 64-bit elements. */
     tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index d46b625e0e..6608a29376 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -712,10 +712,9 @@ QEMU specific operations
 Host vector operations
 ----------------------
 
-All of the vector ops have two parameters, ``TCGOP_VECL`` & ``TCGOP_VECE``.
-The former specifies the length of the vector in log2 64-bit units; the
-latter specifies the length of the element (if applicable) in log2 8-bit units.
-E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
+All of the vector ops have two parameters, ``TCGOP_TYPE`` & ``TCGOP_VECE``.
+The former specifies the length of the vector as a TCGType; the latter
+specifies the length of the element (if applicable) in log2 8-bit units.
 
 .. list-table::
 
@@ -729,7 +728,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
    * - dup_vec *v0*, *r1*
 
-     - | Duplicate the low N bits of *r1* into VECL/VECE copies across *v0*.
+     - | Duplicate the low N bits of *r1* into TYPE/VECE copies across *v0*.
 
    * - dupi_vec *v0*, *c*
 
@@ -738,7 +737,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
    * - dup2_vec *v0*, *r1*, *r2*
 
-     - | Duplicate *r2*:*r1* into VECL/64 copies across *v0*. This opcode is
+     - | Duplicate *r2*:*r1* into TYPE/64 copies across *v0*. This opcode is
          only present for 32-bit hosts.
 
    * - add_vec *v0*, *v1*, *v2*
@@ -810,7 +809,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
        .. code-block:: c
 
-          for (i = 0; i < VECL/VECE; ++i) {
+          for (i = 0; i < TYPE/VECE; ++i) {
               v0[i] = v1[i] << s2;
           }
 
@@ -832,7 +831,7 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 
        .. code-block:: c
 
-          for (i = 0; i < VECL/VECE; ++i) {
+          for (i = 0; i < TYPE/VECE; ++i) {
               v0[i] = v1[i] << v2[i];
           }
 
-- 
2.43.0


