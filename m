Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F407D2166
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRX4-0001sG-Ry; Sun, 22 Oct 2023 02:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWt-00017Q-6y
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:39 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWp-0001ie-OJ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:38 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so1583097b6e.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954494; x=1698559294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rGtH1mlIN2jrrxzbt2zOrF5UKFFP1IE2RgIKYzMTdo=;
 b=Cvrqihh6xmmVzlbdhqEWnJmDCZzkFu+eZ0cR7ihvMJUkMihdXS3BXZ00f/1xifXq5z
 8T0ZX7JcfElXgRO8R3wUJRge6NgZusvpmrCMwxtNRizz2wxwCw6mBaEy+9HqM/WdhaJ4
 WM7Xc6zsFR4CjW4i68j2cs7VVeWL9su8oArnZUFK4sKk0OIT2pETUGBsDoxeaKeye/Bz
 baZy0zV9ylTFh00ghVQcAVy8wBY7HJ6dPxh+f1dUiyGPHKmFaum/H0UoFhN9obyI9TSu
 IrhdAgL2MMFasb+VlfsjIalUdW54UYYIoMhHvrHWtLn3tQR3fGxOTekUrAHL2GmZOzAn
 +uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954494; x=1698559294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rGtH1mlIN2jrrxzbt2zOrF5UKFFP1IE2RgIKYzMTdo=;
 b=M9huMMpySALsxJs7BL9yKR3gl2y4L21Vbi/OniF3BP5BOk1ItrlJetkOYSbA9s4Ena
 6ZEuUxYOjiS548Cm1MA5I+Stip0541MEGN6F4zWoENvc2oRcEoprDX24fRObz0kL2W1L
 rb2qLGg1vn1y2biMqFGted3FGY9p2O7+l2wgU9Ebd3BU4hqTaSUy66WLS9I1rJPDsMUy
 +TBvm8oDG8sdgOIh0RgwSluULtGOV9bqYCISBoOM/TpZNK9Fx14lLNsbQENuBbbDBVdu
 ctOtyqoYFs8XhW8ZFzuBd3p8ybRUFsOzqgrBHeCxvooubfgCwTgAWqX6oWOKESLQKCxX
 mYcA==
X-Gm-Message-State: AOJu0YzxF3kByN3OFuMrODI6HuHhgdw/VptuWPkF0PahZBpixyElnJZy
 rBm2rad6mi4DAvUjNHAqDIEb0piR3kzhcz/tEvk=
X-Google-Smtp-Source: AGHT+IHW7V/rmvyHk80yjJvH6l+sD74sYcliCoNkxbwc3X8h9w0AYrsK3vmkLYAcWt95Qanw6qKRcw==
X-Received: by 2002:a05:6870:9728:b0:1e9:e02e:f4c8 with SMTP id
 n40-20020a056870972800b001e9e02ef4c8mr8023589oaq.54.1697954494651; 
 Sat, 21 Oct 2023 23:01:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:01:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 39/90] target/sparc: Move POPC to decodetree
Date: Sat, 21 Oct 2023 22:59:40 -0700
Message-Id: <20231022060031.490251-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
index cb21405e1a..a596b0fc85 100644
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
index b907873359..9d1307653c 100644
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
@@ -4288,6 +4280,9 @@ TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
 TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, gen_op_taddcctv, NULL)
 TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv, NULL)
 
+/* TODO: Should have feature bit -- comes in with UltraSparc T2. */
+TRANS(POPC, 64, do_arith, a, 0, gen_op_popc, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4875,40 +4870,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


