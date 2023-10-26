Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE77D7950
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2s-00076j-36; Wed, 25 Oct 2023 20:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2m-00071R-PJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rF-LV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1caa7597af9so2154635ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279359; x=1698884159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iO7a+DcsBv1QUswJrwtg846br5OcYCcDIc2AiP9uJP0=;
 b=B3IKCrTCuxR2MudJLPC3lJ30xjkNeoqfVBoqWgNQuFjoZUBCDhdNcpCtXnnaz2bSpA
 KE6vjL2G8VPOQpQNgAn68BsSqZoOOx9hB/1s5Rjl8lPhQzcktf2xJkkw9JmdpeOHcP2D
 igogNGaJRxaYy1tI2BAPiUsrOFOD+/6RGuvceDp4BnJJLUnvowFOX0DIf6mH72c98JVF
 Ou4fE9qkGHjhL5oUP5+LgQLr0gXPMik/dPNjUCHpZoMl2pRTDs84QxBAcrbvqLn3YsiO
 kuLluEAjFIYJafDkKRkr/9yZF+ZK/nY6esxH0yZ1Cestyip/nelu4kIEoyKlXHpk167D
 Xu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279359; x=1698884159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iO7a+DcsBv1QUswJrwtg846br5OcYCcDIc2AiP9uJP0=;
 b=svbZWHxemeg+XcyTFs7LtF037/AOn3YtAPtKUDB/GAsKY7v38koHJxqGO7wCD8b0nE
 dpgYVjQhj9ob6FwTmzm6WSRkw/Nt+GLI6dQmh6XKGVisbCMmo5BvYIORhOI/ntke8Pb3
 pz4BFnu5p5ZqZbkbzC9dOBw7/7ldC2BOAW5BeEFBDco7smOz9E8cl33CdvwOkW7JPt2q
 773ev57Ning5vlxNgg3UED1H1dwxPXExQ73eoGAsMIN579M1nym7EyZdIRPx+NrPBcQI
 RPnCPC7p7Frq6VAcLa82O07qGdB9MwYehW34Ug971jRnCpVZQOWdk285jQlD4j96cS/s
 vwrA==
X-Gm-Message-State: AOJu0YxmEzdguBBhRsJoM0qQBYaBCx50H0N0qs+kf+35OFoFq70lGQII
 Y0wBcKwthupIvvqWLvmkgQFpw84hiCylpmltH+0=
X-Google-Smtp-Source: AGHT+IFj8EvNuYPBt+WJBapaMLaEKAYU93EDM7LuwtwgoljrQswJ5mQKC+J/8exd1Xat7ImuyQyK6A==
X-Received: by 2002:a17:902:e551:b0:1bc:3944:9391 with SMTP id
 n17-20020a170902e55100b001bc39449391mr15752792plf.25.1698279359121; 
 Wed, 25 Oct 2023 17:15:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/29] tcg/arm: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:13:57 -0700
Message-Id: <20231026001542.1141412-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


