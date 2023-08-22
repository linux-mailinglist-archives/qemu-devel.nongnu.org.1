Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C2784933
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVjI-0006lh-Cm; Tue, 22 Aug 2023 14:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVjG-0006js-IL
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:03:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVj5-0006ZH-Mg
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:03:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso3867461b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692727413; x=1693332213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UUZd2AVP+w81hoCD8MVhHNdXDn03i7oAydu1MC5tbQI=;
 b=vNr4uN7ftinqCQ/TsO9NvcZzmfnBha0oOI7GfITpBotPC5x/ZKmcVxbL0Yp7QLIv74
 VHRFF/GlpsqxmI39daAhVk6MZwhcnPhKL9sQ7H+v0k5tu+nzZ84TAeG5gzB4c9uEMzqB
 bakiY6UfhTnyqH/5Mxg41ldrpJByVcTR5zeJuxAbTA6N7E0uJlc8KgxKF+Ol/P9cMbX3
 qMShDDyTa0S2sVQbV37JCwlbR28/sNyMgKVdWgxXT9aslnHAIM9aAh3NeYI3kwsbn38y
 RWeGFM+UdtFwDoYAGAQatxjcwkfPiEDMd3WLE3SKPoqkana2lmcVae+USMxEmuK1iino
 l55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692727413; x=1693332213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UUZd2AVP+w81hoCD8MVhHNdXDn03i7oAydu1MC5tbQI=;
 b=hLQwJgi6K1cRMa8zTuMTgaNbfxpxPQerPx7IbVdEA1C1Mzw+MVgpwVcFkrJ+tXOfLd
 7zhOgnkoaCCXQRY+yaX4c81KeXipJq0kvnI+C+g29lajQwnL2CPLS5m3ghxUeoHVxsU+
 4aQ3Y9jZJlRDa6r43OJIJ73hXXwkxwS5r+p1RJ5WlzGSyC/6QgcKDUKK8zIZ7B807w7e
 xdMlqEW+IB7Hh/WvxfY9fq8zQh4OU2J9hVRQgMzQ2oNg5JLywNaQxnOdQgXsE/fnFahm
 jS9yvXOgIEm+BoPPhYWHOGL/Pnaf3mNJjRch1G3mewAzVBvm+onv09Fv+JY4zSZClzPU
 /R8g==
X-Gm-Message-State: AOJu0Yy8mmi8jl6OV5hiu6tDYE9lUODXndcGIP6qLjh57YGKE6FtYAZZ
 19/Fe3HmUGHEMUrEpBoRJnDHbcGt9aJwEU4dDdI=
X-Google-Smtp-Source: AGHT+IEn4futK00wJS+Gcu8fanSVN+4MkOFkxaiNVa+JSn/RDdEEjjpLAIKIkcqtxfb94hpAY5sJQA==
X-Received: by 2002:a05:6a20:7291:b0:149:729c:d065 with SMTP id
 o17-20020a056a20729100b00149729cd065mr5478421pzk.14.1692727413473; 
 Tue, 22 Aug 2023 11:03:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 n10-20020aa7904a000000b006889601aba4sm8006818pfo.210.2023.08.22.11.03.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 11:03:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
Date: Tue, 22 Aug 2023 11:03:32 -0700
Message-Id: <20230822180332.1174456-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Since a59a29312660 ("tcg/sparc64: Remove sparc32plus constraints")
we no longer distinguish registers with 32 vs 64 bits.
Therefore we can remove support for the backend-specific
type change opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Based-on: 20230822175127.1173698-1-richard.henderson@linaro.org
("tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32")
---
 tcg/sparc64/tcg-target.h     |  2 +-
 tcg/sparc64/tcg-target.c.inc | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 682e6f1613..112dfeafeb 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -114,7 +114,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_extr_i64_i32     1
+#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ffcb879211..d283d174b0 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -529,11 +529,6 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
     tcg_out_ext32u(s, rd, rs);
 }
 
-static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
-{
-    tcg_out_mov(s, TCG_TYPE_I32, rd, rs);
-}
-
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
 {
     return false;
@@ -1429,9 +1424,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_divu_i64:
         c = ARITH_UDIVX;
         goto gen_arith;
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_arithi(s, a0, a1, 32, SHIFT_SRLX);
-        break;
 
     case INDEX_op_brcond_i64:
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
@@ -1483,7 +1475,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
     }
@@ -1515,8 +1506,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_extrl_i64_i32:
-    case INDEX_op_extrh_i64_i32:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
-- 
2.34.1


