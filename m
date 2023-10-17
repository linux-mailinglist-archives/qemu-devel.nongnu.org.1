Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D37CBAF0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKb-0000qY-FS; Tue, 17 Oct 2023 02:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKT-0000md-JP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKQ-0003xn-4m
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9e072472bso31802815ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523196; x=1698127996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/Kdhx62080PZQNabIW6Asll4+EMMOl7ER0zDU4Whso=;
 b=jIFTF2vOGjD7Dn1qETrwBqHd24Y2VIhOYNF+jUvVbomC97aIG4JqaLb/ODMyjCPPbt
 1yPwvNlMygtNJKiLxdO/fI1fxgBZ4CLddclOE4P86WP8M9Q2KGFNr7Ton3bGTh82EA3Y
 Ew0SrYKD6oC6uaQBm7JCkiFrVRv+svxopeXc8BFZ5N+0fCf/s3qGAQtCFL9tA72nwv+X
 QVXw5cUT1nlLhDWXWflN5K2HDxeDQXFtvFiHlPfJKU7XWQYsuB1ntgxVsewvDE+ANdnB
 k4PESqXafNHxIIQ03FScJHkFdsjZLupxACF8+h3UzNRxw0vqzfVmKbk1FGPeE19h1/ny
 81rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523196; x=1698127996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/Kdhx62080PZQNabIW6Asll4+EMMOl7ER0zDU4Whso=;
 b=erVyQXJIHgmp/MHu4adP9dIUY2lhIxi++MRQ6RI8hr8XqRn/ffMny658knfzoEd20D
 lqB3aXg+aoTHe+cIAJHKZNd9ortcspk5VtJesr0CuBsO/KuWCAtoUr7wDGgOmq2roC7c
 l+0a7SeKuYRMK4pzygv+P07Wl/c9TowsNroJsvBuMuTyuXHBu+LMZSc1f/JIwsQCIH9B
 OLoF2GGS2tHk27aN3CpD5Ob88QjSTBZLit645rdjYilJlctbe82g29H98FsxEo+F+Zlj
 IqbS5a+lQfGCJvmsI2tvVfece0OpoY2tFN/T4v7MJJLckng5f33jPkzpBVQCB5dk5oXj
 TqeQ==
X-Gm-Message-State: AOJu0YyeHUVMAAqDLGdIgfIpmzVGlCniwzEY7L0AGQgZiIW+TdXpIoza
 vfRXsGB2bsUxX59Eh9uu4Suljg9mHlUPXwQBQ18=
X-Google-Smtp-Source: AGHT+IFq/+QbOg55Vmkr1BaqZ7qOqAwViGyqwGTt++7fDcPJ1CJ1LwH889EyLTH9V8KQVUgxevUo+A==
X-Received: by 2002:a17:903:24d:b0:1c5:de06:9e5a with SMTP id
 j13-20020a170903024d00b001c5de069e5amr1593570plh.21.1697523195960; 
 Mon, 16 Oct 2023 23:13:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 36/90] target/sparc: Move TADD, TSUB, MULS to decodetree
Date: Mon, 16 Oct 2023 23:11:50 -0700
Message-Id: <20231017061244.681584-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/sparc/insns.decode |  5 +++++
 target/sparc/translate.c  | 47 +++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7d1afb2a87..18e2372928 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -184,5 +184,10 @@ UDIV        10 ..... 001110 ..... . .............          @r_r_ri
 UDIVcc      10 ..... 011110 ..... . .............          @r_r_ri
 SDIV        10 ..... 001111 ..... . .............          @r_r_ri
 SDIVcc      10 ..... 011111 ..... . .............          @r_r_ri
+TADDcc      10 ..... 100000 ..... . .............          @r_r_ri
+TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri
+TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri
+TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri
+MULScc      10 ..... 100100 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d57df60170..4adf2cc3ae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -675,6 +675,16 @@ static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
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
@@ -4248,6 +4258,10 @@ TRANS(UMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_DIV, gen_op_udivcc)
 TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_DIV, gen_op_sdivcc)
+TRANS(TADDcc, ALL, do_cc_arith, a, CC_OP_TADD, gen_op_add_cc, NULL)
+TRANS(TSUBcc, ALL, do_cc_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
+TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_TADDTV, gen_op_taddcctv)
+TRANS(TSUBccTV, ALL, do_flags_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -4310,6 +4324,12 @@ static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
     return advance_pc(dc);
 }
 
+static bool trans_MULScc(DisasContext *dc, arg_r_r_ri *a)
+{
+    update_psr(dc);
+    return do_cc_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4737,36 +4757,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


