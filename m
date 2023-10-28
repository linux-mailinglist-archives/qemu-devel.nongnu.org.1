Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9F7DA901
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFw-0004q1-2Y; Sat, 28 Oct 2023 15:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFZ-0004jW-PW
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:38 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFX-00047J-Fa
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:36 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5869914484fso1837349eaf.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522334; x=1699127134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+X+7ARY9SpSCXVHzvXgsobDyxq2/hmAeX0xNgjlPdBc=;
 b=ZZLDrppBtDL6WGy9L2p3qtEEM3uT+RE646bgScGbXXIbZHHl161NrAlZLlTeava1L4
 +g2LDD8xUuf9BXWYfAI2p7iTIV2qNz1gZMFUEOpIujyB67QzU+6LSnUTo6NN8MYPkuLl
 1uUUlF7aVN3vEWU30wKj0qn12Nttyo9EpcvzcLragG9afGzeLJUNzgCI3b0e0mc9cnb5
 rrmW/TmjSMDiKLdh5lgBkcZ0UzbzZ1ujiSO+Sm0gzP/lUYidxFRhOXFXQebmlp0tTcLp
 E6b8WrWlTx8c5nh7EPhyBNZ1S9Q6ls9julz71wnz9e3BjpAneCVziI/H9G5YK7Bo2MxW
 VfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522334; x=1699127134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+X+7ARY9SpSCXVHzvXgsobDyxq2/hmAeX0xNgjlPdBc=;
 b=U/0Z7wnIcGPAVIUMgcs3EKhlUz+/BnVPOuylhZ4F89dyrjVv1PLrwOCUp6/s/BGChm
 MYN2fzIuQ5anMTP8I3QAeSp6eMAMJUB4aqj3R69ITDyNj+fB7kVwZgg9nBTsoQR6Mem+
 DSSJohAxbGBsD9w6QUxZE6/AUwkQWdpRF50c2JJazkId7zSCeNnBKlhm0xSQjMdAS0cK
 MMHhUVHbdbp4jedHLYcf5xfUxPGGZug01WgwlVfVPbKqANHJfpc5JeJkb1GNkjHWZECK
 r8i0BT9p7mOOl+wZmYIK7K4oAxFMrazR6o8mi+HAblembpr+dtgMGEyRpWwwM0ILV/U/
 8oeA==
X-Gm-Message-State: AOJu0YyAE7iG0MKhOQE6Hbf4pwAMLMe7X4oYQuVK1dX5F+m+oiEPt5vG
 GZrht1h1hb5+el7S3te8UV87KCblXnYGAXV14ek=
X-Google-Smtp-Source: AGHT+IEq8p8oKtD7qUFRQSJWWSf4oxhqo2o84Xbn9WrsmIrB3tIjarOXrqzSGXeRY4zf5bqNyMdHhg==
X-Received: by 2002:a05:6358:186:b0:168:dea8:8897 with SMTP id
 d6-20020a056358018600b00168dea88897mr9012239rwa.22.1698522334245; 
 Sat, 28 Oct 2023 12:45:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 11/35] tcg/arm: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:44:58 -0700
Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
index 0c29a3929b..0fc7273b16 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1191,6 +1191,33 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
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
@@ -1218,6 +1245,13 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
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
@@ -1806,9 +1840,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -1958,25 +1991,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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


