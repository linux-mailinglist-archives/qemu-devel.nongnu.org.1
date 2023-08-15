Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EC77D3C4
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Aq-00055X-WF; Tue, 15 Aug 2023 15:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ao-00054E-Qz
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Al-00013L-Lt
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-565e6a9ccedso417211a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129466; x=1692734266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnRqmTnyTo64hM2Ux3fkk6v6JrhGQ8w8rDALkc8lD9A=;
 b=aaXR0WkJlJNjkiOi40rV/P2zmuxkPDflFhvoDjg56kLau7kiZJu8LZ/nyQY2jSgede
 UpFgPL04nzAG8t6zpJ76xSSW38OKTEbAGhPlWR57rd6W7/hDtK+838ROHi776WB3x5Zz
 IV02RnQTFP+ELrSbZ9erIabH47Td0XNuHXirRefjZISMqLazL1vcXRZSc2RuIau4eCVT
 Qs/E2G7e7q/tubdTZPLvFIveo1Ez7YJmNFCfADDKSup8aTqrjV177iudXCJWmAQG7jf3
 QTNvHIJ6UKcGWhePrpxuQP62RhdsKLqAxSsDZft5jMl0dr/dbHQLNEqKMG4oy2+8OPXr
 KZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129466; x=1692734266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnRqmTnyTo64hM2Ux3fkk6v6JrhGQ8w8rDALkc8lD9A=;
 b=QnLEN6Ot2EuVM8YX6XdPf+dqjzherhLCcZRLPzYKzKacC/5wdSfLvuGNRS1nwjokKj
 WJQ+NeW9CjSG11eMvdvPZtaaFBfVB9ZmdSjpAat1PzuREcR28KCxusXumsNyv0X3j6pa
 9a/lG/Okkv21t/J6MzC0BWQtCQzqWvl9ow9700HpuJ9XY9XRq0f6K+/uNjlTmiBWqRBN
 YY0C7vzPx67q0EQRRmTyuhEPsbIvRski52bx+8nNNh9z1uuM5LrPmNaUGwF5LuXPiazl
 VGzXt1Gbz44RXw4bNhcv7C2ThywIYBsBpy37S907+kqGIe+ezslzvmahi5wEOpqTC2z4
 pPcA==
X-Gm-Message-State: AOJu0Yzc9Bkm/VkSC9Zv7uRAsdSCxld8PeYuhKO4I3cBlouEqugYF8v1
 sUKqW4Bb3yiqK3VmsfQ8DyYJJV5cZEhcYgKnUwM=
X-Google-Smtp-Source: AGHT+IE3uXH3yvrzTXQDuPntwAtZzw8hrxilut/VqemE2gPVeC/8YhZv1p5BEVm+wADHihOpL/nNbA==
X-Received: by 2002:a05:6a20:4415:b0:13b:9d80:673d with SMTP id
 ce21-20020a056a20441500b0013b9d80673dmr16942774pzb.48.1692129466406; 
 Tue, 15 Aug 2023 12:57:46 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 04/14] tcg/ppc: Reinterpret tb-relative to TB+4
Date: Tue, 15 Aug 2023 12:57:31 -0700
Message-Id: <20230815195741.8325-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

It saves one insn to load the address of TB+4 instead of TB.
Adjust all of the indexing to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 134a9bbcb6..19004fa568 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -215,6 +215,12 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_R31
 };
 
+/* For PPC, we use TB+4 instead of TB as the base. */
+static inline ptrdiff_t ppc_tbrel_diff(TCGContext *s, const void *target)
+{
+    return tcg_tbrel_diff(s, target) - 4;
+}
+
 static inline bool in_range_b(tcg_target_long target)
 {
     return target == sextract64(target, 0, 26);
@@ -986,7 +992,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Load addresses within the TB with one insn.  */
-    tb_diff = tcg_tbrel_diff(s, (void *)arg);
+    tb_diff = ppc_tbrel_diff(s, (void *)arg);
     if (!in_prologue && USE_REG_TB && tb_diff == (int16_t)tb_diff) {
         tcg_out32(s, ADDI | TAI(ret, TCG_REG_TB, tb_diff));
         return;
@@ -1039,7 +1045,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     /* Use the constant pool, if possible.  */
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
-                       tcg_tbrel_diff(s, NULL));
+                       ppc_tbrel_diff(s, NULL));
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
@@ -1099,7 +1105,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
      */
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
-        add = tcg_tbrel_diff(s, NULL);
+        add = ppc_tbrel_diff(s, NULL);
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -2486,7 +2492,6 @@ static void tcg_out_tb_start(TCGContext *s)
         /* bcl 20,31,$+4 (preferred form for getting nia) */
         tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
         tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
-        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -4));
     }
 }
 
@@ -2506,7 +2511,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     /* When branch is out of range, fall through to indirect. */
     if (USE_REG_TB) {
-        ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
+        ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
     } else {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
-- 
2.34.1


