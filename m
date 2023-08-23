Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23578616A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOh-0000FG-0j; Wed, 23 Aug 2023 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0008KE-LI
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005UX-EU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdbbede5d4so48112635ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822224; x=1693427024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eu3fIpPsTAmAUm4CNWpy9XF1IfgRxwNd1C0FurvU9EA=;
 b=Tn7ULgmvymDzmEO/0adWQKiMu1+8bsu+kv4avgLomBL9O7/RrY1xzLrwBNAumN46KT
 8bjQBPd4eg56H91K0kyxozPB2U3ctaxvqSz7h7o3NbM9QdwQEh6kL1WfRNuMoSg6vl/R
 v5yVnZ4ItFd4h3pvydf3OO09TCapol3jgxD+kOHSBkkSuCHw/NYmiOEpbifAFMaMfQRB
 lY303Ch7xDKr5VN/TyziH+UM/8a/T+JbOEfV45GQtESnxW736TztNLLXletq9lXn24HL
 ms6um1Z12GJbif5uecA0P6kheXJTPREi/6I6qf1px2bX2wFE0HoCuLGTbcLCbHCVAQTw
 +g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822224; x=1693427024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eu3fIpPsTAmAUm4CNWpy9XF1IfgRxwNd1C0FurvU9EA=;
 b=UGVBBuImhVlHT/RkVvxjscPqFguoonwtSfrkWMWKDr9G0wGq7jVus1tpaBYkDJD4hq
 93qyOleQefq8TeDQ0aB+ApdmqE/fWm3yDL/UUmF++fEciEb6oGFYeifcTjSv2D1BM3zU
 QHx4tQwJeDklipjN0wMyQHsNPa4hTVMc1om+6zudG+f7iToHnW6HG2Dr+oUT1I3Iu7E/
 gy4CkNE85JfbFQ+uuuVNWnA6KVXu0cmJIe3E961pWiXVEu56mlEk/vVhk6x8TEuL+LN9
 rh76fG65PnLWmBQ42i6WonWGE13IfIh6DFgqoiuDLsRd4HEWWWP4a3VyDM39rJW4sYe6
 mX6A==
X-Gm-Message-State: AOJu0YxZdgzj8BlT25lz0SD0tU7lyt2wT7Cnw8xjkc7CK//hYD8pIY+s
 gM1fCJ4ojV0Nj40y7YWpEc/q9wdkeOnBUbRPRtA=
X-Google-Smtp-Source: AGHT+IF4BYZqMnHIDPX3cNjojhrA/OO5ParXJLRViunzd7fhKK1lkPMPSD151ToWxadHlueSI3W8eQ==
X-Received: by 2002:a17:903:447:b0:1b8:971c:b7b7 with SMTP id
 iw7-20020a170903044700b001b8971cb7b7mr13023515plb.56.1692822223775; 
 Wed, 23 Aug 2023 13:23:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/48] tcg: Use tcg_gen_negsetcond_*
Date: Wed, 23 Aug 2023 13:22:55 -0700
Message-Id: <20230823202326.1353645-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index a954004cff..b59a50a5a9 100644
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


