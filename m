Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C11773760
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8f-0000V1-E1; Mon, 07 Aug 2023 23:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8c-0000O7-FY
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8S-0000Bf-UK
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso3593228b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464311; x=1692069111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8a+pmsyT7JaiJjb96T8aB4eik7cv3ApHNhItnmJcZ8=;
 b=aJ7FU4JQA13xkT3Lu3km5N5DbjXZLQAa4sbHN2fBfxqTUKsmlbvfFl14CDBwJsVaLP
 T06mnOuI92/VhXSmPz0+emVQZOBz3AQlUCb39Q5yrVRl4JJboSyZLpg1jNN6SEWZR2SU
 wd+bXbOUE/MB0WVQEeuDepoZwygh724xFnJ80iWK80lUWkYwI2G2TPkWbc39PUmZHgJX
 9eTumgWAY9ipiYvPyZyfjUNOfqed3aLRuhj5Tvzk2tvlJ7gLfYNrP1kF3jxTrlwKCUW0
 MxZL5vhaxTudJizVoP0XXmjZT3PXjiPLqzaMGzjyenUIrm7pmDXbycZ12HtiwXwsIhAE
 OpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464311; x=1692069111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8a+pmsyT7JaiJjb96T8aB4eik7cv3ApHNhItnmJcZ8=;
 b=GTYrveJhU2mvJKvIytU2sXPdkQSAHCW+BGYUrv3LSAj8qYnJN6xwCz4IR94tfhzefZ
 /Cusi1uGK+mTy1uvr9VeJM7awhOxshZDVfJYbGgsG3h4k+K7OmBJtH0PAjHLzSrFqJIb
 C3ErucmyuncE/vXrbTUfnAFzRJsy9Kg3STW3U7gG4Ydq0Vb76/Hgtxbm9aEF2ipIPIpM
 +kiZUo/Dquplzf39NleQq3uEUxQtswrXlX9tVHsZk2sFRx968HRngRrwPULb+NQr1zJl
 0P4LzJfskUla2nJPKKiHgQRIYl/iBTHGx5JA+NOr1FjH50kdz+Ho6pK2pP+kOqF6QDM1
 8/PQ==
X-Gm-Message-State: AOJu0YyFlsNviQ5U4GxqoD2L0smJkpMMYZedqsBY5zP2ndYrHj+BhyOv
 74NBiNO2skqxX/xRCG7Eg07XKvKIvhykKOkZZAI=
X-Google-Smtp-Source: AGHT+IEJIaZLMu62qUhZMyZKOREaCJeDCDdSzEwajan1m6i05LXh/XX9Crcpy6IIc6okok0d18ZE3Q==
X-Received: by 2002:a05:6a00:1a54:b0:687:907f:487c with SMTP id
 h20-20020a056a001a5400b00687907f487cmr10972103pfv.19.1691464311578; 
 Mon, 07 Aug 2023 20:11:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 08/24] target/sparc: Use tcg_gen_movcond_i64 in gen_edge
Date: Mon,  7 Aug 2023 20:11:27 -0700
Message-Id: <20230808031143.50925-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The setcond + neg + or sequence is a complex method of
performing a conditional move.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bd877a5e4a..fa80a91161 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2916,7 +2916,7 @@ static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
 
     tcg_gen_shr_tl(lo1, tcg_constant_tl(tabl), lo1);
     tcg_gen_shr_tl(lo2, tcg_constant_tl(tabr), lo2);
-    tcg_gen_andi_tl(dst, lo1, omask);
+    tcg_gen_andi_tl(lo1, lo1, omask);
     tcg_gen_andi_tl(lo2, lo2, omask);
 
     amask = -8;
@@ -2926,18 +2926,9 @@ static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
     tcg_gen_andi_tl(s1, s1, amask);
     tcg_gen_andi_tl(s2, s2, amask);
 
-    /* We want to compute
-        dst = (s1 == s2 ? lo1 : lo1 & lo2).
-       We've already done dst = lo1, so this reduces to
-        dst &= (s1 == s2 ? -1 : lo2)
-       Which we perform by
-        lo2 |= -(s1 == s2)
-        dst &= lo2
-    */
-    tcg_gen_setcond_tl(TCG_COND_EQ, lo1, s1, s2);
-    tcg_gen_neg_tl(lo1, lo1);
-    tcg_gen_or_tl(lo2, lo2, lo1);
-    tcg_gen_and_tl(dst, dst, lo2);
+    /* Compute dst = (s1 == s2 ? lo1 : lo1 & lo2). */
+    tcg_gen_and_tl(lo2, lo2, lo1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, dst, s1, s2, lo1, lo2);
 }
 
 static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
-- 
2.34.1


