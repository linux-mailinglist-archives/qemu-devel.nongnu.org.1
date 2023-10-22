Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5038E7D2162
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaG-0001kr-Mx; Sun, 22 Oct 2023 02:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa9-0001HC-PY
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:01 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa6-0002IH-Dy
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:01 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-583f571a213so1391627eaf.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954696; x=1698559496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHTe2pzMiK1pshU/eb99Gibbfx2KzxTlzDMwY6as5Do=;
 b=UmT5WeykiKym96vH/E0ngB6hDoJryjUBjLMPWd/OLHBzm4FnIHHyWbD164VKMD8XqL
 xhoCOpBFNi9fMlspbFMXY16yGck43M9t7gyN/UtYBay6xV9O1q/Pv6y4AGJUZam7gAFY
 3HvhOZiXtaIeNY0c+FUmwfSrg2zB80sN/qzIG6qEglgshz2bBf0W9DMEjeXjINXp65ms
 rG/n0vpbe70/j3GZwuXkZZWEAtCDUSIuM4/5T+723biTJG4xhcrzkMCp/krtJ+5IEFke
 YsA04ddynuTUfSSHFk1qRPCCBXDzhoHtrvv+MqC11HOaw7LjV1gAOwOJ+IMrijcET7HR
 1UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954696; x=1698559496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHTe2pzMiK1pshU/eb99Gibbfx2KzxTlzDMwY6as5Do=;
 b=FC3/DkAPZEZC++RekF5Wtrj/LIEPsKCZtTLvjAoMmMarTKYmzKpIv46Qe745UeIZQq
 Z+DL4Zdel9qEBwhbU/ZugUgoPX1YPKfwNpxUDroXCBFnjXWg3FfYbBrzLSR3Ow4c3jsN
 w3ILEw13WfnDjKSsUbxvtAUosy+9FF6xjD/UR+ysw3OtMZnNUraOvZKH0gfTFSUko922
 e4eIzW645C8qP7MgF3a6z1e1T+66sJXAlMrPSdzjuJhPQi4O1uQ96phqwAzICCyCtP4A
 QgVbkuJkQ65b81GP0BSn6Bh63fHsqv/3hsCENSesttOXMGHBvnXMsaQzIAcVYvqjXimj
 9qjw==
X-Gm-Message-State: AOJu0Yz3HnuCW5TFT2jnvC4HI/iezWsIs6jx6L12h3DMU/7zgHZAlCVI
 XyjI+KxzDYN+z7Bj9mmhvzKHkPpx/hJ5OurU5bA=
X-Google-Smtp-Source: AGHT+IG6Qx4HOcPIshhtotpyY4s97D721Tu9Y6ze9bNoqwJItDFYsbZkkLeVVyZeyVGKzsuU4udSYA==
X-Received: by 2002:a05:6358:418d:b0:166:e153:db13 with SMTP id
 w13-20020a056358418d00b00166e153db13mr7206292rwc.16.1697954696093; 
 Sat, 21 Oct 2023 23:04:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 65/90] target/sparc: Use tcg_gen_vec_{add,sub}*
Date: Sat, 21 Oct 2023 23:00:06 -0700
Message-Id: <20231022060031.490251-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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

Replace the local helpers for the same integer operations.

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
index 3e1ef3d28a..2ec8607f61 100644
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
@@ -5513,15 +5512,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5529,15 +5528,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


