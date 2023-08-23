Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80B786174
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOk-0000NY-KC; Wed, 23 Aug 2023 16:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOX-0008Mj-3i
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:01 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOQ-0005V3-Sp
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso28979295ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822229; x=1693427029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tLG8/XHxQLwSuertWPZX823LWYyhiS+FEGkrYeTEgw=;
 b=yerTEFN9rcSa1Aoz890fkjCGPJb0sI7krYVkglL7hUSKNtXvJ+u88YFcC6yJ4aJXbD
 CGW9tJVcnyFgdHsBV43BY3Dz/HLU36yPIf6sHB1I/MtsuM1BG4BzVY5SLr5OuFgK2M07
 bxbnzQpw2eTlLIVA3+zpgjLP8Aifx7gjGDn6ggkw5YiBILbcLL759AyFoYDWkoEVuYcd
 FyeUn5K5vkTSVHn7100VT75PJDqJJ8QGiRAoznv8RwY5twVkBYdfHH16zVlOa11KZKOo
 Uck3Jh9Zf0SZ63mj1NsGNKWO7Y7N7vwbF5/PpYjhlhyqcH3nVz7am7UajtZyTooK/Bw6
 LrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822229; x=1693427029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tLG8/XHxQLwSuertWPZX823LWYyhiS+FEGkrYeTEgw=;
 b=b45VyhEPhMEpFfCtdNaoX4KZScCDgMvTjRUZMtTx5Qehr4Y5LT76QWx3WOi+lL0ZO2
 kAH0CaPeRdI8sS2rOxIq0RiSy6c3jytkATQ8rY9cOBQDe/+G6hY3ToY3bdu867+MAzlM
 96j836She37LVqdyvKHTVoJUswqXOJNY4ANQaAzxeStlfSUUN7u18haVrP94f5whb3HR
 PRyDjfXWbscILpQkXawqi/vH68SQlc5ioPIZeNkYiObA1rAX8gWTQJnBvi4HRRohfHUV
 tBJVQpPgfW7b2oKW/zFF+Wj86Kffj6slF8ioB+I8H72MeRw1aMMqz829KugCQnJ6rWjn
 pSPQ==
X-Gm-Message-State: AOJu0YyswxQYFUhHKSxDfOSVj+pI5NIq5y5EPVo6cFr2/0T5XmaMro9l
 6J2EOVPe4eqDFqMVO7n6QuV2SzOybPl/CDEe3gU=
X-Google-Smtp-Source: AGHT+IHLYNfY+B9+W1vIpS4ZBMyVzPzIsQXhyl18HMT/zK1fqjqyATjNgRmzLd/FnjBPdKOl02vcYg==
X-Received: by 2002:a17:902:c20c:b0:1b8:6cae:4400 with SMTP id
 12-20020a170902c20c00b001b86cae4400mr11897246pll.37.1692822229208; 
 Wed, 23 Aug 2023 13:23:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/48] target/sparc: Use tcg_gen_movcond_i64 in gen_edge
Date: Wed, 23 Aug 2023 13:23:01 -0700
Message-Id: <20230823202326.1353645-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The setcond + neg + or sequence is a complex method of
performing a conditional move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


