Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136D78154F
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:16:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7is-0004vB-Mx; Fri, 18 Aug 2023 18:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ip-0004ti-Qp
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7im-0004Lt-CH
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so10934195ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396811; x=1693001611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nC56Ffn0XhmwS8tEYcAFvXvSIY7B/0Bfq2pmuDaq9zE=;
 b=Pb+mQyWhlqIE+A6pL/2fyRdDrUIymYJJZrQPix2zgM0nIdhr+P1dWhc5or/Ur+xoUm
 jPTU8FklIpJV/kDkBrKntgIHEgnZCpqmZB2mc7Ydff0FX8jTWVk2Ao1s2mt8eEczdJuh
 p+8vAa4ljytMiMVUMT0GYjepoU5Yww7FizSt9tdHgQxLGT8K8p6Brs7JDAtxQmbAXEzi
 fhbi0mu2hHdIG79C9/JEM70Opd8kdAu6EmdFFLCtVVo5s5Po5yBhml30IU1fJuEDhGFy
 sdvXbbU5ZTmQT1SACInhFq5ve/kHIS7wQiTXLdd+VCtP4TxCygHU+vCvITwPCOAgpfWV
 wfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396811; x=1693001611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nC56Ffn0XhmwS8tEYcAFvXvSIY7B/0Bfq2pmuDaq9zE=;
 b=VPwyCoehxvIPqS1Zq4lXAiVj25nwIJW33IUzenA7G53dCHDeUXErH7Zjqb/zEyLSCg
 ejhF665zZJXvsZAAPt/GshbNYPOS0CDX9wilCOXkQkjHaqI0ybjZZqYGVL2EFaJElnA8
 lE/V6pQSu4hdDfBG6Sk7h3IDrQaV5CFTPb4snQJjfVrwIeVY9lVWftRYe8DAV+zmMBqh
 nFCYMoute2lIRdWT5LyhUaxz90Q6iAwAti1ReULrC5JfgTCGVz3Ob9670QSTD4nEZgyJ
 L+o8NmhxQnMeJr6MyQGDeFM3oOpKQ6Hz12iSCS507XhXvT74sSrAlhAMQLiE3DR8iIM+
 d/BA==
X-Gm-Message-State: AOJu0YxMm6yWlO8Q49CqmCVGE8xv1u/5RANuYJIzXbKQUH5K0Mo1BEwA
 nxIhwVY88LlQq9m3x2dUXVNoZj526l/Iffbed2I=
X-Google-Smtp-Source: AGHT+IFqAPg/LgbwoN3W4URdAxqk1qZYpTO/Zjdm5nDfh1krzdHbP/q64kyoZ6bZVjw9x69InZMSEg==
X-Received: by 2002:a17:902:d486:b0:1bf:25d7:6fc1 with SMTP id
 c6-20020a170902d48600b001bf25d76fc1mr528490plg.35.1692396810672; 
 Fri, 18 Aug 2023 15:13:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/23] tcg: Use tcg_gen_negsetcond_*
Date: Fri, 18 Aug 2023 15:13:06 -0700
Message-Id: <20230818221327.150194-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 6 ++----
 tcg/tcg-op.c      | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index a062239804..e260a07c61 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3692,8 +3692,7 @@ static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     for (i = 0; i < oprsz; i += 4) {
         tcg_gen_ld_i32(t0, cpu_env, aofs + i);
         tcg_gen_ld_i32(t1, cpu_env, bofs + i);
-        tcg_gen_setcond_i32(cond, t0, t0, t1);
-        tcg_gen_neg_i32(t0, t0);
+        tcg_gen_negsetcond_i32(cond, t0, t0, t1);
         tcg_gen_st_i32(t0, cpu_env, dofs + i);
     }
     tcg_temp_free_i32(t1);
@@ -3710,8 +3709,7 @@ static void expand_cmp_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     for (i = 0; i < oprsz; i += 8) {
         tcg_gen_ld_i64(t0, cpu_env, aofs + i);
         tcg_gen_ld_i64(t1, cpu_env, bofs + i);
-        tcg_gen_setcond_i64(cond, t0, t0, t1);
-        tcg_gen_neg_i64(t0, t0);
+        tcg_gen_negsetcond_i64(cond, t0, t0, t1);
         tcg_gen_st_i64(t0, cpu_env, dofs + i);
     }
     tcg_temp_free_i64(t1);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 76d2377669..b4f1f24cab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -863,8 +863,7 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_setcond_i32(cond, t0, c1, c2);
-        tcg_gen_neg_i32(t0, t0);
+        tcg_gen_negsetcond_i32(cond, t0, c1, c2);
         tcg_gen_and_i32(t1, v1, t0);
         tcg_gen_andc_i32(ret, v2, t0);
         tcg_gen_or_i32(ret, ret, t1);
@@ -2563,8 +2562,7 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_setcond_i64(cond, t0, c1, c2);
-        tcg_gen_neg_i64(t0, t0);
+        tcg_gen_negsetcond_i64(cond, t0, c1, c2);
         tcg_gen_and_i64(t1, v1, t0);
         tcg_gen_andc_i64(ret, v2, t0);
         tcg_gen_or_i64(ret, ret, t1);
-- 
2.34.1


