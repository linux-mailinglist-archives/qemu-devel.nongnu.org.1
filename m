Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A94167E5983
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:54:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jvH-0001RW-Ie; Wed, 08 Nov 2023 09:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jvG-0001RN-DX
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:52:50 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0jvE-0002Et-Ld
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:52:50 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9d224dca585so1080829566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699455166; x=1700059966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDdmF0dac/ehT5un6rtZ/BCMjBn2hJpxmqGf5ogGxBQ=;
 b=Kqc+ZR+ECvky18Uf5Itzb+3xwkoHGJx68mZsZXkyBwsrOwAeORrC0WrLpinNBEo/Th
 yaKgobDaGxzEqFUnqfliaMxCwJrwa6NmKaV8RZ4M3nABvomPtnjKuhR3GBFOrBx49KVO
 cBG5xMcGD8y8Klo9YorJs4B65HFEzKp0KbzJwF+3ugQmglgzLrTNwNXoktATEQnW0Qno
 tgzy8M5DH0359y2aNlpezeKAqbGqkSo0vgIJUrB0r0KCpVL/AEv3PY5bxd/vwn8cptiX
 krqGv5ye9OZDaOIBjq5nvxg6Fk7NrFT2pcCeu+9ZVYuOW50Vs0XEPX3xWJn66SL17iSB
 yTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699455166; x=1700059966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDdmF0dac/ehT5un6rtZ/BCMjBn2hJpxmqGf5ogGxBQ=;
 b=lkx61qmh2LBdEvuIW6ZUEetveEFapV/KRdYJ3mDnZPR8btpjD0YLiHDVpKdYSql3Nl
 vDdV0JXlYmEHtA0AsapfyZxP7KtMid9D9iHCaiqdbfeATcXZvJQ4aIgUxnWQm/3DJ0xF
 H4cCy5pZPfIgW8+FdXIhDGuWla+9iAGCBTqpMRqlauT3mFNyRzhDr9R8mEGRVl+k6Nuw
 +w0AcMIWXKPX4YgVqfUUVxbvjGnqdytcOdqUAb8dg1+DN8CMFaBXPNpMV/0vjSmAyrBQ
 h3qyWQ+rj/2Yx38k6LHtjsPRl2SLfw6dOMAuXHWVhYhY1wLFAhJPKEdYtAsgsxWNMUYz
 qwOw==
X-Gm-Message-State: AOJu0YyGvhrEFC+HocLT66/IcS0kaYFEighLSUbEZ/ZKsPT+A7fV8jxh
 2S4iPPVnUDPEcgweMvIHEMxIQq5+Rt6ZB96M//A=
X-Google-Smtp-Source: AGHT+IFlXkjY7dXeGSKYUQMyPAb/+GrSj08DX4hjaF02XmSgRhu1Hk1NpDdFgTEks8PtLUgiSTZRdw==
X-Received: by 2002:a17:906:794a:b0:9e1:21d:fdaa with SMTP id
 l10-20020a170906794a00b009e1021dfdaamr1903099ejo.57.1699455166606; 
 Wed, 08 Nov 2023 06:52:46 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170906455300b0099bd1ce18fesm1165398ejq.10.2023.11.08.06.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 06:52:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/35 1/2] tcg/arm: Factor tcg_out_cmp() out
Date: Wed,  8 Nov 2023 15:52:42 +0100
Message-ID: <20231108145244.72421-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028194522.245170-12-richard.henderson@linaro.org>
References: <20231028194522.245170-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 0c29a3929b..66d71af8bf 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1191,6 +1191,13 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     }
 }
 
+static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
+                           TCGArg b, int b_const)
+{
+    tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+    return cond;
+}
+
 static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
                             const int *const_args)
 {
@@ -1806,9 +1813,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -1958,25 +1964,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
2.41.0


