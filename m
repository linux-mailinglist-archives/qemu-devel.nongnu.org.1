Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41637C8F1E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPil-0006Mn-0x; Fri, 13 Oct 2023 17:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPij-0006ME-Jj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:21 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPig-0000W7-Va
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:21 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c4d625da40so1699634a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232557; x=1697837357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDLVZLi0oYXqwZF/ClfVq+VkFL1OKsuupa4RLhxkefc=;
 b=GMGm1BabKOsph/o1BQF5TmtqFCR2Wf+MbhPMYShnqYtUFi0g6zgXD/tYwHicq24Hu5
 qQ7ye6mqznBVB9OMKWxEzZiiMczc3gYrWef3E1GHChPLfgZ4sTe5LxzbeZoFqp4KfayH
 Y7al7Hxxn0w8oslxpvlUSdv+adkqTM99y5HOTVImkEDcZf4kOgCteglS9gncTHt+Vv7/
 6u92Gy48vWFdlTt69WqV2pxxgzzv6lKhVXIrsMmWT+ijA9etU/uarkzkENkrufOiLjeh
 jRqzvX4buXUnnY1rS5sAoxeQx5UZIBhHqElnXwqAw+GaKFeJavF5b6iAEPNg95BE6jml
 N3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232557; x=1697837357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDLVZLi0oYXqwZF/ClfVq+VkFL1OKsuupa4RLhxkefc=;
 b=q3STwGFd1E2yLSe1VZ3KxAZM3/sNEU8F8mQ6AFSgH6JmiiUAmqyfFJ5vLFFPzprzXL
 wdULG4HGKfaehnh2H0RS9Q5sAAtS3gxbUb1JQSdnSJvPGum/evyW1j2vipGLYYw35jxL
 mxDOb0ekaheBLMSh+M2v16VkCvSP6Gc5bwlsdyA8uE/P/zlsjkl6YC3p5b7LlEty3A0B
 sAiP7dqoA0sGNfsM2Kq5UtiKjnuKvGsDUnnsRxNbsQEhap/wvvReGYubjC0eHUC5MkEk
 ElBBwqtKKaFnbJNU8HkiuLTHuWuuKAcckSorj5SAvg6sMN2m3eNNdt0l/OFT9QZEQxR+
 C/yQ==
X-Gm-Message-State: AOJu0YygV+nW00K3xdYFSUmjIz7R///W/M1MgWJsD8TEYToXlpqaaS5p
 zxF63M+lvDLquMz337lpKt3ZkU7Rv1FY6IYt/eQ=
X-Google-Smtp-Source: AGHT+IFmSblFZrAjBawz146y1TwhCAXe3wCI292Y10q6qKuFUH71+sNtAH3ZxAJGqjO9T3TkCxffZA==
X-Received: by 2002:a05:6870:14c1:b0:1b0:89e0:114f with SMTP id
 l1-20020a05687014c100b001b089e0114fmr34298180oab.31.1697232557501; 
 Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 31/85] target/sparc: Move TADD, TSUB, MULS to decodetree
Date: Fri, 13 Oct 2023 14:27:52 -0700
Message-Id: <20231013212846.165724-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
index 35e7905bfe..2aae7d9514 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -187,3 +187,8 @@ UDIV        10 ..... 001110 ..... . .............          @r_r_ri
 UDIVcc      10 ..... 011110 ..... . .............          @r_r_ri
 SDIV        10 ..... 001111 ..... . .............          @r_r_ri
 SDIVcc      10 ..... 011111 ..... . .............          @r_r_ri
+TADDcc      10 ..... 100000 ..... . .............          @r_r_ri
+TSUBcc      10 ..... 100001 ..... . .............          @r_r_ri
+TADDccTV    10 ..... 100010 ..... . .............          @r_r_ri
+TSUBccTV    10 ..... 100011 ..... . .............          @r_r_ri
+MULScc      10 ..... 100100 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1c335fb826..5f5c24b112 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -655,6 +655,16 @@ static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_sdiv(dst, tcg_env, src1, src2);
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
@@ -4191,6 +4201,10 @@ TRANS(UMULcc, ALL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMULcc, ALL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 TRANS(UDIVcc, ALL, do_cc_arith, a, CC_OP_DIV, gen_op_udiv, NULL)
 TRANS(SDIVcc, ALL, do_cc_arith, a, CC_OP_DIV, gen_op_sdiv, NULL)
+TRANS(TADDcc, ALL, do_cc_arith, a, CC_OP_TADD, gen_op_add_cc, NULL)
+TRANS(TSUBcc, ALL, do_cc_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
+TRANS(TADDccTV, ALL, do_cc_arith, a, CC_OP_TADDTV, gen_op_taddcctv, NULL)
+TRANS(TSUBccTV, ALL, do_cc_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv, NULL)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -4253,6 +4267,12 @@ static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
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
@@ -4680,36 +4700,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


