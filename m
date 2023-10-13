Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDC7C8F61
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm5-00010N-RK; Fri, 13 Oct 2023 17:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm2-0000fg-R1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm0-0001TK-Mw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso1080637b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232763; x=1697837563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKUnd2j1DB/Zlx01jGlKEJ96jzWPgB0b2NT1FKdEv6k=;
 b=ADrL3cbz4A60cVhy6A2WBluBxTEwuodMHrXmnami/uhLFK7cSpU9sUNROK7uqCL+9n
 uxxyZ54nRXs4LfXMu6C8tT16fSz0/gtYP/pVvQWBkjUQR/OX/KKRfGAG7kpzxJdBiXCW
 L5cDnSnYVHtDv5J5naxQiz0yZtmHTyLTwd8yEzt8csRVyrXwiqRReVvHAw7IY5uAKcPO
 uBJIsqDub4HslrgOTs7D+kr34qnqnu2AM2bqFazRc2fUWyIy2VZcCS6DZwUiukg7WlLp
 KxYifSX2CmhZ4gdJiMuhm26yoP3l19HIXCPZfasGrjayQboJ92c+yUJeSWSq/qeEZ1y2
 zeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232763; x=1697837563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKUnd2j1DB/Zlx01jGlKEJ96jzWPgB0b2NT1FKdEv6k=;
 b=LlbfUNnt5h5P8Gqh1DBuhDfwv99U7g8VwBlUg4ttO0qOE6xxdmQSVrnWgQXft3pAlU
 qgq1FEBZER54i7p5oiTytVbzBphPMVzmj3QiLI9g+0EfTP9lAxi5ED/PglFZTZsLR/EF
 DpliLTwG+V3Usu5JXM93EHmJ3GkpPeIPueW6U0os2T7rO3PlhZ1Kb/Z+uTdLz5KSdUT9
 tCCUIStuihO2Ip7e7SXVmj8Sa52eGxMerPS7JFXcabHyCH/6peZAodAclkd+2HbrZdGe
 CXHpWUCdfM2aCG5qY2wAcwIeeJWTCmfsY72/aUdXROrSgL1AD+Upav8PNyP4qhnijloY
 5BLg==
X-Gm-Message-State: AOJu0YwUnLwAxNk3SaItZC4tQ06+i2RpnO77MzUlpByDWNYv9thRYcPD
 1Nz2R1nDxRqielXBUAYWI3hfRcINXz1olYYKEEQ=
X-Google-Smtp-Source: AGHT+IEQRHEHZwgIoIEttikWxCNwRuWF2Kx5owt9vgCLziRFvmBH05HqFY0ENu5BsaT3SHqn91Xm5w==
X-Received: by 2002:a05:6a00:2e23:b0:68a:59c6:c0a6 with SMTP id
 fc35-20020a056a002e2300b0068a59c6c0a6mr37374038pfb.24.1697232763301; 
 Fri, 13 Oct 2023 14:32:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 60/85] target/sparc: Use tcg_gen_vec_{add,sub}*
Date: Fri, 13 Oct 2023 14:28:21 -0700
Message-Id: <20231013212846.165724-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Replace the local helpers for the same integer operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 12 --------
 target/sparc/translate.c  | 15 +++++-----
 target/sparc/vis_helper.c | 59 ---------------------------------------
 3 files changed, 7 insertions(+), 79 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index a9ee8e6b9f..8d20258d08 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -138,18 +138,6 @@ DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpackfix, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(bshuffle, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
-#define VIS_HELPER(name)                                                 \
-    DEF_HELPER_FLAGS_2(f ## name ## 16, TCG_CALL_NO_RWG_SE,  \
-                       i64, i64, i64)                                    \
-    DEF_HELPER_FLAGS_2(f ## name ## 16s, TCG_CALL_NO_RWG_SE, \
-                       i32, i32, i32)                                    \
-    DEF_HELPER_FLAGS_2(f ## name ## 32, TCG_CALL_NO_RWG_SE,  \
-                       i64, i64, i64)                                    \
-    DEF_HELPER_FLAGS_2(f ## name ## 32s, TCG_CALL_NO_RWG_SE, \
-                       i32, i32, i32)
-
-VIS_HELPER(padd)
-VIS_HELPER(psub)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0a1ebb62e3..3b6f4bef95 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -25,9 +25,8 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-
+#include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
-
 #include "exec/translator.h"
 #include "exec/log.h"
 #include "asi.h"
@@ -5337,15 +5336,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
                 case 0x050: /* VIS I fpadd16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpadd16);
+                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add16_i64);
                     break;
                 case 0x051: /* VIS I fpadd16s */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, gen_helper_fpadd16s);
