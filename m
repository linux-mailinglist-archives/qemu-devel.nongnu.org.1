Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFDD7D2144
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWy-000165-KC; Sun, 22 Oct 2023 02:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWn-0000t0-Ng
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:33 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWl-0001hi-W6
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:33 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2ea7cca04so1666426b6e.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954491; x=1698559291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsR3F96YR7aN/izdjl7cahAVuudrq9GJhuWfBWDFflg=;
 b=KShtr8Fx9sDwbtO40Cte6B9fCV5mXq+BjYLJXNJoW/O0qLYN9wHmKEOunScwaFiQuz
 HrMzW5C38nc9ssrm+S48uhiHvDndcOi+ikqASFBJJcxqKq0k4AF7Cmp7KhKn7uEa+Y0c
 RoQlAfI+E8trKFIORXeQ8p4biSGddzEAReWqtfyKAe/fy1H2aIGilTwzw6f8sSxGOiE+
 JdhXsGnyfeGKb+WAJxCETpBpcIvGNodiIhXHFjTllHh2ebVvK32yU7V0XW9B26W522U+
 4LukVF6H9/k1rPLQQPNa7ji6xJ0RFxdJZkKBxgg6/DY+MjViNDcNl2X7Mmef5hiqHNQ0
 WpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954491; x=1698559291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsR3F96YR7aN/izdjl7cahAVuudrq9GJhuWfBWDFflg=;
 b=LkXwih432tnwhe7rYzRtfFSOpaJ0nMFl0zsIiha5UvBrH2czzR+sbZ8o5CNjnE2Qo3
 3boRZ+QtEp+NLYq+rLQxaxXZSSn5ZZCg4vv+Ei0FFUS5+9ky1b66BfDJUGmR8vHeN7s+
 IGiRfgdchOOXQP/QtbIu6nkgtOwgcCcibBzbIlqLhRyjXgKKdHTeqL33kH0wyRqYI4b0
 fuEun5+WXn2hwsmdtUUeFyKyInUD2hLTt7yyBEz3I0Ba5CCiCfuco+OsDVYRXLPkSaop
 C2wRy1USiQgBE/MNSYIPtr9oc8Zw8sUPd7jXCisoJgppB5ne7iGd088oi9hVTopZ1s2R
 k9mw==
X-Gm-Message-State: AOJu0YwQukKU9saVUy51mEyQoFZtMJrReEtWcUDrjVxX/rBx+yVUK8Bv
 bc0AEP4q1AI5YbAWp8cUOg54d0d+F8fxk9cbZxA=
X-Google-Smtp-Source: AGHT+IH4VgAYPcKUA14RH5xS5PB1dfIiW/Volx9rTOzu5XK/i9qiBJWBk4dOLUA/yEjN1PLuS9kUVg==
X-Received: by 2002:a54:400f:0:b0:3b2:dda3:aea7 with SMTP id
 x15-20020a54400f000000b003b2dda3aea7mr6143608oie.57.1697954490903; 
 Sat, 21 Oct 2023 23:01:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:01:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 34/90] target/sparc: Move UDIVX, SDIVX to decodetree
Date: Sat, 21 Oct 2023 22:59:35 -0700
Message-Id: <20231022060031.490251-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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
 target/sparc/translate.c  | 23 ++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a188452d2e..dd0ed3a993 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -171,6 +171,9 @@ MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
 SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 
+UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
+SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e2a74a816..6ea857d8ee 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -53,6 +53,8 @@
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
+#define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -685,6 +687,16 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
+static void gen_op_udivx(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_udivx(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_sdivx(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4233,6 +4245,8 @@ TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, 0, tcg_gen_mul_tl, tcg_gen_muli_tl)
 TRANS(UMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
+TRANS(UDIVX, 64, do_arith, a, 0, gen_op_udivx, NULL)
+TRANS(SDIVX, 64, do_arith, a, 0, gen_op_sdivx, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4755,11 +4769,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-#ifdef TARGET_SPARC64
-                    case 0xd: /* V9 udivx */
-                        gen_helper_udivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-                        break;
-#endif
                     case 0xe: /* udiv */
                         CHECK_IU_FEATURE(dc, DIV);
                         if (xop & 0x10) {
@@ -4897,10 +4906,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                             gen_store_gpr(dc, rd, dst);
                             break;
                         }
-                    case 0x2d: /* V9 sdivx */
-                        gen_helper_sdivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
                     case 0x2e: /* V9 popc */
                         tcg_gen_ctpop_tl(cpu_dst, cpu_src2);
                         gen_store_gpr(dc, rd, cpu_dst);
-- 
2.34.1


