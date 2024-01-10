Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A721C82A444
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:52:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLM-0007QJ-TJ; Wed, 10 Jan 2024 17:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKm-0006Bv-Fz
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:04 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKk-0003Cb-MB
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:04 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dbe344a6cf4so3889219276.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926761; x=1705531561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBO9h8KMQ8hfOsqhiuTiqmSfaBXd3OkUHNoQ5JH+g9M=;
 b=kkMUt7g6lh/vFOZZH0/rgxkqvb6g75SD5jYa7nvV+NgmjMnl5qugs2QpFnkUkoKcB8
 8mB0g6StrS1+YgUE/CQKDA5OjGe3DoVkIBYbE+8W01+2tJWiCrvFkdrGLUaz7HPz7QYt
 kT/7GTL9fUHzt6nygS+OS9OhaXVWj0mHyeMlRkuqhzjgA9Pusi+FMBqwHUARYs4RfUjG
 kkSEeV6X6sY9CyuVJ+27W6R7OMndzTJ8TrPbuWhFm1eAUaPynQhgCviH2I5E2BNe5u/S
 quX7IK9uDM8kaj3m+6/By0jBB+1f+xJfvS044I7fUYra5WIPrJ3rY64FwxeL1uzfGkWI
 QKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926761; x=1705531561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBO9h8KMQ8hfOsqhiuTiqmSfaBXd3OkUHNoQ5JH+g9M=;
 b=wW9yrAuuAk8Cnrk+UOJdLKcBEuquG2wPXDBMsYKWdPt109r4Xw0dr2hkHCe8FJxfF9
 QiNpR/gP03njfWEwJV83RoTqFdsotWQ1hrGt7NHJ70DeVNlfUEQICN/S+LmIInpqDPvj
 U6IdR2tPFNVOkoclsitWCf8AbRgtKO+rKQWDHZKq3dSqauobXYXD6nHcKruvM3JTeRdJ
 zsgujKtUXTzUlEbEN0FmUtwmnG25h0xcoRrFUsYH1GmgCXZEdcmXY3zHAhJuY63tIZEg
 DSM0sO3LwhmPlZ4bj6JjqDIT3kdmvZtfCiY44uo5giqWkNPwA0hZEjEsUx2YxE+ffdYj
 yAYg==
X-Gm-Message-State: AOJu0Yy9HH7zr6OtX5j5yeel3y6rD9qj60ns9xLqSC2Zqsv3aP9OiAMF
 S8tpPyuvfA7QG961nF/SIURGv34mCwJ0yRzW482AQtVBK7QwEBiW
X-Google-Smtp-Source: AGHT+IH9BPPU92JRo6PqUm9PVtmswfRd1kFdSemyS59JeqQ3JObf4eQSECbWp6L+1F7jcXgKIblB1Q==
X-Received: by 2002:a25:6b43:0:b0:dbe:337e:4d9 with SMTP id
 o3-20020a256b43000000b00dbe337e04d9mr343655ybm.67.1704926761615; 
 Wed, 10 Jan 2024 14:46:01 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 20/38] tcg/arm: Factor tcg_out_cmp() out
Date: Thu, 11 Jan 2024 09:43:50 +1100
Message-Id: <20240110224408.10444-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108145244.72421-1-philmd@linaro.org>
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
2.34.1


