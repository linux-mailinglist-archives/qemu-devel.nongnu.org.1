Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A52147E33A2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:11:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRp-0005MY-D3; Mon, 06 Nov 2023 22:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRf-0004wM-Pv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:04 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRc-0001QF-4Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:03 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-280200949c3so3900091a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326479; x=1699931279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CpIa1Sa2legrjFfGjmeZYL+BHJcrUIlWJtH6RuB5pv8=;
 b=QjhK0fEbmSbJHcF1SKpFCtlxQoA2nP/+HXivg/HamhEmfv1cpOsWn6xMQCi0uJt/O+
 Pp662RaSJHewLCOlrI0LWfmRJTMQRGN8V5+g3UAmzL+4kaGpnUcUkl+9wASh9GyQjF/w
 keXqQwWQkhrZszfz2O3M9J+ldtlQ4Wh+W82OIq+7foSGfWWTNj8LyDjc7gbOVjfQQPL4
 f6sBkUekujEQVCGefwWJqI8IylRWJPVtlugjZ0t/soLUDwadZ+rKi96XKf9POAlHHWYV
 gbqDNpC+GjFptyaSylgxFcYn5n/BYgAg9QVxrmrFIXm7t7YF1zuD02iYuKWaGGrWoW+Z
 3ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326479; x=1699931279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpIa1Sa2legrjFfGjmeZYL+BHJcrUIlWJtH6RuB5pv8=;
 b=URQN5vjE9afkSmEi9TOpzKJKEu6BGdzu2XJTtFfu385DyoXLvJOSmDhd0/eTfgfT8j
 OLrGbkfkePSzBHpS2QETAOoY/Chhl2iLdimpFTf97a3Ic0dDBSdiDtdnUiB0QWsaswKt
 t6+/siZLutBazGLXCvspb2wkgTSiMQCmS0lnUso9fGCuXfhr0E32DaPDAbdIBvM9aMsj
 C7rkh9BqlbCahGkXAnZE1XSmq0xTOFMVY0OxU2OX2YRJlivvynjvQOinsrWQWXXZ+8yX
 pbskBXqJfTU+1qbfJ0WpbzWRAP4IDwkbe/EI1/aOwqX2W+oIHFKear6TGdS6RmfXjN+O
 qxhw==
X-Gm-Message-State: AOJu0Yzqai1Edi6DSXUxzxj1crAqsIykJ7cUVWh0zSrGU5tzoQMXCZ/J
 N7q6dYMm7bTEu0RxiBGJBlwvHkM9/RA/OOMYHFU=
X-Google-Smtp-Source: AGHT+IF1L/BXDmomjGkLRjCncqDQ+/yz9MBsAS99AewXT/dlc7OB2UDJ4WTjd5FZPYwH4mY5StxHkw==
X-Received: by 2002:a17:90a:1a51:b0:27d:306d:71c9 with SMTP id
 17-20020a17090a1a5100b0027d306d71c9mr21706763pjl.49.1699326478749; 
 Mon, 06 Nov 2023 19:07:58 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/85] target/hppa: Implement PERMH
Date: Mon,  6 Nov 2023 19:03:49 -0800
Message-Id: <20231107030407.8979-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  2 ++
 target/hppa/translate.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 22ec07f892..19e537df24 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -238,6 +238,8 @@ mixh_r          111110 ..... ..... 1 10 00100000 .....  @rrr
 mixw_l          111110 ..... ..... 1 00 00000000 .....  @rrr
 mixw_r          111110 ..... ..... 1 10 00000000 .....  @rrr
 
+permh           111110 r1:5  r2:5  0 c0:2 0 c1:2 c2:2 c3:2 0 t:5
+
 ####
 # Index Mem
 ####
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2b471444d0..ffdd306d31 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2946,6 +2946,35 @@ static bool trans_mixw_r(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_mixw_r);
 }
 
+static bool trans_permh(DisasContext *ctx, arg_permh *a)
+{
+    TCGv_i64 r, t0, t1, t2, t3;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r = load_gpr(ctx, a->r1);
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    t3 = tcg_temp_new_i64();
+
+    tcg_gen_extract_i64(t0, r, (3 - a->c0) * 16, 16);
+    tcg_gen_extract_i64(t1, r, (3 - a->c1) * 16, 16);
+    tcg_gen_extract_i64(t2, r, (3 - a->c2) * 16, 16);
+    tcg_gen_extract_i64(t3, r, (3 - a->c3) * 16, 16);
+
+    tcg_gen_deposit_i64(t0, t1, t0, 16, 48);
+    tcg_gen_deposit_i64(t2, t3, t2, 16, 48);
+    tcg_gen_deposit_i64(t0, t2, t0, 32, 32);
+
+    save_gpr(ctx, a->t, t0);
+    return nullify_end(ctx);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


