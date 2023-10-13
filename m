Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D37C8F70
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:39:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm8-0001O6-FU; Fri, 13 Oct 2023 17:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlz-0000Gs-1E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:43 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlw-0001Qm-It
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:42 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79fa425855cso99510039f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232759; x=1697837559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuzaxZNk6w+U4QVhzbX/JmL5YdnnDuNjn8oMQZbba8g=;
 b=Yk3j5gJx/wxLILQGXj/gGji5S/pux91eIRfel8ydzgetxHp+XtC1J579nigkqPrdl0
 u7G1opBJuITYPGYNHIL+y+elpqLTHFl+el0CA4ARMW1TTV55VmRaQAwDm6eU9JHnaZTX
 Zty+FacbuvkV+sQ3LBeFhp+Ykci9jLTLYvZUGTbGUDNheuaVzr1t1Bi2tEomCVEf71fN
 hUaRkq+Om2gG7mIHE6NpBIem47p8dRx6JrgAvZInY4qbEGxVbmU/lvIkpPzNH62HFWiY
 AHVPUJeUhqZZC7gvbOZujOvzieElYPqHLXWBqmrD6q/8oq+2TRhRr7Bz2suSqzGmbj/e
 mpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232759; x=1697837559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuzaxZNk6w+U4QVhzbX/JmL5YdnnDuNjn8oMQZbba8g=;
 b=hlOast/P345ydt/G5iBwZmspkKH2pTpwKLUxA6x/5DW8Q2P9qsCO3mLTsa8vn9EMzY
 0y2FPaHddMAuKYzsFjfZU7zkOVla7JiKtvCtvCI7oxw+eLXtGaYNRHG7sK5qG1aPm0Ko
 OOjlocmiwmZmXfw+wqSY4kEjJeQOahIm9l9yQARBDQ/wug2dOEEJkYm45g5NElZ5ayOW
 6DRwEbYKVfiqS0PEAfIots9EgtGbUZDf2u+haXI3Ao7P46Zh0IFwcofwerciwPCIQGPW
 0MEaifJzcQdshFikfrz60aPVM8SFRiC6GDQGust6xILzdhz6XCFHCW3Uufn00YGvcya8
 PZ9g==
X-Gm-Message-State: AOJu0YwcBPRFDubBY1qJjxjDl5U5H5FBSS8QRBrBlS6yYw8crzDf827W
 jFtgfhDmdICfA47uZTGFaUl4hWVPzmepeuc4J8M=
X-Google-Smtp-Source: AGHT+IEVA9Nxgz1bAB3YTp9yocG3oeMl3Y9ST1HQGG6ga/H7f17+cXXxCV/Frdak7D1/fOV9J1p1lA==
X-Received: by 2002:a05:6602:2763:b0:7a2:d8a2:9612 with SMTP id
 l3-20020a056602276300b007a2d8a29612mr28543630ioe.18.1697232759242; 
 Fri, 13 Oct 2023 14:32:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 55/85] target/sparc: Move ARRAY* to decodetree
Date: Fri, 13 Oct 2023 14:28:16 -0700
Message-Id: <20231013212846.165724-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd29.google.com
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
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 54 ++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b4bbdd43ec..e8d49de888 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -242,6 +242,10 @@ RETRY       10 00001 111110 00000 0 0000000000000
     EDGE32N     10 ..... 110110 ..... 0 0000 1001 .....    @r_r_r
     EDGE32Lcc   10 ..... 110110 ..... 0 0000 1010 .....    @r_r_r
     EDGE32LN    10 ..... 110110 ..... 0 0000 1011 .....    @r_r_r
+
+    ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
+    ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
+    ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 56f32551af..c8685c6837 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -72,6 +72,10 @@ static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
     g_assert_not_reached();
 }
 # endif
+static void gen_helper_array8(TCGv r, TCGv a, TCGv b)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -659,6 +663,18 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+static void gen_op_array16(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 1);
+}
+
+static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4244,6 +4260,22 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
 TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
 TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
 
+static bool do_rrr(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv, TCGv, TCGv))
+{
+    TCGv dst = gen_dest_gpr(dc, a->rd);
+    TCGv src1 = gen_load_gpr(dc, a->rs1);
+    TCGv src2 = gen_load_gpr(dc, a->rs2);
+
+    func(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
+TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
+TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5133,30 +5165,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x009: /* VIS II edge32n */
                 case 0x00a: /* VIS I edge32lcc */
                 case 0x00b: /* VIS II edge32ln */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x010: /* VIS I array8 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x012: /* VIS I array16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x014: /* VIS I array32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1


