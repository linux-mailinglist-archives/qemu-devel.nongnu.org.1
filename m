Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3F7D2145
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRX3-0001gV-BB; Sun, 22 Oct 2023 02:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWn-0000sk-Gz
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:33 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWl-0001hZ-5v
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:33 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b3e13fc1f7so1676587b6e.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954490; x=1698559290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7WT3KgN8dsMjmh9I4YlPumtwnaUsA+5OvmhpgUYvm0=;
 b=vOPZfMUhyhKR3daafIn1jgB9QCSBeUDow7uAo3seMS2RrsuzKqpwXwZrFsHSGALr91
 seyNpdEoE9KiKFpea3sCzeTB6BljxGAdiJu5imCmtzKWJ+1MprJPMUXJcSJ32Fr5Rxay
 qHxouGEztt6pjWhDcpowsgFMWPIL0xrFsk92VpEqeR/CaQ9SMmcsV4QcjRNog5gDkwcF
 Rv/6MEuNOKd+hbCqpPOm4k4vX94ILtpkVeyWb1yX5mm0ne5KsTJRQ6r+ZTJl/mquEvV/
 XICvcTz1psDSM/pC88SGouqW9QRy+6u8iQu2cGhZtUKfdVmB9D01iy6xR+3tTdnTfbfm
 CQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954490; x=1698559290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7WT3KgN8dsMjmh9I4YlPumtwnaUsA+5OvmhpgUYvm0=;
 b=At7MmzzgMDch0Y+fa9iCsGLoSl0ZwTOTftnhiNStraBI0OEk7a2UUAGQ47N9gEHSAD
 FEy+oseWh9xo9eFU/uMeIACzbPSxMkNj7w5rCliE82il1C+YPTVJ5AMapHcEQ7V265yJ
 fyGjrH63acfiheOKn7K5ic/qBs/be4aIE8Dw5tXM1WYlaa9YfPo+xE7UUKI9ON0QmZ0+
 soDy3oJtGUonV3rzDqadZbPWpf0TuCicvmGQO+2AhUVI6OItHkL8Ko7fLUarQkhQj8Xw
 xuCOGfrzkZEdzCNfKSUxd+lsKRybn/OtQsiOaHQKloaeHhkTyZBxGKiYJC2wFHht6rp0
 oCLg==
X-Gm-Message-State: AOJu0YwPq9baN5LGbHvocEqSJmVN0PMh+je/HWp3u+Q/z9MSXjD0DrJl
 jVydfHUQjZvGYO6oJhvUYBt/SnEw4q1yn7w5qVo=
X-Google-Smtp-Source: AGHT+IFx39hQz134sxLGF9twYJ8tQ3jwBN4ZtgO+AyHrjQJj1uISqQUCjtPrUUP8spwyO54btFYFyQ==
X-Received: by 2002:a05:6808:221d:b0:3ae:1446:d48b with SMTP id
 bd29-20020a056808221d00b003ae1446d48bmr8322511oib.3.1697954460056; 
 Sat, 21 Oct 2023 23:01:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 33/90] target/sparc: Move SUBC to decodetree
Date: Sat, 21 Oct 2023 22:59:34 -0700
Message-Id: <20231022060031.490251-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   1 +
 target/sparc/translate.c  | 147 +++++++++++++++++++++++++-------------
 2 files changed, 98 insertions(+), 50 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d6a7256e71..a188452d2e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -165,6 +165,7 @@ ANDN        10 ..... 0.0101 ..... . .............          @r_r_ri_cc
 ORN         10 ..... 0.0110 ..... . .............          @r_r_ri_cc
 XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
 ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
+SUBC        10 ..... 0.1100 ..... . .............          @r_r_ri_cc
 
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d79e28ab7f..7e2a74a816 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -525,51 +525,11 @@ static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_mov_tl(dst, cpu_cc_dst);
 }
 
