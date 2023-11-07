Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C585F7E3378
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COe-0007SZ-75; Mon, 06 Nov 2023 22:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO7-0006OQ-MR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:30 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO5-0000ew-TM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3388621cso47865485ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326260; x=1699931060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XBkHVGjqIu3LTEV2zzgvwaws1GKhji4cesKfRpz1I/k=;
 b=IpERUTq8K6q9Dq0Ueyf7cvVYBEhuGzJfOr2aul8JWPpIjMQGZSVFC4Z8dGU47NRTeQ
 gmr4eeN3KRsP7DtNYOfgmazO1J5JGXPomwoyQIBq/2bjdip1GwsRsgYdViD5m8vbkDdn
 RWeN1eGqfHo9NeS73jrntWRxRC8R8IOFeRDdOLyZWN/cvfNZUaCPH7skj7wIgjSIk9N6
 fUpXkgnMNnB5N1OXdRjeb+AxKtlUQuPMZdDruFnpqTNHnYGmmqvqRnaG9T+OdYvufUhb
 F4A8W9CJ9lZz3TGVlH4ZCCwMLxLTaCM1vvjYGqo3dUeJf+QE+4+q6+LJgGtSeEoGd5A/
 mR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326260; x=1699931060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBkHVGjqIu3LTEV2zzgvwaws1GKhji4cesKfRpz1I/k=;
 b=fVQG/o46ezAr1M+rIVhiZTBllUbvqHt+l6CkLLtHlv/65eogXjKthvTDG+rKqQm0He
 PeT8npupQ9rF4YQmuvhTr1sM+2U4vITv/rkeduB/HJBl4LU25gjHY6Ie0pLG0Z3kTreg
 dC6IzmZvK8Vv/+4DyE8zZP64C/5uKx/52NxByNP/sp7YvL+XxIthwTA7kgoe1Wt281yh
 YmBKEQXX2+1zJzKuV7XnUpuEOYpplgE+K1X7XVzqmF0AxMLuM4jSjphB1eWWst+uT45F
 5RJdOUhuYkBZaZiPds32Y04yB5iMspqoyhnUF2U1yt7ZxVh3ktKG7tJgPPy+QZMUqw0H
 tYIQ==
X-Gm-Message-State: AOJu0YzqMrjNMlo2aUeY+iZ3ij+D0V01rRuc8QKxqggvRnd+sp3MGwHl
 LN+mv5cOyZ0VemL34sxDTRePdQAgsmqFNjpzhVU=
X-Google-Smtp-Source: AGHT+IEjrNtTeLE2niBzY7D4GBe2TY/S2l67jsRqdmrPnhXnzrJKlc2lWHocbHcncA2jd6QFbE+HCQ==
X-Received: by 2002:a17:902:c402:b0:1cc:5ce4:f64b with SMTP id
 k2-20020a170902c40200b001cc5ce4f64bmr2205660plk.8.1699326260158; 
 Mon, 06 Nov 2023 19:04:20 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/85] target/hppa: Fix bb_sar for hppa64
Date: Mon,  6 Nov 2023 19:02:57 -0800
Message-Id: <20231107030407.8979-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/hppa/translate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b0cd12a2d0..ffa367b91f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3073,14 +3073,21 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    if (cond_need_ext(ctx, d)) {
+        /* Force shift into [32,63] */
+        tcg_gen_ori_reg(tmp, cpu_sar, 32);
+        tcg_gen_shl_reg(tmp, tcg_r, tmp);
+    } else {
+        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    }
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3088,12 +3095,15 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
+    int p;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shli_reg(tmp, tcg_r, a->p);
+    p = a->p | (cond_need_ext(ctx, d) ? 32 : 0);
+    tcg_gen_shli_reg(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
-- 
2.34.1


