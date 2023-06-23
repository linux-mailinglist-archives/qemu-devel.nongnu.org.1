Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A873B7DF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxK-0002UN-Gi; Fri, 23 Jun 2023 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0001iU-75
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx4-0000hO-88
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f9ede60140so6763645e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523505; x=1690115505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IViGb+tGY7LLks8rfYxqnKsEO6Q8hyPjN6DLlblFJLA=;
 b=qEHmRsQUqutbjfXwakii/hn/sqYSslOx91rNNMb0h6nI/9gJuZjQ0ElQ7NU9fPYstk
 P07Dl93DmOAcmCuM6AMsPQq6QDDXEppZmLfrwzl/Ni03NNpFRVys6e5hdqjk99Rmt1kE
 58vOOpVqZdp6IkKTu1nhQwGa/rgCAyiCyEP0RqIkOZ80QamH5CoRfwCvK2M1RJJfWyjv
 11UG7+0SzWNXfqeaeIxy/p3Y8LpTqWhxNlNqo+tehjcd/XOWfuUCfcEM/4r6AutjGDnH
 Hj9cByQhwprDUT1zKQKxNL9aHTnfS0zUxv2888w8WxdKJC8Ft38VTOHZXm2mqhm+tcXh
 7vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523505; x=1690115505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IViGb+tGY7LLks8rfYxqnKsEO6Q8hyPjN6DLlblFJLA=;
 b=MPjlUF5RpNFJYw7UQa2aU3KqHAcs523BUvcxaV00qzVZlowU0zGY37Pf6XNXqdElNQ
 gK5oBgmp0JJWZdXa41LmpZqzJRrGHJAmm632M6nNC6dqNeTGOVty9jS7HRHmY5+SEa1Y
 pMET453vD/Hh9OIEx95+0ifJxid8U8mYUzhDNXtFnwiw9HasVtrkZQj4n+3fqe0TA9Ro
 4P6d3Btz4OA2wpm2lntZXd22yOgNtkJCp5fr4+v6LyModRpBsbiOO8NlxD9CqAMnFbPz
 Doxbh3YqiMT7WWrX6KPoeAm3YF3WLEiORN/diSrPHxH0AKZ6ZX0LQhIZ19qtgUC2G+dV
 BGxQ==
X-Gm-Message-State: AC+VfDz6ipNTdLKMUzuUm0O4PCrHICuyjX/Plzw7bo9+9995xRLiphsK
 aoaCe1uYbWvvwtPt0XK6s1DNpQ5g3APqhXP9JeU=
X-Google-Smtp-Source: ACHHUZ7/Y9jC4R8RDuLqvFXK2zOIAt4F48k6YRxf3fU74cOPnl+vgJHTkTw91ZePtY3M8DWT65O6Og==
X-Received: by 2002:a7b:ce06:0:b0:3fa:7bf9:705b with SMTP id
 m6-20020a7bce06000000b003fa7bf9705bmr1363246wmc.20.1687523504979; 
 Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] target/arm: Use get_phys_addr_with_struct for stage2
Date: Fri, 23 Jun 2023 13:31:25 +0100
Message-Id: <20230623123135.1788191-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This fixes a bug in which we failed to initialize
the result attributes properly after the memset.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 558b4b731b8..7c4526e2da1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -39,10 +39,6 @@ typedef struct S1Translate {
     void *out_host;
 } S1Translate;
 
-static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
-                               uint64_t address, MMUAccessType access_type,
-                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi);
-
 static bool get_phys_addr_with_struct(CPUARMState *env, S1Translate *ptw,
                                       target_ulong address,
                                       MMUAccessType access_type,
@@ -2886,12 +2882,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    if (arm_feature(env, ARM_FEATURE_PMSA)) {
-        ret = get_phys_addr_pmsav8(env, ipa, access_type,
-                                   ptw->in_mmu_idx, is_secure, result, fi);
-    } else {
-        ret = get_phys_addr_lpae(env, ptw, ipa, access_type, result, fi);
-    }
+    ret = get_phys_addr_with_struct(env, ptw, ipa, access_type, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
-- 
2.34.1


