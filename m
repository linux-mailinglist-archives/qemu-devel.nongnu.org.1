Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC057D795E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:25:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6j-0002B4-E9; Wed, 25 Oct 2023 20:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6I-0001IA-PF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6B-0006m8-EV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso278447b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279581; x=1698884381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qmRgRparTj0SEd6WHdvCzqYVoVclLUZvYDDLn1Vsfg=;
 b=v01OkbSjjI4jjJduCyCOptFqVmb0/Okl4rIwy+wo29sQ3Cl7dNdx9g75edAFJ81Y8q
 TSdR1QGkq9VX7lBdRjcTsTrXNBHQ5waI5y0Gh5ktyE/wlSHcFrdIOxK68osV3vd7pHl7
 h7JiO88gejyQvfeHVe/uYQ9NRvxLV6QF7Z/M0HDEECuAby4U16VgbcBvOSJUzcwlF5O1
 elFhxwqK5qEbCnqcIu54UEreiXG+/X95e1oLhbpEZVj+nbe4VnHbk+/iRGh4QD9qgqYT
 YOxzWZTs0RRrwwZiTMa8MJrcILHqocFzsWovwpy1wqupX9XbCpe5UL7Q/jrNb+t2yYBm
 K1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279581; x=1698884381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qmRgRparTj0SEd6WHdvCzqYVoVclLUZvYDDLn1Vsfg=;
 b=sLAQn0D59tKyrw5s2ERu7vSmngnN466tsdGqLG3zXospCHDeYlkumsv/NX6EEg4lIW
 IK6fiC/vsTMeTu8pdMmJ598YUeo3vkxd5cnVeyHmmHIigvAqapMVrrgaxcZPK/ZebSpe
 uC8EDPahhnm5Sgic6C2uhEJtf3lkxdy+bY26vHQ0KHMObz9jCN6XoMPchNMWqVt5Anv1
 xemvbBdRXmtCgoetHlF9qz4R1gcbGPITY2S+SmjFpH9kwXzgUX0ybUv8HT6Y0fKrA3hC
 L2ZxxaqWhSMd2jflvwdy+lTz9MTRV5CTq4Dms6PipxKYAnYqf1/7fKYhzrfuVb9/mwvu
 C6ig==
X-Gm-Message-State: AOJu0YxfwIQIalmANMuRZQYUcetH81Q3UKhbAD3OIfx75pkr3zpUddiq
 AWxZucxkJlN1qLVYrPsOJQFjk/jtxmYKshlfJ0Q=
X-Google-Smtp-Source: AGHT+IHY7pSnK4nnvsl+HSgs90fiOJSHh2KGsCLiMFSv2Sen6fasu/Paj/lw0W/LVLiXl7hbBvHgFw==
X-Received: by 2002:a05:6a20:54a7:b0:15e:2d9f:cae0 with SMTP id
 i39-20020a056a2054a700b0015e2d9fcae0mr8323941pzk.10.1698279581308; 
 Wed, 25 Oct 2023 17:19:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 40/94] target/sparc: Move TADD, TSUB, MULS to decodetree
Date: Wed, 25 Oct 2023 17:14:48 -0700
Message-Id: <20231026001542.1141412-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/sparc/insns.decode |  7 ++++++
 target/sparc/helper.c     |  4 ----
 target/sparc/translate.c  | 48 ++++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4415d03858..b35921aabb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -32,6 +32,7 @@ CALL    01 i:s30
 &r_r_ri_cc  rd rs1 rs2_or_imm imm:bool cc:bool
 @r_r_ri_cc  .. rd:5  . cc:1 .... rs1:5 imm:1 rs2_or_imm:s13    &r_r_ri_cc
 @r_r_ri_cc0 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=0
+@r_r_ri_cc1 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=1
 
 {
   [
@@ -170,12 +171,18 @@ SUBC        10 ..... 0.1100 ..... . .............          @r_r_ri_cc
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
 SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
+MULScc      10 ..... 100100 ..... . .............          @r_r_ri_cc1
 
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
 UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
 SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
+TADDcc      10 ..... 100000 ..... . .............          @r_r_ri_cc1
+TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri_cc1
+TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri_cc1
+TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri_cc1
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index e25fdaeedd..2bcdc81d54 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -198,10 +198,8 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TADDTV;
     env->cc_src = src1;
     env->cc_src2 = src2;
-    env->cc_dst = dst;
     return dst;
 
  tag_overflow:
@@ -226,10 +224,8 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TSUBTV;
     env->cc_src = src1;
     env->cc_src2 = src2;
-    env->cc_dst = dst;
     return dst;
 
  tag_overflow:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1ebaaa1114..861c6e8f1e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -730,6 +730,16 @@ static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_sdiv_cc(dst, tcg_env, src1, src2);
 }
 
+static void gen_op_taddcctv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_taddcctv(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_tsubcctv(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4146,6 +4156,11 @@ TRANS(ADD, ALL, do_arith, a, CC_OP_ADD,
 TRANS(SUB, ALL, do_arith, a, CC_OP_SUB,
       tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc)
 
+TRANS(TADDcc, ALL, do_arith, a, CC_OP_TADD, NULL, NULL, gen_op_add_cc)
+TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, NULL, NULL, gen_op_sub_cc)
+TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, NULL, NULL, gen_op_taddcctv)
+TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, NULL, NULL, gen_op_tsubcctv)
+
 TRANS(AND, ALL, do_logic, a, tcg_gen_and_tl, tcg_gen_andi_tl)
 TRANS(XOR, ALL, do_logic, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
 TRANS(ANDN, ALL, do_logic, a, tcg_gen_andc_tl, NULL)
@@ -4226,6 +4241,12 @@ static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
     }
 }
 
+static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    update_psr(dc);
+    return do_arith(dc, a, CC_OP_ADD, NULL, NULL, gen_op_mulscc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4653,36 +4674,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop) {
                     case 0x20: /* taddcc */
-                        gen_op_add_cc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_TADD);
-                        dc->cc_op = CC_OP_TADD;
-                        break;
                     case 0x21: /* tsubcc */
-                        gen_op_sub_cc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_TSUB);
-                        dc->cc_op = CC_OP_TSUB;
-                        break;
                     case 0x22: /* taddcctv */
-                        gen_helper_taddcctv(cpu_dst, tcg_env,
-                                            cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        dc->cc_op = CC_OP_TADDTV;
-                        break;
                     case 0x23: /* tsubcctv */
-                        gen_helper_tsubcctv(cpu_dst, tcg_env,
-                                            cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        dc->cc_op = CC_OP_TSUBTV;
-                        break;
                     case 0x24: /* mulscc */
-                        update_psr(dc);
-                        gen_op_mulscc(cpu_dst, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADD);
-                        dc->cc_op = CC_OP_ADD;
-                        break;
+                        goto illegal_insn;  /* in decodetree */
 #ifndef TARGET_SPARC64
                     case 0x25:  /* sll */
                         if (IS_IMM) { /* immediate */
-- 
2.34.1


