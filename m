Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E108C7DEA65
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:48:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMco-0001GU-T4; Wed, 01 Nov 2023 21:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbM-0006gL-AB
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbH-0002Al-Tr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6c115026985so503606b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888862; x=1699493662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hozauViA59+hLTL6ZLv3We/p27nrWdEmoLtLynuHCIg=;
 b=BazxGFPbfaLRZKdGd8E362vt1Eq1QA6u7iwtLiRMS/HOsu34DkBvFgmSDyqVnC/f3+
 5KnTHcPT38H0XUAS3s/QhAKxN9bZJCyfgoI5OKxuZKQDOOq1E6yicTbHQHWmnBZAH/gW
 AAJ7mSqY+npZV2hWPpJ80BTtxFC63oNQVkXOvbPtLwChwd1G1RtPnF0W/450AieL2CMj
 P3nKaO2Rq9PNFodTOIHecVHMRuCWEVbTaOAyYi0J6N/8z+gFr0mxmBV66sKC5uBJDnQQ
 LiF3BuWbgnSptjyKEC2gTsqrv3nJnyIv646GL3uWSaGLbyOZolZBUyqzgNRrVXqybnU0
 ld9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888862; x=1699493662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hozauViA59+hLTL6ZLv3We/p27nrWdEmoLtLynuHCIg=;
 b=Zpr7dXdYiNKsLpSnMRFY/HGiT+fXrMjTZi5vNhv/oJ2SOR3aRPfZrshowT4TCD3flP
 KcCvxzBklYbqvjPI2UZyy9OHAUHB1n5/XI/yA+ZkzeZCvZENXcv6SMLxAU44MC66hFOp
 m6C9IbiRuuRhJN+yITs3WkzqrnwHZAK8dhd1rZHrtRMnzhpvnwJQhMtyV5LfrKzhwzcP
 z/gEVX6CDkY152Io2sc017BHJoBMQBqqFpQAgpO6VOgvENqmqgiuTO0YlBxY5Vg+aqLN
 qJnEdozQu9a1NPOVN0VepNdEq7iK2mDMIqYNnRqbjdxa8FrPFaG4IpNteDaFXrJmXZn+
 vXdA==
X-Gm-Message-State: AOJu0YxJQg5dVr0pP5DZfO7oazNfI7HIei9G0qtY7gRIexSeX7fVkBY1
 zg5+NXNl45KLWZvlCPRd4T5MviT8vmAk+kXeFVA=
X-Google-Smtp-Source: AGHT+IFe+aeCh+uVGqXMgzZSeJdmEi1vIZvQEN0p97qc2P4C1tLjEBPLznA6DQZELNYzCjg4HXEiuA==
X-Received: by 2002:a05:6a20:da95:b0:17b:426f:829 with SMTP id
 iy21-20020a056a20da9500b0017b426f0829mr23984689pzb.37.1698888861863; 
 Wed, 01 Nov 2023 18:34:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 76/88] target/hppa: Implement pa2.0 data prefetch
 instructions
Date: Wed,  1 Nov 2023 18:30:04 -0700
Message-Id: <20231102013016.369010-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

These are aliased onto the normal integer loads to %g0.
Since we don't emulate caches, prefetch is a nop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3d8240ea7d..0883b146a9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2976,7 +2976,15 @@ static bool trans_permh(DisasContext *ctx, arg_permh *a)
 
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
-    if (!ctx->is_pa20 && a->size > MO_32) {
+    if (ctx->is_pa20) {
+       /*
+        * With pa20, LDB, LDH, LDW, LDD to %g0 are prefetches.
+        * Any base modification still occurs.
+        */
+        if (a->t == 0) {
+            return trans_nop_addrx(ctx, a);
+        }
+    } else if (a->size > MO_32) {
         return gen_illegal(ctx);
     }
     return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
-- 
2.34.1