+                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_vec_add16_i32);
                     break;
                 case 0x052: /* VIS I fpadd32 */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpadd32);
+                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add32_i64);
                     break;
                 case 0x053: /* VIS I fpadd32s */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5353,15 +5352,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     break;
                 case 0x054: /* VIS I fpsub16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpsub16);
+                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_sub16_i64);
                     break;
                 case 0x055: /* VIS I fpsub16s */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, gen_helper_fpsub16s);
+                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_vec_sub16_i32);
                     break;
                 case 0x056: /* VIS I fpsub32 */
                     CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpsub32);
+                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add32_i64);
                     break;
                 case 0x057: /* VIS I fpsub32s */
                     CHECK_FPU_FEATURE(dc, VIS1);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 3afdc6975c..7763b16c24 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -275,65 +275,6 @@ uint64_t helper_fexpand(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-#define VIS_HELPER(name, F)                             \
-    uint64_t name##16(uint64_t src1, uint64_t src2)     \
-    {                                                   \
-        VIS64 s, d;                                     \
-                                                        \
-        s.ll = src1;                                    \
-        d.ll = src2;                                    \
-                                                        \
-        d.VIS_W64(0) = F(d.VIS_W64(0), s.VIS_W64(0));   \
-        d.VIS_W64(1) = F(d.VIS_W64(1), s.VIS_W64(1));   \
-        d.VIS_W64(2) = F(d.VIS_W64(2), s.VIS_W64(2));   \
-        d.VIS_W64(3) = F(d.VIS_W64(3), s.VIS_W64(3));   \
-                                                        \
-        return d.ll;                                    \
-    }                                                   \
-                                                        \
-    uint32_t name##16s(uint32_t src1, uint32_t src2)    \
-    {                                                   \
-        VIS32 s, d;                                     \
-                                                        \
-        s.l = src1;                                     \
-        d.l = src2;                                     \
-                                                        \
-        d.VIS_W32(0) = F(d.VIS_W32(0), s.VIS_W32(0));   \
-        d.VIS_W32(1) = F(d.VIS_W32(1), s.VIS_W32(1));   \
-                                                        \
-        return d.l;                                     \
-    }                                                   \
-                                                        \
-    uint64_t name##32(uint64_t src1, uint64_t src2)     \
-    {                                                   \
-        VIS64 s, d;                                     \
-                                                        \
-        s.ll = src1;                                    \
-        d.ll = src2;                                    \
-                                                        \
-        d.VIS_L64(0) = F(d.VIS_L64(0), s.VIS_L64(0));   \
-        d.VIS_L64(1) = F(d.VIS_L64(1), s.VIS_L64(1));   \
-                                                        \
-        return d.ll;                                    \
-    }                                                   \
-                                                        \
-    uint32_t name##32s(uint32_t src1, uint32_t src2)    \
-    {                                                   \
-        VIS32 s, d;                                     \
-                                                        \
-        s.l = src1;                                     \
-        d.l = src2;                                     \
-                                                        \
-        d.l = F(d.l, s.l);                              \
-                                                        \
-        return d.l;                                     \
-    }
-
-#define FADD(a, b) ((a) + (b))
-#define FSUB(a, b) ((a) - (b))
-VIS_HELPER(helper_fpadd, FADD)
-VIS_HELPER(helper_fpsub, FSUB)
-
 #define VIS_CMPHELPER(name, F)                                    \
     uint64_t name##16(uint64_t src1, uint64_t src2)               \
     {                                                             \
-- 
2.34.1


