Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6727D79AE
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6O-0001YK-W2; Wed, 25 Oct 2023 20:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6G-0001E0-Oa
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo66-0006eA-Ew
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso2283605ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279576; x=1698884376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoLBlyu7idL5AbpDPBt4MB7Nht6Rv+NOTvRkK60g84Q=;
 b=uqX+qJ2GN6PP4lFMKzaRkH9OOFuHKmNI7TlU8k/Zjrmru8wBJvnhrwIitQuo5r/lwX
 r3ZdvP8Q6Z8eW7GdxpnBtB1C6cz8P4Ajwl3CG80z+xg3OscCTLeCGdpIB9gHLhRcFDEO
 fB40WxZZIoBzRW+7nmWxqYrn23CVV6clZRBLrVSXmy+IN2/VEArsgmX0aDWabEwSPqnw
 HaNumatN9jGvkMYVZ4p3AYKy5Rk6ltN94emM0eZaupM0YE8Q9DC6zyPcGOMFzphrCQxA
 b27direZYUhLcPqpfBAjMAJz7uKPix8ghV99+JUKcOxbkdLOKzwzHxkMg2ROkMtEDGcE
 39ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279576; x=1698884376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoLBlyu7idL5AbpDPBt4MB7Nht6Rv+NOTvRkK60g84Q=;
 b=waOqkltDGgKUR21wOkkLc1mxR1jJkSlmbqe6Pf7PwhyXp1Fme2exATxK01TJn6haSl
 u+qze2OQXBGOHc9fM40X1pi3opx1+a5eGWzMQa+cLsAmxBGedhqU0OAASQkM8wWdmKYF
 yndR1L0NPrJzkFamFNKE3VgRioDDaBWJamhFJoRXgexYb6rBTzhXYrX90zoMakrVxhzH
 hb1YWVFJHqBWNQETayL2dfoykTmozTat5mdHXfDfH9WshdsTuCgTY8bsZIXYSoCBykb9
 vR88oOy733WJcumyhUM655LruMuBVP8edGWUFQ93eDISJijJZyEJPb5eCghmqZcDJsyl
 EL1Q==
X-Gm-Message-State: AOJu0YzOJrq5DnLTQDVNQWNO6MLSZ2RI970D2LNrCV7ofujh0bNeqD4n
 HBUWgbNFBGnGjm6mrRpBrg7FFbalrgE2cz16ykQ=
X-Google-Smtp-Source: AGHT+IG9YgMxbmG5wYwrH1+a0D7a5NHOsUnqXdT+YDydmhLQWXMQdILdCySi9LzQmA5cf4BO0BAgfA==
X-Received: by 2002:a17:902:a417:b0:1bb:b855:db3c with SMTP id
 p23-20020a170902a41700b001bbb855db3cmr11839100plq.41.1698279576244; 
 Wed, 25 Oct 2023 17:19:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 34/94] target/sparc: Move ADDC to decodetree
Date: Wed, 25 Oct 2023 17:14:42 -0700
Message-Id: <20231026001542.1141412-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   1 +
 target/sparc/translate.c  | 154 ++++++++++++++++++++++++--------------
 2 files changed, 97 insertions(+), 58 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 3271c2997d..1cff18fa1f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -163,6 +163,7 @@ SUB         10 ..... 0.0100 ..... . .............          @r_r_ri_cc
 ANDN        10 ..... 0.0101 ..... . .............          @r_r_ri_cc
 ORN         10 ..... 0.0110 ..... . .............          @r_r_ri_cc
 XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
+ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
 
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2a8846f2ac..eb829acc68 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -447,71 +447,89 @@ static TCGv_i32 gen_sub32_carry32(void)
     return carry_32;
 }
 
