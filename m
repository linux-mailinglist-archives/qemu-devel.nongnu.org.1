Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6467CEB55
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzl-0008Dj-0t; Wed, 18 Oct 2023 18:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzh-0008CC-UE
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzg-0002Wj-9c
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso27745655ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667983; x=1698272783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QOgygXHDxUHtfSFg6wMi8J9He8Jq0o2OiYkY7oLrEpM=;
 b=TrBpgvRJH7NywtdKrlwyN3vLPadSu/sRKc0LCCoZpQmPfEGpMla1fVP5P+jB86+Lpo
 90Iqj4f10yNrMDf9Bln00p6opZ4sca96/IReDh51ZgoDdPQYJmyGykTnZC4ZgGYcH+78
 3tj4n8tYs6yAbTcH2YdvdzzHYEoSW3nUcujQfWaldtokrEx73H/W1yODrTTwdMWd9W29
 r2NHw4B1ZO85173Ocmk2/+8HfE36sv2zql1lH2RR5+iROQXcQidzjLljwuvEFfXKIuW6
 DZCNCVjsEjumv4VmsoKHJXyufvs7pxBMlh9+cGom8rRrjcfQdP36io2H25gSQlbktJfP
 XYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667983; x=1698272783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOgygXHDxUHtfSFg6wMi8J9He8Jq0o2OiYkY7oLrEpM=;
 b=BX/cO+c/8IlA1X6GB6VzRY1E2rPzI8jUZEiFbKduq+3v5fG0WrvBRs/1KYOmrUg2wl
 VDkgFrYFlkqd6MEBEiX0D3OSH+OCoiSm5kIOTXlb07p1o4xjh3iTzCDniiHq/pwRYko9
 I8QuEeo92Zy2vHDXm0J9+9Kdr0nJ+JN4/hBhP3XUa3KtTQXaU8zU/mHmvCNaZyDijrHu
 xrRX764BzT2pHh6/9GjqtDdd3nfAO4wlwd4jl0Kio2YIjKA50erHT2480FlUQgISMaZR
 Qqw6IsPYbSiNCdW+Gjl+BDXvxLGkhRQi2IKMfvCxGH1+Mluyb0IQ/hfDVaBwnaISnFHB
 PcuQ==
X-Gm-Message-State: AOJu0Yywdm8opzHrV3isAS95l0e3v4VPSW4xk33IuABMwrVJJQ/aSoF+
 OTZKckIdq7h7qJOO5ETdnVmBf3PJcAAXdQNAH5Y=
X-Google-Smtp-Source: AGHT+IEOXKKTnp+LyfWr7jK5iamAehfggSAaU2ZpsyD8ZDob1RfuEW65XtWIatXhtAnrpBGbZKeYow==
X-Received: by 2002:a17:902:f38b:b0:1c9:d667:4e85 with SMTP id
 f11-20020a170902f38b00b001c9d6674e85mr643466ple.40.1697667982778; 
 Wed, 18 Oct 2023 15:26:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/29] tcg: Optimize past conditional branches
Date: Wed, 18 Oct 2023 15:25:55 -0700
Message-Id: <20231018222557.1562065-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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


