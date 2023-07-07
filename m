Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB174AEC1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHiix-0005ao-VK; Fri, 07 Jul 2023 06:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHiiw-0005aP-Oi
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:30:02 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHiit-0005CP-RD
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:30:01 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so2699858e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688725798; x=1691317798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gj130Ggv0CLz7wN97AyXytE/rsONt1PH6rxWlgOhxnM=;
 b=D9WrGahNLmXAIyHcUf+AUi6iRVwhRzm8anDt3lghNJRnfbpOEk2niiuda7x+sQ6892
 3jwyEyrEhH/G55wVOrB4fAzMHib6L63e0KngMYNWRiSbByx3RrjCjAeVuZm7yJhiuDwV
 ADdrluHGKNdtdkle3T99GICzdBe7nG8y1fMajnYj9STm1YvdODrW+QtiJLi0XPN/3INt
 q0Eo3TG+G35Q8sf0DpdwA0db9d7c74BDZs453kSt76exLFmvclQ5gfLlOd3WTbJtfn0n
 KeuyJcs35DmKKrhXmm5OI+TtfiuH/i/eXEXPf1Vcv1FkVKK3UpPEuH4k4OxV3G97ZkLS
 jffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688725798; x=1691317798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gj130Ggv0CLz7wN97AyXytE/rsONt1PH6rxWlgOhxnM=;
 b=awMopfWmJNnHnVAw6XwLYyaRnuy0lDwAfQh5l/2Qd3jIiM0iJ7d6wO5CTamn5jdQhk
 q+sk9f3hODRNzE9wl2urUqr7mYv+mp9h396nidBnNiXQ72hZbUnl39VZhsA6GTN8uQRu
 QEHs/Eet57lDujUeqI05Db5ghQj/RIs7e7lEbjAShflknhPK9yNqzBq5Ur00hXpO0TIN
 txKGE1BrCM9J7kK9D36oFzMoU+UIh1Y2KHq+K4OsCr+X/ZjXlAQkTDoWyUNagys/8vWN
 WZVXvs8mPEZ3EqxOneRr2bUniyFytCnIzXqr9HNauzROU8Fzx/2BRFSoGsJuBSd98iUh
 ZsZg==
X-Gm-Message-State: ABy/qLZp/9/oKQ3KylMQqqnAZTpwJY6BB4bcJFBTDwM/mnIB9nCIPRDs
 LajdHEKl6iRuMOeD7slMni+ViPMxwI3+ZJC/fno=
X-Google-Smtp-Source: APBJJlGSfANNkyCyh1eYNsf+SIo4NZQRoPNg3xrgUJF/AOT3mEAT8rNVgATL67cdaKyZqlLW0+NBLw==
X-Received: by 2002:a05:6512:214a:b0:4fa:d194:36be with SMTP id
 s10-20020a056512214a00b004fad19436bemr2975637lfr.65.1688725797965; 
 Fri, 07 Jul 2023 03:29:57 -0700 (PDT)
Received: from stoup.. ([91.223.100.9]) by smtp.gmail.com with ESMTPSA id
 u21-20020ac248b5000000b004fb73bea65esm629231lfg.25.2023.07.07.03.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:29:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH] tcg: Fix info_in_idx increment in layout_arg_by_ref
Date: Fri,  7 Jul 2023 11:29:55 +0100
Message-Id: <20230707102955.5607-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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

Off by one error, failing to take into account that layout_arg_1
already incremeneted info_in_idx for the first piece.  We only
need care for the n-1 TCG_CALL_ARG_BY_REF_N pieces here.

Cc: qemu-stable@nongnu.org
Fixes: 313bdea84d2 ("tcg: Add TCG_CALL_{RET,ARG}_BY_REF")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1751
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0628fe424..652e8ea6b9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1083,7 +1083,7 @@ static void layout_arg_by_ref(TCGCumulativeArgs *cum, TCGHelperInfo *info)
             .ref_slot = cum->ref_slot + i,
         };
     }
-    cum->info_in_idx += n;
+    cum->info_in_idx += n - 1;  /* i=0 accounted for in layout_arg_1 */
     cum->ref_slot += n;
 }
 
-- 
2.34.1


