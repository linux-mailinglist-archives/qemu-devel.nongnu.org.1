Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7979F85C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:46:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcM5-0000mE-I2; Wed, 13 Sep 2023 22:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcM1-0000kH-HH
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLc-0000i6-8r
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso3682305ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659491; x=1695264291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl9/MlxCo8JFdigycPzjBriVcEOo7sdAagnNzEtipCY=;
 b=yzjKNeOxV2Ot4B6XsSL9xZJ5iUauOnDNHUhxRfdhpG4/hqKUO8hYthGgfJJji6/fJt
 XpyhUnNUIz/GlKHkUuLHRUHp2jOeHfxwgBx89iVCwDKW8WzBY6xKPeoYGn1uLqULenyr
 2LeohRK8tE2TkU9DSAwofrwH0usaLmfoEUnrXRuLIsyu/xoD7OTusEGdSqR4cg6M+E0R
 4+WIsBlapDvqK5z/qeOdfzDX/08TncgqLCSPMIMBIQeE+AGXwWb/wORM4T6mU+CsH1Cw
 Z8r8nWrcMq/QjVq1EjWFRfeHv7bJ9Vwl4BHgu1TzfsIFSu+Qt9YHK/UeCDvg/kBrjV2g
 aXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659491; x=1695264291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl9/MlxCo8JFdigycPzjBriVcEOo7sdAagnNzEtipCY=;
 b=dvXBm6PREvJ3/A2MeFFRnisiOAeI6Y7bXIslE54bjzM9YRwHgkVJz40iwjMv83kjr7
 LQ/++H8EFFqS083MzokxYg/RY295/nAYtPOrQ/bRPorqrjzcNjtjORpFLuU+UNmU4rcx
 hl4i1LRf/gDVV2FKWYnPl+T7F1qb47JSVUYO9aq1f8ymcXf6kDS9gAKc8D7itpxuAyBq
 9i2xuVo/uZb+6VJ0L0J57ETgUP+Z1rQ6bOklOXAkYHNhDV30HO6JvrW+orvUtWYO72AZ
 kDOvT7YadmGENg5gzOBUOpbi7i17sXzeAXnpiotJ7HhqkkZlMHvcDu0EfBbnUbqV+UDE
 lHyQ==
X-Gm-Message-State: AOJu0YxA/YJiLrOFRj1EgPaA+awM2wPQ1f8OKJtjB9cHXkPTOyxPhMLM
 Tw22WhL/4utorTsqitq2B3fub3IETaifv2BaDhE=
X-Google-Smtp-Source: AGHT+IH8pUK+OHSpEcoprJ0YLots5q4gU+nI+wp9OLZr5sNcsWoEA3mCO4mdtscAexi/TU5oMpsJvg==
X-Received: by 2002:a17:902:b490:b0:1c0:c0af:ba59 with SMTP id
 y16-20020a170902b49000b001c0c0afba59mr4073688plr.34.1694659491154; 
 Wed, 13 Sep 2023 19:44:51 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 15/24] accel/tcg: Remove env_neg()
Date: Wed, 13 Sep 2023 19:44:26 -0700
Message-Id: <20230914024435.1381329-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Replace the single use within env_tlb() and remove.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 9db8544125..af9516654a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -451,17 +451,6 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
-/**
- * env_neg(env)
- * @env: The architecture environment
- *
- * Return the CPUNegativeOffsetState associated with the environment.
- */
-static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUNegativeOffsetState);
-}
-
 /**
  * env_tlb(env)
  * @env: The architecture environment
@@ -470,7 +459,7 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
  */
 static inline CPUTLB *env_tlb(CPUArchState *env)
 {
-    return &env_neg(env)->tlb;
+    return &env_cpu(env)->neg.tlb;
 }
 
 #endif /* CPU_ALL_H */
-- 
2.34.1


