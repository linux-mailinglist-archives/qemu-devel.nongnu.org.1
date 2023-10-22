Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606A7D2728
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:35:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwi-0004WH-1V; Sun, 22 Oct 2023 19:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwd-00043F-4k
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:19 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwW-0007UB-Sy
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:18 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b3f6f330d4so1436039b6e.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017591; x=1698622391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgJxWrLUXVkUN0XQXaFw+Vs9UAlI/canSzkQAgwF54c=;
 b=mZJNVGQ9dAE5khB0VEtB6ZwDXce3ELCWalLlLri1ZYWrHXA1oLokUXhVzG5Jk9+nw8
 ir9x9X88zgoNo3OiYzdBrC6JrQFfO/GrqGZ4QarkrP2wWx6u0NVHVMsLOFXRImlpi69L
 e3gPYoNhFr8S3Gjf/diCpbPb2CXBdYdNbsa2UoHEYQN6WyW5bsLYw+/XLYu7p7It6GTS
 Tdoe4s+S0Re0mXnmbkV5b9JY9jBdkcaHzwj+hIxw0THb6qzfKzN8D7eFB1THB9peYuDL
 m0G01COlnKmGADxp01VaKqdwJZU7ckIsH3bvcwK7vxPjZwLa/N6AISyOE3z3gvd9dS7j
 /RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017591; x=1698622391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgJxWrLUXVkUN0XQXaFw+Vs9UAlI/canSzkQAgwF54c=;
 b=BzzvlUNilTAIBfkgHNR/vVliaiQj3J3xrxKq/ehsEA9FK4T8wr17o0u9NbCtlQxLbT
 PH6JERop+/wsXjimkpRnLWDhCpDoIpCed9e5bLS9LnOMiFVIgP0xEgmxLOg4G22lzgMh
 OL/Sqcgu8aRLqx743UA+TXDPYrhUkMJCCMtQ9xT2KmnWZSMz9UE6lxRqqPME2kADAGKn
 jFwEZ5DDjaVVRBE4w80n6xSw/oEg92uzc8WcfE1t9Lj+/c4SHGwwkcgCcdTPGSmtqqDZ
 FS82hkbJNs/SebqNNXje5D2VFrkc7Xm2J9sLb+79m4/psUSBmNx3QCGX7CnwmDtbNGdL
 /SNg==
X-Gm-Message-State: AOJu0Yz1zYRrsxaCVccZJvtwWHfPYAqLQnYVK+FDtpqYG8RtLjIMijiT
 XHhbGoRTpvrDJHhVP65KMuch/8MQUdOJu0Y1Tl4=
X-Google-Smtp-Source: AGHT+IEsNFvxaqu8FXeLSpA0nqW1sYRVqVg3vCo4HN/E/cvNDLfFbYBWkHQeCDIA/FMVqMryE2V9ug==
X-Received: by 2002:a05:6808:3c7:b0:3a7:73e0:d18f with SMTP id
 o7-20020a05680803c700b003a773e0d18fmr9182844oie.14.1698017591286; 
 Sun, 22 Oct 2023 16:33:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 43/94] target/sparc: Move POPC to decodetree
Date: Sun, 22 Oct 2023 16:28:41 -0700
Message-Id: <20231022232932.80507-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
index 1e9f5c660a..2050193cb0 100644
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
@@ -4168,6 +4160,9 @@ TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, NULL, NULL, gen_op_sub_cc)
 TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, NULL, NULL, gen_op_taddcctv)
 TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, NULL, NULL, gen_op_tsubcctv)
 
+/* TODO: Should have feature bit -- comes in with UltraSparc T2. */
+TRANS(POPC, 64, do_arith, a, -1, gen_op_popc, NULL, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4728,40 +4723,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


