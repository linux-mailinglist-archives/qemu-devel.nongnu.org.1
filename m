Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6977D797E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:31:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6h-00026j-K5; Wed, 25 Oct 2023 20:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6F-000162-1O
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo63-0006de-Ox
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:46 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cace3e142eso2220845ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279573; x=1698884373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qScZs44s00L/oLLs4eIUKTqGk+BatBxWrSAikGLStjw=;
 b=CQpL95TqoRalMAy5AGV6wpYOJ3YSszC6uCoHCtRERtLvtRBe+EeJ9V8Qsi0b6YDXmT
 fGXHKykq+lmuTQ3t81xw2Nc0WwIg2mXgJOGlL4x2MqyNKxV+jGs6bOjNH6q9cdjRzC7/
 yEHG5ta329YlDutrRFaP/ZLLrW1i2nm7ltcxdyolOme3St4DBH6058b9TTwzRXGbKvhM
 uc1d9btqOCx0sSl4zI/HeNoCdUjdr14Vt2F1d/UGAdaxoPppBBu0zHYsYK8ADXvORGR+
 Q4+k50G9HWK+cFsN9gutmFR/nZo9dEn+E96GZPQ9pAAtAFLgCmk3Sv48X7dzu7zXf7Jt
 iNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279573; x=1698884373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qScZs44s00L/oLLs4eIUKTqGk+BatBxWrSAikGLStjw=;
 b=R8zLF/4CQCz8zEPNrZq+i72bdGDBwszyTI2h+gaMW8I9KjJcscxBoN9eOC6FTfTz2D
 IXpOpOtgmwD4KBO81S3TN9PZY4UNGWylXJoEGzTo5WZOmtgvlf8ojOuFpZsJFmRVzFMv
 K75381CvbSD5+1lBi1ld76L0Fdv0XhvMUW9DUtQnBIOLKplRJGcLbFFo07NUp9lLZihq
 CM7R9+fjnkfB1sz7GpRAXNDp35kVkybU9ZO4FKyUhM1w+6355cig8u34jB09+2gWBL8H
 5LUTeXShj0PDHwNOhekirNW98F31bMTgaf3bc232x9z4sn+qEzXn0Qi8+7EsIoipXoWy
 ommA==
X-Gm-Message-State: AOJu0YzQKEpKa71w/KsYIV6MIHM9yBFDCG01DWi308rT1QB0wGQupLTn
 bnT3n2y5tpHzWCyZXFp8e5U+FEXO1l37hJls6wk=
X-Google-Smtp-Source: AGHT+IFeW+aZPPjOdiigJiz/QENE9ZspgfkxUQw3aiIX1Q6qNBFHnVgRYZQnPcNfHoA6EoTVv5TwGg==
X-Received: by 2002:a17:902:e402:b0:1c9:ca02:645c with SMTP id
 m2-20020a170902e40200b001c9ca02645cmr11144143ple.36.1698279573133; 
 Wed, 25 Oct 2023 17:19:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/94] target/sparc: Remove cpu_wim
Date: Wed, 25 Oct 2023 17:14:38 -0700
Message-Id: <20231026001542.1141412-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use direct loads and stores to env instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d87c08c18c..096cbb869f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -84,9 +84,7 @@ static TCGv_i32 cpu_xcc, cpu_fprs;
 static TCGv cpu_gsr;
 static TCGv cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr;
 static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
-# define cpu_wim                ({ qemu_build_not_reached(); (TCGv)NULL; })
 #else
-static TCGv cpu_wim;
 # define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_gsr                ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_hintp              ({ qemu_build_not_reached(); (TCGv)NULL; })
@@ -103,8 +101,10 @@ static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
 #define env_field_offsetof(X)     offsetof(CPUSPARCState, X)
 #ifdef TARGET_SPARC64
+# define env32_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
 # define env64_field_offsetof(X)  env_field_offsetof(X)
 #else
+# define env32_field_offsetof(X)  env_field_offsetof(X)
 # define env64_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
 #endif
 
@@ -3414,7 +3414,8 @@ TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
 
 static TCGv do_rdwim(DisasContext *dc, TCGv dst)
 {
-    return cpu_wim;
+    tcg_gen_ld_tl(dst, tcg_env, env32_field_offsetof(wim));
+    return dst;
 }
 
 TRANS(RDWIM, 32, do_rd_special, supervisor(dc), a->rd, do_rdwim)
@@ -3767,7 +3768,10 @@ TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
 static void do_wrwim(DisasContext *dc, TCGv src)
 {
     target_ulong mask = MAKE_64BIT_MASK(0, dc->def->nwindows);
-    tcg_gen_andi_tl(cpu_wim, src, mask);
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_andi_tl(tmp, src, mask);
+    tcg_gen_st_tl(tmp, tcg_env, env32_field_offsetof(wim));
 }
 
 TRANS(WRWIM, 32, do_wr_special, a, supervisor(dc), do_wrwim)
@@ -5939,8 +5943,6 @@ void sparc_tcg_init(void)
 #ifdef TARGET_SPARC64
         { &cpu_xcc, offsetof(CPUSPARCState, xcc), "xcc" },
         { &cpu_fprs, offsetof(CPUSPARCState, fprs), "fprs" },
-#else
-        { &cpu_wim, offsetof(CPUSPARCState, wim), "wim" },
 #endif
         { &cpu_cc_op, offsetof(CPUSPARCState, cc_op), "cc_op" },
         { &cpu_psr, offsetof(CPUSPARCState, psr), "psr" },
-- 
2.34.1


