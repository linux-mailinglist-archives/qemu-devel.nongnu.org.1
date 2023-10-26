Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D447D797A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9w-0003Yc-HB; Wed, 25 Oct 2023 20:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9W-0001o3-8J
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:10 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9R-0008Db-VE
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so292849b3a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279784; x=1698884584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf1oJrduPCBqL7ZJPmcmrJhpPRE8uXn/4De5kKhDPeY=;
 b=ZnGzBBODna+PKMReZ3IEqpU40rrUXy7CRbozznbBh4xgpTvl1ZOr8pc6itDBgy/gMg
 qQAvHECRUvfMK0cL+rGsfNWsvSZ23c7sUSvqE6nZp8RCpsRNmVFaPLbzJQFNuc4EVGl4
 Opkz2/R1BnlVtWHVPvkrJrxNvIsc0WeWdYNG0nEm7D1YmK1SuCRtMdA/zrhyVhPW4GcE
 gDo716PSgWVEa59CgHpvT/hCElbb3UoCSmfNoulVpq5eHp2O0vhBXTjsDXEP/gY3WDQQ
 YC1csOUgtChMo7+YnWtLf+6BzRvqJJV8U1xs3ppFSSef/E5Vu28v9FFSXdGt4RVr/Bgc
 u42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279784; x=1698884584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mf1oJrduPCBqL7ZJPmcmrJhpPRE8uXn/4De5kKhDPeY=;
 b=cMKuT6KQqx0V8W48iZiVfMuwgtgA/6FGNAZmQ+7xkLrMQuftVzzKzQZna7ValuFfda
 iMAITtL3hDlPZ7xUBzcuhoR7IACNgSjKn3IM79LP/MoWm+Do3WTpLtAmbvtjxGWHfdUk
 ENWhy0rPzrRRniG9YCyjEQSv1SzyxGglHTLvSk0PCJZQl6Aeueu6JQAXW+z3QnIkztJK
 88WbTkVoEn5pEw7aJ2OWVnux10TDMzdeKUOIq1ulc9yRm+YUrmzrLNEMuSg+NHQarvb2
 zIfgGPkzTuCfK8RmrzFtKyB+H3AYQx1TOhOrjZltfU6yG8TBnuSouNFs+X7rbhH3R6yk
 XsQg==
X-Gm-Message-State: AOJu0Ywemxk0mCllOLUM24Rw6/R7aQmvh4xSF84AgXISwRHh1Ij2Wu5D
 qHSvw0ng2CNXndNZG81ryb2KXzf9VO46JxFJ5xg=
X-Google-Smtp-Source: AGHT+IErZlCcYAjQaXTfsUlxiW7cHzAMkXv7NTmiXzUgArFc+LPvfAYs84CK3RJFqxBRXrjnGvwlXQ==
X-Received: by 2002:a05:6a20:7f86:b0:174:2d20:5414 with SMTP id
 d6-20020a056a207f8600b001742d205414mr9593997pzj.49.1698279784366; 
 Wed, 25 Oct 2023 17:23:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 69/94] target/sparc: Use tcg_gen_vec_{add,sub}*
Date: Wed, 25 Oct 2023 17:15:17 -0700
Message-Id: <20231026001542.1141412-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 12 --------
 target/sparc/translate.c  | 15 +++++-----
 target/sparc/vis_helper.c | 59 ---------------------------------------
 3 files changed, 7 insertions(+), 79 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 790752467f..dd1721a340 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -137,18 +137,6 @@ DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
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
index 572de4ef14..09ca9c51bd 100644
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
@@ -5353,15 +5352,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5369,15 +5368,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


