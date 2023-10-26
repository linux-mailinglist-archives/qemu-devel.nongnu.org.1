Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B67D7958
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6e-00025s-Ok; Wed, 25 Oct 2023 20:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6K-0001Mz-0y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6E-0006sc-2b
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso11227355ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279584; x=1698884384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaLDZUlxbnEBMWQWA0yY43XdPUXdultOeDE7cUVCPGo=;
 b=zWaYqCjbKeNOnR4VUs3rwa1DMB0UkEHxvdSx30I54nsoX3InPZzCEBaD3jlxLnpXwY
 /8eB292/CaLsN3XjPbeVH+OADN/y4ENqNXFwMRUbXLDOhLAhEEJxALyzBn4rty5CErYS
 szyDugQxuU0zTxnCxZTTMff3uGF3yQQW36L5Cv2r61Rnm0bky+qV7MnVtLC5jk9SHFdH
 wjAMYuzJnzAQ+kEdtjnCTz3UAJxtXgsdklti5Qt12E2eqo3AjmGyt4WNkEbiQLdwe0XG
 4tPR9f/OODbF3h8jZbotPZaeVR/SbDx35sF+y2pNMeJK5SdESKjWQca7RFNFkjfFWhaD
 xQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279584; x=1698884384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaLDZUlxbnEBMWQWA0yY43XdPUXdultOeDE7cUVCPGo=;
 b=sXnGEpd1tI7XleBoRuf+ezTTPY0MQqsOIvJji8eZFLp4hB4xACiT/uKPpB1ddkaXKC
 l39bwR1v/I+cyxikhxW8JoR0uft0V/NIw/S0yXJkX/6vSnslG5VRGXi9Xl+bZWCD1eZj
 b3GtxkW+i26HhjOI0YafrAT7UomxRX0aQiCJSi5ab0M40ZGz0Bp89pj8jjlkm67Bh9eE
 qK06q4TdblXX08SF9c/helQhKBbp/PSpZciejE1HYcFnx3TzDZboygUl2IcUH8D8Hnk0
 xWrc+rAYr/uYLDQfBUW3oaoHe+MJUUnizW5k75aVNGdelbHjfmvIPNmplJFUqj8FSmbt
 b5bA==
X-Gm-Message-State: AOJu0YztZoSH1amuuS/8CYjWRbTuiK76UrBk9rQlarWBirbKk9twPMRw
 JrIOmwftn6sTEteebEwuHfkpuqnqVJLyDCMfTLo=
X-Google-Smtp-Source: AGHT+IErRqavVHHCzJ7ih8xrXDD0wAAO4oEzwaXSUu6H9wcuCWfDOU/e3EiSMLeE2mMEGvpTH5FyQQ==
X-Received: by 2002:a17:903:32c4:b0:1c7:5776:a30f with SMTP id
 i4-20020a17090332c400b001c75776a30fmr1373463plr.12.1698279583769; 
 Wed, 25 Oct 2023 17:19:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 43/94] target/sparc: Move POPC to decodetree
Date: Wed, 25 Oct 2023 17:14:51 -0700
Message-Id: <20231026001542.1141412-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
index 10b2d1b578..9122f82844 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -740,6 +740,11 @@ static void gen_op_tsubcctv(TCGv dst, TCGv src1, TCGv src2)
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
@@ -2733,19 +2738,6 @@ static TCGv get_src1(DisasContext *dc, unsigned int insn)
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
@@ -4176,6 +4168,9 @@ TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
 TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_udiv, NULL, gen_op_udivcc)
 TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_sdiv, NULL, gen_op_sdivcc)
 
+/* TODO: Should have feature bit -- comes in with UltraSparc T2. */
+TRANS(POPC, 64, do_arith, a, -1, gen_op_popc, NULL, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4731,40 +4726,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


