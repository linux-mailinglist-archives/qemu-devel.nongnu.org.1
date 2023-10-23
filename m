Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 015957D3ED2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRG-0005o8-B3; Mon, 23 Oct 2023 14:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRA-0005fk-BD
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR6-0008Gx-H2
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so2722596b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084835; x=1698689635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QOgygXHDxUHtfSFg6wMi8J9He8Jq0o2OiYkY7oLrEpM=;
 b=PrshqDM37Noanvu4ezPThl2V/kkmtx5+5ahssjfzCdSPfJJ+s6+ILW1AIMl/ja+OJb
 ll/teYNj7Ow0vTubsCIgb1Bz315I+NAPkOBkahxbjuaa5+3anBoCgjGTTfUSQAJZAVpb
 CQKHM5akfQ4O5Y9vncpzSC9/Bmcye7P55nZ1MLavda5zK5HwevFSUQcOkS5TDVtUo5PG
 J50ENOS0OWjdfbn3Ylzh+MVRcN60QOR7/mH+iG2tejg0g6rdr9SWa5lcK8HS/s3tBzcc
 /iGZag/Ys9aa+KJ7icZl448AsNsEdouj+IoMIWJwkrlv1BvIrSAkZV+HtP+pfx3ZZHOH
 6YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084835; x=1698689635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOgygXHDxUHtfSFg6wMi8J9He8Jq0o2OiYkY7oLrEpM=;
 b=R38Fu2g5bVOsECpGxG5jxoxLKsQB6tpwToRKhKvxleyozS5uXadUuQlNCeCEcBVKQz
 JGJNB/T56+ofobK/Rmt6frlrqi7xltJ9c4VBvI++KU+6up9ykPKy05ZxVJ497T6czwtw
 Htogk+6etaDmyvRNYBJYKPYQ9+8AH9uunp4Uu8BGYNxKimmdZY5wKCmW9ORdXXOR6Ql/
 9PvXgSrJYv/xhUvzLJptj8QdEeLm2XaUONACskVEMt5LTMwE4gGvLdgUiF0xQxoinGso
 LcPFoqV0+CM3M46SDn8rLN1HhKBj3soRy9Baj21nYasOcBDPiODm3JQdY7T2YJ/3Nalv
 6lHA==
X-Gm-Message-State: AOJu0YxmP515xfYlvR2SPVLJO6yqBV5r6ZsueCq7nAoJVTHpEiSrYE/s
 dZ68OfHXt7Xcb3QhYZVMfDCRV1u+0Y2qgNPzET0=
X-Google-Smtp-Source: AGHT+IFfoN5L+vwHGQxHVykmb4r1VWURoJBJEG9/LtXKD8SsT9zEsTKEXIsdBntwPg3Cm/rGaR9xnA==
X-Received: by 2002:a05:6a00:10c4:b0:6b8:780:94e5 with SMTP id
 d4-20020a056a0010c400b006b8078094e5mr8729053pfu.18.1698084834755; 
 Mon, 23 Oct 2023 11:13:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 27/38] tcg: Optimize past conditional branches
Date: Mon, 23 Oct 2023 11:13:18 -0700
Message-Id: <20231023181329.171490-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

We already register allocate through extended basic blocks,
optimize through extended basic blocks as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3013eb04e6..2db5177c32 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -688,12 +688,14 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
     int i, nb_oargs;
 
     /*
-     * For an opcode that ends a BB, reset all temp data.
-     * We do no cross-BB optimization.
+     * We only optimize extended basic blocks.  If the opcode ends a BB
+     * and is not a conditional branch, reset all temp data.
      */
     if (def->flags & TCG_OPF_BB_END) {
-        memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
         ctx->prev_mb = NULL;
+        if (!(def->flags & TCG_OPF_COND_BRANCH)) {
+            memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
+        }
         return;
     }
 
-- 
2.34.1


