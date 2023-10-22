Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E77D2715
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtq-0007MV-9U; Sun, 22 Oct 2023 19:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtZ-0007IJ-Py
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtY-00072B-4B
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-694ed847889so2136404b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017406; x=1698622206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZO5lemXVvg4EBtLG5t9A/G+USNmFJlyOA5fd86/h+E=;
 b=kcmG43y/ZwMqP2u/MW/cP1E9Wgg5eU3xQ0YHmf6JIrm31PT1Hi0avnewX+wYCU4rfe
 /iU0/EDPsM/VBxVS5V5h4mI8D9Tb88YPjGvG98FzUsCkH6NZ6DP7WdEUGSbPcyKqHncj
 t8y9UNm+0kIQ4WUn9jy/TJwlp5aE1IfNEX7S1OdtGLJJ8AcuqBZmiz8AZIypLONIJzT9
 8BMJeagbfsM++M/2sJ62J6V+Wf3Flrt5lHOrGI2Ff2P64YY2nmLYnSHIDh6HP73QyNrv
 XhC/ep9rq3CAzpl9hPpSYsfdGHfMG8SecQsq/YUKjKIcoPSRtBuXV+yKx6mrqtu1Y8eG
 Zyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017406; x=1698622206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZO5lemXVvg4EBtLG5t9A/G+USNmFJlyOA5fd86/h+E=;
 b=g17Ye2SAhtJyuX3NtDluo0yIGE0gvD+FGhy7jOp382yRCWxl0mQWkyPWZ0kCkKsHRA
 YOFVPs65CV1n21aRoF6n3P2Z3V7SQhpC2pIyavSxkSfBUMJWMDaWorsXqOSXiTl16fko
 fK6jNIfZquXNRE/FXNGElV0+R4ewaOdEtAYQPeAo47vlm900beq9rzpHmodLS1EscTAf
 jdo31E+sFNHcSw3aEJxdimhyll6/+3JnaAVh3KUFTCYx5TNXvYoz35QR47uCbYax4eCr
 blQwqDJ6rgYVOIe1wcS747uAD8BmvMdsFt/dc57xcP8yq8mmbKp8Kq98AECa/2Zb665g
 Ilvw==
X-Gm-Message-State: AOJu0Yx4vEfBaUS5IK/upJVqfQpLL7CVHnQADhpJZqUrd7PnHbEeltRO
 k2qGp7/UbZ7K2tuv3Of9XrpLMsEQ07hkR9Ekppk=
X-Google-Smtp-Source: AGHT+IGYdhsRIurM9CvBvHamke1RFjb3ZRTI+gDt2F9oADJQSHyNTzTJtUJlv/r71/0SKy6BuHev3w==
X-Received: by 2002:a05:6a00:194c:b0:6bb:8982:411c with SMTP id
 s12-20020a056a00194c00b006bb8982411cmr5807021pfk.8.1698017406588; 
 Sun, 22 Oct 2023 16:30:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:30:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 38/94] target/sparc: Move UDIVX, SDIVX to decodetree
Date: Sun, 22 Oct 2023 16:28:36 -0700
Message-Id: <20231022232932.80507-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index d572a02724..da530ff0a3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -47,10 +47,12 @@
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
 # define gen_helper_saved(E)                    qemu_build_not_reached()
+# define gen_helper_sdivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
 # define gen_helper_tick_set_count(P, S)        qemu_build_not_reached()
 # define gen_helper_tick_set_limit(P, S)        qemu_build_not_reached()
+# define gen_helper_udivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_wrccr(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrcwp(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrgl(E, S)                  qemu_build_not_reached()
@@ -698,6 +700,16 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
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
@@ -4115,6 +4127,8 @@ TRANS(XORN, ALL, do_logic, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
 TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
+TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
+TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4610,11 +4624,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4752,10 +4761,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


