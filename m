Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382D76A25F
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa29-0000tS-7W; Mon, 31 Jul 2023 17:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa23-0000se-Ho
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa21-0006Pq-L3
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbd03cb7c1so30983605ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837340; x=1691442140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHJK3pOh2Y7OF4yiI5SRsx/aGbKiHXoxnDvDxXZ5OqE=;
 b=Mx05B3VOYI3AT0xTAhdfgJxtDMJ3A+N7XXwJ8a0l8Ul1CaAXKIr2CQ6CgWDRVdBNtb
 e8hLXI/CaUEuWFyfEarC4SGqqTZHwgXuDKX4xbCTnLBSQafMSUb6CVIuBTEVWOgFjMi6
 sQWKbgC4nQxHykKGy7KumQ1q2dyFcZlWT5hdE6mhjc9j0msa7JqQnvPfyfA7yczbcDEQ
 Wun/YRlfUgomu9TVMEzRe+7Vs2Zai+6Y/CWZCDftD0zyxK74MbOiZ/3z24wT/5YosUxt
 53hCsXV6hq3A04U+QXQA+YK6sgkFdQt7+/FUyJfjY+JvZnHtuzhIKMMe37WbWwHvGtel
 U2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837340; x=1691442140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHJK3pOh2Y7OF4yiI5SRsx/aGbKiHXoxnDvDxXZ5OqE=;
 b=f4XZHK71gOyEj6jFRTvHnXqzYyhZ6dtXas1Rq1i1jW8OZM2gUgXRUU+jKhi4iPgGtl
 GMJm5u63Kmr3iknoFFCgqznu8ZuzCur7ZVv8MeisXsswvJas2tQg1uIZofuAYnpbcAK2
 /J9gQSNkisssn3mmT91WliyYBuNFHN1RLf7hRAIVwsEoaL6sqe1nVvjw4DwaI6YTmaXd
 BYeetIy6h8vCaBcSstFh5NPZsxoCvLLli169HcjvdjNSISH3ZgdW4mubmF6F0X8rEJWg
 3QnsWCm4DN2xIvUXxcudhYLP63ptqb4sA8b6QTY42ltrpACktDvrBCOlTp2fWQl6jEQq
 ICVQ==
X-Gm-Message-State: ABy/qLYuyoFVjuQv0nP3cqHkvN30kiS10fm5rgiu66OUxoY1vYssxeqP
 gDiPgeQoxWQFiXx2LPiH0twaJURb5Ul0dNhKXpg=
X-Google-Smtp-Source: APBJJlFDlQLWa/N+0R0iP5LvHX1JVuOm3paUlSnrrP0pvXFlg3ogCikboBz3vk/JZ2eNTP6ngRjEUg==
X-Received: by 2002:a17:902:dad2:b0:1b8:9b1b:ae7a with SMTP id
 q18-20020a170902dad200b001b89b1bae7amr11479324plx.34.1690837340145; 
 Mon, 31 Jul 2023 14:02:20 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/10] target/ppc: Disable goto_tb with architectural singlestep
Date: Mon, 31 Jul 2023 14:02:09 -0700
Message-Id: <20230731210211.137353-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The change to use translator_use_goto_tb went too far, as the
CF_SINGLE_STEP flag managed by the translator only handles
gdb single stepping and not the architectural single stepping
modeled in DisasContext.singlestep_enabled.

Fixes: 6e9cc373ec5 ("target/ppc: Use translator_use_goto_tb")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1795
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e6a0709066..74796ec7ba 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4175,6 +4175,9 @@ static void pmu_count_insns(DisasContext *ctx)
 
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
+    if (unlikely(ctx->singlestep_enabled)) {
+        return false;
+    }
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
-- 
2.34.1