-static void gen_op_addx_int(DisasContext *dc, TCGv dst, TCGv src1,
-                            TCGv src2, int update_cc)
+static void gen_op_addc_int(TCGv dst, TCGv src1, TCGv src2,
+                            TCGv_i32 carry_32, bool update_cc)
 {
-    TCGv_i32 carry_32;
-    TCGv carry;
+    tcg_gen_add_tl(dst, src1, src2);
 
-    switch (dc->cc_op) {
-    case CC_OP_DIV:
-    case CC_OP_LOGIC:
-        /* Carry is known to be zero.  Fall back to plain ADD.  */
-        if (update_cc) {
-            gen_op_add_cc(dst, src1, src2);
-        } else {
-            tcg_gen_add_tl(dst, src1, src2);
-        }
-        return;
-
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        if (TARGET_LONG_BITS == 32) {
-            /* We can re-use the host's hardware carry generation by using
-               an ADD2 opcode.  We discard the low part of the output.
-               Ideally we'd combine this operation with the add that
-               generated the carry in the first place.  */
-            carry = tcg_temp_new();
-            tcg_gen_add2_tl(carry, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-            goto add_done;
-        }
-        carry_32 = gen_add32_carry32();
-        break;
-
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        carry_32 = gen_sub32_carry32();
-        break;
-
-    default:
-        /* We need external help to produce the carry.  */
-        carry_32 = tcg_temp_new_i32();
-        gen_helper_compute_C_icc(carry_32, tcg_env);
-        break;
-    }
-
-#if TARGET_LONG_BITS == 64
-    carry = tcg_temp_new();
-    tcg_gen_extu_i32_i64(carry, carry_32);
+#ifdef TARGET_SPARC64
+    TCGv carry = tcg_temp_new();
+    tcg_gen_extu_i32_tl(carry, carry_32);
+    tcg_gen_add_tl(dst, dst, carry);
 #else
-    carry = carry_32;
+    tcg_gen_add_i32(dst, dst, carry_32);
 #endif
 
-    tcg_gen_add_tl(dst, src1, src2);
-    tcg_gen_add_tl(dst, dst, carry);
-
- add_done:
     if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
         tcg_gen_mov_tl(cpu_cc_src, src1);
         tcg_gen_mov_tl(cpu_cc_src2, src2);
-        tcg_gen_mov_tl(cpu_cc_dst, dst);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADDX);
-        dc->cc_op = CC_OP_ADDX;
     }
 }
 
+static void gen_op_addc_int_add(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
+{
+    TCGv discard;
+
+    if (TARGET_LONG_BITS == 64) {
+        gen_op_addc_int(dst, src1, src2, gen_add32_carry32(), update_cc);
+        return;
+    }
+
+    /*
+     * We can re-use the host's hardware carry generation by using
+     * an ADD2 opcode.  We discard the low part of the output.
+     * Ideally we'd combine this operation with the add that
+     * generated the carry in the first place.
+     */
+    discard = tcg_temp_new();
+    tcg_gen_add2_tl(discard, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
+
+    if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
+        tcg_gen_mov_tl(cpu_cc_src, src1);
+        tcg_gen_mov_tl(cpu_cc_src2, src2);
+    }
+}
+
+static void gen_op_addc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_add(dst, src1, src2, false);
+}
+
+static void gen_op_addccc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_add(dst, src1, src2, true);
+}
+
+static void gen_op_addc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int(dst, src1, src2, gen_sub32_carry32(), false);
+}
+
+static void gen_op_addccc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int(dst, src1, src2, gen_sub32_carry32(), true);
+}
+
+static void gen_op_addc_int_generic(TCGv dst, TCGv src1, TCGv src2,
+                                    bool update_cc)
+{
+    TCGv_i32 carry_32 = tcg_temp_new_i32();
+    gen_helper_compute_C_icc(carry_32, tcg_env);
+    gen_op_addc_int(dst, src1, src2, carry_32, update_cc);
+}
+
+static void gen_op_addc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_generic(dst, src1, src2, false);
+}
+
+static void gen_op_addccc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addc_int_generic(dst, src1, src2, true);
+}
+
 static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
@@ -4095,6 +4113,30 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_logic(dc, a, tcg_gen_or_tl, tcg_gen_ori_tl);
 }
 
+static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    switch (dc->cc_op) {
+    case CC_OP_DIV:
+    case CC_OP_LOGIC:
+        /* Carry is known to be zero.  Fall back to plain ADD.  */
+        return do_arith(dc, a, CC_OP_ADD,
+                        tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_add_cc);
+    case CC_OP_ADD:
+    case CC_OP_TADD:
+    case CC_OP_TADDTV:
+        return do_arith(dc, a, CC_OP_ADDX,
+                        gen_op_addc_add, NULL, gen_op_addccc_add);
+    case CC_OP_SUB:
+    case CC_OP_TSUB:
+    case CC_OP_TSUBTV:
+        return do_arith(dc, a, CC_OP_ADDX,
+                        gen_op_addc_sub, NULL, gen_op_addccc_sub);
+    default:
+        return do_arith(dc, a, CC_OP_ADDX,
+                        gen_op_addc_generic, NULL, gen_op_addccc_generic);
+    }
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4519,10 +4561,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0x8: /* addx, V9 addc */
-                        gen_op_addx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0x9: /* V9 mulx */
                         tcg_gen_mul_i64(cpu_dst, cpu_src1, cpu_src2);
-- 
2.34.1


