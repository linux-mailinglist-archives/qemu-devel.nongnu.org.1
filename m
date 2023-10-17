Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E788E7CBAE3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:19:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKZ-0000pY-Ct; Tue, 17 Oct 2023 02:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKQ-0000kH-Q4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKO-0003xf-Mh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso42644095ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523195; x=1698127995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOvQ9vN+isuXim3kJTjKf4QoMsy15rCiHw37mEg1HDQ=;
 b=FSaWoelQyyBU10HO5fxO82vFt0bxwOFa5RYXmfEwqWYYzGUafH8/Tge5Zt84OcJ+db
 5gzeD3y8uzZjLuFbwD/WzFrzPo0RD6P02VkyS0kK9Yu9r8NqlKrqyN58eq/u7AKWHCwN
 7g5pJ/SSm3wv1EHe/PZOc/QTB4b95SFWDwbZabACamGWXeJ3vJjHKhoPVXaxW7gzhnuE
 wwuJRdlXrxfuu5KAu/oDfmnEhcLSv4F0zhAibzYBsr1ZIxX8yUd2DC/HXaxkAp9tbZ/y
 ohUGrUgIlIRk6NA1g8cZ3MMiqo06EpXmYfDfZz1nsM3GGAZvahsaIvhWDKIJ+oY7Kpsl
 mtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523195; x=1698127995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOvQ9vN+isuXim3kJTjKf4QoMsy15rCiHw37mEg1HDQ=;
 b=n+mMWThZOD3jMDPD4fnNYp7PiSU5TfRE9LMbr6NQdpEPLMQuxtJB+0hm2XojQ2COET
 sFk6dlBpQ/bw+m3z92lRdZL8XX/9MeXvYDO6EdgfGHl1ma2i+Y3zf2PbqI5KDMmtBWGq
 1pYga9vLC5a8Gjn1/l1CPGFWvWEEkBTurnD3Vz+iIfaKiX6SYkj+Dtgp4ZMwmWnHyKDy
 OhugQL0Q5sa1AhmNogy+mf/FtYdnkALrfsMZKX9eYypHe41nwUa1dz4tR3QrlUeMOABD
 Uyp6dYgQWfdQlfhn7yabUTkmwwGiOgolgc9QfNf3SccHVgfQNNgloIlP0oIFv68urOmU
 cIoA==
X-Gm-Message-State: AOJu0Yzw6quc35iT1ka/E/KWRcLsdcntKZGY22VJKdWFSH91Sw+gZwpX
 Xaz2Q9OYeq8u8oB4r1GcU5r7H+YwuRqjQ81T8vM=
X-Google-Smtp-Source: AGHT+IGl/0bPJuHmtOYHhn7jc9h5PbpEFllPFrJQkOXxnHn2BwYuHxubEHPbTOGnMgH6TYk4Skj/Gg==
X-Received: by 2002:a17:902:c382:b0:1c9:c0fa:dfb7 with SMTP id
 g2-20020a170902c38200b001c9c0fadfb7mr1491366plg.57.1697523195267; 
 Mon, 16 Oct 2023 23:13:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 35/90] target/sparc: Move UDIV, SDIV to decodetree
Date: Mon, 16 Oct 2023 23:11:49 -0700
Message-Id: <20231017061244.681584-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 66 ++++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a2512d8d47..7d1afb2a87 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -180,5 +180,9 @@ SUBC        10 ..... 001100 ..... . .............          @r_r_ri
 SUBCcc      10 ..... 011100 ..... . .............          @r_r_ri
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
+UDIV        10 ..... 001110 ..... . .............          @r_r_ri
+UDIVcc      10 ..... 011110 ..... . .............          @r_r_ri
+SDIV        10 ..... 001111 ..... . .............          @r_r_ri
+SDIVcc      10 ..... 011111 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c2e4172872..d57df60170 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -655,6 +655,26 @@ static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_sdivx(dst, tcg_env, src1, src2);
 }
 
+static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_udiv(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_sdiv(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_udivcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_udiv_cc(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_sdiv_cc(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -2869,6 +2889,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_64(C)      false
 #endif
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_DIV(C)      ((C)->def->features & CPU_FEATURE_DIV)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
 #define avail_MUL(C)      ((C)->def->features & CPU_FEATURE_MUL)
@@ -4166,6 +4187,17 @@ static bool do_arith(DisasContext *dc, arg_r_r_ri *a,
     return do_cc_arith(dc, a, -1, func, funci);
 }
 
+static bool do_flags_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
+                           void (*func)(TCGv, TCGv, TCGv))
+{
+    if (do_arith(dc, a, func, NULL)) {
+        /* Assume FUNC has set env->cc_op and all cc_foo variables. */
+        dc->cc_op = cc_op;
+        return true;
+    }
+    return false;
+}
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri *a)
 {
     /* For simplicity, we under-decoded the rs2 form. */
@@ -4201,6 +4233,8 @@ TRANS(UMUL, MUL, do_arith, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, gen_op_smul, NULL)
 TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
+TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL)
+TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4212,6 +4246,8 @@ TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(UMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
+TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_DIV, gen_op_udivcc)
+TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_DIV, gen_op_sdivcc)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -4695,35 +4731,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
             } else if (xop < 0x36) {
                 if (xop < 0x20) {
-                    cpu_src1 = get_src1(dc, insn);
-                    cpu_src2 = get_src2(dc, insn);
-                    switch (xop & ~0x10) {
-                    case 0xe: /* udiv */
-                        CHECK_IU_FEATURE(dc, DIV);
-                        if (xop & 0x10) {
-                            gen_helper_udiv_cc(cpu_dst, tcg_env, cpu_src1,
-                                               cpu_src2);
-                            dc->cc_op = CC_OP_DIV;
-                        } else {
-                            gen_helper_udiv(cpu_dst, tcg_env, cpu_src1,
-                                            cpu_src2);
-                        }
-                        break;
-                    case 0xf: /* sdiv */
-                        CHECK_IU_FEATURE(dc, DIV);
-                        if (xop & 0x10) {
-                            gen_helper_sdiv_cc(cpu_dst, tcg_env, cpu_src1,
-                                               cpu_src2);
-                            dc->cc_op = CC_OP_DIV;
-                        } else {
-                            gen_helper_sdiv(cpu_dst, tcg_env, cpu_src1,
-                                            cpu_src2);
-                        }
-                        break;
-                    default:
-                        goto illegal_insn;
-                    }
-                    gen_store_gpr(dc, rd, cpu_dst);
+                    goto illegal_insn;
                 } else {
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
-- 
2.34.1