-static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
-                            TCGv src2, int update_cc)
+static void gen_op_subc_int(TCGv dst, TCGv src1, TCGv src2,
+                            TCGv_i32 carry_32, bool update_cc)
 {
-    TCGv_i32 carry_32;
     TCGv carry;
 
-    switch (dc->cc_op) {
-    case CC_OP_DIV:
-    case CC_OP_LOGIC:
-        /* Carry is known to be zero.  Fall back to plain SUB.  */
-        if (update_cc) {
-            gen_op_sub_cc(dst, src1, src2);
-        } else {
-            tcg_gen_sub_tl(dst, src1, src2);
-        }
-        return;
-
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        carry_32 = gen_add32_carry32();
-        break;
-
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        if (TARGET_LONG_BITS == 32) {
-            /* We can re-use the host's hardware carry generation by using
-               a SUB2 opcode.  We discard the low part of the output.
-               Ideally we'd combine this operation with the add that
-               generated the carry in the first place.  */
-            carry = tcg_temp_new();
-            tcg_gen_sub2_tl(carry, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-            goto sub_done;
-        }
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
 #if TARGET_LONG_BITS == 64
     carry = tcg_temp_new();
     tcg_gen_extu_i32_i64(carry, carry_32);
@@ -580,16 +540,75 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
     tcg_gen_sub_tl(dst, src1, src2);
     tcg_gen_sub_tl(dst, dst, carry);
 
- sub_done:
     if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
         tcg_gen_mov_tl(cpu_cc_src, src1);
         tcg_gen_mov_tl(cpu_cc_src2, src2);
-        tcg_gen_mov_tl(cpu_cc_dst, dst);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUBX);
-        dc->cc_op = CC_OP_SUBX;
     }
 }
 
+static void gen_op_subc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int(dst, src1, src2, gen_add32_carry32(), false);
+}
+
+static void gen_op_subccc_add(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int(dst, src1, src2, gen_sub32_carry32(), true);
+}
+
+static void gen_op_subc_int_sub(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
+{
+    TCGv discard;
+
+    if (TARGET_LONG_BITS == 64) {
+        gen_op_subc_int(dst, src1, src2, gen_sub32_carry32(), update_cc);
+        return;
+    }
+
+    /*
+     * We can re-use the host's hardware carry generation by using
+     * a SUB2 opcode.  We discard the low part of the output.
+     */
+    discard = tcg_temp_new();
+    tcg_gen_sub2_tl(discard, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
+
+    if (update_cc) {
+        tcg_debug_assert(dst == cpu_cc_dst);
+        tcg_gen_mov_tl(cpu_cc_src, src1);
+        tcg_gen_mov_tl(cpu_cc_src2, src2);
+    }
+}
+
+static void gen_op_subc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_sub(dst, src1, src2, false);
+}
+
+static void gen_op_subccc_sub(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_sub(dst, src1, src2, true);
+}
+
+static void gen_op_subc_int_generic(TCGv dst, TCGv src1, TCGv src2,
+                                    bool update_cc)
+{
+    TCGv_i32 carry_32 = tcg_temp_new_i32();
+
+    gen_helper_compute_C_icc(carry_32, tcg_env);
+    gen_op_subc_int(dst, src1, src2, carry_32, update_cc);
+}
+
+static void gen_op_subc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_generic(dst, src1, src2, false);
+}
+
+static void gen_op_subccc_generic(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subc_int_generic(dst, src1, src2, true);
+}
+
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv r_temp, zero, t0;
@@ -4280,6 +4299,38 @@ static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADDX, func, NULL);
 }
 
+static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    void (*func)(TCGv, TCGv, TCGv);
+
+    switch (dc->cc_op) {
+    case CC_OP_DIV:
+    case CC_OP_LOGIC:
+        /* Carry is known to be zero.  Fall back to plain SUB.  */
+        if (a->cc) {
+            return do_arith(dc, a, CC_OP_SUB, gen_op_sub_cc, NULL);
+        }
+        return do_arith(dc, a, -1, tcg_gen_sub_tl, tcg_gen_subi_tl);
+
+    case CC_OP_ADD:
+    case CC_OP_TADD:
+    case CC_OP_TADDTV:
+        func = a->cc ? gen_op_subccc_add : gen_op_subc_add;
+        break;
+
+    case CC_OP_SUB:
+    case CC_OP_TSUB:
+    case CC_OP_TSUBTV:
+        func = a->cc ? gen_op_subccc_sub : gen_op_subc_sub;
+        break;
+
+    default:
+        func = a->cc ? gen_op_subccc_generic : gen_op_subc_generic;
+        break;
+    }
+    return do_arith(dc, a, CC_OP_SUBX, func, NULL);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4704,10 +4755,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xc: /* subx, V9 subc */
-                        gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0xd: /* V9 udivx */
                         gen_helper_udivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-- 
2.34.1


