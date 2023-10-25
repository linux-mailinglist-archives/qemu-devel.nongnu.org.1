Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B17D62B7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIT-0000BM-Rf; Wed, 25 Oct 2023 03:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIS-0000B3-D0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIQ-0004fM-Kw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27db9fdec0dso4706232a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218837; x=1698823637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iO7a+DcsBv1QUswJrwtg846br5OcYCcDIc2AiP9uJP0=;
 b=GQ2pgiuIqFnAQK8yH3/6DCFEbsbdIQU2c3yO+VUYknQMfUfcMeNLwoorsGdzxvdkUC
 p7UQF7P2f2Y+eD19VHQlYz2a/2u3/aaVEAGdHbYOJb1Cx+YNAxmYfzzSDx73Em20l4MD
 sNIRHClMEaKOU8TTJy4lgWZiQ2qnEVZ8b3KEbYD7Im1WpcS4MMmLCTlUq9xIgwd47i/V
 eQOa6ofxOATvkMvnllRB1+BHZFpQfgbw5kIXnOeAUqxdgLMNyV2k7umkqbZ73DV8mGMZ
 p5qBS7kmiqL9C0I+9G4/g/mdXx+4TFxwtNi7ElWai+UdM7Vky5R/s+6slD7odW5OWHKV
 vi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218837; x=1698823637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iO7a+DcsBv1QUswJrwtg846br5OcYCcDIc2AiP9uJP0=;
 b=RFaypAUi6oLkuCqQytwMIqK3vViYntZzowyY4kR1LqgReo0DmpcnoHZHApiVrVUR18
 DUJFxwrxTkAEyyBS57KEstooAnIBGbLzkWR6NxjOBP4RtvC7zMV6d2JycdvhK6sqWbxL
 D5saCAqyK+XNG674GEhXs5V4Ysu+ckek4NNIcodK2n0bEngGJ8MhXtFO/5VmL0pictBm
 iJXOuCOTWTH+/YvEkfvOwFxwnNmB/S1rDKuvBSYL+t5Cag2amkb8zdSgokqajjPIyPU/
 S1QTZDo7Que0PUNakkSxD8hG+r0tRTDU2m4JZ6xDUJazlqmCNJK3wZMeF9kldV1S1hPR
 AxDQ==
X-Gm-Message-State: AOJu0Yx4XGkQdnPsxXqu+KO0pdfVIzAclRDwcrT58g0qZ94x+n4hVsiK
 Sv/Ri/ABvQRHZqkWPx6UKsGwaqyl1BP0Qb58etg=
X-Google-Smtp-Source: AGHT+IFg7yG4K7il5lSweG0/lzzrmSPDA7150VnABN3HQ7dI4qFcW6T86L9bBrZSOros3qzl5pAXhA==
X-Received: by 2002:a17:90a:8c2:b0:27f:df1a:caab with SMTP id
 2-20020a17090a08c200b0027fdf1acaabmr745289pjn.21.1698218837255; 
 Wed, 25 Oct 2023 00:27:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 09/29] tcg/arm: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:47 -0700
Message-Id: <20231025072707.833943-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 tcg/arm/tcg-target.c.inc | 59 ++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index fc78566494..344143cd10 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1190,6 +1190,33 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     }
 }
 
+static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
+                           TCGArg b, int b_const)
+{
+    if (!is_tst_cond(cond)) {
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+        return cond;
+    }
+
+    cond = tcg_tst_eqne_cond(cond);
+    if (b_const) {
+        int imm12 = encode_imm(b);
+
+        /*
+         * The compare constraints allow rIN, but TST does not support N.
+         * Be prepared to load the constant into a scratch register.
+         */
+        if (imm12 >= 0) {
+            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, a, imm12);
+            return cond;
+        }
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, b);
+        b = TCG_REG_TMP;
+    }
+    tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0, a, b, SHIFT_IMM_LSL(0));
+    return cond;
+}
+
 static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
                             const int *const_args)
 {
@@ -1217,6 +1244,13 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out_dat_rI(s, COND_EQ, ARITH_CMP, 0, al, bl, const_bl);
         return cond;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Similar, but with TST instead of CMP. */
+        tcg_out_dat_rI(s, COND_AL, ARITH_TST, 0, ah, bh, const_bh);
+        tcg_out_dat_rI(s, COND_EQ, ARITH_TST, 0, al, bl, const_bl);
+        return tcg_tst_eqne_cond(cond);
+
     case TCG_COND_LT:
     case TCG_COND_GE:
         /* We perform a double-word subtraction and examine the result.
@@ -1805,9 +1839,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* Constraints mean that v2 is always in the same register as dest,
          * so we only need to do "if condition passed, move v1 to dest".
          */
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
-                        args[1], args[2], const_args[2]);
-        tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[args[5]], ARITH_MOV,
+        c = tcg_out_cmp(s, args[5], args[1], args[2], const_args[2]);
+        tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
                         ARITH_MVN, args[0], 0, args[3], const_args[3]);
         break;
     case INDEX_op_add_i32:
@@ -1957,25 +1990,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_brcond_i32:
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
-                       args[0], args[1], const_args[1]);
-        tcg_out_goto_label(s, tcg_cond_to_arm_cond[args[2]],
-                           arg_label(args[3]));
+        c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
+        tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[3]));
         break;
     case INDEX_op_setcond_i32:
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
-                        args[1], args[2], const_args[2]);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[args[3]],
+        c = tcg_out_cmp(s, args[3], args[1], args[2], const_args[2]);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c],
                         ARITH_MOV, args[0], 0, 1);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
         break;
     case INDEX_op_negsetcond_i32:
-        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
-                        args[1], args[2], const_args[2]);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[args[3]],
+        c = tcg_out_cmp(s, args[3], args[1], args[2], const_args[2]);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c],
                         ARITH_MVN, args[0], 0, 0);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
         break;
 
-- 
2.34.1


