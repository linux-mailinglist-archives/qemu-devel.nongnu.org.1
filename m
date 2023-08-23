Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DAC78615E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOo-0000h7-Va; Wed, 23 Aug 2023 16:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008Sr-QZ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOW-0005VH-RS
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso1604335ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822230; x=1693427030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHbWd+vL9cFJb3YCRtGzznScqvArtoWUo4TuP0it/ow=;
 b=Uhn6AOAahQATLmAqNKbQz2AmgQdYih9Z0vAqmHr5qBLbu1QO+sEFM34mjnC+5IOEp4
 8p6haXTlesS1wzguIW2Oddd+IHQIdyb7Lj7rdJGRR/5t/frpi23Tnep+CxBg+l/GU87H
 PRMJyRJ/kJR8DLkz+kJvMoAbFYL7wL5tuBCXLVQBm/Rc4n20WrWTQm/ZUv3AOECL0Y7Y
 H32h2bBUJvfmDFNv0DBIEo7tcUe+A6F7SGOz7rnJPkx5RKSV9LzxOJOCrTRH/orTnLSd
 3119agK/P9Y8yar9HUeKehxUaA7jC/t5DpL7OWQCBLTGKn8vSh1XxtoTtudhf3f90SJn
 2ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822230; x=1693427030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHbWd+vL9cFJb3YCRtGzznScqvArtoWUo4TuP0it/ow=;
 b=R0tg4D49kyKxaNJMyzOlmR3G/Rok1nQu0Owve2wycw8WDFRh+6Wg/5Lr5N+UCubfjp
 1my1IGudKarqcAun6cLj40mfLdC9NRZBUDpb7zq4yhgbJRApywulVSW7FjvkEhg5r78L
 IxuZAjIc5RlfsyX4clwyahBqpRbSCRWK+kFIxi4Y6cqUeG39334s6ANQqLaqd3zNhPrN
 W+z4gEIqmN6oYXe7YYG/Bc/fMZXGhpifCw4YVRMz07YJEJCDIb01mmqR+jKtXpAzYhGC
 cLerAf03kQR0F4BZUqYRDBtffdbr542L16BSuGOl2Omz8t1+9emd+SUFS6dXrFWW74UK
 lS4w==
X-Gm-Message-State: AOJu0Yx37TbTNbX8xzH7ugULjC/QAotwi8scLP3ZUUrLu6JeOH4Kbyed
 f+zvnqywf3hJNz+Ev5B97BmfeWFlfj03E6cQ8Gs=
X-Google-Smtp-Source: AGHT+IEI1g+OnqkIvsdrwMUji3VdIc/3aQAug5yA9jhB7+qfpnV+6K2fh1gnX8h7cnX7UnCJUeWeeg==
X-Received: by 2002:a17:902:e5c9:b0:1b7:ca9c:4f5c with SMTP id
 u9-20020a170902e5c900b001b7ca9c4f5cmr19800592plf.28.1692822229937; 
 Wed, 23 Aug 2023 13:23:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 24/48] target/tricore: Replace gen_cond_w with
 tcg_gen_negsetcond_tl
Date: Wed, 23 Aug 2023 13:23:02 -0700
Message-Id: <20230823202326.1353645-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1947733870..6ae5ccbf72 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2680,13 +2680,6 @@ gen_accumulating_condi(int cond, TCGv ret, TCGv r1, int32_t con,
     gen_accumulating_cond(cond, ret, r1, temp, op);
 }
 
-/* ret = (r1 cond r2) ? 0xFFFFFFFF ? 0x00000000;*/
-static inline void gen_cond_w(TCGCond cond, TCGv ret, TCGv r1, TCGv r2)
-{
-    tcg_gen_setcond_tl(cond, ret, r1, r2);
-    tcg_gen_neg_tl(ret, ret);
-}
-
 static inline void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv b0 = tcg_temp_new();
@@ -5692,7 +5685,8 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_eq_h(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQ_W:
-        gen_cond_w(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_negsetcond_tl(TCG_COND_EQ, cpu_gpr_d[r3],
+                              cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQANY_B:
         gen_helper_eqany_b(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
@@ -5729,10 +5723,12 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_lt_hu(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_W:
-        gen_cond_w(TCG_COND_LT, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_negsetcond_tl(TCG_COND_LT, cpu_gpr_d[r3],
+                              cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_WU:
-        gen_cond_w(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_negsetcond_tl(TCG_COND_LTU, cpu_gpr_d[r3],
+                              cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MAX:
         tcg_gen_movcond_tl(TCG_COND_GT, cpu_gpr_d[r3], cpu_gpr_d[r1],
-- 
2.34.1


