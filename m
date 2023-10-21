Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F12657D1AF7
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bN-0007NX-J4; Sat, 21 Oct 2023 01:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4bE-0007I6-9o
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:37 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4bC-0008UE-B0
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:35 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ce2b6b3cb6so989873a34.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866352; x=1698471152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnJgyiV19sDiLGIzPT4ho6uw+aKTIF7hpKly+eWnlQw=;
 b=HeG+LSCpCoyEieL6DlpU1Z1U91I/SeF3Cso1Ma5H5hc+6M0kATL5lgd1wAO+i36bHo
 BUdFIlnknGymKqWLMfIYNSEdngtIl5UsSnr7/Hsi/bt+xmwd482SiCUx+gbO5qNXuDW7
 jGABSYCzPEUJwERha3u0t6nQSaeH3X/XSmsdnFGkvz5BIjSpk16+u0nBuDJ6qmTifv1v
 SoZBUE5Ubf0kx0LkywS9P8w3gOBxJgi8/UFiSsHjyrz6riJJuQz/DWUzW4pVJdJuNaBn
 HNnQ65AsKq1bcZwRim2seJYOATV2s3QEhgkT0s/gkRLSot7trPGhSsCKNrkrUQr1yd3f
 WG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866352; x=1698471152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnJgyiV19sDiLGIzPT4ho6uw+aKTIF7hpKly+eWnlQw=;
 b=C8cHeVLABtuLqQF5iRuNKfVlMop6xuMovOPvriYAsWuVDHWOrPLmwC6biPgMKjkLcg
 29YBsZjM7gSK/Kp9rsXf8xjz+YME5vXP1WTwqDYRq3q/Ai2q8q6o5pYdbyGOb3SDztSh
 x/ybeYDZIeBFLO0x2+8TWObRS2Qods4mSFSSmXxZuZ8SnJlVJn+UaTk4dAHOFxi5s1LX
 hfwddZayi1r4/f4n7xAew+NqpN2oBDtwkEPiF08XIrgePp6iXKY57OPsB47PplVaNMda
 lFgRxrdNZ78vTyHkFb2YhBRSgwJt9KQpv2aUoyOPymO8h8YGQRPDrg63aSeA/I819bys
 FM/A==
X-Gm-Message-State: AOJu0Yzl/0mgESglxUuwJ7kPA5wbSXIJo4/SyWXglXMvXBd6Sp5YCeWf
 opDnRrWEiuOm3gjxIy4vbqujCBWTOOcuZ4yojlE=
X-Google-Smtp-Source: AGHT+IE9w4GEIKmpwgX3/JX4a4CiLuG2PbvctWi3w/3AqflQHftxMagw7axrGGRWcVD0onoT2FKhIQ==
X-Received: by 2002:a05:6830:2693:b0:6b9:14bf:7097 with SMTP id
 l19-20020a056830269300b006b914bf7097mr4365873otu.9.1697866351812; 
 Fri, 20 Oct 2023 22:32:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 39/90] target/sparc: Move POPC to decodetree
Date: Fri, 20 Oct 2023 22:31:07 -0700
Message-Id: <20231021053158.278135-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 56 +++++++--------------------------------
 2 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8f4881a776..667067822f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -183,6 +183,9 @@ TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri_cc1
 TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri_cc1
 TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri_cc1
 
+POPC        10 rd:5  101110 00000 imm:1 rs2_or_imm:s13     \
+            &r_r_ri_cc rs1=0 cc=0
+
 &shiftr     rd rs1 rs2 x:bool
 @shiftr     .. rd:5  ...... rs1:5 . x:1 ....... rs2:5      &shiftr
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index feeaebae93..7fd19ff5ee 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -727,6 +727,11 @@ static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_tsubcctv(dst, tcg_env, src1, src2);
 }
 
+static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_ctpop_tl(dst, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -2720,19 +2725,6 @@ static TCGv get_src1(DisasContext *dc, unsigned int insn)
     return gen_load_gpr(dc, rs1);
 }
 
-static TCGv get_src2(DisasContext *dc, unsigned int insn)
-{
-    if (IS_IMM) { /* immediate */
-        target_long simm = GET_FIELDs(insn, 19, 31);
-        TCGv t = tcg_temp_new();
-        tcg_gen_movi_tl(t, simm);
-        return t;
-    } else {      /* register */
-        unsigned int rs2 = GET_FIELD(insn, 27, 31);
-        return gen_load_gpr(dc, rs2);
-    }
-}
-
 #ifdef TARGET_SPARC64
 static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
@@ -4247,6 +4239,9 @@ TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
 TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, gen_op_taddcctv, NULL)
 TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv, NULL)
 
+/* TODO: Should have feature bit -- comes in with UltraSparc T2. */
+TRANS(POPC, 64, do_arith, a, 0, gen_op_popc, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4834,40 +4829,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                         goto illegal_insn;
                 }
             } else if (xop < 0x36) {
-                if (xop < 0x20) {
-                    goto illegal_insn;
-                } else {
-                    cpu_src1 = get_src1(dc, insn);
-                    cpu_src2 = get_src2(dc, insn);
-                    switch (xop) {
-                    case 0x20: /* taddcc */
-                    case 0x21: /* tsubcc */
-                    case 0x22: /* taddcctv */
-                    case 0x23: /* tsubcctv */
-                    case 0x24: /* mulscc */
-                    case 0x25:  /* sll */
-                    case 0x26:  /* srl */
-                    case 0x27:  /* sra */
-                        goto illegal_insn;  /* in decodetree */
-                    case 0x30:
-                        goto illegal_insn;  /* WRASR in decodetree */
-                    case 0x32:
-                        goto illegal_insn;  /* WRPR in decodetree */
-                    case 0x33: /* wrtbr, UA2005 wrhpr */
-                        goto illegal_insn;  /* WRTBR, WRHPR in decodetree */
-#ifdef TARGET_SPARC64
-                    case 0x2c: /* V9 movcc */
-                    case 0x2f: /* V9 movr */
-                        goto illegal_insn;  /* in decodetree */
-                    case 0x2e: /* V9 popc */
-                        tcg_gen_ctpop_tl(cpu_dst, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
-#endif
-                    default:
-                        goto illegal_insn;
-                    }
-                }
+                goto illegal_insn; /* in decodetree */
             } else if (xop == 0x36) { /* UltraSparc shutdown, VIS, V8 CPop1 */
 #ifdef TARGET_SPARC64
                 int opf = GET_FIELD_SP(insn, 5, 13);
-- 
2.34.1


