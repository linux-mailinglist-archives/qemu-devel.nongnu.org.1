Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36D7E5F7C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pXq-0002bD-0H; Wed, 08 Nov 2023 15:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pXk-0002aM-9p
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:52:56 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pXg-0004fR-NB
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:52:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4084095722aso465615e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476771; x=1700081571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3258Ya/S+x5wNxL494Ng94PzU4Hq1EoIHA1WzmO4Z1Q=;
 b=kl5R1BQurm2bk1NhwnmkpUkP3kQNve7ezLB0mfzVrrOzzoeA2uxDXuCmhN6gKNDOwY
 B8ZzCfr4CwYjjnuXK0mG5eOhwAovprC92rEU9KlHK5yCrEmGUpyjV9xr9WU4d9vbrBl9
 lMBNC370CIMTKDpAH3lysnCTF11npKAdfGjAHknc3pKs2sP+rHWiDnxTIJ3PireDF2dd
 XDA5ipkn/7R6J0AZkrs/5CORkFEST0Inr5JVdyZhQvFGJZN3xbzcFUzCrMOuQedfTtMj
 KExA3W/oUhrlcf6seZvR3OTv4Yr/AC3mkqaGgYk8zEFFr/mr2Bl1baaM29V/II592JYK
 2xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476771; x=1700081571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3258Ya/S+x5wNxL494Ng94PzU4Hq1EoIHA1WzmO4Z1Q=;
 b=xRl3IxE9jk9Kjfsmzybaev9TRCR/ymLyW7A5p4vbt8dTEx7Xm3knaxBPErAumfBFrQ
 9BrM+vxJAiQ/TeMjCsUn+wagRH0YuUC0Hk1xKu4zltw1qp0aThq3DTro0NEequ3Hydin
 xrP46j7tA09lb8ZnuwFPJOrY0W4aDzbHG6HiHFNiuGUPST7adEmZWQxUCPodx5k0fKCg
 4csAmBcEOLQmFCiJrcnP+lWiooqicYXtyeWiUhV5DDkqEARbKR5aSQdOZa/CPR+Gkpnu
 c+EgTLwY4AWaUphUBKO8baQUNHEC7LWRTS37goS6wdT7oCtOixb/OUjg7g5tmwM5tS/G
 rpxQ==
X-Gm-Message-State: AOJu0YwVOWoq8jy//GtYEzotDe4RaC10yae24qjAKzfZ48MISe2zQv3s
 0NroVQwQxiF8loT2hZxmLhVOhzusBpVZp0zvzUM=
X-Google-Smtp-Source: AGHT+IF8Wg88NE8oLXxsS3F4++FUJVQdbR1NHsCsuwLsTxva3fKSJY+A3I8R8+3R/0R/OnrzXZSCtg==
X-Received: by 2002:a05:600c:4511:b0:3fe:1b4e:c484 with SMTP id
 t17-20020a05600c451100b003fe1b4ec484mr2782244wmo.5.1699476770898; 
 Wed, 08 Nov 2023 12:52:50 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a05600c341700b00406408dc788sm19896531wmp.44.2023.11.08.12.52.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 12:52:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 32/35 1/2] target/alpha: Pass immediate value to
 gen_bcond_internal()
Date: Wed,  8 Nov 2023 21:52:46 +0100
Message-ID: <20231108205247.83234-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028194522.245170-33-richard.henderson@linaro.org>
References: <20231028194522.245170-33-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Simplify gen_bcond() by passing an immediate value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..46efe1df7c 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -453,13 +453,13 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                        TCGv cmp, int32_t disp)
+                                        TCGv cmp, uint64_t imm, int32_t disp)
 {
     uint64_t dest = ctx->base.pc_next + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
+        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
 
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
@@ -472,11 +472,11 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         return DISAS_NORETURN;
     } else {
-        TCGv_i64 z = load_zero(ctx);
+        TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
         TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
 
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
+        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         return DISAS_PC_UPDATED;
     }
 }
@@ -484,15 +484,8 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
                                int32_t disp, int mask)
 {
-    if (mask) {
-        TCGv tmp = tcg_temp_new();
-        DisasJumpType ret;
-
-        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
-        ret = gen_bcond_internal(ctx, cond, tmp, disp);
-        return ret;
-    }
-    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
+    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
+                              !!mask, disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -533,7 +526,7 @@ static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
     DisasJumpType ret;
 
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
     return ret;
 }
 
-- 
2.41.0


