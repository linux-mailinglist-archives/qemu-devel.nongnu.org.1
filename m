Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C57317D2155
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWT-0000fU-6E; Sun, 22 Oct 2023 02:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWI-0000c1-Bu
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWG-0001cP-NA
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso18398455ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954459; x=1698559259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loiG8IoonkY1ZKs18NLWsqcd2RIkcRcXOOGkEupcu0Y=;
 b=D6qMMm3jbV8s2IfbqBfKQ4vk4J8U2bDUFp7l2sIDeATeLzHQJ7LWSPrr0yFHleIkK6
 QKFTAPac5PSWmf3nTbUtz7gzg9nlnln9W0LJIA8jcHAGgY3nx+6kr6U2rVi5caodsbcN
 qfhJ+KQbF7gx/mS+LZIjB0irA/bU0EOhcDDftVOLn8lh4SekkjYkRlmsYgvWtmqLHeee
 A4Xa9AZXFi58D+Ljhw5O+YNkDASXaKaeN3oc5bm5SZT0DmbcdkEkZJ1TKZ2zwwl3Ba6z
 gs2edkIYsxELJKLxCXZFFJfTVhP2IwPyz0dcGJ2fUBFhf/B6cxbqHsYX68Br3af2DjFa
 6cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954459; x=1698559259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loiG8IoonkY1ZKs18NLWsqcd2RIkcRcXOOGkEupcu0Y=;
 b=CEM8V15lqsqVLT6D1djY86bbLyxb/kRQuoYDFv0H8y2mdfe1kgY0jHZtvxZkGz02Aq
 DD9K97h+KNeEuygfVon67jfFF5r5jafLy2CQo/6Ffp4mfSWhYjNCG1oMtiKqoFBQnedE
 db7A2Nmdcz5toxpXSrJaq+I0aCI0u5LSJ8OhWJ5ZK7f0kehakiWAz/8oMb6E+vXi109p
 ZCpgNT9aPdP8POGvafI/2n0GSGThqv6T+uRtbwzc4vlq+ydENom4Ys7IZkpR/YeCu3eK
 rJCQQktHmZmaWdm9bMUjQtLbT+O+6uEBKo9UyhfOPdRwCKzYkN20aappRl+W5q8a55Dm
 p0cw==
X-Gm-Message-State: AOJu0YzEpFZtSeeZKP6zPMbnBX+469RCZyKuGl5W8Mmnpj/u9Ed5a/mu
 joaN1CfPBPSTWQqx+l4GyM7u4YDLD7pr/LGPzwM=
X-Google-Smtp-Source: AGHT+IFV26Nd2d8HHZlgwSboW05icXCe7MzfdCQgG8aeURa6HHCGuUF0lDGGIFTQFwTVN5GpdDmSAA==
X-Received: by 2002:a17:903:455:b0:1ca:3e64:2378 with SMTP id
 iw21-20020a170903045500b001ca3e642378mr5843439plb.4.1697954459312; 
 Sat, 21 Oct 2023 23:00:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 32/90] target/sparc: Move UMUL, SMUL to decodetree
Date: Sat, 21 Oct 2023 22:59:33 -0700
Message-Id: <20231022060031.490251-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 21 +++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1a04a8e229..d6a7256e71 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -167,6 +167,8 @@ XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
 ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
 
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
+UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
+SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index be00bd00fc..d79e28ab7f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2882,6 +2882,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
+#define avail_MUL(C)      ((C)->def->features & CPU_FEATURE_MUL)
 #define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 
 /* Default case for non jump instructions. */
@@ -4211,6 +4212,8 @@ TRANS(ANDN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, 0, tcg_gen_mul_tl, tcg_gen_muli_tl)
+TRANS(UMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
+TRANS(SMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4701,24 +4704,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xa: /* umul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0xb: /* smul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_smul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
                     case 0xc: /* subx, V9 subc */
                         gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
                                         (xop & 0x10));
-- 
2.34.1


