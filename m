Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D72781545
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7iw-0004yL-2d; Fri, 18 Aug 2023 18:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7is-0004vh-NM
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iq-0004N4-F5
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bddac1b7bfso10102095ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396815; x=1693001615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXTuJLuVUV/PuBzgJU7K0Vdmip6KJacvGUEEE2MhUro=;
 b=vyU6D4DDXPVY5AA3mGiOHNYOz4/IpqvlvI9gVCDXaXTFDwEZOGDM7HIb4gRS3qNzPd
 7+okSyqVkqypK9oVhLM8Jo+gK19I7UdKYOzCHrOKqjxnCsiuwl9P9AJALg5hbWoueKW1
 mufcJ6dulFMkU278dzYqNbCqeBcDFjAiXXmkc64sFWT7hThusymDCZzISVDQ73sAir3l
 aH7XN/KJ1N2H/8USau1MQEsSXsqFopN1YTwn6LNt4IGjZA7zIg9SiA9SlnhuNTQjHpad
 wEyB/skJoRySRvjpiydJOosNYrWK362BMEZtXyNdHkrhffLx6dkrVscqpXo7MjMvzo13
 gUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396815; x=1693001615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXTuJLuVUV/PuBzgJU7K0Vdmip6KJacvGUEEE2MhUro=;
 b=BSJgT7ZUlSyizCK16W90qxJCrfwMTE56aaT6jxHP9YIVjfYMeXDDlWJQk/ZqAUBhL+
 5mpIL+FD6lUkntJ9ho8WVx8LDVd0arENl2L2+KvGM6kSR35082z2Ml6xW/sWTAFmQRLJ
 DoudIZ6taB60pOwTRfD/0CXXoqHxHHir907zkVXLZThxlQ/KnVU6z9gtmGRWKIG0JfT/
 TWJDfqS6zfDAi3txRhkfDV/9SqCyOvl8AGKHJmmLr69w2HXKce30X9IFIso77VkZxbdB
 7s36E7HT9f9zWf9u/leO0bB0xiYit2Yz9FEbn3Kt4OMwJiegfhWHMcoMJeiALr/6EkrK
 6NGA==
X-Gm-Message-State: AOJu0YzBICe3Qws2wQR8OZukIlYVQ+1osrOAEa9AO+BG9Wt7ZsQqxKcF
 RsIehHI+xEyypK77wR9IHAz0dIbPzia7v7m054U=
X-Google-Smtp-Source: AGHT+IFYAuRaJAPGCC9swYlo4znlDkaUzAwo19JyuKxrnrqJsoCzDbz2rIc0wYSXoKMit1rRlPkVnQ==
X-Received: by 2002:a17:902:cec9:b0:1bb:85cd:9190 with SMTP id
 d9-20020a170902cec900b001bb85cd9190mr671773plg.18.1692396815075; 
 Fri, 18 Aug 2023 15:13:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v2 07/23] target/ppc: Use tcg_gen_negsetcond_*
Date: Fri, 18 Aug 2023 15:13:11 -0700
Message-Id: <20230818221327.150194-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/fixedpoint-impl.c.inc | 6 ++++--
 target/ppc/translate/vmx-impl.c.inc        | 8 +++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index f47f1a50e8..4ce02fd3a4 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -342,12 +342,14 @@ static bool do_set_bool_cond(DisasContext *ctx, arg_X_bi *a, bool neg, bool rev)
     uint32_t mask = 0x08 >> (a->bi & 0x03);
     TCGCond cond = rev ? TCG_COND_EQ : TCG_COND_NE;
     TCGv temp = tcg_temp_new();
+    TCGv zero = tcg_constant_tl(0);
 
     tcg_gen_extu_i32_tl(temp, cpu_crf[a->bi >> 2]);
     tcg_gen_andi_tl(temp, temp, mask);
-    tcg_gen_setcondi_tl(cond, cpu_gpr[a->rt], temp, 0);
     if (neg) {
-        tcg_gen_neg_tl(cpu_gpr[a->rt], cpu_gpr[a->rt]);
+        tcg_gen_negsetcond_tl(cond, cpu_gpr[a->rt], temp, zero);
+    } else {
+        tcg_gen_setcond_tl(cond, cpu_gpr[a->rt], temp, zero);
     }
     return true;
 }
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index c8712dd7d8..6d7669aabd 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -1341,8 +1341,7 @@ static bool trans_VCMPEQUQ(DisasContext *ctx, arg_VC *a)
     tcg_gen_xor_i64(t1, t0, t1);
 
     tcg_gen_or_i64(t1, t1, t2);
-    tcg_gen_setcondi_i64(TCG_COND_EQ, t1, t1, 0);
-    tcg_gen_neg_i64(t1, t1);
+    tcg_gen_negsetcond_i64(TCG_COND_EQ, t1, t1, tcg_constant_i64(0));
 
     set_avr64(a->vrt, t1, true);
     set_avr64(a->vrt, t1, false);
@@ -1365,15 +1364,14 @@ static bool do_vcmpgtq(DisasContext *ctx, arg_VC *a, bool sign)
 
     get_avr64(t0, a->vra, false);
     get_avr64(t1, a->vrb, false);
-    tcg_gen_setcond_i64(TCG_COND_GTU, t2, t0, t1);
+    tcg_gen_negsetcond_i64(TCG_COND_GTU, t2, t0, t1);
 
     get_avr64(t0, a->vra, true);
     get_avr64(t1, a->vrb, true);
     tcg_gen_movcond_i64(TCG_COND_EQ, t2, t0, t1, t2, tcg_constant_i64(0));
-    tcg_gen_setcond_i64(sign ? TCG_COND_GT : TCG_COND_GTU, t1, t0, t1);
+    tcg_gen_negsetcond_i64(sign ? TCG_COND_GT : TCG_COND_GTU, t1, t0, t1);
 
     tcg_gen_or_i64(t1, t1, t2);
-    tcg_gen_neg_i64(t1, t1);
 
     set_avr64(a->vrt, t1, true);
     set_avr64(a->vrt, t1, false);
-- 
2.34.1


