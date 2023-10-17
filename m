Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7074D7CBADE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKa-0000pg-L9; Tue, 17 Oct 2023 02:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKU-0000nA-TH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKT-0003yo-3H
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca215cc713so15175185ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523198; x=1698127998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpYlXrhETLxpDZghiwgxak1PUoYJ/Oh0DGQpkeamlnI=;
 b=ndF2eeuZNMDGTaTa8BGWJOiuVztmwQmms4ZqxeVWtCocM4W8Y+QcKP8QBx6gX7Xwvc
 Jrn6SDtDfTvDqfpQ2Yz/e4QlKOG+8klNWoaLMH851PLq9qRv+djUrha07xLHS30+SV2s
 MT7FX11bS7LpJ7w4Hb+1TzW7q5RA6S/5GnVXMooJHLw+rUO02ncT//EatE0k9VJfj+6o
 v41riZdz848jL0dbTS6TFAEfGijhS716hpgjYCW4rgVI9JTzR2tlHZu8Mvuw8/bV86zR
 cjoMWkg/nWTxiAJ5bh4bWRC2jPtCzAt9Sayw/GvHIcXf0lb2G2MbMxAaFOpw6OpPg1on
 6wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523198; x=1698127998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BpYlXrhETLxpDZghiwgxak1PUoYJ/Oh0DGQpkeamlnI=;
 b=a5+TNZniywvA1sm5FdJGIpPn0MM2hYsGIE8URH5iSOUAwfq229G7Rk7AV/4Th0sKwF
 tSnHUR6DqlHBrGCiXL0drrcYVxq1sv3wudJ3rHHaJa/wBOnzyN3mREn+tDn4A8TNPg98
 o2lE7w0rpqkc+yuzGsdvjQLCwSlSDRJyB2rYHae13DpKy+m1F5o0CyiZhsV10Xet13r1
 cZz7tQoJevlFTg50zWz81Nas345JZZFeFcpwycxWXgUEEGcG4BUuhag/KNcPEjMM7tM4
 PnS9Z0x7nwbWnWoxNCkpyeipMJWipHx1qjdN0vcR0gXjOBadE01qhY6LwwHcis0wmAAy
 4GgA==
X-Gm-Message-State: AOJu0YxXoQ/8DjxlLN1OE6wlG/nZS+LZvxGL5GLOLiC2+Kn8MKo+SDtp
 frzQnhBlRIZmx5x0nSlLdygYm2lBVkequvi7sVs=
X-Google-Smtp-Source: AGHT+IHXVtZXZh/7NM2GBn+V9jBT23hZwZPV02yCKr1gPPqKnY8wXehuaCBksH2EhPKQyaQj7rRntg==
X-Received: by 2002:a17:902:f9cc:b0:1ca:25e:3c32 with SMTP id
 kz12-20020a170902f9cc00b001ca025e3c32mr1404245plb.19.1697523198225; 
 Mon, 16 Oct 2023 23:13:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 39/90] target/sparc: Move POPC to decodetree
Date: Mon, 16 Oct 2023 23:11:53 -0700
Message-Id: <20231017061244.681584-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 55 ++++++---------------------------------
 2 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a61d10be5a..0c1517f024 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -189,6 +189,7 @@ TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri
 TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri
 TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri
 MULScc      10 ..... 100100 ..... . .............          @r_r_ri
+POPC        10 rd:5  101110 00000 imm:1 rs2_or_imm:s13     &r_r_ri rs1=0
 
 &shiftr     rd rs1 rs2 x:bool
 @shiftr     .. rd:5  ...... rs1:5 . x:1 ....... rs2:5      &shiftr
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0b0b9aa8d3..75a2de764e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -685,6 +685,11 @@ static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
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
@@ -2678,19 +2683,6 @@ static TCGv get_src1(DisasContext *dc, unsigned int insn)
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
@@ -4245,6 +4237,8 @@ TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
 TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
+/* TODO: Should have feature bit -- comes in with UltraSparc T2. */
+TRANS(POPC, 64, do_arith, a, gen_op_popc, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4801,40 +4795,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


