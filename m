Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0580781559
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j0-00050S-HI; Fri, 18 Aug 2023 18:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ix-0004zN-CV
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iv-0004Og-6P
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so15825095ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396820; x=1693001620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHAzG5NBmtmmlBFRwBpOEZ4Jp/kDiJcy7WVkYVKJlgY=;
 b=mi76i3PnRlZJ96hQin4pgNk86ZJmdXPdZHPGEE3ykP+eB6bM8OdnnLRGYNMe62448X
 GxV5dioxzzE78B/Lsm3wc6QeMQV3GKmzMDniDOeYtdizPnj3dEHNqePzqGFtd6t9MXtD
 FCWcpGnQgo2mdEp6ZWgxuEfjxHiSivYtrI5QKPDcOQShce9rUg0IlTO1ep3yWRMf/wBD
 YT/qM+TPOaLz5DBTA7P71RYyyR/2UUzjFbzGM47dLdLJOF0UjhiSEQE4O8SNFMH+s9Q7
 i7Ez8nLTWTESFWIfVMdCW3DIAmS2h9MrsimrL3FUCAB8Qw2rZnFw2w+rJ4rUxHRwO/ZK
 OQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396820; x=1693001620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHAzG5NBmtmmlBFRwBpOEZ4Jp/kDiJcy7WVkYVKJlgY=;
 b=HD/aDNq0/VFEdej9zWInYGGLFzCAaWtqOWStRNh2y8Eh4xYQAIWHNf2+fF5TuDQLrk
 6RDMi2c2VIvKXPA3yXvhaP8QVqnjjgi6lrxN36Xq6fi+iAnLVFnL4vUNg49ON5y2QYiN
 GRdTphU5llM2yJcOE0Y0SXsZ8+TWw9/lqdDQQ0RbfJ4sBFDCNsDe2hKBkNM490GdnyjE
 5WW5T0V1aAjlL4j7h7Smn0X0iXlpswqbGVC2aMlMfsU429VKwoNjG158VxAPLdjoLqdB
 gIoXd3T3Mle8oyyOZ5TcG9mv3xBQqRj6Jb9e49u2CD/aP5HG86UiekgNn6d983oXCAKJ
 lXmw==
X-Gm-Message-State: AOJu0YyZBpm2jqfWTeJ2A8NvzoL3KffX9ozpmOAJiJH/dC3Iwdr3xV3E
 wjUL6i0A07c84vESSAxFImOwwMLB1KXPTY2hM9I=
X-Google-Smtp-Source: AGHT+IFq30bvbCW61Zr6aIzLpbpAaDYI+iuDZRa2i0xCEpRwD9l9LVvM05h7sG8ehph/dhY4N2ZDtw==
X-Received: by 2002:a17:902:e74b:b0:1bd:c32e:df59 with SMTP id
 p11-20020a170902e74b00b001bdc32edf59mr795955plf.9.1692396820055; 
 Fri, 18 Aug 2023 15:13:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/23] tcg/arm: Implement negsetcond_i32
Date: Fri, 18 Aug 2023 15:13:17 -0700
Message-Id: <20230818221327.150194-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Trivial, as we simply need to load a different constant
in the conditional move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     | 2 +-
 tcg/arm/tcg-target.c.inc | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index b076d033a9..b064bbda9f 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -122,7 +122,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..162df38c73 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1975,6 +1975,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
                         ARITH_MOV, args[0], 0, 0);
         break;
+    case INDEX_op_negsetcond_i32:
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
+                        args[1], args[2], const_args[2]);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[args[3]],
+                        ARITH_MVN, args[0], 0, 0);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
+                        ARITH_MOV, args[0], 0, 0);
+        break;
 
     case INDEX_op_brcond2_i32:
         c = tcg_out_cmp2(s, args, const_args);
@@ -2112,6 +2120,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
+    case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
     case INDEX_op_and_i32:
-- 
2.34.1


