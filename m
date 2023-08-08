Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40B773789
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8V-00006s-7x; Mon, 07 Aug 2023 23:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8S-0008US-8T
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:11:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8N-00007u-KT
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:11:51 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686f090310dso5201148b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464306; x=1692069106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGq6ojlO3QPTHf7EEiR5KaCrsEAyjZrCLlJyqE12lWg=;
 b=s4pAehY61hMkKZnfSH4ztqXCuVZAHCKCm21f/15x/Ko43yox7QAr5yoOxoFjIYZh94
 m+qwIvG/2Lbi+NnWRxqEjTeLDcTQ3ZXUn19lH5un1rH8Ai0fn0PMr65OPQyhpJHc2GAN
 hZlrOtRrgSBjWdFvL8SLAxD3AKteI6ZLiLnVxyymCPTEN2GOYDD2R4DAwETQKaoDIfV1
 HTP2lvwqPFiUSwsmdxwV7xG9KZerZAeQ+Dk68tNlpgQHUj7MVITlptJGUu2XTSCSrYtr
 JVkkBJVjHOXpjHt3uzuo/OkVm8/bWPEr35z5tuPXU3AeXThH1/4RrNM3h5+vR/TmS9Mw
 scCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464306; x=1692069106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGq6ojlO3QPTHf7EEiR5KaCrsEAyjZrCLlJyqE12lWg=;
 b=Aw0ytOZbvWNeUqPczi4IVCdZZZmpvoRunURr9AbPqw7oEbLCJjTwJbefwIfzr3Q3Tn
 jbAmU68ZENQDeH17CoLQKhpgBPh01X0JLX4dZDOYvg/47N+MmEMlYTzsoY7VrBytKwh3
 flHF73x/xWFprJQci/zjwhUG/z5+ti8bF2omSY9LUmH0xoFo7cpkMgqWGoQhw8Tpf/V6
 qF/58FwdkQ2XMeBoVsybZ02XP1FkgAiAHZMkQ9HEHq3LtcGgmcotUkT2Pv70RwD879aM
 IUCIJ8R0GeOa956YRbmj8XK+V+ijIkznjCb3saecF/o6rNLCLOR3pc10Kp4Xk0/4kj+a
 WHIg==
X-Gm-Message-State: AOJu0Yx3r93utZ8ZTrAqRmXtr6zlpAjsjqSkAeswv5XWa1WZ9WNL8Djz
 rVUqIIpLO0EdCKpZ+xTLXZM3hfhMOSHZwKda2VY=
X-Google-Smtp-Source: AGHT+IHxeY6zCMntvoE3HvmUK5iek+S36+AItBoKNjMJnqyHyaWDBeEpzMMY5d54a4bwSYMo9QDRBw==
X-Received: by 2002:a05:6a00:1acc:b0:668:6445:8931 with SMTP id
 f12-20020a056a001acc00b0066864458931mr8514102pfv.29.1691464306436; 
 Mon, 07 Aug 2023 20:11:46 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 02/24] tcg: Use tcg_gen_negsetcond_*
Date: Mon,  7 Aug 2023 20:11:21 -0700
Message-Id: <20230808031143.50925-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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


