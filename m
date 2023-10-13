Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FD7C8F26
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPin-0006OP-HU; Fri, 13 Oct 2023 17:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPil-0006NI-5m
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPij-0000Ws-FZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d329a704bso1016455a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232560; x=1697837360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+Po0tdVkDRqVAnCRFhdgPPaFsI/xFw6qDs18ZteNnU=;
 b=Pp4URL4WY8ggKdX/n8+rKDImxxhDvdSW5B1POmNsWLrfR8379d+OR+JE43/GA26EJO
 VXBq3WraXjxVTXLs/q206Hc7LkCVsecCG/gspHd+uo36W/EXADkD1ZJ0NouDPT3n91Zl
 WJg2ml3JI8E6wplgnhglzPqYkSbbicGfQ7psoH359Fsb0ZRuRcsz6WL1e1kse+eXMKR9
 7Ejpi3cdW0LIqNfYylSENp0KcSZW19cG2HjhDvPNQ8KbGduADQ6p9G0nXda0A4ZEpEYS
 LEGuwGOovVjEk/xifRo7gQFZWEySyT92URxFnk+hmuqyPWogwlUD+iEl1m25bZt90PMW
 Vb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232560; x=1697837360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+Po0tdVkDRqVAnCRFhdgPPaFsI/xFw6qDs18ZteNnU=;
 b=GGUfTgNh3p+xiv2Ti37/w8P0/mBqMVuiBMYlflsK9G7QQLQwSqiiBOKWrM2Ok0Ns0z
 S4NMvqYlcGPedhJMSBZA4YrfKYwungW6age8FAFNTn8IgLNt8z7CshcNmZyx3SyUNsk+
 mOF7jQfBxxorfIiPLsz1Fos/1A30BfqMW+aGmyz3A3AdJbnlPacxXCAI4gZ6745HW6zr
 jf6a539ozN7MKLe0r7J8+8lc5erpWE6X/lZcgeglDJBzoF7fiHY9nfre4emf/7WxYvBE
 EhrpQmFOBAkcO6FsBE/bF9UK+NAzMsLXq0JsFgXhQHm7Qpv/Fbr4nbmZBnfQUJpLtA7r
 U/GQ==
X-Gm-Message-State: AOJu0Yx0fNXWvv0iOWbEcHzEhAgrCCywEXRt5NzBkktf8LMaJqtLD2J+
 5s0DIpPbVkyYIVSwyDXpZM6grv6tWUJlGncGDLM=
X-Google-Smtp-Source: AGHT+IGqO/CmFI5JU6DTcRdUh9LZP2EpY3dlpRZbL3BVl0/JSBbx18TG2w+0e4iZmSzLzsslbmWdWQ==
X-Received: by 2002:a17:90a:194:b0:27d:1d52:98e8 with SMTP id
 20-20020a17090a019400b0027d1d5298e8mr6108907pjc.21.1697232560211; 
 Fri, 13 Oct 2023 14:29:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 34/85] target/sparc: Move POPC to decodetree
Date: Fri, 13 Oct 2023 14:27:55 -0700
Message-Id: <20231013212846.165724-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/sparc/translate.c  | 54 +++++----------------------------------
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1f6dfa210f..7ec1518b54 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -192,6 +192,7 @@ TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri
 TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri
 TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri
 MULScc      10 ..... 100100 ..... . .............          @r_r_ri
+POPC        10 rd:5  101110 00000 imm:1 rs2_or_imm:s13     &r_r_ri rs1=0
 
 &shiftr     rd rs1 rs2 x:bool
 @shiftr     .. rd:5  ...... rs1:5 . x:1 ....... rs2:5      &shiftr
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 81a2518498..caa2eff626 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -665,6 +665,11 @@ static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
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
@@ -2629,19 +2634,6 @@ static TCGv get_src1(DisasContext *dc, unsigned int insn)
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
@@ -4188,6 +4180,7 @@ TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
 TRANS(UDIV, ALL, do_arith, a, gen_op_udiv, NULL)
 TRANS(SDIV, ALL, do_arith, a, gen_op_sdiv, NULL)
+TRANS(POPC, 64, do_arith, a, gen_op_popc, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4744,40 +4737,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


