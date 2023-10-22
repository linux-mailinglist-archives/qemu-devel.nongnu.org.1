Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A43397D2709
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtv-0007O8-BG; Sun, 22 Oct 2023 19:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtZ-0007Hg-7L
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:09 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtX-00071s-6v
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:08 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3576e74ae9dso9711695ab.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017406; x=1698622206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOG0+J6q7MgdBIGJ+u8riSNg5bj9bAAHoC21eXjtrds=;
 b=m2JaFPsfurHjMOdlk0o08vcqn3J9m+6dgyVdrpFxz/OhwGOTn6BR4OA5ew18r8epcf
 uy0UqLnBzHIs+Eq8/+7xJgm9y4eKYUSRfb9JeeeioFXQ2KyyXK+P7GweqoeIiot7J5DN
 3bGhmGt7Zf1Or84MjlckGNBluCvLOlI9EJxi/C3erEEUFm7VKWK2JHJecovoTrM4N+ge
 iOYb+WTjj71HkrE0B/LMO4e2NxVVQnitsLG71o+uvkHnGb0wTZCOBqokRpLmh0YSM9+b
 bFkQK+Db0FYXRbfEJwf18xLIH2cijGWT1oTgN70dUZmJChwEN1TTpJWl1uwZ3BjrYFWK
 6Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017406; x=1698622206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOG0+J6q7MgdBIGJ+u8riSNg5bj9bAAHoC21eXjtrds=;
 b=YCh8Do6hRxP7oECTqXEZwdBhfi7Kc2eIWBFhgq+Cm9Fi58Rk38uSdPBGiwGb72yDdy
 RG0FYmU55fweCyK+D84wrdR94tQftK+nGGJAghNc3ue/R/N5BKvqaUOCWfmzeLvPlnaL
 A9MEEUQ3rxMQyDRiFtXom++YRl5nSvwsxxk5dmM3myzsiAYy08jaEiriTCKfh1vWSvNz
 6iSrjWTsE481TMF3Q/Eyf7KdLp+pj5V58BLJYFeJtvVAzkEU8mI66CZB/daUWRGUwgBt
 W0Tet1Y87Ot6Kieli6xBHkChvL7BRaG1JmOMURR3bCIEVL6hgND5f1rryZ9OrJDdevMN
 +shg==
X-Gm-Message-State: AOJu0Yz/SSrFWEVPuZuRj4W3S87sbI2Q6QxuU/l05nBL66slGUJqmos6
 YJoNbsSPvj+4FdRFgp6goWdFPmwrKddzek1d08c=
X-Google-Smtp-Source: AGHT+IElAPNxX4egs5KoKjBCT9dUK9aY3QJYxZ6HBthkoqZbG9XGEq4sETfNdDOsr5gk//N5J4tdeQ==
X-Received: by 2002:a05:6e02:150:b0:352:a1c8:6e99 with SMTP id
 j16-20020a056e02015000b00352a1c86e99mr8393765ilr.6.1698017405777; 
 Sun, 22 Oct 2023 16:30:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:30:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 37/94] target/sparc: Move SUBC to decodetree
Date: Sun, 22 Oct 2023 16:28:35 -0700
Message-Id: <20231022232932.80507-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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
 target/sparc/translate.c  | 139 ++++++++++++++++++++++++--------------
 2 files changed, 90 insertions(+), 50 deletions(-)

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
index 14e79f1c87..d572a02724 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -538,51 +538,11 @@ static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
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
@@ -593,16 +553,75 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
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
@@ -4143,6 +4162,30 @@ static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
     }
 }
 
+static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    switch (dc->cc_op) {
+    case CC_OP_DIV:
+    case CC_OP_LOGIC:
+        /* Carry is known to be zero.  Fall back to plain SUB.  */
+        return do_arith(dc, a, CC_OP_SUB,
+                        tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc);
+    case CC_OP_ADD:
+    case CC_OP_TADD:
+    case CC_OP_TADDTV:
+        return do_arith(dc, a, CC_OP_SUBX,
+                        gen_op_subc_add, NULL, gen_op_subccc_add);
+    case CC_OP_SUB:
+    case CC_OP_TSUB:
+    case CC_OP_TSUBTV:
+        return do_arith(dc, a, CC_OP_SUBX,
+                        gen_op_subc_sub, NULL, gen_op_subccc_sub);
+    default:
+        return do_arith(dc, a, CC_OP_SUBX,
+                        gen_op_subc_generic, NULL, gen_op_subccc_generic);
+    }
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4567,10 +4610,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


